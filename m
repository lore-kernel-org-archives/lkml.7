Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5598C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0EF2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2FcjTUGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEBIDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:03:05 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:38722 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfEBIDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:03:04 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Christian.Gromm@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Christian.Gromm@microchip.com";
  x-sender="Christian.Gromm@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Christian.Gromm@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Christian.Gromm@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,421,1549954800"; 
   d="scan'208";a="31310964"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 02 May 2019 01:03:03 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 2 May 2019 01:03:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jB8R2wPHmZpW5wkNFuZCjbE7fqD7E2KMeFbTFZmgzsg=;
 b=2FcjTUGsFoqNqsoK8JiK1jKUPzLLBdhuNSeY7aE+bNAJE6rfj0i1ILw6upYDfVCWKRjubeqZMVzELohWkH4EpqRPQEOa9xX/tHrCPa2PEEWGKzqztSKa294qBzgHXg2fZvHA1GgsfQ1ATngCMU98o1AhF/cxAfi/mwI97cp4QPY=
Received: from MN2PR11MB3710.namprd11.prod.outlook.com (20.178.252.215) by
 MN2PR11MB3902.namprd11.prod.outlook.com (10.255.180.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 2 May 2019 08:02:56 +0000
Received: from MN2PR11MB3710.namprd11.prod.outlook.com
 ([fe80::8dab:655a:59a2:ba40]) by MN2PR11MB3710.namprd11.prod.outlook.com
 ([fe80::8dab:655a:59a2:ba40%4]) with mapi id 15.20.1835.018; Thu, 2 May 2019
 08:02:56 +0000
From:   <Christian.Gromm@microchip.com>
To:     <erosca@de.adit-jv.com>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
CC:     <dan.carpenter@oracle.com>, <sudipi@jp.adit-jv.com>,
        <o-takashi@sakamocchi.jp>, <colin.king@canonical.com>,
        <andrey.shvetsov@k2l.de>, <tiwai@suse.de>,
        <roscaeugeniu@gmail.com>, <marcin.s.ciupak@gmail.com>
Subject: Re: [PATCH] staging: most: cdev: fix chrdev_region leak in mod_exit
Thread-Topic: [PATCH] staging: most: cdev: fix chrdev_region leak in mod_exit
Thread-Index: AQHU+tN5IgKTYbcaoU6Jhe9IvPmqQaZXhhyA
Date:   Thu, 2 May 2019 08:02:56 +0000
Message-ID: <1556784361.2199.1.camel@microchip.com>
References: <20190424192343.15418-1-erosca@de.adit-jv.com>
In-Reply-To: <20190424192343.15418-1-erosca@de.adit-jv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.154.213.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3efd87c5-e797-4cbb-94e6-08d6ced49608
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR11MB3902;
x-ms-traffictypediagnostic: MN2PR11MB3902:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB3902557063B2393724C3D504F8340@MN2PR11MB3902.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:179;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(136003)(396003)(346002)(199004)(189003)(66946007)(91956017)(486006)(305945005)(66476007)(73956011)(256004)(102836004)(2501003)(66556008)(6486002)(14444005)(14454004)(36756003)(76116006)(6436002)(72206003)(7736002)(64756008)(66446008)(446003)(966005)(478600001)(110136005)(2616005)(54906003)(186003)(11346002)(26005)(6506007)(6512007)(6306002)(476003)(7416002)(2906002)(53936002)(2201001)(229853002)(6116002)(68736007)(316002)(4326008)(103116003)(99286004)(76176011)(66066001)(5660300002)(25786009)(86362001)(81166006)(8676002)(81156014)(6246003)(8936002)(71200400001)(71190400001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3902;H:MN2PR11MB3710.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n45SNq1uszvdoqFIxzWSaoWBYu5js7cPtZuxb638V3+iT2KJ98GTyrTb1kWR1DOSXcXhrpYCX+8JdECQePZjpOWjhpVG9U2x2d1O0qu6bvndH8y7Oqed6vnFNzconkX1jjBF0r7Awl6QEPkeVuhvwiZD4yyQRBZY0ehtunaoahUqameGm/cacBsK3bevjYOSSyBhh5TrS/h4bBfNvYfbkpZ0tBJvCejy768jtQRToCOUCIDAz66Xq8ju0H9OuxmYk1H8WQ/Sz0rqTrlV7mj8GufscU8J47OeJ9soxOpRW8paybEbi0Q5M/QICK958i2cM0TAkGE3UMh4kmDazn29xhh4bOHWFdmdvHbVo9Ifjg5nU/rVWT/+tTpIeIuT5KG8E2t8/oJ9BxF1Q/RWtdEDCTvtD8rzDpMtePA8s/xj1uI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F55FE955468DD548A67FA09241931D1C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efd87c5-e797-4cbb-94e6-08d6ced49608
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:02:56.3856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3902
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWksIDIwMTktMDQtMjQgYXQgMjE6MjMgKzAyMDAsIEV1Z2VuaXUgUm9zY2Egd3JvdGU6DQo+
IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IEZyb206IFN1cmVzaCBVZGlwaSA8c3VkaXBpQGpw
LmFkaXQtanYuY29tPg0KPiANCj4gSXQgbG9va3MgbGlrZSB2NC4xOC1yYzEgY29tbWl0IFswXSB3
aGljaCB1cHN0cmVhbXMgbWxkLTEuOC4wDQo+IGNvbW1pdCBbMV0gbWlzc2VkIHRvIGZpeCB0aGUg
bWVtb3J5IGxlYWsgaW4gbW9kX2V4aXQgZnVuY3Rpb24uDQo+IA0KPiBEbyBpdCBub3cuDQo+IA0K
PiBbMF0gYWJhMjU4YjczMTAxNjcgKCJzdGFnaW5nOiBtb3N0OiBjZGV2OiBmaXggY2hyZGV2X3Jl
Z2lvbiBsZWFrIikNCj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9taWNyb2NoaXAtYWlzL2xpbnV4
L2NvbW1pdC9hMmQ4ZjdhZTdlYTM4MQ0KPiDCoMKgwqDCoCgic3RhZ2luZzogbW9zdDogY2Rldjog
Zml4IGxlYWsgZm9yIGNocmRldl9yZWdpb24iKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3VyZXNo
IFVkaXBpIDxzdWRpcGlAanAuYWRpdC1qdi5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaXUg
Um9zY2EgPGVyb3NjYUBkZS5hZGl0LWp2LmNvbT4NCg0KQWNrZWQtYnk6IENocmlzdGlhbiBHcm9t
bSA8Y2hyaXN0aWFuLmdyb21tQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9z
dGFnaW5nL21vc3QvY2Rldi9jZGV2LmMgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFn
aW5nL21vc3QvY2Rldi9jZGV2LmMNCj4gYi9kcml2ZXJzL3N0YWdpbmcvbW9zdC9jZGV2L2NkZXYu
Yw0KPiBpbmRleCBmMmIzNDdjZGE4YjcuLmQ1ZjIzNjg4OTAyMSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9zdGFnaW5nL21vc3QvY2Rldi9jZGV2LmMNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL21v
c3QvY2Rldi9jZGV2LmMNCj4gQEAgLTU0OSw3ICs1NDksNyBAQCBzdGF0aWMgdm9pZCBfX2V4aXQg
bW9kX2V4aXQodm9pZCkNCj4gwqAJCWRlc3Ryb3lfY2RldihjKTsNCj4gwqAJCWRlc3Ryb3lfY2hh
bm5lbChjKTsNCj4gwqAJfQ0KPiAtCXVucmVnaXN0ZXJfY2hyZGV2X3JlZ2lvbihjb21wLmRldm5v
LCAxKTsNCj4gKwl1bnJlZ2lzdGVyX2NocmRldl9yZWdpb24oY29tcC5kZXZubywgQ0hSREVWX1JF
R0lPTl9TSVpFKTsNCj4gwqAJaWRhX2Rlc3Ryb3koJmNvbXAubWlub3JfaWQpOw0KPiDCoAljbGFz
c19kZXN0cm95KGNvbXAuY2xhc3MpOw0KPiDCoH0=
