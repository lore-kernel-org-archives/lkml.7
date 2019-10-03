Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74D7C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F022133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="JD50Mjwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfJCPWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:22:52 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com ([40.107.0.103]:2274
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727587AbfJCPWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:22:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/GY/dIiTzLNWvlOrWMKXZsg4pR4zW7GYf7wSdWbYof8hCGhV0T48Te81GejKQxZnllI2OBP+DQdBwIfBDn7XxXLoPJSAtvVDuzxNbV9K6N8X8lp3FDAt6G/Uz4C7wbO6E9/d4Fy8oDMQHSXLhYJPhWswvAgRhMIibEealRypXFLf8uJMcTHivdW5/25ehVcDgsFoenz82dq6XHZ/V77qZd+6HQLp1001HwGWA4WveDppZElNsdcSttHreSu6bc6jRAydrp0mof0IQPv8W0eNJWBSODuvh0jHZq5UDD0QB3+FD3O0hEw/hti9pbGH6KEIFsWFrYHhw2gzzpJ+21uBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf1/V+bjhBLCULM+QCgKgngUOYMBlX25TTpG9CKh0Vc=;
 b=aswzSKMvunC5g5CSGYc4//LGfysPWFZEqbnImbQ/OFH+hJx8S6aiAEZZ7EDg/mfD33+atlgbb8NRT21WzMk0ew2+v+bm5xDuY4bLDJXZOPYmuXD+7lq+2VxeC4oTK3D8e7bFyOaAPd9UibYTGbKiOGTnF5VTS7NB3OyOhzS7ugwW3QjbYyVF3/hPjogKV9a0I7j3XshyYgScsIWHOFoHrAepIySj/qkVXoxZ7AXQ7oNQ1yclx3x9baqo2k3H9IBXtJfKrH+GSLbPxYSx+NCQzNUDV0H1MVZzm5cEn0qzlqHsMoioclYIaiNH+FF4eOnsWWI1k/YsDpv9U+BFbEJ4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf1/V+bjhBLCULM+QCgKgngUOYMBlX25TTpG9CKh0Vc=;
 b=JD50MjwpwnczzRORQxSEfTuXYOovY8Vcu70BKn/wuZocGObIzyenLL/zeETVsFb0lxzmc9zBofNYcc13+L3KOzgvIiVtYZd2NRdM4PGQsMDQHesVDwG5f5sVzIx/fE7Mt/TKFerOeqnsZIylKj01ircX4aph3Ygo6m78jz7dU+U=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB4557.eurprd02.prod.outlook.com (20.178.12.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 15:22:36 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78a3:56d0:8d09:1604]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78a3:56d0:8d09:1604%6]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 15:22:36 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] habanalabs: Add pre-CS-scheduling ASIC function
Thread-Topic: [PATCH v2 3/4] habanalabs: Add pre-CS-scheduling ASIC function
Thread-Index: AQHVef5jfeHzyYECJUy10t93KTuTow==
Date:   Thu, 3 Oct 2019 15:22:36 +0000
Message-ID: <20191003152228.28955-3-ttayar@habana.ai>
References: <20191003152228.28955-1-ttayar@habana.ai>
In-Reply-To: <20191003152228.28955-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0086.eurprd02.prod.outlook.com
 (2603:10a6:208:154::27) To VI1PR02MB3054.eurprd02.prod.outlook.com
 (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d6b7723-90e1-4c55-3975-08d748158571
x-ms-traffictypediagnostic: VI1PR02MB4557:
x-microsoft-antispam-prvs: <VI1PR02MB4557A28C3A48F80E1F85C981D29F0@VI1PR02MB4557.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39840400004)(346002)(136003)(366004)(199004)(189003)(66446008)(66556008)(66476007)(6916009)(64756008)(316002)(66946007)(14444005)(256004)(5660300002)(6512007)(1361003)(71190400001)(71200400001)(2906002)(36756003)(1076003)(2351001)(6436002)(7736002)(86362001)(5640700003)(6486002)(11346002)(476003)(446003)(2616005)(81166006)(81156014)(99286004)(8676002)(486006)(4326008)(478600001)(305945005)(8936002)(2501003)(3846002)(26005)(102836004)(386003)(6506007)(186003)(6116002)(52116002)(66066001)(25786009)(76176011)(14454004)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4557;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UOFgkgOWxeGJejHwHH77hrkx65tV4ES5Cf//dH5t5oP9A+Vgojl01ReYAs4f2C2kNYUUFmFx0SMgwinquXyy/0WTgLcUi7ybYVM+MCpFjLwUF7FtjstnHxEa1QAJWsaO4FSC8LWk4xQCwRWCDZhsXq96LfbE0galdIlRzvgBAjAtj6USasEOySLL7CBqxVjNbs8kbSlb/f5kA9GpPGht1EpYEU+4VFdKJbkHcCkIPuP2yB5GMvP3UwHtKol54yWI/A8XRL06HjBEIiylgUwSFtbpkx0BpVKPOKvTxnBc0xIEB2sci84pej3xrXpiU1FBScWigOIgTEjVFrKzKl8r8yOcwMYiUj+t2zJSmvEAHwgrlk2d7QIv23e3SULWuJ26CqcBlS09Rup2Pz8Ym5pxSKuREHV4CioCEVSZkzFSks8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6b7723-90e1-4c55-3975-08d748158571
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 15:22:36.8266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rr/KLmLFQksokcEru/eJh930x6Ut06y5dKd+9MbpQgMLyDm4pnjKb2zxACTu7uEN18hKKuX5BUpRELfGMDOc5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds a pre-CS-scheduling ASIC function for operations just
before placing CS jobs on the queues.

