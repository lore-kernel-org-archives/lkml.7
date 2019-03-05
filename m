Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55754C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA7E20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="tfsDH8BV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfCEOp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:45:58 -0500
Received: from mail-eopbgr40120.outbound.protection.outlook.com ([40.107.4.120]:62371
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727935AbfCEOp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0z+2D9ofclwiIcbDUnZ0R6G7swW3zyEHwhnJvop9FLU=;
 b=tfsDH8BV5FkOm/3abwUNSNTLcyDRMexD/pBCz5gmYAtNUrnUC+ZutAj+Xl73T8NBXafdCkRkp/35EDMnU9Zmx6MRuaVLYmrwk5QuH2kMupkt+4QHidlaq0b0Cazw88OtugOD/dv1SbDekuaNpAqKmI3k9e/Ap51GTMKijY5BR9g=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2078.EURPRD10.PROD.OUTLOOK.COM (52.134.28.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 14:45:50 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51c2:2f6a:3148:4a1f]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51c2:2f6a:3148:4a1f%3]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 14:45:50 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        Per Noergaard Christensen <pnc@deif.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] net: dsa: mv88e6xxx: support single chip sw_addr
 offset
Thread-Topic: [RFC PATCH] net: dsa: mv88e6xxx: support single chip sw_addr
 offset
Thread-Index: AQHU0ooiDH2KrqMx8kGD7LZV2/HnjaX7e/WAgAGjMgA=
Date:   Tue, 5 Mar 2019 14:45:49 +0000
Message-ID: <e81ffefd-92a6-eb9c-7b9d-5b00420146a7@prevas.dk>
References: <20190304125933.5653-1-rasmus.villemoes@prevas.dk>
 <20190304134525.GC26378@lunn.ch>
