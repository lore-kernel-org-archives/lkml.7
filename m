Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144CAC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98FD2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="B3pTU7cT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbfKGPk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:40:26 -0500
Received: from mail-eopbgr690044.outbound.protection.outlook.com ([40.107.69.44]:53046
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727401AbfKGPkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:40:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+LckH3a0MtimrpLVKmXACugT2l9O+dM2hr9/XjaMEOV5dSPbmXiuYxnKdbs/6mhYiZ24Njhe/0Zpv7wVU1w632hzA5l9iEWargThMNk7U0zf8kGEKAMFhAsn+CKDUhZ8zdnEu4WB92XmnYNTTyO6A6PLXiGOwNDZq6PmRErR8K5QCxNS6hie/nD6KhjzQ0hMmn2hi38eT1dsta8SPEoq170HQHrX72Qqq+pv7nR7FbL/LlfyLTQoVVUmqYSSB3REWMkwDkmqbHSiIe9ejfACMi5Ac3cw2zyogGeCGGxN5Z1y2eGmkJHFkBsd75h8fwcJthUBATobNLXQm/ASi8XkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvni0J62Ve2Ge7pKRmAxe77Omz24CxDX6+9lN6xjcic=;
 b=KUSlhVAqHQw7iRmfNvCGaQDVpJQ8awnOXxPC1OJi3oq22u5cNW+ZrUgpNvIJe5nOgzi0R07eBl0LSxEejI/+fv5Y/BI/uPvV/4B8B8EZsILq7U4mRc0Jcpn0lMwIRWB8vI2HLzpsOpLg1XvRfs3S94LC4wNozpqLgYg7mK7+fektNbSrort38sD6Cg4s5oy0+ALlU1PVKXPpysQjqJf/Gs9qrNrzEP9qMvdQDIEvF9CJd7ZOzCQ0lNlr+z8acXBwUvHHLpNHwC82Uv6s4lJnxchjY5SuvSIQuB/uPJfIvyGStNV0KnioaFs6Ke8itQCrbyGTSwA3cLvSU8XSMPXGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvni0J62Ve2Ge7pKRmAxe77Omz24CxDX6+9lN6xjcic=;
 b=B3pTU7cTn2FPXoY6Fg6UCxrYgLkNXItfVAcQqlvI7Vgk5rqOpIq1CPK45coBjDd/yt9M2GU4hXDMPjIRX9JRciL3YK0Bsmb7sJK0H52IpPEj+kcmp/AXMVirUK93jsT6MTWdD80soB8Q8K11lMUSzrDZeEbcGnfPiGyB3+Fh+FM=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.230.25) by
 CH2PR02MB6102.namprd02.prod.outlook.com (52.132.229.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 15:40:23 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a%7]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 15:40:23 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 1/2] misc: xilinx_sdfec: Use memdup_user() rather than
 duplicating its implementation
Thread-Topic: [PATCH 1/2] misc: xilinx_sdfec: Use memdup_user() rather than
 duplicating its implementation
Thread-Index: AQHVlAp4a7DAmwL3UEy4xr76jpF77qd/2r7A
Date:   Thu, 7 Nov 2019 15:40:23 +0000
Message-ID: <CH2PR02MB6359C7594FC4969EBCF0301FCB780@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <af1ff373-56c0-ca49-36dd-15666d183c95@web.de>
 <f6f8f94b-295f-48f5-902e-3d6d4052d76b@web.de>
