Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15467C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC07E20989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="gSlczPVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfCYQej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:34:39 -0400
Received: from mail-eopbgr710068.outbound.protection.outlook.com ([40.107.71.68]:2209
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729648AbfCYQeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07fsGvYmVhq4sIBJpvb+eSbUdcuHZPzfkbJNzH+Q3f8=;
 b=gSlczPVqA54OnnGtxDApb3e6Jcj7vIeTU5DZO6Y7hB3n8yvrMEc+xmBeQUG/uu3towljTHHFHRHDALPyYjgx15Me+mN4oiT0gs09QtXpk8ZD9+YYiypK2DH7QSGdAoXNHCKofJ0KLJoEZ7z+laYIfLsEmHbJ5+tsssV84HVc6+c=
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com (52.132.21.33) by
 BL0PR1501MB2068.namprd15.prod.outlook.com (52.132.21.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 16:34:32 +0000
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047]) by BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 16:34:32 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     syzbot <syzbot+ba21d65f55b562432c58@syzkaller.appspotmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
Subject: RE: WARNING: locking bug in icmp_send
Thread-Topic: WARNING: locking bug in icmp_send
Thread-Index: AQHU4aKtpv/H8KwmQkaYLwC8x05gkaYcjZhg
Date:   Mon, 25 Mar 2019 16:34:32 +0000
Message-ID: <BL0PR1501MB20033F21FB21816CC2F50AA49A5E0@BL0PR1501MB2003.namprd15.prod.outlook.com>
References: <000000000000bc227a0582464e62@google.com>
 <0000000000003d44980584c6c82a@google.com>
