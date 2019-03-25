Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDE4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A2120848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZuN9CWU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbfCYUdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:33:36 -0400
Received: from mail-eopbgr710043.outbound.protection.outlook.com ([40.107.71.43]:29472
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729610AbfCYUdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak1EREfgwjlRSrD7jhgtd8LGkb3UXP7QxLbDUMBpyDs=;
 b=ZuN9CWU/tJXgXLZb4eW7OhPwc5L/tEAgimIg+lhL1dOIvsQeW2tMRlYodRgwGE8/HlQcP9ToCVZyQfc+TIXFXy3i52e75bD4qZ8EFtENzTKTiCr7tAZCD3HP8xYkLMlhOZftIwSwdVogFkuw7RxnZWLoenLyk14hvKJq1mBkJZA=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2782.namprd12.prod.outlook.com (52.135.107.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 20:33:31 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 20:33:31 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH] EDAC/amd64: Use maximum channel count for the EDAC channel
 layer size
Thread-Topic: [PATCH] EDAC/amd64: Use maximum channel count for the EDAC
 channel layer size
Thread-Index: AQHU40oCFvOyy4xqaEiYK0CJr0cY8Q==
Date:   Mon, 25 Mar 2019 20:33:30 +0000
Message-ID: <20190325203319.7603-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:805:de::21) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfa4a9ee-6e93-4443-5180-08d6b16124ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2782;
x-ms-traffictypediagnostic: SN6PR12MB2782:
x-microsoft-antispam-prvs: <SN6PR12MB278263D8BF78934A92A0D08FF85E0@SN6PR12MB2782.namprd12.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(316002)(81156014)(53936002)(8676002)(54906003)(7736002)(305945005)(8936002)(81166006)(66066001)(6916009)(68736007)(386003)(99286004)(97736004)(71200400001)(72206003)(478600001)(4326008)(50226002)(106356001)(14454004)(105586002)(2351001)(71190400001)(2501003)(5660300002)(14444005)(1076003)(486006)(2616005)(25786009)(476003)(86362001)(36756003)(6512007)(6486002)(6436002)(2906002)(6116002)(3846002)(186003)(256004)(102836004)(26005)(52116002)(5640700003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2782;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IFXqzm58GaGiTMls2QRANXRH3Jv28WM4I00FS7NhV6WDU2AsvBfe61mmB2kS3GSWmyExdNzPHhWFD1Iktmibp1KeJ2hzV2OqXeBFwCCEZGJFfXsAzrxepzYGfmieN+tkq3gEwYlDsdn5AdSccTbA5TwrvhsrtWGzsSa0HscobbjgMsb8t24H4133AYu+JOR89DOrgbj9+9M3i2g/1JssOr6vVyj2B5ociL6oC+AZABYA0CKB4P3YJFk/qTb9WCZozhIh9Lexix1q/4uExhITpjCmfXy9NbW3NXXoYuLdykPWdLMJX53OJ/uAf8FhXa0Y9FDJEZWdnYjoYp/hnBVvHNeUbh15pO1oAvwxSAF/5Lm5V3LSl3e31DhmzfFTYU5o4PsaAvAPMNJUz8skexWeQQb8NbGhMudC+2Xb77dxOzY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa4a9ee-6e93-4443-5180-08d6b16124ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 20:33:30.9471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2782
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The AMD64 EDAC module current hardcodes the EDAC channel layer size
(count) to two. Future AMD systems may have more channels than this.

Set the EDAC channel layer size equal to the maximum number of channels
possible for the system. On Family 17h and later, this is set in the
num_umcs variable. Older systems will continue to use two as the
default.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b7617fad282c..4c0239aeff2f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3357,8 +3357,14 @@ static int init_one_instance(unsigned int nid)
 	 * Always allocate two channels since we can have setups with DIMMs on
 	 * only one channel. Also, this simplifies handling later for the price
 	 * of a couple of KBs tops.
+	 *
+	 * On Fam17h+, the number of controllers may be greater than two. So set
+	 * the size equal to the maximum number of UMCs.
 	 */
-	layers[1].size =3D 2;
+	if (pvt->fam >=3D 0x17)
+		layers[1].size =3D num_umcs;
+	else
+		layers[1].size =3D 2;
 	layers[1].is_virt_csrow =3D false;
=20
 	mci =3D edac_mc_alloc(nid, ARRAY_SIZE(layers), layers, 0);
--=20
2.17.1