For H/W queues, it is used to configure dedicated sync object and
monitor for this CS. The sync object value is increased when each of
the jobs is completed. When it reaches the number of jobs, the monitor
generates interrupt towards the host, to inform the driver about the
completion of the CS.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/command_submission.c | 1 +
 drivers/misc/habanalabs/goya/goya.c          | 8 +++++++-
 drivers/misc/habanalabs/goya/goyaP.h         | 2 ++
 drivers/misc/habanalabs/habanalabs.h         | 6 ++++++
 drivers/misc/habanalabs/hw_queue.c           | 8 ++++++++
 5 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/ha=
banalabs/command_submission.c
index 776ddafc47fb..25dc7308da19 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -592,6 +592,7 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __=
user *chunks,
 		job->hw_queue_id =3D chunk->queue_index;
=20
 		cs->jobs_in_queue_cnt[job->hw_queue_id]++;
+		cs->jobs_cnt++;
=20
 		list_add_tail(&job->cs_node, &cs->job_list);
=20
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/=
goya/goya.c
index 0b40915bede2..d0d4c1a38dbe 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5089,6 +5089,11 @@ static enum hl_device_hw_state goya_get_hw_state(str=
uct hl_device *hdev)
 	return RREG32(mmHW_STATE);
 }
=20
+int goya_pre_schedule_cs(struct hl_cs *cs)
+{
+	return 0;
+}
+
 static const struct hl_asic_funcs goya_funcs =3D {
 	.early_init =3D goya_early_init,
 	.early_fini =3D goya_early_fini,
@@ -5145,7 +5150,8 @@ static const struct hl_asic_funcs goya_funcs =3D {
 	.init_iatu =3D goya_init_iatu,
 	.rreg =3D hl_rreg,
 	.wreg =3D hl_wreg,
-	.halt_coresight =3D goya_halt_coresight
+	.halt_coresight =3D goya_halt_coresight,
+	.pre_schedule_cs =3D goya_pre_schedule_cs
 };
=20
 /*
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs=
/goya/goyaP.h
index 89b6574f8e4f..346e70d3afa8 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -233,4 +233,6 @@ void goya_cpu_accessible_dma_pool_free(struct hl_device=
 *hdev, size_t size,
 					void *vaddr);
 void goya_mmu_remove_device_cpu_mappings(struct hl_device *hdev);
=20
+int goya_pre_schedule_cs(struct hl_cs *cs);
+
 #endif /* GOYAP_H_ */
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs=
/habanalabs.h
index 371d1ec15697..c1af83f96415 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -433,6 +433,8 @@ enum hl_pll_frequency {
 	PLL_LAST
 };
=20
+struct hl_cs;
+
 /**
  * struct hl_asic_funcs - ASIC specific functions that are can be called f=
rom
  *                        common code.
@@ -508,6 +510,7 @@ enum hl_pll_frequency {
  * @rreg: Read a register. Needed for simulator support.
  * @wreg: Write a register. Needed for simulator support.
  * @halt_coresight: stop the ETF and ETR traces.
+ * @pre_schedule_cs: Perform pre-CS-scheduling operations.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -590,6 +593,7 @@ struct hl_asic_funcs {
 	u32 (*rreg)(struct hl_device *hdev, u32 reg);
 	void (*wreg)(struct hl_device *hdev, u32 reg, u32 val);
 	void (*halt_coresight)(struct hl_device *hdev);
+	int (*pre_schedule_cs)(struct hl_cs *cs);
 };
=20
=20
@@ -722,6 +726,7 @@ struct hl_userptr {
  * @mirror_node : node in device mirror list of command submissions.
  * @debugfs_list: node in debugfs list of command submissions.
  * @sequence: the sequence number of this CS.
+ * @jobs_cnt: counter of submitted jobs on all queues.
  * @submitted: true if CS was submitted to H/W.
  * @completed: true if CS was completed by device.
  * @timedout : true if CS was timedout.
@@ -740,6 +745,7 @@ struct hl_cs {
 	struct list_head	mirror_node;
 	struct list_head	debugfs_list;
 	u64			sequence;
+	u32			jobs_cnt;
 	u8			submitted;
 	u8			completed;
 	u8			timedout;
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/h=
w_queue.c
index 91579dde9262..8ea993494a49 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -461,6 +461,14 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 		}
 	}
=20
+	rc =3D hdev->asic_funcs->pre_schedule_cs(cs);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed in pre-submission operations of CS %d.%llu\n",
+			cs->ctx->asid, cs->sequence);
+		goto unroll_cq_resv;
+	}
+
 	spin_lock(&hdev->hw_queues_mirror_lock);
 	list_add_tail(&cs->mirror_node, &hdev->hw_queues_mirror_list);
=20
--=20
2.17.1