In-Reply-To: <0000000000003d44980584c6c82a@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [24.225.233.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4b11083-f8e8-4203-2e8b-08d6b13fc2b0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR1501MB2068;
x-ms-traffictypediagnostic: BL0PR1501MB2068:
x-ms-exchange-purlcount: 7
x-microsoft-antispam-prvs: <BL0PR1501MB2068B9830AB5A3CF7415F9299A5E0@BL0PR1501MB2068.namprd15.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39850400004)(366004)(199004)(189003)(13464003)(8676002)(68736007)(81166006)(6246003)(102836004)(106356001)(105586002)(81156014)(6506007)(76176011)(14454004)(53546011)(3846002)(5660300002)(110136005)(25786009)(316002)(33656002)(66066001)(7696005)(86362001)(2501003)(99286004)(2201001)(476003)(8936002)(305945005)(6306002)(9686003)(97736004)(6116002)(55016002)(53936002)(486006)(74316002)(11346002)(7736002)(478600001)(966005)(186003)(229853002)(6436002)(44832011)(26005)(71200400001)(52536014)(256004)(446003)(2906002)(14444005)(71190400001)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1501MB2068;H:BL0PR1501MB2003.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RcYR9gKFa20h2CAqwUSTjlZCwad98i2Pi1IPha31HpJXWZGWAEB32yI7ZQf9s8ojgK2hNGOvLVGQsaT1vkamdPJNlBpkl+AmgXj/8JKESZmmqKM8m2/eKA2xSoY78EBcOMBkzDgHdqPGYet3We2UfhyxFz5mUH1bOgb9WP1VrN19QeeAiIVvhm1qTjXHRSqcVlq8704ziighidwyD+fo6mEDJf/X6rt1KqeRj4pRtna+IQ7mpqG/P1NOj9a2h3b/LYGgVEam8LciuOGjuGX++0md0CcuqCqsWMRPZGeegzI6Zm9k9QAhWlTOW7nT0cLnUBlYRa+fBUeZwpZly8+EOVXe15jrY3NHtp+aigBoY788PXqJM2be8oKM2TT+5sg4gKc8BWfyTgXsna/Q1CFnBVHagy6xjEFBX7wYAjyOBHU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b11083-f8e8-4203-2e8b-08d6b13fc2b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 16:34:32.4754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWV0IGFub3RoZXIgZHVwbGljYXRlIG9mICBzeXpib3QrYTI1MzA3YWQwOTkzMDlmMWMyYjlAc3l6
a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KDQpBIGZpeCBoYXMgYmVlbiBwb3N0ZWQuDQoNCi8vL2pv
bg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbmV0ZGV2LW93bmVy
QHZnZXIua2VybmVsLm9yZyA8bmV0ZGV2LW93bmVyQHZnZXIua2VybmVsLm9yZz4NCj4gT24gQmVo
YWxmIE9mIHN5emJvdA0KPiBTZW50OiAyMy1NYXItMTkgMTk6MDMNCj4gVG86IGRhdmVtQGRhdmVt
bG9mdC5uZXQ7IEpvbiBNYWxveSA8am9uLm1hbG95QGVyaWNzc29uLmNvbT47DQo+IGt1em5ldEBt
czIuaW5yLmFjLnJ1OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOyBzeXprYWxsZXItYnVnc0Bnb29nbGVncm91cHMuY29tOyB0aXBjLQ0KPiBk
aXNjdXNzaW9uQGxpc3RzLnNvdXJjZWZvcmdlLm5ldDsgeWluZy54dWVAd2luZHJpdmVyLmNvbTsg
eW9zaGZ1amlAbGludXgtDQo+IGlwdjYub3JnDQo+IFN1YmplY3Q6IFJlOiBXQVJOSU5HOiBsb2Nr
aW5nIGJ1ZyBpbiBpY21wX3NlbmQNCj4gDQo+IHN5emJvdCBoYXMgYmlzZWN0ZWQgdGhpcyBidWcg
dG86DQo+IA0KPiBjb21taXQgNTJkZmFlNWM4NWE0YzEwNzhlOWYxZDVlODk0N2Q0YTI1ZjczZGQ4
MQ0KPiBBdXRob3I6IEpvbiBNYWxveSA8am9uLm1hbG95QGVyaWNzc29uLmNvbT4NCj4gRGF0ZTog
ICBUaHUgTWFyIDIyIDE5OjQyOjUyIDIwMTggKzAwMDANCj4gDQo+ICAgICAgdGlwYzogb2J0YWlu
IG5vZGUgaWRlbnRpdHkgZnJvbSBpbnRlcmZhY2UgYnkgZGVmYXVsdA0KPiANCj4gYmlzZWN0aW9u
IGxvZzogIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvYmlzZWN0LnR4dD94PTExYjZk
YzVkMjAwMDAwDQo+IHN0YXJ0IGNvbW1pdDogICBiNTM3MmZlNSBleGVjOiBsb2FkX3NjcmlwdDog
RG8gbm90IGV4ZWMgdHJ1bmNhdGVkIGludGVycHJlLi4NCj4gZ2l0IHRyZWU6ICAgICAgIHVwc3Ry
ZWFtDQo+IGZpbmFsIGNyYXNoOiAgICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L3Jl
cG9ydC50eHQ/eD0xM2I2ZGM1ZDIwMDAwMA0KPiBjb25zb2xlIG91dHB1dDogaHR0cHM6Ly9zeXpr
YWxsZXIuYXBwc3BvdC5jb20veC9sb2cudHh0P3g9MTViNmRjNWQyMDAwMDANCj4ga2VybmVsIGNv
bmZpZzogIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvLmNvbmZpZz94PTcxMzIzNDQ3
MjhlN2VjM2YNCj4gZGFzaGJvYXJkIGxpbms6DQo+IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3Qu
Y29tL2J1Zz9leHRpZD1iYTIxZDY1ZjU1YjU2MjQzMmM1OA0KPiBzeXogcmVwcm86ICAgICAgaHR0
cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9yZXByby5zeXo/eD0xNGM5MGZhNzQwMDAwMA0K
PiANCj4gUmVwb3J0ZWQtYnk6IHN5emJvdCtiYTIxZDY1ZjU1YjU2MjQzMmM1OEBzeXprYWxsZXIu
YXBwc3BvdG1haWwuY29tDQo+IEZpeGVzOiA1MmRmYWU1Yzg1YTQgKCJ0aXBjOiBvYnRhaW4gbm9k
ZSBpZGVudGl0eSBmcm9tIGludGVyZmFjZSBieSBkZWZhdWx0IikNCj4gDQo+IEZvciBpbmZvcm1h
dGlvbiBhYm91dCBiaXNlY3Rpb24gcHJvY2VzcyBzZWU6DQo+IGh0dHBzOi8vZ29vLmdsL3Rwc21F
SiNiaXNlY3Rpb24NCg==