In-Reply-To: <f6f8f94b-295f-48f5-902e-3d6d4052d76b@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1dc1cb4-56ad-4d55-ac23-08d76398cd9a
x-ms-traffictypediagnostic: CH2PR02MB6102:|CH2PR02MB6102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB610296CBDC4F216403C93E78CB780@CH2PR02MB6102.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(199004)(13464003)(51914003)(189003)(26005)(64756008)(186003)(446003)(81156014)(71190400001)(25786009)(6436002)(8936002)(6636002)(102836004)(11346002)(74316002)(486006)(86362001)(53546011)(7736002)(8676002)(33656002)(4326008)(6506007)(76176011)(66446008)(55016002)(66476007)(71200400001)(66946007)(76116006)(3846002)(66556008)(99286004)(81166006)(305945005)(6116002)(2906002)(52536014)(2501003)(5660300002)(6246003)(14454004)(54906003)(7696005)(229853002)(256004)(316002)(9686003)(476003)(478600001)(66066001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6102;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +z5iXwzgmRxwPLC0Ytf7TN8v6AY1NfDxKFiC+DQItY2GQjarFtuqX/UV6g519r7YaOku+MSuVYlzzFSt8En7JC0sTfOok3JGO8xWUVwKLjBLyBPjqe9cTFp6t3quWIuibJ2e6pySbYWMWoVvT0Na2w4Ed7uOx0IxyFFY/uszVDqQV5gz+D85hZ3uSX6pPqC6beRmJvbt9DRJ67Lk7wxPD1UG64UZ6Z5ASgnT1omBsx2pkoHRnmvtlZDyHRZAp+E6DLILAamIaoB1jS7wpSH9wmDFqW6mksJCdY9kUL3swR5oRUg4+HljmOTiMMp8zFWzICE4okY4GWR7EiGVuwZM45c7yp/MoxJWGAzmzAEvQQ+WTwfnsHVQgU4+H4CB71q6wDHHnX4QF8OrNeSUP7T+xrtbIhmirD8t5aYC6nAZqV8XS1OXCJGSgSh+Voc/Sq0T
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dc1cb4-56ad-4d55-ac23-08d76398cd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 15:40:23.1329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiC2p8j1VNTLkbXEGFCHp5/+iEsVAPY6w7orqxJ/y1cWnwbCIOf4vCEBbD4VZ5VGz/ObXMEOINZfmRaeuMEflw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEkgTWFya3VzLA0KDQpUaGFua3MgZm9yIHRoZSBuaWNlIHNvbHV0aW9uLA0Kd2UgYXJlIGdvaW5n
IHRvIHRlc3QgdGhpcyBjaGFuZ2UgYW5kIGxldCB5b3Uga25vdyBhYm91dCB0aGUgcmVzdWx0Lg0K
DQpSZWdhcmRzDQpEcmFnYW4NCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IE1hcmt1cyBFbGZyaW5nIFttYWlsdG86TWFya3VzLkVsZnJpbmdAd2ViLmRlXQ0KPiBTZW50
OiBUdWVzZGF5IDUgTm92ZW1iZXIgMjAxOSAxODo1NQ0KPiBUbzogbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgRGVyZWsg
S2llcm5hbiA8ZGtpZXJuYW5AeGlsaW54LmNvbT47IERyYWdhbiBDdmV0aWMNCj4gPGRyYWdhbmNA
eGlsaW54LmNvbT47IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT4NCj4gQ2M6IExLTUwgPGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIG1pc2M6IHhpbGlueF9zZGZlYzogVXNlIG1lbWR1cF91
c2VyKCkgcmF0aGVyIHRoYW4gZHVwbGljYXRpbmcgaXRzIGltcGxlbWVudGF0aW9uDQo+IA0KPiBG
cm9tOiBNYXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+DQo+IERh
dGU6IFR1ZSwgNSBOb3YgMjAxOSAxOTowOToxNSArMDEwMA0KPiANCj4gUmV1c2UgZXhpc3Rpbmcg
ZnVuY3Rpb25hbGl0eSBmcm9tIG1lbWR1cF91c2VyKCkgaW5zdGVhZCBvZiBrZWVwaW5nDQo+IGR1
cGxpY2F0ZSBzb3VyY2UgY29kZS4NCj4gDQo+IEdlbmVyYXRlZCBieTogc2NyaXB0cy9jb2NjaW5l
bGxlL2FwaS9tZW1kdXBfdXNlci5jb2NjaQ0KPiANCj4gRml4ZXM6IDIwZWM2MjhlODAwN2VjNzVj
MmY4ODRlMDAwMDRmMzllYWI2Mjg5YjUgKCJtaXNjOiB4aWxpbnhfc2RmZWM6IEFkZCBhYmlsaXR5
IHRvIGNvbmZpZ3VyZSBMRFBDIikNCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEVsZnJpbmcgPGVs
ZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0KPiAtLS0NCj4gIGRyaXZlcnMvbWlzYy94aWxp
bnhfc2RmZWMuYyB8IDExICsrKy0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy94
aWxpbnhfc2RmZWMuYyBiL2RyaXZlcnMvbWlzYy94aWxpbnhfc2RmZWMuYw0KPiBpbmRleCAxMTgz
NTk2OWU5ODIuLmE2MjJmY2Y0OTU0YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9taXNjL3hpbGlu
eF9zZGZlYy5jDQo+ICsrKyBiL2RyaXZlcnMvbWlzYy94aWxpbnhfc2RmZWMuYw0KPiBAQCAtNjQ5
LDE0ICs2NDksOSBAQCBzdGF0aWMgaW50IHhzZGZlY19hZGRfbGRwYyhzdHJ1Y3QgeHNkZmVjX2Rl
diAqeHNkZmVjLCB2b2lkIF9fdXNlciAqYXJnKQ0KPiAgCXN0cnVjdCB4c2RmZWNfbGRwY19wYXJh
bXMgKmxkcGM7DQo+ICAJaW50IHJldCwgbjsNCj4gDQo+IC0JbGRwYyA9IGt6YWxsb2Moc2l6ZW9m
KCpsZHBjKSwgR0ZQX0tFUk5FTCk7DQo+IC0JaWYgKCFsZHBjKQ0KPiAtCQlyZXR1cm4gLUVOT01F
TTsNCj4gLQ0KPiAtCWlmIChjb3B5X2Zyb21fdXNlcihsZHBjLCBhcmcsIHNpemVvZigqbGRwYykp
KSB7DQo+IC0JCXJldCA9IC1FRkFVTFQ7DQo+IC0JCWdvdG8gZXJyX291dDsNCj4gLQl9DQo+ICsJ
bGRwYyA9IG1lbWR1cF91c2VyKGFyZywgc2l6ZW9mKCpsZHBjKSk7DQo+ICsJaWYgKElTX0VSUihs
ZHBjKSkNCj4gKwkJcmV0dXJuIFBUUl9FUlIobGRwYyk7DQo+IA0KPiAgCWlmICh4c2RmZWMtPmNv
bmZpZy5jb2RlID09IFhTREZFQ19UVVJCT19DT0RFKSB7DQo+ICAJCXJldCA9IC1FSU87DQo+IC0t
DQo+IDIuMjQuMA0KDQo=
