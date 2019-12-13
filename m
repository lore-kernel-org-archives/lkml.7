Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EFDC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535BC2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="S8D/nYOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfLMJbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:31:10 -0500
Received: from mail-eopbgr140112.outbound.protection.outlook.com ([40.107.14.112]:48211
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbfLMJbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:31:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/60L5D6/6ZFYN0IDCl8qk/tMXuNU+UErExNDIeRaSQ9OsAjw1P0LCewzZ2E9ISSodGSCJLn+11ljmITfrbXJTOELeZn5zkC+ift/6zt3r8NVv834cnipyTk8HuK14jdP9/rpQ/83KuYbIHmXgwjXIiCcXmvRmXHlI51VvZ2TGXmH/t9WRp+8ofiElJIXakku/7aGWaZanpAZh9oEhvm09p/W8RwOhr4JqPEL946MaozHufRXV1slPSnXBayFTKx9y8vAzXdPOTnH+SS7avh9Lh7xJW3zzFEuDuhtRM7W3dfbw1FwPLGeRbsuEaG9pYaQk7dWUy15iyMp1EC8msnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgzuOxOAh0vuBgzLzyvSqbVaGg+tm5tiLCBdGSrzdoc=;
 b=niZrKPT2yb+rb/ZRKVQQBzErxSTZlzdD4hD0/B8Y3EzNSxpK4jLdfcF+AADpZN3rqBcIqNc0+hqfwGaPJ4gZplBXUPmH7SjvCO0v62tejl5AHK6EXMEKIlcYBISUTqvUXwSDPSDUn7mlEBg2/y8yJ6MHBtoFdqWo3dUgFIP54va549mawB1e5mTeYIXkhbCXI15xFyY3ONEpP5z/7OYt+5Y10IsqJrA2Ck2YFF7XWbT5lu9ntT4SL8SOw/AHwquVI/oOAMB+N8vcuQNxQgSF4OwrALPtWx+BoDLGc/zbEtBeMwteX+vjMQ82n6iK05797xys6hCxqFt/jH+dEAbvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgzuOxOAh0vuBgzLzyvSqbVaGg+tm5tiLCBdGSrzdoc=;
 b=S8D/nYOwkWYo0TyQqXSQME4/L+DgwT0ZUWD9CwrtLHZMsSuQEe1NQiKkf6C9zFkC0XejR9m+45BGL4tlelEKkVFxY/dHaNiiXSJ67ujVLj7+UtdJQAE4a8BQcdIO1ZMHjc3QfGN749/HSfFliOldYqkxfsMjPjQrw4EJWfOs9KY=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3418.eurprd02.prod.outlook.com (52.134.70.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Fri, 13 Dec 2019 09:30:59 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::cd85:a8a5:da14:db13]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::cd85:a8a5:da14:db13%7]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 09:30:59 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Topic: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Index: AQHVr11DyxIz9S+dLEWyrkArJlSyg6ezeYGA///8moCAADjaAIABIyyAgAAtnoCAAtDTgIAAAL4A
Date:   Fri, 13 Dec 2019 09:30:59 +0000
Message-ID: <e41b9a8f-b0f4-bb88-1512-7fb94dfaebe4@axentia.se>
References: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
 <1575984287-26787-5-git-send-email-claudiu.beznea@microchip.com>
 <4c3ffc48-7aa5-1e48-b0e9-a50c4eea7c38@axentia.se>
 <5fbad2cd-0dbe-0be5-833a-f7a612d48012@microchip.com>
 <2272669c-38ee-1928-9563-46755574897c@axentia.se>
 <167cb87e-b189-71fd-0a79-adf89336d1f3@microchip.com>
 <b5ea01da-5345-05cf-9f89-b7123dbbb893@axentia.se>
 <be6a9bce-7d14-563b-1ee5-a968e2e3a6c8@microchip.com>
