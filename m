Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B52C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107282087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="WdfCl8sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfCYQcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:32:31 -0400
Received: from mail-eopbgr710086.outbound.protection.outlook.com ([40.107.71.86]:30087
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfCYQcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDOm3rTqro8/g+BzmKM99Nb2H+pkdabeXl4S3/pakYI=;
 b=WdfCl8srwSCKXLjFJidHVyQ4IipE9K4O9uxAPehn+v0T93L1ntRMZ/1dtCalf8I8/53vQJVo6Um9WMhFIP2GiN4ewtpFGs7U2wz4IolV/6lCWEc8Vl6yybBbQQwlO5DdzfC9oPoOIsuDCgev+Nh7xErbVT76SMRsSUtc635DgPY=
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com (52.132.21.33) by
 BL0PR1501MB2068.namprd15.prod.outlook.com (52.132.21.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 16:32:01 +0000
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047]) by BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 16:32:01 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     syzbot <syzbot+251ec6887ada6eac4921@syzkaller.appspotmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
Subject: RE: inconsistent lock state in icmp_send
Thread-Topic: inconsistent lock state in icmp_send
Thread-Index: AQHU4kbSK0cg+0m7nUu4Fze/wDhQDaYciwhw
Date:   Mon, 25 Mar 2019 16:32:01 +0000
Message-ID: <BL0PR1501MB20038874DDA7C8371A9969699A5E0@BL0PR1501MB2003.namprd15.prod.outlook.com>
References: <0000000000000a9cca057cd141bd@google.com>
 <0000000000005986b10584d73269@google.com>
