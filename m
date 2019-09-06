Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6738DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4D1218DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iI0TOKiy";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iI0TOKiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391798AbfIFHSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:18:33 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:62986
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727031AbfIFHSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt7L+662i7YqM8E1kVVQBKNPBL3JUrbegKFExr816SM=;
 b=iI0TOKiyD+VPmBWpm8L2K8/9xiaQuIBaLTglg+lWeLS3LPQnF/2BFBJGvmfx2EbBC+b/3he4JyL9ZQ46ow88MdzM+ttM9jD2wb9cbEGKsbaMyul7v5Ov/PKeSkXgkRL+3M8xdlBs5X0DdCVu1r2EXV0gp9Ry6X2XySPbo1l+3XQ=
Received: from AM4PR08CA0073.eurprd08.prod.outlook.com (2603:10a6:205:2::44)
 by AM0PR08MB4132.eurprd08.prod.outlook.com (2603:10a6:208:127::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.18; Fri, 6 Sep
 2019 07:18:21 +0000
Received: from AM5EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by AM4PR08CA0073.outlook.office365.com
 (2603:10a6:205:2::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.14 via Frontend
 Transport; Fri, 6 Sep 2019 07:18:21 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT055.mail.protection.outlook.com (10.152.17.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14 via Frontend Transport; Fri, 6 Sep 2019 07:18:19 +0000
Received: ("Tessian outbound a25c4e5fef41:v27"); Fri, 06 Sep 2019 07:18:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 185be6e1a1252d25
X-CR-MTA-TID: 64aa7808
Received: from 42e31b1b06b1.2 (cr-mta-lb-1.cr-mta-net [104.47.6.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1B3BB755-EA91-483C-9FBF-A8BFFBDE08AF.1;
        Fri, 06 Sep 2019 07:18:10 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2050.outbound.protection.outlook.com [104.47.6.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 42e31b1b06b1.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 06 Sep 2019 07:18:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8dEh9RQFYEiBeKFAmUfqW5ObWZ9o218ueH/ut+OtAXLfYoujzbRdi5gdtJeGMeyNlu0muSp+0xCDmgquR6mLqtPFawfEsOG5EHqIr+KWSFMEEECH47b9dQZgEs/WxSE2D0UCWReuxtZokIHlDqiyK771OuADXc9+2sS/LRoRnUIsLkLiyMJh1xIbC7bGp8c+t0TF56UDipfc2cIbzfYYS/c4FqG/ID+VdqL9hy/p2WRut9c0mQOGV+tGvBmU3rRqtBy5AgWqulgw7ZK/Z9egHc67HV073b7rHRX/m92FSB4iF5WzizKyiIrfxVPl5vNXmfr/Pn1CJsBU5NkFx5xIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt7L+662i7YqM8E1kVVQBKNPBL3JUrbegKFExr816SM=;
 b=gyQKrp1hZlLOE/4lOpluZToZ/qImJdwEMJuobZwEnfVmrY1MxonsLFxn3rUm8gOd201Ek7f0ehGPHdzwFhLE21wHte6RxxyWwbGjhfMNVqXchxRPs0e+ZQgdueWQTn7FElRDQhjjgCf/kZu86nnDpq3oA366utkt7a3z9NGhRRtjsF/AW91lXnL7Bh3PYJZBc70TXyyPRAmOXMcfLuHuIYp8MBjc/K8YE2X0pZ62o8C6I3SkGu5ZSpgWVwBPbLMnzEpTdxMchA4s4RrVy89fcJCFKF4zUkglikrPJmMPUlJ5eXZBMzjBnlApHrd8nqrESpvBuOT2hWUrvioD7RY+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt7L+662i7YqM8E1kVVQBKNPBL3JUrbegKFExr816SM=;
 b=iI0TOKiyD+VPmBWpm8L2K8/9xiaQuIBaLTglg+lWeLS3LPQnF/2BFBJGvmfx2EbBC+b/3he4JyL9ZQ46ow88MdzM+ttM9jD2wb9cbEGKsbaMyul7v5Ov/PKeSkXgkRL+3M8xdlBs5X0DdCVu1r2EXV0gp9Ry6X2XySPbo1l+3XQ=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB4062.eurprd08.prod.outlook.com (20.178.127.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.13; Fri, 6 Sep 2019 07:18:07 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b%3]) with mapi id 15.20.2241.014; Fri, 6 Sep 2019
 07:18:07 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: [PATCH] drm/komeda: SW workaround for D71 doesn't flush shadow
 registers
Thread-Topic: [PATCH] drm/komeda: SW workaround for D71 doesn't flush shadow
 registers
Thread-Index: AQHVZIM6o5HIk86gzk2duo5rdg8pbQ==
Date:   Fri, 6 Sep 2019 07:18:06 +0000
Message-ID: <20190906071750.4563-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0047.apcprd03.prod.outlook.com
 (2603:1096:203:2f::35) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8bf02176-de93-45ce-1b0a-08d7329a64e5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB4062;
X-MS-TrafficTypeDiagnostic: VI1PR08MB4062:|VI1PR08MB4062:|AM0PR08MB4132:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4132D1272464BCEFE5A9E2829FBA0@AM0PR08MB4132.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2733;OLM:2733;
x-forefront-prvs: 0152EBA40F
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(4326008)(6506007)(53936002)(14454004)(26005)(386003)(6436002)(25786009)(110136005)(316002)(86362001)(36756003)(2201001)(54906003)(52116002)(99286004)(66066001)(71200400001)(71190400001)(55236004)(186003)(102836004)(6512007)(14444005)(256004)(486006)(478600001)(2616005)(476003)(6636002)(305945005)(66446008)(7736002)(66556008)(64756008)(66946007)(6116002)(50226002)(66476007)(1076003)(6486002)(2501003)(5660300002)(8936002)(2906002)(81166006)(8676002)(3846002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4062;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: YvVjrMr0IS3saj5Qh/p4pj+npLSypgvLvfzhF+OhIf2pY3wf6UO2CcTpnQx95abglD5cfD04OEo1Ph2o9L6iBdfIn45FXuApy/qMbCZix1DqAlTA58cBDlatwbNHALLQAU1gVVFLdA+IFV4ZxodVwr9ePi268kW263Gc//LNgdwaL2Ox3I/DiCHpofdU+vE/uO+Xvr8DifIPzzhVsv1dCXbyN9RR1aeggrbEyT94mqY7YAUqKy+dmJPqG6D7JF3iXe+jQMfe95y78nAt5OBJJwHW0Um3UYH0pYAvRsLNhBdZxn7HtjHjVwODJvzzl8TMpeY12yyUPvnwHcIbr/0SA0akWXZAPEn/tA9LnvmlLz6aMH3ykgWBDeJzRxv+RGqEpIglzNw/+N5ZEzUXWYyvtAU0QZD2vb3ch/ZPN+uwgTk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4062
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(2980300002)(199004)(189003)(6512007)(50466002)(14454004)(81166006)(8746002)(8676002)(25786009)(81156014)(36756003)(8936002)(478600001)(14444005)(50226002)(305945005)(7736002)(26826003)(6486002)(2501003)(6636002)(66066001)(70586007)(70206006)(47776003)(76130400001)(2201001)(86362001)(63350400001)(63370400001)(356004)(5660300002)(2906002)(3846002)(6116002)(22756006)(1076003)(26005)(186003)(316002)(54906003)(110136005)(36906005)(386003)(6506007)(4326008)(102836004)(23756003)(476003)(486006)(336012)(99286004)(2616005)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4132;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b395017b-aa5c-4d3f-f756-08d7329a5d1e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB4132;
NoDisclaimer: True
X-Forefront-PRVS: 0152EBA40F
X-Microsoft-Antispam-Message-Info: kcRN17lHB78lL5h6Poyqhy/ac0bzstvchJukaUqEVCjlgXrajKJQwQymiPDWLc77fT9UpmmX7zcK0sI+P24EQWThm6GqlXmpHZbBMtQXiQt+XbJHvWyy5E7ADVhabiT+zQs2MF1QvZZ/usLlexIiRQBLb8IYyZFOgYWMM1Zph6D4SVmzoPkEoMdaOtNC7BZnN8bJHZ0J4kt304WEp1LuLTiIBADJB8XGg548K+3tXVBZPl05Xjmj24m274GaJxhBj7eWSZwd5EXRq/avGX45qCKhtYAjvUh8jewIxwy0lJ4pn0Wb/wQXdeBz/a289KhUG8HsDTL6PRBWcnlL5xzS5uNwCuLekO84bNUfvbgCDsPQEYz6P3S7mOf4QJu5Irk0CWPP9dIawyEcsCdpMo36FrBqPc5SYKxTji3+G0KGLPY=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2019 07:18:19.3841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf02176-de93-45ce-1b0a-08d7329a64e5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a SW workaround for shadow un-flushed when together with the
DOU Timing-disable.

D71 HW doesn't update shadow registers when display output is turned
off. So when we disable all pipeline components together with display
output disabling by one flush or one operation, the disable operation
updated registers will not be flushed or valid in HW, which may lead
problem. To workaround this problem, introduce a two phase disable for
pipeline disable.

Phase1: Disable components with display is on and flush it, this phase
        for flushing or validating the shadow registers.
Phase2: Turn-off display output.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 16 ++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 73 ++++++++++++-------
 .../drm/arm/display/komeda/komeda_pipeline.h  | 14 +++-
 .../display/komeda/komeda_pipeline_state.c    | 30 +++++++-
 4 files changed, 103 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index 2151cb3f9e68..e74069ef3b7b 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -487,6 +487,22 @@ static int d71_enum_resources(struct komeda_dev *mdev)
 			err =3D PTR_ERR(pipe);
 			goto err_cleanup;
 		}
+
+		/* D71 HW doesn't update shadow registers when display output
+		 * is turning off, so when we disable all pipeline components
+		 * together with display output disable by one flush or one
+		 * operation, the disable operation updated registers will not
+		 * be flush to or valid in HW, which may leads problem.
+		 * To workaround this problem, introduce a two phase disable.
+		 * Phase1: Disabling components with display is on to make sure
+		 *	   the disable can be flushed to HW.
+		 * Phase2: Only turn-off display output.
+		 */
+		value =3D KOMEDA_PIPELINE_IMPROCS |
+			BIT(KOMEDA_COMPONENT_TIMING_CTRLR);
+
+		pipe->standalone_disabled_comps =3D value;
+
 		d71->pipes[i] =3D to_d71_pipeline(pipe);
 	}
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 3155bb17ea1b..c0c803d56d5c 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -280,20 +280,53 @@ komeda_crtc_atomic_enable(struct drm_crtc *crtc,
 	komeda_crtc_do_flush(crtc, old);
 }
=20
+static void
+komeda_crtc_flush_and_wait_for_flip_done(struct komeda_crtc *kcrtc,
+					 struct completion *input_flip_done)
+{
+	struct drm_device *drm =3D kcrtc->base.dev;
+	struct komeda_dev *mdev =3D kcrtc->master->mdev;
+	struct completion *flip_done;
+	struct completion temp;
+	int timeout;
+
+	/* if caller doesn't send a flip_done, use a private flip_done */
+	if (input_flip_done) {
+		flip_done =3D input_flip_done;
+	} else {
+		init_completion(&temp);
+		kcrtc->disable_done =3D &temp;
+		flip_done =3D &temp;
+	}
+
+	mdev->funcs->flush(mdev, kcrtc->master->id, 0);
+
+	/* wait the flip take affect.*/
+	timeout =3D wait_for_completion_timeout(flip_done, HZ);
+	if (timeout =3D=3D 0) {
+		DRM_ERROR("wait pipe%d flip done timeout\n", kcrtc->master->id);
+		if (!input_flip_done) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&drm->event_lock, flags);
+			kcrtc->disable_done =3D NULL;
+			spin_unlock_irqrestore(&drm->event_lock, flags);
+		}
+	}
+}
+
 static void
 komeda_crtc_atomic_disable(struct drm_crtc *crtc,
 			   struct drm_crtc_state *old)
 {
 	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
 	struct komeda_crtc_state *old_st =3D to_kcrtc_st(old);
-	struct komeda_dev *mdev =3D crtc->dev->dev_private;
 	struct komeda_pipeline *master =3D kcrtc->master;
 	struct komeda_pipeline *slave  =3D kcrtc->slave;
 	struct completion *disable_done =3D &crtc->state->commit->flip_done;
-	struct completion temp;
-	int timeout;
+	bool needs_phase2 =3D false;
=20
-	DRM_DEBUG_ATOMIC("CRTC%d_DISABLE: active_pipes: 0x%x, affected: 0x%x.\n",
+	DRM_DEBUG_ATOMIC("CRTC%d_DISABLE: active_pipes: 0x%x, affected: 0x%x\n",
 			 drm_crtc_index(crtc),
 			 old_st->active_pipes, old_st->affected_pipes);
=20
@@ -301,7 +334,7 @@ komeda_crtc_atomic_disable(struct drm_crtc *crtc,
 		komeda_pipeline_disable(slave, old->state);
=20
 	if (has_bit(master->id, old_st->active_pipes))
-		komeda_pipeline_disable(master, old->state);
+		needs_phase2 =3D komeda_pipeline_disable(master, old->state);
=20
 	/* crtc_disable has two scenarios according to the state->active switch.
 	 * 1. active -> inactive
@@ -320,30 +353,20 @@ komeda_crtc_atomic_disable(struct drm_crtc *crtc,
 	 *    That's also the reason why skip modeset commit in
 	 *    komeda_crtc_atomic_flush()
 	 */
-	if (crtc->state->active) {
-		struct komeda_pipeline_state *pipe_st;
-		/* clear the old active_comps to zero */
-		pipe_st =3D komeda_pipeline_get_old_state(master, old->state);
-		pipe_st->active_comps =3D 0;
+	disable_done =3D (needs_phase2 || crtc->state->active) ?
+		       NULL : &crtc->state->commit->flip_done;
=20
-		init_completion(&temp);
-		kcrtc->disable_done =3D &temp;
-		disable_done =3D &temp;
-	}
+	/* wait phase 1 disable done */
+	komeda_crtc_flush_and_wait_for_flip_done(kcrtc, disable_done);
=20
-	mdev->funcs->flush(mdev, master->id, 0);
+	/* phase 2 */
+	if (needs_phase2) {
+		komeda_pipeline_disable(kcrtc->master, old->state);
=20
-	/* wait the disable take affect.*/
-	timeout =3D wait_for_completion_timeout(disable_done, HZ);
-	if (timeout =3D=3D 0) {
-		DRM_ERROR("disable pipeline%d timeout.\n", kcrtc->master->id);
-		if (crtc->state->active) {
-			unsigned long flags;
+		disable_done =3D crtc->state->active ?
+			       NULL : &crtc->state->commit->flip_done;
=20
-			spin_lock_irqsave(&crtc->dev->event_lock, flags);
-			kcrtc->disable_done =3D NULL;
-			spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
-		}
+		komeda_crtc_flush_and_wait_for_flip_done(kcrtc, disable_done);
 	}
=20
 	drm_crtc_vblank_off(crtc);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 4eac23ef56c1..2afd07579138 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -496,6 +496,18 @@ struct komeda_pipeline {
 	int id;
 	/** @avail_comps: available components mask of pipeline */
 	u32 avail_comps;
+	/**
+	 * @standalone_disabled_comps:
+	 *
+	 * When disable the pipeline, some components can not be disabled
+	 * together with others, but need a sparated and standalone disable.
+	 * The standalone_disabled_comps are the components which need to be
+	 * disabled standalone, and this concept also introduce concept of
+	 * two phase.
+	 * phase 1: for disabling the common components.
+	 * phase 2: for disabling the standalong_disabled_comps.
+	 */
+	u32 standalone_disabled_comps;
 	/** @n_layers: the number of layer on @layers */
 	int n_layers;
 	/** @layers: the pipeline layers */
@@ -674,7 +686,7 @@ int komeda_release_unclaimed_resources(struct komeda_pi=
peline *pipe,
 struct komeda_pipeline_state *
 komeda_pipeline_get_old_state(struct komeda_pipeline *pipe,
 			      struct drm_atomic_state *state);
-void komeda_pipeline_disable(struct komeda_pipeline *pipe,
+bool komeda_pipeline_disable(struct komeda_pipeline *pipe,
 			     struct drm_atomic_state *old_state);
 void komeda_pipeline_update(struct komeda_pipeline *pipe,
 			    struct drm_atomic_state *old_state);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index f2c5d6c8f508..7699322949bb 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -1899,7 +1899,17 @@ int komeda_release_unclaimed_resources(struct komeda=
_pipeline *pipe,
 	return 0;
 }
=20
-void komeda_pipeline_disable(struct komeda_pipeline *pipe,
+/* Since standalong disabled components must be disabled separately and in=
 the
+ * last, So a complete disable operation may needs to call pipeline_disabl=
e
+ * twice (two phase disabling).
+ * Phase 1: disable the common components, flush it.
+ * Phase 2: disable the standalone disabled components, flush it.
+ *
+ * RETURNS:
+ * true: disable is not complete, needs a phase 2 disable.
+ * false: disable is complete.
+ */
+bool komeda_pipeline_disable(struct komeda_pipeline *pipe,
 			     struct drm_atomic_state *old_state)
 {
 	struct komeda_pipeline_state *old;
@@ -1909,9 +1919,14 @@ void komeda_pipeline_disable(struct komeda_pipeline =
*pipe,
=20
 	old =3D komeda_pipeline_get_old_state(pipe, old_state);
=20
-	disabling_comps =3D old->active_comps;
-	DRM_DEBUG_ATOMIC("PIPE%d: disabling_comps: 0x%x.\n",
-			 pipe->id, disabling_comps);
+	disabling_comps =3D old->active_comps &
+			  (~pipe->standalone_disabled_comps);
+	if (!disabling_comps)
+		disabling_comps =3D old->active_comps &
+				  pipe->standalone_disabled_comps;
+
+	DRM_DEBUG_ATOMIC("PIPE%d: active_comps: 0x%x, disabling_comps: 0x%x.\n",
+			 pipe->id, old->active_comps, disabling_comps);
=20
 	dp_for_each_set_bit(id, disabling_comps) {
 		c =3D komeda_pipeline_get_component(pipe, id);
@@ -1929,6 +1944,13 @@ void komeda_pipeline_disable(struct komeda_pipeline =
*pipe,
=20
 		c->funcs->disable(c);
 	}
+
+	/* Update the pipeline state, if there are components that are still
+	 * active, return true for calling the phase 2 disable.
+	 */
+	old->active_comps &=3D ~disabling_comps;
+
+	return old->active_comps ? true : false;
 }
=20
 void komeda_pipeline_update(struct komeda_pipeline *pipe,
--=20
2.17.1

