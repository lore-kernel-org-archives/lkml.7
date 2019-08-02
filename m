Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A1AC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595CE217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="agKjVeU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405751AbfHBRjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:39:40 -0400
Received: from mail-eopbgr700100.outbound.protection.outlook.com ([40.107.70.100]:28256
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729364AbfHBRjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:39:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YI8HkPdN9AJMs/5hHENQ8D87hpq4yNsiQfyoIzdBSRgqs89wWfVg1uYh23yu38H5ZmVOZwYOHWemIWMcHEEJUI1V+5pBkn/JOJ93YWk0kTzLEF42msBqjIdIMG+QiqBcNBmC2qzgYhvNJaCmO3eMl8Ok9I1MEiPy+bQQghbTC9DgglHsD5qJE9607N8TT4fPIFbNfAYsqAFzcrUpewgRa0z5iPEsHco2a17bAequ3KuBODA+HoLdV+EgzU4sUtkgDbgGhmQRkgBZ5AAbj180hURcPUtxr/XKn0nsTvXUyaNUtrNmX2J6h4rjouJJ66ABJXsu8TUzNq3RItxEpc3Xqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeD2p+tolI/9LekmRqeEGBa6SSnMrJfhthUovMKBNBI=;
 b=RmQM4LNtOu1wbf4HrHaE1OhUpYrMlnfBhrYsRKb4xiLIdGAzN0YQFT5gXFLIvT3kFfcIVUCQVXz6vcQMy5TtviwF/iGZl8WfJ9MlkMqh6KwNncehYhcdQCWWTjPtvPEkLJeZRO3et0lpAJfA7lNYlpuvLzSgZ8DYRtXA4DvP7jk4HcaK6Yzj9SrWXOdVFYsrp4OVn05AASOxEAdjo6mhVRSvX13wrS6iWxuMnEqLJILU6tMraX+qpclDFkjuxDzw2OGsQ89F13EILP0EbBIKsVMVAfsWwaH2aoLlVTKgY24bxlU/G9VrRC6suDnNb3Q5lJ//kHqhASk4QnKaYuG0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bayhubtech.com;dmarc=pass action=none
 header.from=bayhubtech.com;dkim=pass header.d=bayhubtech.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeD2p+tolI/9LekmRqeEGBa6SSnMrJfhthUovMKBNBI=;
 b=agKjVeU43P3rmxwTocuTHoIcAnOXwfvC1PPb3zjKs/8J0NV87ZvfZfCNQfT7jXIhmaS29UyUnT1926WOParLKIVPIMClvbiAUMrbWZc4sVZrL5Lqqjpy5q1hbfRZFnpCn9kdGn8hNEXptXCNbb2R1XPyGFgIyrgnK1VF5nIWn38=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB1871.namprd16.prod.outlook.com (10.172.61.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Fri, 2 Aug 2019 17:39:34 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 17:39:34 +0000
From:   "Shirley Her (SC)" <shirley.her@bayhubtech.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Subject: [PATCH V4 1/2] mmc: sdhci: Fix O2 Host data read/write DLL Lock Phase
 shift issue
Thread-Topic: [PATCH V4 1/2] mmc: sdhci: Fix O2 Host data read/write DLL Lock
 Phase shift issue
Thread-Index: AQHVSVk/sGtN0W38RE+Zf8Kmy0Y9zg==
Date:   Fri, 2 Aug 2019 17:39:34 +0000
Message-ID: <1564767547-4515-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::19) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 542765c6-b198-44cc-d444-08d71770621a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:MWHPR16MB1871;
x-ms-traffictypediagnostic: MWHPR16MB1871:
x-microsoft-antispam-prvs: <MWHPR16MB1871B9B1D976093F69A9B5CF8BD90@MWHPR16MB1871.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(102836004)(2616005)(486006)(6486002)(71200400001)(476003)(71190400001)(6436002)(66066001)(99286004)(107886003)(52116002)(53936002)(36756003)(54906003)(110136005)(316002)(26005)(186003)(5660300002)(14454004)(25786009)(86362001)(66946007)(66476007)(66446008)(64756008)(66556008)(2501003)(305945005)(256004)(2906002)(14444005)(7736002)(68736007)(6116002)(386003)(508600001)(6506007)(4326008)(8936002)(3846002)(50226002)(8676002)(2201001)(81166006)(6512007)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB1871;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uIUGycj+8X2ztY8nJgIub8JYfd2xSelSYBCAkSVkd/SfVi55fAZE8DJzlhKw5dVuX0XnGEz15Bd7iscrIKfrbOLHBmqIG0+EyUGqGabt1cSgAFZbDy5VAozN+MazY5VCPLrepkT8yvx/VaX8Qu04v5dM91VI3s5JjVE0vE6rwacEiNvk8YWotT/XKcs62/6/X6SmjpQMkLU8TiWgZUu9BnKMYf2BBVHqonPAqMS+lUBQtgr34C8JS7oRZ2ojnLWN4JuUGmFpItNA7UL+LtpWQ/M3+55Z22Wtlfs37A3qFm8PNrm1YCOMYbXUGs2KMcTzDTuuETrpbluE4dFIX3txvfEhwe/D4KcEB0JCLTycF9BE8+NWsEW7izj5U5XD5H506+7EliLizqqcgHuzLdJckCAE3T7cDYUmb99Z2sGgN3I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542765c6-b198-44cc-d444-08d71770621a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 17:39:34.8884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shirley.her@bayhubtech.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB1871
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix data read/write error in HS200 mode due to chip DLL lock phase shift

Signed-off-by:Shirley Her<shirley.her@bayhubtech.com>
---
change in V4:
 1. add a bug fix in V3

change in V3:
 1. add more explanation in dll_recovery and execute_tuning function
 2. move dll_adjust_count to O2_host struct
 3. fix some coding style error
 4. renaming O2_PLL_WDT_CONTROL1 TO O2_PLL_DLL_WDT_CONTROL1

change in V2:
 1. use usleep_range instead of udelay
 2. move dll_adjust_count to sdhci-pci-o2micro.c

chagne in V1:
 1. add error recovery function to relock DLL with correct phase
 2. retuning HS200 after DLL locked
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 9dc4548..186a33d 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -51,7 +51,7 @@
 #define O2_SD_VENDOR_SETTING2	0x1C8
 #define O2_SD_HW_TUNING_DISABLE	BIT(4)
=20
-#define O2_PLL_WDT_CONTROL1	0x1CC
+#define O2_PLL_DLL_WDT_CONTROL1	0x1CC
 #define  O2_PLL_FORCE_ACTIVE	BIT(18)
 #define  O2_PLL_LOCK_STATUS	BIT(14)
 #define  O2_PLL_SOFT_RESET	BIT(12)
--=20
2.7.4