In-Reply-To: <20190304134525.GC26378@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::14)
 To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef325571-61dc-425c-8a90-08d6a1794264
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2078;
x-ms-traffictypediagnostic: VI1PR10MB2078:
x-microsoft-antispam-prvs: <VI1PR10MB2078D058BA7EA747EB9BE3608A720@VI1PR10MB2078.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(39850400004)(376002)(396003)(189003)(199004)(8976002)(6916009)(105586002)(6246003)(81156014)(81166006)(8936002)(8676002)(54906003)(6116002)(106356001)(72206003)(3846002)(44832011)(316002)(14444005)(478600001)(256004)(14454004)(76176011)(6486002)(5660300002)(52116002)(386003)(6506007)(6512007)(68736007)(2906002)(97736004)(31686004)(71190400001)(71200400001)(305945005)(486006)(186003)(36756003)(7736002)(99286004)(74482002)(26005)(4326008)(476003)(11346002)(6436002)(229853002)(102836004)(31696002)(42882007)(53936002)(25786009)(446003)(66066001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2078;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjEwTUIyMDc4OzIzOjYxN1VwTjZaMlhibEJsVWtOYkNaNENMQks0?=
 =?utf-8?B?b2RkZ3UwK0E1VlFUVVNmc0lwT2dMeWtCWWQ2TGxhbGozcjU4ZG5KOUtiWW10?=
 =?utf-8?B?Slp6cmh2WlVzT2pkeEkwTUVmZjZQQ2RKaDFwbWhrN1QrTlpaL3Y4MGpkRkZ6?=
 =?utf-8?B?SDVNWm1FVGlSZnBLTHV6cXFxclo1cnBtK2JPc05TaEllSmZ5aW45V2NHR0JF?=
 =?utf-8?B?UkIzK3hKRVlNbnJYTkJXN042ME84NWl5SXlsQWZOYmJUU0lKakp2MDdPcWRr?=
 =?utf-8?B?b3ZOU0xwSzdxZEx1ZGsxTWZhcy9ieHZPN1kwaTB1MUNkZmZveUh3d0ZkMGRI?=
 =?utf-8?B?M3NGdjdzQ0Zzc2lZRVhKdWR3ajVWZ24vUzZsVGltNkVZQ0xaVzRhSXhvdUp0?=
 =?utf-8?B?TjdnUGNyRUhWdG9RbUozT1J6dzZYVjdRQ2UrOHdUaC9QRzdXSG9LWG1XQzdp?=
 =?utf-8?B?eXZ5QnhGUDI1cTNMbXNTK0pRYlp1WlJSVVNYU1VRTjZZbTV1c2dlZE80cDd4?=
 =?utf-8?B?UU8vd2lkRTZxUlY1Uzk5ZjV0YlJ2aG9iMFVyR2tCZUtMcGtTNC82aVpSS0M2?=
 =?utf-8?B?Tml0VE1aZlJuaTZGM3gyU2RackRCck1YRmJYMEZvaHpYTE43aS8vdnpKVGtR?=
 =?utf-8?B?ZDJYYUdBc1lVOXJnVENzNXArSkVJL2tudUFRMjI0VkowdTRQdGl5YWdGbG1s?=
 =?utf-8?B?c21GTmZNVEZvNFJ2WHNOSy93NjlqQjRCdUFHTlUrVWt1U0huZGNwRlIrVWF5?=
 =?utf-8?B?aUJHWlFqWnBIYVAvczZPYWo3WHBxYUt6RGdTVTIvb3JqQ3FsbUtoZmpHa2JQ?=
 =?utf-8?B?UnlvcEVoSnhmb1BISUZib3dlWDJtTHBkRVp0ZXJFdXQ5RWc4TEJwN2VlbnlZ?=
 =?utf-8?B?MEVISitPRU1ZRFc1KzdyOEJqZG9wRWlvd2JhU0NaVjhVcU4ra2RuQjR1eWxB?=
 =?utf-8?B?TjdEVlZwaU1OVXJTNmxZMHhmVjU0bUhhQjZNRVNlclBidzRPUjBGZXlmZzln?=
 =?utf-8?B?YjMrbVZZcFpLaGV2WDh0bHlBTktKTzNnd1Q0U1E2L1pEaFMzUGpFcy9xa3hq?=
 =?utf-8?B?M29aYTlwdGowZktmYWg4UmI2QnFlRzVGTUxjV2VGU2RDeExRWU5wS1dqRzRN?=
 =?utf-8?B?R01TRTgxVjBsWGUwYnVQTnV3aWZUUHVZT0pZYjBFTk9CcGhDYkNBdDJsWG1F?=
 =?utf-8?B?clBFb05TcUkvWHl3N3U5b09ZVzVDQVRNb3pkdnBScWNtUlBTVSsybitQM3Z1?=
 =?utf-8?B?SlhxWnZMbG5YTE1HbnVld05DLzVoRDRIWW5nZ2txUVhQNFVBTm9EcjFUK29V?=
 =?utf-8?B?WlB5d2ZTTlhYTTRzYUxXTGVEMXh1SWZiRDB2K25EWmQ0UTVHOUlQdW91cmVZ?=
 =?utf-8?B?dWVWMGtXSXVCejZmaG5aWXNIUmVpNG9SS1JRdlkreEpqUVk0M0JiSy9lMzVU?=
 =?utf-8?B?dWR1QVJic1JhNklWWk1UamVZc3VtbmJyVmhkZ2I3L2luNlBBQ2FOUTJWN0tX?=
 =?utf-8?B?TFFrQ0tjVkFMQlh5WUlUQmN5Uld1SVU5bVNGSWdxVWZLcFRibWZFVDMwQmtE?=
 =?utf-8?B?WEpZYzJVTHNHQi9rNks3SEZtU05YcEtqOE5rTDZRZEM5bk8wclhIY1VQd3FH?=
 =?utf-8?B?OTY3Q2YxYW12b2hYT3NqMllKTDB4MzZUcGxzNmRTYzE5TEZpa2xSOE16d3Zs?=
 =?utf-8?B?NnJRdTE3U0FwMGR6SEVBVWp1WnN5bjAzcXNPVzZuMHpXZElHbzQ2VTZzcGk5?=
 =?utf-8?B?Y0kveDVPTWhGVGhwRGZnSE5qNXhrai9kZUFuM0YvOWpnNTBNMWtoeEVvZU1M?=
 =?utf-8?B?bnQ5U2s0L3FvTkNoNDBlTHNpSGVCbG5PNFE1L0FDTmlEYmc9PQ==?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SJBtQCnlOXPSGMqaUfPTcQvcY2IdgHbKqjFIn/dMYZ+BMGG8cKlpt+1qBVGuULyJs5qKbXoK/0fLooc/U19CO2UF3Mh7CKWVP1OwEd4p2eKbV5tBiClJceNfurtJKGM1/x3JceQYg2HbLOqn1Oxm0dooUoJefWzb4mNqT0k+n1dr8SYryeIwcaQCNQHtrT2CTbhCYg/Mc7hgBBsizNZCdNEC//iMsGDaUNUU7AUGjtnKseQrhXWXCmjq+vCGY+KrrufzWTjAmZR2M86bEFlM6LUBPmFVI/eUy4OTHf+jDKIHHG7d4yZP+EszTxo1lY3HgoNGF9fzRl6Isvod/m1ELoqxyE1vJT27MoFkiuJzMgql2mvwV8TBhYMxaSVDfTbU9BtA3LmzmctJscKrRF0frL8uuWKnmU3ooUgIb2ThLAI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FDE0B653FF0D54A963DAAE1E8C81AB4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ef325571-61dc-425c-8a90-08d6a1794264
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 14:45:49.9496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQvMDMvMjAxOSAxNC40NSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIE1vbiwgTWFyIDA0
LCAyMDE5IGF0IDEyOjU5OjQyUE0gKzAwMDAsIFJhc211cyBWaWxsZW1vZXMgd3JvdGU6DQo+PiBG
cm9tOiBQZXIgTm9lcmdhYXJkIENocmlzdGVuc2VuIDxwbmNAZGVpZi5jb20+DQo+Pg0KPj4gVGhl
IDg4ZTYyNTAgZG9lcyBub3Qgc3VwcG9ydCBtdWx0aS1jaGlwIGFkZHJlc3NpbmcuIEhvd2V2ZXIs
IG9uZSBjYW4NCj4+IHN0aWxsIGhhdmUgdHdvIG9mIHRoZW0gb24gdGhlIHNhbWUgbWRpbyBidXMs
IHNpbmNlIHRoZSBkZXZpY2Ugb25seQ0KPj4gdXNlcyAxNiBvZiB0aGUgMzIgcG9zc2libGUgYWRk
cmVzc2VzLCBlaXRoZXIgYWRkcmVzc2VzIDB4MDAtMHgwRiBvcg0KPj4gMHgxMC0weDFGIGRlcGVu
ZGluZyBvbiB0aGUgQUREUjQgcGluIGF0IHJlc2V0IFtzaW5jZSBBRERSNCBpcw0KPj4gaW50ZXJu
YWxseSBwdWxsZWQgaGlnaCwgdGhlIGxhdHRlciBpcyB0aGUgZGVmYXVsdF0uDQo+Pg0KPj4gSW4g
b3JkZXIgdG8gcHJlcGFyZSBmb3Igc3VwcG9ydGluZyB0aGUgODhlNjI1MCwgY2hhbmdlDQo+PiBt
djg4ZTZ4eHhfc21pX2luaXQgYW5kIHRoZSBzaW5nbGVfY2hpcF97cmVhZCx3cml0ZX0gZnVuY3Rp
b25zIHRvIGFsbG93DQo+PiBhbmQgaG9ub3VyIGEgbm9uLXplcm8gc3dfYWRkciBpbiBzaW5nbGUg
Y2hpcCBtb2RlLiBTaW5jZSB0aGlzIG9ubHkNCj4+IGNoYW5nZXMgdGhlIGJlaGF2aW91ciBpbiB0
aGUgc3dfYWRkciE9MCAmJiAhY2hpcC0+aW5mby0+bXVsdGlfY2hpcA0KPj4gY2FzZSBmcm9tIHJl
dHVybmluZyAtRUlOVkFMLCBpdCBzaG91bGQgbm90IGJyZWFrIGV4aXN0aW5nIHNldHVwcy4NCj4g
DQo+IEhpIFJhc211cw0KPiANCj4gV2UgaGF2ZSB0aGUgbmljZSBhYnN0cmFjdGlvbiBvZiBtdjg4
ZTZ4eHhfc21pX211bHRpX2NoaXBfb3BzIGFuZA0KPiBtdjg4ZTZ4eHhfc21pX3NpbmdsZV9jaGlw
X29wcy4gSSB0aGluayB3ZSBzaG91bGQgZXh0ZW5kIHRoaXMNCj4gYWJzdHJhY3Rpb24gYW5kIGlt
cGxlbWVudCBtdjg4ZTZ4eHhfc21pX2R1YWxfY2hpcF9vcHMuIEFsc28sIGFkZCBhDQo+IGNoaXAt
PmluZm8tPmR1YWxfY2hpcCBmbGFnLCBzbyB3ZSBrbm93IHdoZW4gaXQgY2FuIGJlIHVzZWQuDQo+
IA0KDQpIaSBBbmRyZXcNCg0KSSBzaG91bGQgcHJvYmFibHkgZ2l2ZSBhIGxpdHRsZSBtb3JlIGNv
bnRleHQsIGFuZCBtZW50aW9uIHRoYXQgSSBkb24ndA0KYWN0dWFsbHkgaGF2ZSBhIGJvYXJkIHdp
dGggdHdvIDg4ZTYyNTAgc2l0dGluZyBvbiB0aGUgc2FtZSBidXMsIHNvIEkNCmNhbid0IHRlc3Qg
dGhhdCBzdWNoIGEgc2V0dXAgd2lsbCBhY3R1YWxseSB3b3JrIChidXQgSSBhc3N1bWUgdGhhdCdz
IHRoZQ0Kd2hvbGUgcG9pbnQgb2YgdGhlIHJlc2V0IGJlaGF2aW91cikuIEJ1dCBJIGRvIGhhdmUg
YSBzaW5nbGUgODhlNjI1MCwgYXQNCmFkZHJlc3NlcyAweDEwLTB4MWYsIGFuZCBmb3IgdGhhdCB0
byBnZXQgcmVjb2duaXplZCBJIG5lZWQgdG8gZ2V0DQptdjg4ZTZ4eHhfZGV0ZWN0IHRvIGxvb2sg
YXQgc21pIGFkZHJlc3MgMHgxMCsweDggKGkuZS4sIEkgYWxzbyBuZWVkIHRvDQphZGQgYW5vdGhl
ciBmYW1pbHkgdG8gbXY4OGU2eHh4X29mX21hdGNoIHdpdGggcG9ydF9iYXNlX2FkZHIgPSAweDA4
LCBhbmQNCnRoZW4gc29tZWhvdyBoYXZlIG12ODhlNnh4eF9zbWlfcmVhZCBhZGQgYSAweDEwIG9m
ZnNldCkuDQoNCkkgY2FuIGNlcnRhaW5seSBkbyBhcyB5b3Ugc3VnZ2VzdCBpbnN0ZWFkLCBidXQg
SSdtIG5vdCBzdXJlIHdoYXQgdGhhdA0KYnV5cyB1cz8gRXNwZWNpYWxseSBnaXZlbiB0aGF0IEkg
Y2FuJ3QgdGVzdCBhbiBhY3R1YWwgZHVhbCBjaGlwIHNldHVwLCBJDQp0aGluayBpdCdzIG1vcmUg
bmF0dXJhbCB0byB1c2UgYSAic2luZ2xlIGNoaXAgb3BzIHdpdGggYW4gYWRkciBvZmZzZXQiLg0K
DQpUaGFua3MsDQpSYXNtdXMNCg==
