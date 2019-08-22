Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297CFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26DC233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sOQ8LTGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391631AbfHVRqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:46:43 -0400
Received: from mail-eopbgr760089.outbound.protection.outlook.com ([40.107.76.89]:34198
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389333AbfHVRqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:46:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doa8mFEOXXTu2eBDGc8GMCl5aKHD4TEQHqm5DYVQytYhRQW/kd2yIzZQxNnLIqMw41I1mJMrGNR0UERx9fFFpxJOcYNEKMdHGcPOZ6NuAqN/9ZIlzNdEXziQhknTI0j8N+kqjYCZtiE03+Dp8lSAzbfvePXzktJtHPevmn6YpjzUYfv7V8Ikl2oA+vQp1bdvaJFepramr1XnJtRNQexpZjHSBF2z/NOtv8okUB2IMbMKkBBDAMRdmZLMldVVdncZavD4RAXgQTey9W8eIE54URna1aTnRKCvwJl+jU5ZRJYGKJEWoVYl+mDJFV82gazGf0x3y2vJtN7r3TejHuSp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUK30UwzVfHljYQyXvmnFcFhPo0kD61tDWawQOrlqfw=;
 b=ZOqntH1u90GyDIPEU75a3zZ7iQuZPHbAgf6C5HgEnW07NaPojMmXycKu4fGc5BUesZ8DWPQXCYj242tx23xN6dJBMMvaO9nKqwEBWaQQy07Bp8WSF+nZJwQDOny3QyFUnnUZ/ANoYIY4a1diWC0R+DcW2qOtEmfP2L61BpgrL2LnggV70niIuGa2Udnn1Cr8VVeLsQ5PTJaJW6xM/IMnKILyr+j7smLzTnR8h2g4c8TAMCVaNHxUqEdCMys549rd4t40RhYMfM9w80+PztXXwqsaS5T33GmsP0jq6k9Q+BEU0Paz/7CRDfOU+7fMID+KezxJudI9RmReHR5+oB8LCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUK30UwzVfHljYQyXvmnFcFhPo0kD61tDWawQOrlqfw=;
 b=sOQ8LTGhf7Sqavj90klmUiYcgPiNH5mbgRchtrSvu0XBltc1cTJbceVjnUTGUNYVu9JO+NCJF5wCRPpkl5ptLDXWCdDKzehBajAToTpfaRuoQUHS9s0ZGy6SxTpedx9XmXsGbbKvCyC7eUTVuHuWuYlH+3vBdqqhFmPRDhY4wzQ=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.231.93) by
 CH2PR02MB6789.namprd02.prod.outlook.com (20.180.17.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 17:46:38 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::5c58:16c0:d226:4c96]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::5c58:16c0:d226:4c96%2]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 17:46:37 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Colin King <colin.king@canonical.com>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] misc: xilinx_sdfec: fix spelling mistake: "Schdule"
 -> "Schedule"
Thread-Topic: [PATCH][next] misc: xilinx_sdfec: fix spelling mistake:
 "Schdule" -> "Schedule"
