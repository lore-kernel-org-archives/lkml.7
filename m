Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B77C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C428520B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="gAxycas2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbfHFHiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:38:03 -0400
Received: from mail-eopbgr130109.outbound.protection.outlook.com ([40.107.13.109]:54401
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728798AbfHFHiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:38:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpJVE5yvnb0/3kHTPGKSefDF3k0f63Kv96MlZOix91ti1+4dhoDK6nOq9qO+eRGRzwBhzabWtHPcGTwfzuG+YGyp5T5F/pPcxMXPd0xRYQdin9oh+i6YLL3wskcTbMKEW2K0Zz8k2hAFEtW0+tmsztRnF6w7VyYeB5qC42SDCoxymEU5mfSazMrfo5ZxJU9w38gvhkVcPpq4K4ZFoo8sG5aOl+MeigXWqM+VG3dPsEwJqExK8Ob90+tLCcDONBoc9Wgr72pLZ1ankF2noPhSBjj0rD07e09nxWbDf5Y31Rk+qOdHJVNLIJAx2NNO9e26ww7H8+X1awqM/YfiIYQKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL9uTtnDoyXcJaUYuWe0eqb82dh/PycIPEEUOO9Y1G0=;
 b=nHmJ/lK+EzFFEouIgMP1KveQqLlagfqUl5XiNp+njybpjJ+oVG7Uhm18RDBYAyG70RnP6zkiOZTNQnQZAwPrQ93Wqf0OTJT4ucNCZkEsmIdf2CYye6iSdkgjcx8K5VDokwzR2khq4QHodukeu+bx6sfuRByqimxyZst/F2LYcdADvjSqi8jHtBos5OxvElbfkBeLRejB2mpVgOpgz+mQwzq7cleszwVyI2Yo8oBrxdgEHyvt+tj1Dg33MXbnNOkJUWtit0RgA2IzoXG+7U0fgPNtvosvEcxt5TtPqoOA8kGV3fqlxZ6SIRNL62asFjTbrci3JVS2kfaMT5sukdYIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=habana.ai;dmarc=pass action=none
 header.from=habana.ai;dkim=pass header.d=habana.ai;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL9uTtnDoyXcJaUYuWe0eqb82dh/PycIPEEUOO9Y1G0=;
 b=gAxycas29Lu9mshYw5OAsSr5CPwEYuaL5hTx7Izv5gK6ME6LzM4/eERPRtwcTdHVEJJQCVy/LarTo1muAqYMtOvvQyUCR9s4OBUf0CEklb/pc11GdtdLFNCBncF5ibpoUhO+WFYCHW51iBWDX2jQ0gw3LL4loiGDMcLgnJWO78g=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3477.eurprd02.prod.outlook.com (52.133.8.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Tue, 6 Aug 2019 07:37:59 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::85d6:dc30:6af9:37a0]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::85d6:dc30:6af9:37a0%3]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 07:37:59 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] habanalabs: use default structure for user input in Debug
 IOCTL
Thread-Topic: [PATCH 1/2] habanalabs: use default structure for user input in
 Debug IOCTL
Thread-Index: AQHVTCne6ZTXebTy5UWlZtsghyMMiA==
Date:   Tue, 6 Aug 2019 07:37:59 +0000
Message-ID: <20190806073743.31575-1-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR1PR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::45) To AM6PR0202MB3382.eurprd02.prod.outlook.com
 (2603:10a6:209:20::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d883445-320e-42e2-10d6-08d71a410115
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR0202MB3477;
x-ms-traffictypediagnostic: AM6PR0202MB3477:
x-microsoft-antispam-prvs: <AM6PR0202MB347797A9F14B2A8347D4CD11B8D50@AM6PR0202MB3477.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(346002)(396003)(366004)(376002)(189003)(199004)(52116002)(316002)(81166006)(7736002)(478600001)(6486002)(14454004)(2501003)(50226002)(4326008)(3846002)(6116002)(6436002)(68736007)(25786009)(6512007)(1361003)(476003)(6916009)(26005)(66556008)(2616005)(66446008)(66946007)(64756008)(8676002)(2906002)(81156014)(8936002)(102836004)(486006)(66476007)(186003)(53936002)(5660300002)(6506007)(386003)(36756003)(86362001)(66066001)(256004)(71200400001)(71190400001)(1076003)(305945005)(5640700003)(99286004)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3477;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aqLsryotq0UiwJ3rrvLN8hOL82p4VlsYnZ/UomKtMW18mCGhoiaxLQ/IfhAcuxxsjRbcXbrGYoQ/Km3Yv1nFp1j0ZB333kOmDPPWQj2JIpFBxVUNrh7vCYRI7UK1acb051/ZMi6Vji2S/VcPV2QhqjZCgxDy4zV7T7SURUIk48oO2MkiibGrW0CeW2WNDXWezYPnsWPuOYyQTWBFOTetv7SRT1iugSdKUOPoNW+eU0A4schx2g9ZDrSsKCBnFv3S+tOjfqDbZC2czeCwKVaQ2FgPL8llGYR+RzIeMnderWwNkLAcqR7CVbyDqaSynm1m8JUySKw0Pi8gbxJT8Vo+9WCLZOVQUkYA8yOWC72g6x+k66DWyKN0Xt0SFQs4OdvQaSDbl/3d4z/F9L+y4Cp5wnS86jCrGQYsWV/dx/UXmZ8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d883445-320e-42e2-10d6-08d71a410115
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 07:37:59.2776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oshpigelman@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a possible kernel crash when a user provides a too small
input structure to the Debug IOCTL.
The fix sets a default input structure and copies to it the user data.
In case the user provided as input a too small structure, the code will
use the default values taken from the default structure.
Note that in contrary to the input structure, the user can provide an
output structure with changing size or no size at all. Therefore the user
output structure validation is already done in the Debug logic later on.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/habanalabs_ioctl.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/haba=
nalabs/habanalabs_ioctl.c
index ce0cd93a8421..3ce65459b01c 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -144,13 +144,16 @@ static int debug_coresight(struct hl_device *hdev, st=
ruct hl_debug_args *args)
 	params->op =3D args->op;
=20
 	if (args->input_ptr && args->input_size) {
-		input =3D memdup_user(u64_to_user_ptr(args->input_ptr),
-					args->input_size);
-		if (IS_ERR(input)) {
-			rc =3D PTR_ERR(input);
-			input =3D NULL;
-			dev_err(hdev->dev,
-				"error %d when copying input debug data\n", rc);
+		input =3D kzalloc(hl_debug_struct_size[args->op], GFP_KERNEL);
+		if (!input) {
+			rc =3D -ENOMEM;
+			goto out;
+		}
+
+		if (copy_from_user(input, u64_to_user_ptr(args->input_ptr),
+					args->input_size)) {
+			rc =3D -EFAULT;
+			dev_err(hdev->dev, "failed to copy input debug data\n");
 			goto out;
 		}
=20
--=20
2.17.1

