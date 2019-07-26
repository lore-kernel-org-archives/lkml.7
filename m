Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44916C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AA321880
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Acd9lTsJ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Acd9lTsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfGZIPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:15:00 -0400
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:30457
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfGZIPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgY8oeibiBD6WrixfYc+P2BmrPVYxKZ9bPd3a85T118=;
 b=Acd9lTsJFx6lWgfhvUNwZBk19sMSBHglND4QOEq12VV+rIoDSHG7HHZl3k7uauuVjCvabSmgbQWxxL84G6fN9/3E5jFtkra/C7pfrYbwrqANu7Dwvw4RVklq3DR5pN5rRKWNMmrWkFqu0Nckdu+ZtYkj6Yv5Gm9/LeyQ9ZiRp8Y=
Received: from VI1PR08CA0230.eurprd08.prod.outlook.com (2603:10a6:802:15::39)
 by DB6PR0801MB1845.eurprd08.prod.outlook.com (2603:10a6:4:39::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16; Fri, 26 Jul
 2019 08:13:15 +0000
Received: from AM5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by VI1PR08CA0230.outlook.office365.com
 (2603:10a6:802:15::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2094.14 via Frontend
 Transport; Fri, 26 Jul 2019 08:13:14 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT054.mail.protection.outlook.com (10.152.16.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Fri, 26 Jul 2019 08:13:13 +0000
Received: ("Tessian outbound 1e6e633a5b56:v26"); Fri, 26 Jul 2019 08:13:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4ee8ac99b27cfc05
X-CR-MTA-TID: 64aa7808
Received: from 80f38c3bcd16.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0FEB74C8-7CCA-4665-83DD-D8C3D92E91BB.1;
        Fri, 26 Jul 2019 08:13:04 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 80f38c3bcd16.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 26 Jul 2019 08:13:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkoU2Q7ex90ktMFBYpm9mjFnSk58voEPAsJCiuFi3I2y6vcsLy5wpJhsHkWyTvTwBkxWjayhLtoTADM3bzLKLoI4j+P7tkppF03aQknMx8c/Dg0zG8aYK6/1aknC9ivcNzwJYx+o9KFMKcrKtgOdBMQDSi17ichyMx7FRQqrN6o6+ldPpips4H8ok3QTAo+LSUGrrKITRQ7druTkarP9wqTwe7QmHhljsMUqUQtxszfceO+amyMUX8Fz06bRDDUhU/+OvXRpnSPnhOKWlHBFRXIBkG3x9qjhsGE9eXWGCxdMw3/iOpK6XKVV89ZKpOILnr6sLuYEP+lQjongUPsgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgY8oeibiBD6WrixfYc+P2BmrPVYxKZ9bPd3a85T118=;
 b=C+7rf14WSksmPakiN8i6hrh4hPIuKXyFjCnkG7GaIK2pPwJBMSCMqRW5v523N45Zwo25JCayoFiTqnHRVjCWIYEUVAVbItq3RTT3e4pbcl+p2oWOuRMtURhbEwRqojwJG7GjmkF1o/21wsB5qcf11m6OAZ/VKK55dtSm/VLq2L3ctBT1f3KL2+h7WnY28jrdyPT2M1p8S58YboAWs0AILBhUrzAol7kck+KgDUXxg1wA49o+1YPFZyyXxjSc98jhTQEJXyw7kaaCY0e23kWTxd9CqCMLqktHuXRgQP4HBfgOyW0AElY7/Q9pYdb8Hwe2lsbaMI4Vd1yyhBS743h0Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgY8oeibiBD6WrixfYc+P2BmrPVYxKZ9bPd3a85T118=;
 b=Acd9lTsJFx6lWgfhvUNwZBk19sMSBHglND4QOEq12VV+rIoDSHG7HHZl3k7uauuVjCvabSmgbQWxxL84G6fN9/3E5jFtkra/C7pfrYbwrqANu7Dwvw4RVklq3DR5pN5rRKWNMmrWkFqu0Nckdu+ZtYkj6Yv5Gm9/LeyQ9ZiRp8Y=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3806.eurprd08.prod.outlook.com (20.178.14.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Fri, 26 Jul 2019 08:13:01 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236%2]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 08:13:01 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: [PATCH] drm/komeda: Skips the invalid writeback job
Thread-Topic: [PATCH] drm/komeda: Skips the invalid writeback job
Thread-Index: AQHVQ4nw7K9FV7USuUuF4ik2yHSO+g==
Date:   Fri, 26 Jul 2019 08:13:00 +0000
Message-ID: <1564128758-23553-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0039.apcprd03.prod.outlook.com
 (2603:1096:203:2f::27) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 842e31ef-2046-40ee-e394-08d711a11ae7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3806;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3806:|DB6PR0801MB1845:
X-Microsoft-Antispam-PRVS: <DB6PR0801MB18453C12534D03F60C156FEB9FC00@DB6PR0801MB1845.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:972;OLM:972;
x-forefront-prvs: 01106E96F6
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(189003)(199004)(66946007)(478600001)(2201001)(4326008)(26005)(2501003)(36756003)(25786009)(66476007)(186003)(53936002)(5660300002)(386003)(6486002)(2906002)(55236004)(64756008)(66446008)(6506007)(8936002)(66556008)(102836004)(6636002)(99286004)(68736007)(81166006)(110136005)(66066001)(71200400001)(486006)(8676002)(71190400001)(14454004)(54906003)(50226002)(7736002)(2616005)(6512007)(6116002)(316002)(6436002)(256004)(3846002)(305945005)(14444005)(86362001)(476003)(81156014)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3806;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: cMjaXxZo/5zeBnMzoPoPivur9Ki73FfV08C64Uq8iiQoA1Y1WKvStXnIkHZzeEW65km3ySEFLYBNxcu73DbavRrlj3FJdmMxiJnRSo5KOlpEvhxV4SRriOQxCqn8Q5QP2seYzLCfFjuNAT9kN/TuNGzbewUo3z5fjNSEIYG5UZdW2QQP62aLzvkukE8dZtQfN8ftLW7Ff0kefjru3py6i8B0HKg5rfMQme7Hpnl7GtwI55Vlmm1FhCh5oXQzeyjdm7BLmR6XUlU6JMXZByL75hODIFCIP+1bzKfFnOVg1VOJeRk4/1pjVJdunKqzOBw5OFktKWQBUn7YZ0vbb7JWzK+SLiWPIySCRDKFv+MsPhzJ7WlNeQ6xa3SdcUmJmI+MEvE85FcRJRMwH0mm2rqeUYKMVkkOH1btqK+2yKhsYBE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3806
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(2980300002)(199004)(189003)(26005)(2501003)(86362001)(2616005)(14444005)(186003)(386003)(76130400001)(63370400001)(6116002)(126002)(25786009)(2906002)(476003)(63350400001)(6506007)(81166006)(36906005)(81156014)(36756003)(8676002)(486006)(478600001)(3846002)(336012)(22756006)(102836004)(2201001)(6636002)(26826003)(14454004)(110136005)(5660300002)(54906003)(8746002)(4326008)(50226002)(8936002)(6512007)(66066001)(47776003)(6486002)(50466002)(316002)(7736002)(99286004)(70586007)(356004)(70206006)(305945005)(23756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1845;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8fb0ef02-f817-402f-b68b-08d711a11335
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB6PR0801MB1845;
NoDisclaimer: True
X-Forefront-PRVS: 01106E96F6
X-Microsoft-Antispam-Message-Info: 4lJMLjF5kHkHPoGeqS2HToNKL99yvtCo9ENZGP3fUTFqoZMalbGVkod0P5hAJSpwJNpUrfYH6eJM4jfIQGi51Ylt5P3lWcLy/zJcZ4kCSzeNO202Tr3/s89b+ij2ivScgQL1+wZF7VwoR9HBRa1EIZmctdGhoBX6c4Rlk2RVYQp62/+3GJvFLI9JpSW3ZQm52U/xsq9UsPjCkmoIsEuC1Tv/YRhFfj1+lYK28wtT5Oyb8pWvwQc8EVo0pZXmbAmnTJPjLRrAhOPw68SF92Y7/fja0YimN+sjWwF8qRUwLvTlaq18DiRtXteiAv5j1mSILi+cOMTSPv1gCWGzFQiJHS7AzGMRcT8yoH4tl/TmmIIZX7U12eysZBfXcL4HR3edtfVhB6tIVXe74Rnh6zlw+mdoqPd6pl0QtEj22eQTZMg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2019 08:13:13.4275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 842e31ef-2046-40ee-e394-08d711a11ae7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1845
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current DRM-CORE accepts the writeback_job with a empty fb, but that
is an invalid job for HW, so need to skip it when commit it to HW.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c         | 2 +-
 drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 2fed1f6..372e99a 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -265,7 +265,7 @@ void komeda_crtc_handle_event(struct komeda_crtc *kcrtc=
,
 		komeda_pipeline_update(slave, old->state);
=20
 	conn_st =3D wb_conn ? wb_conn->base.base.state : NULL;
-	if (conn_st && conn_st->writeback_job)
+	if (conn_st && conn_st->writeback_job && conn_st->writeback_job->fb)
 		drm_writeback_queue_job(&wb_conn->base, conn_st);
=20
 	/* step 2: notify the HW to kickoff the update */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 9787745..8e2ef63 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -52,9 +52,16 @@
 	struct komeda_data_flow_cfg dflow;
 	int err;
=20
-	if (!writeback_job || !writeback_job->fb)
+	if (!writeback_job)
 		return 0;
=20
+	if (!writeback_job->fb) {
+		if (writeback_job->out_fence)
+			DRM_DEBUG_ATOMIC("Out fence required on a invalid writeback job.\n");
+
+		return writeback_job->out_fence ? -EINVAL : 0;
+	}
+
 	if (!crtc_st->active) {
 		DRM_DEBUG_ATOMIC("Cannot write the composition result out on a inactive =
CRTC.\n");
 		return -EINVAL;
--=20
1.9.1