Thread-Index: AQHVVnJP4VcE2hpVHUK1v1iNBAmG8KcHdetw
Date:   Thu, 22 Aug 2019 17:46:37 +0000
Message-ID: <CH2PR02MB635948C20B17ED85455EBE06CBA50@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <20190819094137.390-1-colin.king@canonical.com>
In-Reply-To: <20190819094137.390-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adab16dc-e1fa-4594-453c-08d72728ae71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR02MB6789;
x-ms-traffictypediagnostic: CH2PR02MB6789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB6789CA4D05A5230057A05873CBA50@CH2PR02MB6789.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39840400004)(376002)(396003)(136003)(13464003)(189003)(199004)(2906002)(316002)(229853002)(66476007)(76116006)(76176011)(66946007)(54906003)(305945005)(74316002)(478600001)(99286004)(110136005)(64756008)(66446008)(66556008)(55016002)(9686003)(6436002)(71200400001)(71190400001)(7736002)(7696005)(14444005)(3846002)(486006)(6116002)(66066001)(33656002)(53936002)(52536014)(5660300002)(14454004)(11346002)(446003)(53546011)(6246003)(8936002)(6506007)(81166006)(81156014)(26005)(8676002)(25786009)(186003)(102836004)(86362001)(4326008)(256004)(476003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6789;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UTsoc5jSyL/8viEq6rlvcvp5hkfG/Ts6DnteM2Sdt0Q1yQBGKIMM0QJXkUxQLam2ii7G/xyB+sR/USV19Av1TF9FhahwZiuYcwtfrJd/b7mqquVRIiA0yruUGn4eGUbJt2Tfu4514NcWrBwG5Ve63nV+Ktyrwjf5wzPsfpK8yOsDvKL9V/pdp7pXU7tdKTRusSjr+iZqoXWAUpi7PqdTffqctm3/oCpZqRpyeUXoOYeg+Spoink812cIM8V1BXftV5qu/kcg4/5xHULCQB2os1/5uuBebhpdPjWgmRGzHv5S+9MalGVRFdZ+uOtHzJMv3iW6aGv/tVemGHt4muKhRl9XyPXQDnb+AcoAk8MVsD9o/+8rmJoyeQun8FJasKBkoDA7a00iL129/4mMnwaRl1xsOThy3v4Ka1W4PI9AUBE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adab16dc-e1fa-4594-453c-08d72728ae71
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 17:46:37.3789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tr+bfPqEx5j0SQ5ne1RVTeQW+iqgnYADnchG5BxZEYWK2/xED8l3q81sxQrJ5uyPCM3KUiBoA37i5fok5imZ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29saW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29saW4g
S2luZyBbbWFpbHRvOmNvbGluLmtpbmdAY2Fub25pY2FsLmNvbV0NCj4gU2VudDogTW9uZGF5IDE5
IEF1Z3VzdCAyMDE5IDEwOjQyDQo+IFRvOiBEZXJlayBLaWVybmFuIDxka2llcm5hbkB4aWxpbngu
Y29tPjsgRHJhZ2FuIEN2ZXRpYyA8ZHJhZ2FuY0B4aWxpbnguY29tPjsgQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT47IEdyZWcgS3JvYWgtDQo+IEhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPjsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+OyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENI
XVtuZXh0XSBtaXNjOiB4aWxpbnhfc2RmZWM6IGZpeCBzcGVsbGluZyBtaXN0YWtlOiAiU2NoZHVs
ZSIgLT4gIlNjaGVkdWxlIg0KPiANCj4gRnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdA
Y2Fub25pY2FsLmNvbT4NCj4gDQo+IFRoZXJlIGlzIGEgc3BlbGxpbmcgbWlzdGFrZSBpbiBhIGRl
dl9kYmcgbWVzc2FnZSwgZml4IGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtp
bmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21pc2MveGls
aW54X3NkZmVjLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MveGlsaW54X3NkZmVj
LmMgYi9kcml2ZXJzL21pc2MveGlsaW54X3NkZmVjLmMNCj4gaW5kZXggOTEyZTkzOWRlYzYyLi5i
MjVjNThlZTYxOGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy94aWxpbnhfc2RmZWMuYw0K
PiArKysgYi9kcml2ZXJzL21pc2MveGlsaW54X3NkZmVjLmMNCj4gQEAgLTU1Myw3ICs1NTMsNyBA
QCBzdGF0aWMgaW50IHhzZGZlY19yZWcyX3dyaXRlKHN0cnVjdCB4c2RmZWNfZGV2ICp4c2RmZWMs
IHUzMiBubGF5ZXJzLCB1MzIgbm1xYywNCj4gIAkJIFhTREZFQ19SRUcyX05PX0ZJTkFMX1BBUklU
WV9NQVNLKTsNCj4gIAlpZiAobWF4X3NjaGVkdWxlICYNCj4gIAkgICAgfihYU0RGRUNfUkVHMl9N
QVhfU0NIRURVTEVfTUFTSyA+PiBYU0RGRUNfUkVHMl9NQVhfU0NIRURVTEVfTFNCKSkNCj4gLQkJ
ZGV2X2RiZyh4c2RmZWMtPmRldiwgIk1heCBTY2hkdWxlIGV4Y2VlZHMgMiBiaXRzIik7DQo+ICsJ
CWRldl9kYmcoeHNkZmVjLT5kZXYsICJNYXggU2NoZWR1bGUgZXhjZWVkcyAyIGJpdHMiKTsNCj4g
IAltYXhfc2NoZWR1bGUgPSAoKG1heF9zY2hlZHVsZSA8PCBYU0RGRUNfUkVHMl9NQVhfU0NIRURV
TEVfTFNCKSAmDQo+ICAJCQlYU0RGRUNfUkVHMl9NQVhfU0NIRURVTEVfTUFTSyk7DQo+IA0KPiAt
LQ0KPiAyLjIwLjENCg0KUmV2aWV3ZWQtYnk6IERyYWdhbiBDdmV0aWMgPGRyYWdhbi5jdmV0aWNA
eGlsaW54LmNvbT4NCg0KVGhhbmtzLA0KRHJhZ2FuDQo=