In-Reply-To: <0000000000005986b10584d73269@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [24.225.233.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 644027b4-dd17-490e-65e9-08d6b13f68bb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR1501MB2068;
x-ms-traffictypediagnostic: BL0PR1501MB2068:
x-ms-exchange-purlcount: 7
x-microsoft-antispam-prvs: <BL0PR1501MB20681EC7F88E0F8FD808501F9A5E0@BL0PR1501MB2068.namprd15.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(199004)(189003)(13464003)(8676002)(68736007)(81166006)(6246003)(102836004)(106356001)(105586002)(81156014)(6506007)(76176011)(14454004)(53546011)(3846002)(5660300002)(110136005)(25786009)(33656002)(66066001)(7696005)(86362001)(2501003)(99286004)(2201001)(476003)(8936002)(305945005)(6306002)(9686003)(97736004)(6116002)(55016002)(53936002)(486006)(74316002)(11346002)(7736002)(966005)(186003)(229853002)(6436002)(44832011)(26005)(71200400001)(52536014)(256004)(446003)(2906002)(498600001)(14444005)(71190400001)(99710200001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1501MB2068;H:BL0PR1501MB2003.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ITfKSVvO5Qs/VOd/QTwjsYJ3P0tvT88xMnJgwGdffeBRJlcTGnwT1xRyq/9sC1gZyCBz/m4mWYRl15z9xU9YTQ8lEIbs6eUfbsQLLzNhITBpRPChArrTxADquDE9wOsuvWu4rvw53/ntNeuj2XIfgUL+FU5pbX/Ep5UgWnp0r+Rd+G6xR9ZrnT9Obv0spLRLFQ63yNaWbJm53p+Cs5XC0vZxgz0lHB9ul46UpQLif7+tUKQfnN0c3jx7dYAm0U6GDgduY6MTI6XR/LUSiqs/111KRsy02iGLCvNFEZzUNz6e/afVM0lLSPetbaMwZsFrLEzmScTmwq6Chn7jAXLZCAFJoed6jgQQWWqV4HiDPpBtov/g6L3oy2Se8r5fyEO+yNej/3X/cFwcv+rJ4WvqVQmn8CBWmhp7GVDeadHjPKs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644027b4-dd17-490e-65e9-08d6b13f68bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 16:32:01.5580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SnVzdCBhbm90aGVyIG1hbmlmZXN0YXRpb24gb2YgIHN5emJvdCthMjUzMDdhZDA5OTMwOWYxYzJi
OUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tDQoNCldlIGhhdmUganVzdCBwb3N0ZWQgYSBwYXRj
aCBmaXhpbmcgdGhpcy4NCg0KLy8vam9uDQoNCj4gU2lnbmVkLW9mZi1ieTogWGluIExvbmcgPGx1
Y2llbi54aW5AZ21haWwuY29tPg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IG5ldGRldi1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPG5ldGRldi1vd25lckB2Z2VyLmtlcm5l
bC5vcmc+DQo+IE9uIEJlaGFsZiBPZiBzeXpib3QNCj4gU2VudDogMjQtTWFyLTE5IDE0OjM4DQo+
IFRvOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBKb24gTWFsb3kgPGpvbi5tYWxveUBlcmljc3Nvbi5j
b20+Ow0KPiBrdXpuZXRAbXMyLmluci5hYy5ydTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgc3l6a2FsbGVyLWJ1Z3NAZ29vZ2xlZ3JvdXBz
LmNvbTsgdGlwYy0NCj4gZGlzY3Vzc2lvbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7IHlpbmcueHVl
QHdpbmRyaXZlci5jb207IHlvc2hmdWppQGxpbnV4LQ0KPiBpcHY2Lm9yZw0KPiBTdWJqZWN0OiBS
ZTogaW5jb25zaXN0ZW50IGxvY2sgc3RhdGUgaW4gaWNtcF9zZW5kDQo+IA0KPiBzeXpib3QgaGFz
IGJpc2VjdGVkIHRoaXMgYnVnIHRvOg0KPiANCj4gY29tbWl0IDUyZGZhZTVjODVhNGMxMDc4ZTlm
MWQ1ZTg5NDdkNGEyNWY3M2RkODENCj4gQXV0aG9yOiBKb24gTWFsb3kgPGpvbi5tYWxveUBlcmlj
c3Nvbi5jb20+DQo+IERhdGU6ICAgVGh1IE1hciAyMiAxOTo0Mjo1MiAyMDE4ICswMDAwDQo+IA0K
PiAgICAgIHRpcGM6IG9idGFpbiBub2RlIGlkZW50aXR5IGZyb20gaW50ZXJmYWNlIGJ5IGRlZmF1
bHQNCj4gDQo+IGJpc2VjdGlvbiBsb2c6ICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94
L2Jpc2VjdC50eHQ/eD0xMjYxOTkxNzIwMDAwMA0KPiBzdGFydCBjb21taXQ6ICAgZjVkNTgyNzcg
TWVyZ2UgYnJhbmNoICdmb3ItbGludXMnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnLy4uDQo+IGdp
dCB0cmVlOiAgICAgICB1cHN0cmVhbQ0KPiBmaW5hbCBjcmFzaDogICAgaHR0cHM6Ly9zeXprYWxs
ZXIuYXBwc3BvdC5jb20veC9yZXBvcnQudHh0P3g9MTE2MTk5MTcyMDAwMDANCj4gY29uc29sZSBv
dXRwdXQ6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4dD94PTE2NjE5OTE3
MjAwMDAwDQo+IGtlcm5lbCBjb25maWc6ICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94
Ly5jb25maWc/eD1jODk3MGM4OWEwZWZiYjIzDQo+IGRhc2hib2FyZCBsaW5rOg0KPiBodHRwczov
L3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9MjUxZWM2ODg3YWRhNmVhYzQ5MjENCj4g
c3l6IHJlcHJvOiAgICAgIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwcm8uc3l6
P3g9MTBhYjZiYTM0MDAwMDANCj4gDQo+IFJlcG9ydGVkLWJ5OiBzeXpib3QrMjUxZWM2ODg3YWRh
NmVhYzQ5MjFAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPiBGaXhlczogNTJkZmFlNWM4NWE0
ICgidGlwYzogb2J0YWluIG5vZGUgaWRlbnRpdHkgZnJvbSBpbnRlcmZhY2UgYnkgZGVmYXVsdCIp
DQo+IA0KPiBGb3IgaW5mb3JtYXRpb24gYWJvdXQgYmlzZWN0aW9uIHByb2Nlc3Mgc2VlOg0KPiBo
dHRwczovL2dvby5nbC90cHNtRUojYmlzZWN0aW9uDQo=