In-Reply-To: <be6a9bce-7d14-563b-1ee5-a968e2e3a6c8@microchip.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::33)
 To DB3PR0202MB3434.eurprd02.prod.outlook.com (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3f0e860-2afb-4d07-b20d-08d77faf29b6
x-ms-traffictypediagnostic: DB3PR0202MB3418:
x-microsoft-antispam-prvs: <DB3PR0202MB34180DEA97DA6CA52DDAC193BC540@DB3PR0202MB3418.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(136003)(396003)(39830400003)(199004)(189003)(31686004)(66556008)(5660300002)(66476007)(2616005)(36756003)(316002)(71200400001)(54906003)(110136005)(64756008)(7416002)(6486002)(66446008)(66946007)(31696002)(6506007)(53546011)(508600001)(4326008)(81156014)(186003)(8936002)(4001150100001)(26005)(2906002)(6512007)(8676002)(81166006)(52116002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3418;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2jMfNXjNbeGqNJEhyuvYpIIEeRd/ImqTvo6upAMgtQzJ7rqqlaG22IBhGASzykpxhVFBgZKRftpmReV9yPXdsSxWOfCIcgroTFwR5ceM//6v0Klv5WhyNWnbSnnE2w2D53EpMPDpNvj+f3cbZSTHE+QUhZo7Zk+Yy4Cf5m+Dj2v66fsSBKHkgnq6/yEvJWrOcsEOXd0ZlCDgbCDHc0rs6M1nINYHfyf2Irm7ZjmDULxnaNI0FkLR2o28RmZ7lG+WFSQuWxot38oder0cqx54Vm/Zd0ae4Xb9hIdYLGWB7sgz1In5GAJTGzJUCM6xzxHkMae86eJHi/DomYvKmnC03thWBnGwTfzeZdnXD3ZP4HeZnpKLwPTVtzAwB8ql+HiXirD0CovkYx3YpLPQC0higK9+BOnrajGuIJ70S+QwPNxGPSS41DzEmCOD7lMig8w7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E58D646F03742341997F54DCEB0144F6@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f0e860-2afb-4d07-b20d-08d77faf29b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 09:30:59.4656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cby1IleFZNzQn/oCi7nHN9MQnjm/Asd4j3eQXBokQGmvJ+Z/KAfLRrxCJD5gWAKM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3418
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0xMi0xMyAxMDoyOCwgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3cm90ZToN
Cj4gDQo+IA0KPiBPbiAxMS4xMi4yMDE5IDE1OjI4LCBQZXRlciBSb3NpbiB3cm90ZToNCj4+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4NCj4+IE9uIDIwMTktMTItMTEgMTI6
NDUsIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IE9u
IDEwLjEyLjIwMTkgMTk6MjIsIFBldGVyIFJvc2luIHdyb3RlOg0KPj4+PiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4NCj4+Pj4gT24gMjAxOS0xMi0xMCAxNTo1OSwgQ2xh
dWRpdS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gT24g
MTAuMTIuMjAxOSAxNjoxMSwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+Pj4+Pj4gT24gMjAxOS0xMi0x
MCAxNDoyNCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+Pj4+Pj4+IFRoaXMgcmV2ZXJ0cyBjb21t
aXQgZjZmN2FkMzIzNDYxM2Y2ZjdmMjdjMjUwMzZhYWYwNzhkZTA3ZTliMC4NCj4+Pj4+Pj4gKCJk
cm0vYXRtZWwtaGxjZGM6IGFsbG93IHNlbGVjdGluZyBhIGhpZ2hlciBwaXhlbC1jbG9jayB0aGFu
IHJlcXVlc3RlZCIpDQo+Pj4+Pj4+IGJlY2F1c2UgYWxsb3dpbmcgc2VsZWN0aW5nIGEgaGlnaGVy
IHBpeGVsIGNsb2NrIG1heSBvdmVyY2xvY2sNCj4+Pj4+Pj4gTENEIGRldmljZXMsIG5vdCBhbGwg
b2YgdGhlbSBiZWluZyBjYXBhYmxlIG9mIHRoaXMuDQo+Pj4+Pj4NCj4+Pj4+PiBXaXRob3V0IHRo
aXMgcGF0Y2gsIHRoZXJlIGFyZSBwYW5lbHMgdGhhdCBhcmUgKnNldmVybHkqIHVuZGVyY2xvY2tl
ZCAob24gdGhlDQo+Pj4+Pj4gbWFnbml0dWRlIG9mIDQwTUh6IGluc3RlYWQgb2YgNjVNSHogb3Ig
c29tZXRoaW5nIGxpa2UgdGhhdCwgSSBkb24ndCByZW1lbWJlcg0KPj4+Pj4+IHRoZSBleGFjdCBm
aWd1cmVzKS4NCj4+Pj4+DQo+Pj4+PiBXaXRoIHBhdGNoIHRoYXQgc3dpdGNoZXMgYnkgZGVmYXVs
dCB0byAyeHN5c3RlbSBjbG9jayBmb3IgcGl4ZWwgY2xvY2ssIGlmDQo+Pj4+PiB1c2luZyAxMzNN
SHogc3lzdGVtIGNsb2NrIChhcyB5b3Ugc3BlY2lmaWVkIGluIHRoZSBwYXRjaCBJIHByb3Bvc2Vk
IGZvcg0KPj4+Pj4gcmV2ZXJ0IGhlcmUpIHRoYXQgd291bGQgZ28sIHdpdGhvdXQgdGhpcyBwYXRj
aCBhdCA1M01IeiBpZiA2NU1IeiBpcw0KPj4+Pj4gcmVxdWVzdGVkLiBDb3JyZWN0IG1lIGlmIEkn
bSB3cm9uZy4NCj4+Pj4NCj4+Pj4gSXQgbWlnaHQgaGF2ZSBiZWVuIDUzTUh6LCB3aGF0ZXZlciBp
dCB3YXMgaXQgd2FzIHRvbyBsb3cgZm9yIHRoaW5ncyB0byB3b3JrLg0KPj4+Pg0KPj4+Pj4+IEFu
ZCB0aGV5IGFyZSBvZiBjb3Vyc2Ugbm90IGNhcGFibGUgb2YgdGhhdC4gQWxsIHBhbmVscw0KPj4+
Pj4+IGhhdmUgKnNvbWUqIHNsYWNrIGFzIHRvIHdoYXQgZnJlcXVlbmNpZXMgYXJlIHN1cHBvcnRl
ZCwgYW5kIHRoZSBwYXRjaCB3YXMNCj4+Pj4+PiB3cml0dGVuIHVuZGVyIHRoZSBhc3N1bXB0aW9u
IHRoYXQgdGhlIHByZWZlcnJlZCBmcmVxdWVuY3kgb2YgdGhlIHBhbmVsIHdhcw0KPj4+Pj4+IHJl
cXVlc3RlZCwgd2hpY2ggc2hvdWxkIGxlYXZlIGF0IGxlYXN0IGEgKmxpdHRsZSogaGVhZHJvb20u
DQo+Pj4+Pg0KPj4+Pj4gSSBzZWUsIGJ1dCBmcm9tIG15IHBvaW50IG9mIHZpZXcsIHRoZSB1cHBl
ciBsYXllcnMgc2hvdWxkIGRlY2lkZSB3aGF0DQo+Pj4+PiBmcmVxdWVuY3kgc2V0dGluZ3Mgc2hv
dWxkIGJlIGRvbmUgb24gdGhlIExDRCBjb250cm9sbGVyIGFuZCBub3QgbGV0IHRoaXMgYXQNCj4+
Pj4+ICB0aGUgZHJpdmVyJ3MgbGF0aXR1ZGUuDQo+Pj4+DQo+Pj4+IFJpZ2h0LCBidXQgdGhlIHVw
cGVyIGxheWVycyBkbyBub3Qgc3VwcG9ydCBuZWdvdGlhdGluZyBhIGZyZXF1ZW5jeSBmcm9tDQo+
Pj4+IHJhbmdlcy4gQXQgbGVhc3QgdGhlIGRpZG4ndCB3aGVuIHRoZSBwYXRjaCB3YXMgd3JpdHRl
biwgYW5kIGltcGxlbWVudGluZw0KPj4+PiAqdGhhdCogc2VlbWVkIGxpa2UgYSBodWdlIHVuZGVy
dGFraW5nLg0KPj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gU28sIEknbSBjdXJpb3VzIGFzIHRvIHdoYXQg
cGFuZWwgcmVncmVzc2VkLiBPciByYXRoZXIsIHdoYXQgcGl4ZWwtY2xvY2sgaXQgbmVlZHMNCj4+
Pj4+PiBhbmQgd2hhdCBpdCBnZXRzIHdpdGgvd2l0aG91dCB0aGUgcGF0Y2g/DQo+Pj4+Pg0KPj4+
Pj4gSSBoYXZlIDIgdXNlIGNhc2VzOg0KPj4+Pj4gMS8gc3lzdGVtIGNsb2NrID0gMjAwTUh6IGFu
ZCByZXF1ZXN0ZWQgcGl4ZWwgY2xvY2sgKG1vZGVfcmF0ZSkgfjcxTUh6LiBXaXRoDQo+Pj4+PiB0
aGUgcmV2ZXJ0ZWQgcGF0Y2ggdGhlIHJlc3VsdGVkIGNvbXB1dGVkIHBpeGVsIGNsb2NrIHdvdWxk
IGJlIDgwTUh6Lg0KPj4+Pj4gUHJldmlvdXNseSBpdCB3YXMgYXQgNjZNSHoNCj4+Pj4NCj4+Pj4g
SSBkb24ndCBzZWUgaG93IHRoYXQncyBwb3NzaWJsZS4NCj4+Pj4NCj4+Pj4gW2RvaW5nIHNvbWUg
Y2FsY3VsYXRpb24gYnkgaGFuZF0NCj4+Pj4NCj4+Pj4gQXJyZ2guICpibHVzaCoNCj4+Pj4NCj4+
Pj4gVGhlIGNvZGUgZG9lcyBub3QgZG8gd2hhdCBJIGludGVuZGVkIGZvciBpdCB0byBkby4NCj4+
Pj4gQ2FuIHlvdSBwbGVhc2UgdHJ5IHRoaXMgaW5zdGVhZCBvZiByZXZlcnRpbmc/DQo+Pj4+DQo+
Pj4+IENoZWVycywNCj4+Pj4gUGV0ZXINCj4+Pj4NCj4+Pj4gRnJvbSBiM2U4NmQ1NWI4ZDEwN2E1
YzA3ZTk4Zjg3OWM2N2Y2NzEyMGM4N2E2IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KPj4+PiBG
cm9tOiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KPj4+PiBEYXRlOiBUdWUsIDEwIERl
YyAyMDE5IDE4OjExOjI4ICswMTAwDQo+Pj4+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2F0bWVsLWhs
Y2RjOiBwcmVmZXIgYSBsb3dlciBwaXhlbC1jbG9jayB0aGFuIHJlcXVlc3RlZA0KPj4+Pg0KPj4+
PiBUaGUgaW50ZW50aW9uIHdhcyB0byBvbmx5IHNlbGVjdCBhIGhpZ2hlciBwaXhlbC1jbG9jayBy
YXRlIHRoYW4gdGhlDQo+Pj4+IHJlcXVlc3RlZCwgaWYgYSBzbGlnaHQgb3ZlcmNsb2NraW5nIHdv
dWxkIHJlc3VsdCBpbiBhIHJhdGUgc2lnbmlmaWNhbnRseQ0KPj4+PiBjbG9zZXIgdG8gdGhlIHJl
cXVlc3RlZCByYXRlIHRoYW4gaWYgdGhlIGNvbnNlcnZhdGl2ZSBsb3dlciBwaXhlbC1jbG9jaw0K
Pj4+PiByYXRlIGlzIHNlbGVjdGVkLiBUaGUgZml4ZWQgcGF0Y2ggaGFzIHRoZSBsb2dpYyB0aGUg
b3RoZXIgd2F5IGFyb3VuZCBhbmQNCj4+Pj4gYWN0dWFsbHkgcHJlZmVycyB0aGUgaGlnaGVyIGZy
ZXF1ZW5jeS4gRml4IHRoYXQuDQo+Pj4+DQo+Pj4+IEZpeGVzOiBmNmY3YWQzMjM0NjEgKCJkcm0v
YXRtZWwtaGxjZGM6IGFsbG93IHNlbGVjdGluZyBhIGhpZ2hlciBwaXhlbC1jbG9jayB0aGFuIHJl
cXVlc3RlZCIpDQo+Pj4+IFJlcG9ydGVkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpu
ZWFAbWljcm9jaGlwLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgUm9zaW4gPHBlZGFA
YXhlbnRpYS5zZT4NCj4+Pj4gLS0tDQo+Pj4+ICBkcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMv
YXRtZWxfaGxjZGNfY3J0Yy5jIHwgNCArKy0tDQo+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMNCj4+Pj4gaW5kZXggOWUzNGJjZTA4OWQw
Li4wMzY5MTg0NWQzN2EgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1o
bGNkYy9hdG1lbF9obGNkY19jcnRjLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2F0bWVs
LWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYw0KPj4+PiBAQCAtMTIwLDggKzEyMCw4IEBAIHN0YXRp
YyB2b2lkIGF0bWVsX2hsY2RjX2NydGNfbW9kZV9zZXRfbm9mYihzdHJ1Y3QgZHJtX2NydGMgKmMp
DQo+Pj4+ICAgICAgICAgICAgICAgICBpbnQgZGl2X2xvdyA9IHByYXRlIC8gbW9kZV9yYXRlOw0K
Pj4+Pg0KPj4+PiAgICAgICAgICAgICAgICAgaWYgKGRpdl9sb3cgPj0gMiAmJg0KPj4+PiAtICAg
ICAgICAgICAgICAgICAgICgocHJhdGUgLyBkaXZfbG93IC0gbW9kZV9yYXRlKSA8DQo+Pj4+IC0g
ICAgICAgICAgICAgICAgICAgIDEwICogKG1vZGVfcmF0ZSAtIHByYXRlIC8gZGl2KSkpDQo+Pj4+
ICsgICAgICAgICAgICAgICAgICAgKDEwICogKHByYXRlIC8gZGl2X2xvdyAtIG1vZGVfcmF0ZSkg
PA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAobW9kZV9yYXRlIC0gcHJhdGUgLyBkaXYpKSkN
Cj4+Pg0KPj4+IEkgdGVzdGVkIGl0IG9uIG15IHNldHVwIChJIGhhdmUgb25seSBvbmUgb2YgdGhv
c2Ugc3BlY2lmaWVkIGFib3ZlKSBhbmQgaXQNCj4+PiBpcyBPSy4gRG9pbmcgc29tZSBtYXRoIGZv
ciB0aGUgb3RoZXIgc2V0dXAgaXQgc2hvdWxkIGFsc28gYmUgT0suDQo+Pg0KPj4gR2xhZCB0byBo
ZWFyIGl0LCBhbmQgdGhhbmtzIGZvciB0ZXN0aW5nL3ZlcmlmeWluZyENCj4+DQo+Pj4gQXMgYSB3
aG9sZSwgSSdtIE9LIHdpdGggdGhpcyBhdCB0aGUgbW9tZW50IChsZXQncyBob3BlIGl0IHdpbGwg
d29yayBmb3IgYWxsDQo+Pj4gdXNlLWNhc2VzKSBidXQgc3RpbGwgSSBhbSBub3QgT0sgd2l0aCBz
ZWxlY3RpbmcgaGVyZSwgaW4gdGhlIGRyaXZlciwNCj4+PiBzb21ldGhpbmcgdGhhdCBtaWdodCB3
b3JrLg0KPj4NCj4+IFRoZSBkcml2ZXIgaGFzIHRvIHNlbGVjdCAqc29tZXRoaW5nKi4gSWYgaXQg
Y2FuIGRlbGl2ZXIgdGhlIGV4YWN0IHJlcXVlc3RlZA0KPj4gZnJlcXVlbmN5LCBmaW5lLiBPdGhl
cndpc2U/IFdoYXQgc2hvdWxkIGl0IGRvPyBCYWlsIG91dD8gV2h5IGlzIDUzTUh6IGJldHRlcg0K
Pj4gYW5kIG1vcmUgbGlrZWx5IHRvIHByb2R1Y2UgYSBwaWN0dXJlIHRoYW4gNjZNSHosIHdoZW4g
NjVNSHogaXMgcmVxdWVzdGVkPw0KPj4gVGhhdCdzIG9mIGNvdXJzZSBhbiBpbXBvc3NpYmxlIHF1
ZXN0aW9uIGZvciB0aGUgZHJpdmVyIHRvIGFuc3dlci4NCj4+DQo+PiBTbywgaWYgeW91IGFyZSBu
b3Qgb2sgd2l0aCB0aGF0LCB5b3UgbmVlZCB0byBpbXBsZW1lbnQgc29tZXRoaW5nIHRoYXQgdXNl
cw0KPj4gdGhlIG1pbi9tYXggZmllbGRzIGZyb20gdGhlIHZhcmlvdXMgZmllbGRzIGluc2lkZSBz
dHJ1Y3QgZGlzcGxheV90aW1pbmcNCj4+IGluc3RlYWQgb2Ygb25seSBsb29raW5nIGF0IHRoZSB0
eXAgZmllbGQuIEUuZy4gdGhlIHBhbmVsX2x2ZHMgZHJpdmVyIGNhbGxzDQo+PiB2aWRlb21vZGVf
ZnJvbV90aW1pbmdzKCkgYW5kIHRoZSByZXN1bHQgaXMgYSBzaW5nbGUgcG9zc2libGUgbW9kZSB3
aXRoIG9ubHkNCj4+IHRoZSB0eXBpY2FsIHRpbWluZ3MsIHdpdGggbm8gbmVnb3RpYXRpb24gb2Yg
dGhlIGJlc3Qgb3B0aW9uIHdpdGhpbiB0aGUNCj4+IGdpdmVuIHJhbmdlcyB3aXRoIHRoZSBvdGhl
ciBkcml2ZXJzIGludm9sdmVkIHdpdGggdGhlIHBpcGUuIEkgdGhpbmsgdGhlDQo+PiBwYW5lbC1z
aW1wbGUgZHJpdmVyIGFsc28gbWFrZXMgdGhpcyBvbmUtc2lkZWQgZGVjaXNpb24gb2Ygb25seSBt
YWtpbmcgdXNlDQo+PiBvZiB0aGUgdHlwIGZpZWxkIGZvciBlYWNoIGdpdmVuIHRpbWluZyByYW5n
ZS4gSGF2aW5nIGRhYmJsZWQgYSBiaXQgaW4gd2hhdA0KPj4gdGhlIHNvdW5kIHN0YWNrIGRvZXMg
dG8gbmVnb3RpYXRlIHRoZSBzYW1wbGUgcmF0ZSwgc2FtcGxlIGZvcm1hdCBhbmQNCj4+IGNoYW5u
ZWwgY291bnQgZXRjLCBJIGNhbiBvbmx5IHByZWRpY3QgdGhhdCByZXRyb2ZpdHRpbmcgc29tZXRo
aW5nIGxpa2UgdGhhdA0KPj4gZm9yIHZpZGVvIG1vZGVzIHdpbGwgYmUgLi4uIGludGVyZXN0aW5n
LiBXaGljaCBpcyBwcm9iYWJseSB3aHkgaXQncyBub3QNCj4+IGRvbmUgYXQgYWxsLCBhdCBsZWFz
dCBub3QgaW4gdGhlIGdlbmVyYWwgY2FzZS4NCj4+DQo+PiBBbmQgeWVzLCBJIGFncmVlLCB0aGUg
Y3VycmVudCBtZWNoYW5pY3MgYXJlIGxlc3MgdGhhbiBpZGVhbC4gQnV0IEkgaGF2ZSBubw0KPj4g
dGltZSB0byBkbyBhbnl0aGluZyBhYm91dCBpdC4NCj4+DQo+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgQWx0aG91Z2ggSSBhbSBub3QgZmFtaWxpYXIgd2l0aCBob3cgb3RoZXIgRFJNDQo+
Pj4gZHJpdmVycyBhcmUgaGFuZGxpbmcgdGhpcyBraW5kIG9mIHNjZW5hcmlvcy4gTWF5YmUgeW91
IGFuZC9vciBvdGhlciBEUk0NCj4+PiBndXlzIGtub3dzIG1vcmUgYWJvdXQgaXQuDQo+Pg0KPj4g
SSBkb24ndCBrbm93IChhbmQgSSBtZWFuIGl0IGxpdGVyYWxseSksIGJ1dCBtYXliZSB0aGVzZSBj
aGlwcyBhcmUgc3BlY2lhbA0KPj4gYXMgdGhleSB0eXBpY2FsbHkgZW5kIHVwIHdpdGggdmVyeSBz
bWFsbCBkaXZpZGVycyBhbmQgdGh1cyBsYXJnZSBmcmVxdWVuY3kNCj4+IHN0ZXBzPyBCVFcsIEkg
ZG8gbm90IGNvbnNpZGVyIG15c2VsZiBhIERSTSBndXksIEkgaGF2ZSBvbmx5IHRyaWVkIHRvDQo+
PiBmaXggdGhhdCB3aGljaCBkaWQgbm90IHdvcmsgb3V0IGZvciBvdXIgbmVlZHMuLi4NCj4+DQo+
Pj4gSnVzdCBhcyBhIG5vdGljZSwgaXQgbWF5IHdvcnRoIGFkZGluZyBhIHByaW50IG1lc3NhZ2Ug
c2F5aW5nIHdoYXQgd2FzDQo+Pj4gZnJlcXVlbmN5IHdhcyByZXF1ZXN0ZWQgYW5kIHdoYXQgZnJl
cXVlbmN5IGhhcyBiZWVuIHNldHVwIGJ5IGRyaXZlci4NCj4+DQo+PiBJIGhhdmUgbm8gcHJvYmxl
bSB3aXRoIHRoYXQuDQo+IA0KPiBIaSBQZXRlciwNCj4gDQo+IEkgaW50ZW5kIHRvIHByZXBhcmUg
bXkgdjIgb2YgdGhpcyBzZXJpZXMuIEhvdyB3b3VsZCB5b3UgbGlrZSB0byBwcm9jZWVkDQo+IHdp
dGggdGhlIHBhdGNoIHlvdSBwcm92aWRlZD8gQXJlIHlvdSBPSyBpZiBJIGFkZCBpdCB0byBteSB2
MiBvZiB0aGlzIHNlcmllcw0KPiBvciB3b3VsZCB5b3UgcHJlZmVyIHRvIHNlbmQgaXQgb24geW91
ciBvd24/DQoNCkl0IHdvdWxkIGJlIGF3ZXNvbWUgaWYgeW91IHNoZXBoZXJkIGl0IGZvciBtZSwg
dGhhbmtzIQ0KDQpDaGVlcnMsDQpQZXRlcg0K
