Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF66C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96EB2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="dq4FlYmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfJCPWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:22:47 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com ([40.107.0.103]:2274
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727978AbfJCPWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:22:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3jCsl9gD/GpRxY8tDwHHOpkNvOXfSlmOiDl1wU5U40OjnRDQ45N9bZZyH9L68MxB0JkZJr8puOt5HLiq+/igMqy5KSX0dKviXRhBAP3I1miuAVOZWmYklCUqNjOnFjYtAMX3e0fq0MYVeO6nOyFLGp/UKpcKPEN/8uHZeHN3U21ZFWnK7R9AUmbuGF1t/+RmMD7ThojMtv/lq08R1fSHUzc70g3m+tQAubRCq6sIakFvgxENhPmdF6p+vRGZ94IjJnpLlX1oXM9j30K3+ny+RXKX1wFk1ERSub1+W0LZaheOWFNybxaSwX3I6iWDjv/CNkNnHn5EOVut8JQXpNM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPaHnV+J7J9DcG6V0qnRKGjWqvpOAbrSIJrqpOwJsHo=;
 b=O3pcdThrUMTCmxcD9/gGzq+faUBdwS5qQSuzJhcbcwcOhuU8BETbt9Dl3EQoNoVQuvCOWqJPSBF3Vprchz8EzzQbE/U9oL++jIRCike4xlvQDyGhrChQp7sNP9CgKpLLrKFzM18leh5a7yw+0PF4NBAjeifZ/b2O8xe1OHOEQFDs9+C7aBelnqDROus+AgMF8FmL2OOb0Z0pC5H0wYQzAORAeYd3gVlurFAiKSJnsJpkmrp7Vhb+uAmHr3irtDxug0QeHsyiXNSsT/E2Lsx9jRuUOIbQFamLdBS1VIgD4Ol8vaeAzTjeLV9MDb94T/fCoCw5kSsIZ5PgsakxIMVvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPaHnV+J7J9DcG6V0qnRKGjWqvpOAbrSIJrqpOwJsHo=;
 b=dq4FlYmrDcuv2R5hMogOcQdM7QSrHONLL8VVvWOlRk2BpkwDBpVWBjLZcuqKS+NnmrTWEbxtqO0w3Ze/uMdXB506L/54UC4WWI3eYWqF6YJu6X2trt1LImrdRgf6tkNKqsn19F37ILlvbuK0PE9KZuk5YEPwg/gbNjxZmCXzeUo=
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
Subject: [PATCH v2 2/4] habanalabs: Add a new H/W queue type
Thread-Topic: [PATCH v2 2/4] habanalabs: Add a new H/W queue type
Thread-Index: AQHVef5iAH8+idSI90eqBqarPjs06Q==
Date:   Thu, 3 Oct 2019 15:22:36 +0000
Message-ID: <20191003152228.28955-2-ttayar@habana.ai>
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
x-ms-office365-filtering-correlation-id: cc4c8245-6702-4b96-86ce-08d748158500
x-ms-traffictypediagnostic: VI1PR02MB4557:
x-microsoft-antispam-prvs: <VI1PR02MB4557D12CAA7845FF071BE18ED29F0@VI1PR02MB4557.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39840400004)(346002)(136003)(366004)(51234002)(199004)(189003)(66446008)(66556008)(66476007)(6916009)(64756008)(316002)(66946007)(14444005)(256004)(5660300002)(6512007)(30864003)(1361003)(71190400001)(71200400001)(2906002)(36756003)(1076003)(2351001)(6436002)(7736002)(86362001)(5640700003)(6486002)(11346002)(476003)(446003)(2616005)(81166006)(81156014)(99286004)(8676002)(486006)(4326008)(478600001)(305945005)(8936002)(2501003)(3846002)(26005)(102836004)(386003)(6506007)(186003)(6116002)(52116002)(66066001)(25786009)(76176011)(14454004)(50226002)(579004)(559001)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4557;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j84ykEeoXPngA5UF4/W2EL9L9aTfssZxniVgEfXO1A2dDwazifDPdByxbS0p6EE8B7oPZ0fumCuAwZaseqGlmCd6cIrdvd6xOsKMyk2q97GMjCz5Urx3Es+Q/hkoJtvxs2O9PGWV5vryE/ABea5v/zbY9DgU9VInwVePp72ibAT6G8RslFqxhYJVvVqWmtIHFTxUB2VubnMCozWX2IF3bKWCngkXGkzoUGnnRMpNl2O9Y0HPiRu5/Pt7Yz4mpXcZ67sCfCVdnPfcnM/9setZOlCHPQcl4bZKKIPzST6sdRtQn6z9H9qDuNxjqJEHlEpWbcONqcGDa33/HLuPtStdIg0srD+rwTUxf/yQU3+jdIQ8FUOOAKYhSBdQAWvp4winTAAjz5ac9GvATieQyGlXgO+xX7gqkDRrAdCVhEF97p8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4c8245-6702-4b96-86ce-08d748158500
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 15:22:36.1650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EyCZ+EbOhR6LPffyR2gE/b4Tx0r9ZeblmYoDB5U14coCzBM6Nt2/a+ai7k8RfxQ1ljs5x7pf+lr/UbBpDuWmzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a support for a new H/W queue type.
This type of queue is for DMA and compute engines jobs, for which
completion notification are sent be H/W.
Command buffer for this queue can be created either through the CB
IOCTL and using the retrieved CB handle, or by preparing a buffer on the
host or device SRAM/DRAM, and using the device address to that buffer.
The patch includes the handling of the 2 options, as well as the
initialization of the H/W queue and its jobs scheduling.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
Changes in v2:
- Fix an uninitialized 'rc' variable in hl_hw_queue_send_cb_no_cmpl().

 drivers/misc/habanalabs/command_submission.c | 120 ++++++---
 drivers/misc/habanalabs/goya/goya.c          |   4 +-
 drivers/misc/habanalabs/habanalabs.h         |  24 +-
 drivers/misc/habanalabs/hw_queue.c           | 249 +++++++++++++++----
 drivers/misc/habanalabs/include/qman_if.h    |  12 +
 5 files changed, 308 insertions(+), 101 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/ha=
banalabs/command_submission.c
index f44205540520..776ddafc47fb 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -65,6 +65,18 @@ static void cs_put(struct hl_cs *cs)
 	kref_put(&cs->refcount, cs_do_release);
 }
=20
+static bool is_cb_patched(struct hl_device *hdev, struct hl_cs_job *job)
+{
+	/*
+	 * Patched CB is created for external queues jobs, and for H/W queues
+	 * jobs if the user CB was allocated by driver and MMU is disabled.
+	 */
+	return (job->queue_type =3D=3D QUEUE_TYPE_EXT ||
+			(job->queue_type =3D=3D QUEUE_TYPE_HW &&
+					job->is_kernel_allocated_cb &&
+					!hdev->mmu_enable));
+}
+
 /*
  * cs_parser - parse the user command submission
  *
@@ -91,11 +103,13 @@ static int cs_parser(struct hl_fpriv *hpriv, struct hl=
_cs_job *job)
 	parser.patched_cb =3D NULL;
 	parser.user_cb =3D job->user_cb;
 	parser.user_cb_size =3D job->user_cb_size;
-	parser.ext_queue =3D job->ext_queue;
+	parser.queue_type =3D job->queue_type;
+	parser.is_kernel_allocated_cb =3D job->is_kernel_allocated_cb;
 	job->patched_cb =3D NULL;
=20
 	rc =3D hdev->asic_funcs->cs_parser(hdev, &parser);
-	if (job->ext_queue) {
+
+	if (is_cb_patched(hdev, job)) {
 		if (!rc) {
 			job->patched_cb =3D parser.patched_cb;
 			job->job_cb_size =3D parser.patched_cb_size;
@@ -124,7 +138,7 @@ static void free_job(struct hl_device *hdev, struct hl_=
cs_job *job)
 {
 	struct hl_cs *cs =3D job->cs;
=20
-	if (job->ext_queue) {
+	if (is_cb_patched(hdev, job)) {
 		hl_userptr_delete_list(hdev, &job->userptr_list);
=20
 		/*
@@ -140,6 +154,19 @@ static void free_job(struct hl_device *hdev, struct hl=
_cs_job *job)
 		}
 	}
=20
+	/* For H/W queue jobs, if a user CB was allocated by driver and MMU is
+	 * enabled, the user CB isn't released in cs_parser() and thus should be
+	 * released here.
+	 */
+	if (job->queue_type =3D=3D QUEUE_TYPE_HW &&
+			job->is_kernel_allocated_cb && hdev->mmu_enable) {
+		spin_lock(&job->user_cb->lock);
+		job->user_cb->cs_cnt--;
+		spin_unlock(&job->user_cb->lock);
+
+		hl_cb_put(job->user_cb);
+	}
+
 	/*
 	 * This is the only place where there can be multiple threads
 	 * modifying the list at the same time
@@ -150,7 +177,8 @@ static void free_job(struct hl_device *hdev, struct hl_=
cs_job *job)
=20
 	hl_debugfs_remove_job(hdev, job);
=20
-	if (job->ext_queue)
+	if (job->queue_type =3D=3D QUEUE_TYPE_EXT ||
+			job->queue_type =3D=3D QUEUE_TYPE_HW)
 		cs_put(cs);
=20
 	kfree(job);
@@ -387,18 +415,13 @@ static void job_wq_completion(struct work_struct *wor=
k)
 	free_job(hdev, job);
 }
=20
-static struct hl_cb *validate_queue_index(struct hl_device *hdev,
-					struct hl_cb_mgr *cb_mgr,
-					struct hl_cs_chunk *chunk,
-					bool *ext_queue)
+static int validate_queue_index(struct hl_device *hdev,
+				struct hl_cs_chunk *chunk,
+				enum hl_queue_type *queue_type,
+				bool *is_kernel_allocated_cb)
 {
 	struct asic_fixed_properties *asic =3D &hdev->asic_prop;
 	struct hw_queue_properties *hw_queue_prop;
-	u32 cb_handle;
-	struct hl_cb *cb;
-
-	/* Assume external queue */
-	*ext_queue =3D true;
=20
 	hw_queue_prop =3D &asic->hw_queues_props[chunk->queue_index];
=20
@@ -406,22 +429,29 @@ static struct hl_cb *validate_queue_index(struct hl_d=
evice *hdev,
 			(hw_queue_prop->type =3D=3D QUEUE_TYPE_NA)) {
 		dev_err(hdev->dev, "Queue index %d is invalid\n",
 			chunk->queue_index);
-		return NULL;
+		return -EINVAL;
 	}
=20
 	if (hw_queue_prop->driver_only) {
 		dev_err(hdev->dev,
 			"Queue index %d is restricted for the kernel driver\n",
 			chunk->queue_index);
-		return NULL;
+		return -EINVAL;
 	}
=20
-	if (!hw_queue_prop->requires_kernel_cb) {
-		*ext_queue =3D false;
-		return (struct hl_cb *) (uintptr_t) chunk->cb_handle;
-	}
+	*queue_type =3D hw_queue_prop->type;
+	*is_kernel_allocated_cb =3D !!hw_queue_prop->requires_kernel_cb;
+
+	return 0;
+}
+
+static struct hl_cb *get_cb_from_cs_chunk(struct hl_device *hdev,
+					struct hl_cb_mgr *cb_mgr,
+					struct hl_cs_chunk *chunk)
+{
+	struct hl_cb *cb;
+	u32 cb_handle;
=20
-	/* Retrieve CB object */
 	cb_handle =3D (u32) (chunk->cb_handle >> PAGE_SHIFT);
=20
 	cb =3D hl_cb_get(hdev, cb_mgr, cb_handle);
@@ -446,7 +476,8 @@ static struct hl_cb *validate_queue_index(struct hl_dev=
ice *hdev,
 	return NULL;
 }
=20
-struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev, bool ext_queu=
e)
+struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev,
+		enum hl_queue_type queue_type, bool is_kernel_allocated_cb)
 {
 	struct hl_cs_job *job;
=20
@@ -454,12 +485,14 @@ struct hl_cs_job *hl_cs_allocate_job(struct hl_device=
 *hdev, bool ext_queue)
 	if (!job)
 		return NULL;
=20
-	job->ext_queue =3D ext_queue;
+	job->queue_type =3D queue_type;
+	job->is_kernel_allocated_cb =3D is_kernel_allocated_cb;
=20
-	if (job->ext_queue) {
+	if (is_cb_patched(hdev, job))
 		INIT_LIST_HEAD(&job->userptr_list);
+
+	if (job->queue_type =3D=3D QUEUE_TYPE_EXT)
 		INIT_WORK(&job->finish_work, job_wq_completion);
-	}
=20
 	return job;
 }
@@ -472,7 +505,7 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __=
user *chunks,
 	struct hl_cs_job *job;
 	struct hl_cs *cs;
 	struct hl_cb *cb;
-	bool ext_queue_present =3D false;
+	bool int_queues_only =3D true;
 	u32 size_to_copy;
 	int rc, i, parse_cnt;
=20
@@ -516,23 +549,33 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void =
__user *chunks,
 	/* Validate ALL the CS chunks before submitting the CS */
 	for (i =3D 0, parse_cnt =3D 0 ; i < num_chunks ; i++, parse_cnt++) {
 		struct hl_cs_chunk *chunk =3D &cs_chunk_array[i];
-		bool ext_queue;
+		enum hl_queue_type queue_type;
+		bool is_kernel_allocated_cb;
=20
-		cb =3D validate_queue_index(hdev, &hpriv->cb_mgr, chunk,
-					&ext_queue);
-		if (ext_queue) {
-			ext_queue_present =3D true;
+		rc =3D validate_queue_index(hdev, chunk, &queue_type,
+						&is_kernel_allocated_cb);
+		if (rc)
+			goto free_cs_object;
+
+		if (is_kernel_allocated_cb) {
+			cb =3D get_cb_from_cs_chunk(hdev, &hpriv->cb_mgr, chunk);
 			if (!cb) {
 				rc =3D -EINVAL;
 				goto free_cs_object;
 			}
+		} else {
+			cb =3D (struct hl_cb *) (uintptr_t) chunk->cb_handle;
 		}
=20
-		job =3D hl_cs_allocate_job(hdev, ext_queue);
+		if (queue_type =3D=3D QUEUE_TYPE_EXT || queue_type =3D=3D QUEUE_TYPE_HW)
+			int_queues_only =3D false;
+
+		job =3D hl_cs_allocate_job(hdev, queue_type,
+						is_kernel_allocated_cb);
 		if (!job) {
 			dev_err(hdev->dev, "Failed to allocate a new job\n");
 			rc =3D -ENOMEM;
-			if (ext_queue)
+			if (is_kernel_allocated_cb)
 				goto release_cb;
 			else
 				goto free_cs_object;
@@ -542,7 +585,7 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __=
user *chunks,
 		job->cs =3D cs;
 		job->user_cb =3D cb;
 		job->user_cb_size =3D chunk->cb_size;
-		if (job->ext_queue)
+		if (is_kernel_allocated_cb)
 			job->job_cb_size =3D cb->size;
 		else
 			job->job_cb_size =3D chunk->cb_size;
@@ -555,10 +598,11 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void =
__user *chunks,
 		/*
 		 * Increment CS reference. When CS reference is 0, CS is
 		 * done and can be signaled to user and free all its resources
-		 * Only increment for JOB on external queues, because only
-		 * for those JOBs we get completion
+		 * Only increment for JOB on external or H/W queues, because
+		 * only for those JOBs we get completion
 		 */
-		if (job->ext_queue)
+		if (job->queue_type =3D=3D QUEUE_TYPE_EXT ||
+				job->queue_type =3D=3D QUEUE_TYPE_HW)
 			cs_get(cs);
=20
 		hl_debugfs_add_job(hdev, job);
@@ -572,9 +616,9 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __=
user *chunks,
 		}
 	}
=20
-	if (!ext_queue_present) {
+	if (int_queues_only) {
 		dev_err(hdev->dev,
-			"Reject CS %d.%llu because no external queues jobs\n",
+			"Reject CS %d.%llu because only internal queues jobs are present\n",
 			cs->ctx->asid, cs->sequence);
 		rc =3D -EINVAL;
 		goto free_cs_object;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/=
goya/goya.c
index 71693fcffb16..0b40915bede2 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3943,7 +3943,7 @@ int goya_cs_parser(struct hl_device *hdev, struct hl_=
cs_parser *parser)
 {
 	struct goya_device *goya =3D hdev->asic_specific;
=20
-	if (!parser->ext_queue)
+	if (parser->queue_type =3D=3D QUEUE_TYPE_INT)
 		return goya_parse_cb_no_ext_queue(hdev, parser);
=20
 	if (goya->hw_cap_initialized & HW_CAP_MMU)
@@ -4614,7 +4614,7 @@ static int goya_memset_device_memory(struct hl_device=
 *hdev, u64 addr, u64 size,
 		lin_dma_pkt++;
 	} while (--lin_dma_pkts_cnt);
=20
-	job =3D hl_cs_allocate_job(hdev, true);
+	job =3D hl_cs_allocate_job(hdev, QUEUE_TYPE_EXT, true);
 	if (!job) {
 		dev_err(hdev->dev, "Failed to allocate a new job\n");
 		rc =3D -ENOMEM;
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs=
/habanalabs.h
index f47f4b22cb6b..371d1ec15697 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -85,12 +85,15 @@ struct hl_fpriv;
  * @QUEUE_TYPE_INT: internal queue that performs DMA inside the device's
  *			memories and/or operates the compute engines.
  * @QUEUE_TYPE_CPU: S/W queue for communication with the device's CPU.
+ * @QUEUE_TYPE_HW: queue of DMA and compute engines jobs, for which comple=
tion
+ *                 notifications are sent by H/W.
  */
 enum hl_queue_type {
 	QUEUE_TYPE_NA,
 	QUEUE_TYPE_EXT,
 	QUEUE_TYPE_INT,
-	QUEUE_TYPE_CPU
+	QUEUE_TYPE_CPU,
+	QUEUE_TYPE_HW
 };
=20
 /**
@@ -755,11 +758,14 @@ struct hl_cs {
  * @userptr_list: linked-list of userptr mappings that belong to this job =
and
  *			wait for completion.
  * @debugfs_list: node in debugfs list of command submission jobs.
+ * @queue_type: the type of the H/W queue this job is submitted to.
  * @id: the id of this job inside a CS.
  * @hw_queue_id: the id of the H/W queue this job is submitted to.
  * @user_cb_size: the actual size of the CB we got from the user.
  * @job_cb_size: the actual size of the CB that we put on the queue.
- * @ext_queue: whether the job is for external queue or internal queue.
+ * @is_kernel_allocated_cb: true if the CB handle we got from the user hol=
ds a
+ *                          handle to a kernel-allocated CB object, false
+ *                          otherwise (SRAM/DRAM/host address).
  */
 struct hl_cs_job {
 	struct list_head	cs_node;
@@ -769,11 +775,12 @@ struct hl_cs_job {
 	struct work_struct	finish_work;
 	struct list_head	userptr_list;
 	struct list_head	debugfs_list;
+	enum hl_queue_type	queue_type;
 	u32			id;
 	u32			hw_queue_id;
 	u32			user_cb_size;
 	u32			job_cb_size;
-	u8			ext_queue;
+	u8			is_kernel_allocated_cb;
 };
=20
 /**
@@ -784,24 +791,28 @@ struct hl_cs_job {
  * @job_userptr_list: linked-list of userptr mappings that belong to the r=
elated
  *			job and wait for completion.
  * @cs_sequence: the sequence number of the related CS.
+ * @queue_type: the type of the H/W queue this job is submitted to.
  * @ctx_id: the ID of the context the related CS belongs to.
  * @hw_queue_id: the id of the H/W queue this job is submitted to.
  * @user_cb_size: the actual size of the CB we got from the user.
  * @patched_cb_size: the size of the CB after parsing.
- * @ext_queue: whether the job is for external queue or internal queue.
  * @job_id: the id of the related job inside the related CS.
+ * @is_kernel_allocated_cb: true if the CB handle we got from the user hol=
ds a
+ *                          handle to a kernel-allocated CB object, false
+ *                          otherwise (SRAM/DRAM/host address).
  */
 struct hl_cs_parser {
 	struct hl_cb		*user_cb;
 	struct hl_cb		*patched_cb;
 	struct list_head	*job_userptr_list;
 	u64			cs_sequence;
+	enum hl_queue_type	queue_type;
 	u32			ctx_id;
 	u32			hw_queue_id;
 	u32			user_cb_size;
 	u32			patched_cb_size;
-	u8			ext_queue;
 	u8			job_id;
+	u8			is_kernel_allocated_cb;
 };
=20
=20
@@ -1504,7 +1515,8 @@ int hl_cb_pool_init(struct hl_device *hdev);
 int hl_cb_pool_fini(struct hl_device *hdev);
=20
 void hl_cs_rollback_all(struct hl_device *hdev);
-struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev, bool ext_queu=
e);
+struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev,
+		enum hl_queue_type queue_type, bool is_kernel_allocated_cb);
=20
 void goya_set_asic_funcs(struct hl_device *hdev);
=20
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/h=
w_queue.c
index f733b534f738..91579dde9262 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -58,8 +58,8 @@ void hl_int_hw_queue_update_ci(struct hl_cs *cs)
 }
=20
 /*
- * ext_queue_submit_bd - Submit a buffer descriptor to an external queue
- *
+ * ext_and_hw_queue_submit_bd() - Submit a buffer descriptor to an externa=
l or a
+ *                                H/W queue.
  * @hdev: pointer to habanalabs device structure
  * @q: pointer to habanalabs queue structure
  * @ctl: BD's control word
@@ -73,8 +73,8 @@ void hl_int_hw_queue_update_ci(struct hl_cs *cs)
  * This function must be called when the scheduler mutex is taken
  *
  */
-static void ext_queue_submit_bd(struct hl_device *hdev, struct hl_hw_queue=
 *q,
-				u32 ctl, u32 len, u64 ptr)
+static void ext_and_hw_queue_submit_bd(struct hl_device *hdev,
+			struct hl_hw_queue *q, u32 ctl, u32 len, u64 ptr)
 {
 	struct hl_bd *bd;
=20
@@ -173,6 +173,45 @@ static int int_queue_sanity_checks(struct hl_device *h=
dev,
 	return 0;
 }
=20
+/*
+ * hw_queue_sanity_checks() - Perform some sanity checks on a H/W queue.
+ * @hdev: Pointer to hl_device structure.
+ * @q: Pointer to hl_hw_queue structure.
+ * @num_of_entries: How many entries to check for space.
+ *
+ * Perform the following:
+ * - Make sure we have enough space in the completion queue.
+ *   This check also ensures that there is enough space in the h/w queue, =
as
+ *   both queues are of the same size.
+ * - Reserve space in the completion queue (needs to be reversed if there
+ *   is a failure down the road before the actual submission of work).
+ *
+ * Both operations are done using the "free_slots_cnt" field of the comple=
tion
+ * queue. The CI counters of the queue and the completion queue are not
+ * needed/used for the H/W queue type.
+ */
+static int hw_queue_sanity_checks(struct hl_device *hdev, struct hl_hw_que=
ue *q,
+					int num_of_entries)
+{
+	atomic_t *free_slots =3D
+			&hdev->completion_queue[q->hw_queue_id].free_slots_cnt;
+
+	/*
+	 * Check we have enough space in the completion queue.
+	 * Add -1 to counter (decrement) unless counter was already 0.
+	 * In that case, CQ is full so we can't submit a new CB.
+	 * atomic_add_unless will return 0 if counter was already 0.
+	 */
+	if (atomic_add_negative(num_of_entries * -1, free_slots)) {
+		dev_dbg(hdev->dev, "No space for %d entries on CQ %d\n",
+			num_of_entries, q->hw_queue_id);
+		atomic_add(num_of_entries, free_slots);
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
 /*
  * hl_hw_queue_send_cb_no_cmpl - send a single CB (not a JOB) without comp=
letion
  *
@@ -188,7 +227,7 @@ int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hdev,=
 u32 hw_queue_id,
 				u32 cb_size, u64 cb_ptr)
 {
 	struct hl_hw_queue *q =3D &hdev->kernel_queues[hw_queue_id];
-	int rc;
+	int rc =3D 0;
=20
 	/*
 	 * The CPU queue is a synchronous queue with an effective depth of
@@ -206,11 +245,18 @@ int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hde=
v, u32 hw_queue_id,
 		goto out;
 	}
=20
-	rc =3D ext_queue_sanity_checks(hdev, q, 1, false);
-	if (rc)
-		goto out;
+	/*
+	 * hl_hw_queue_send_cb_no_cmpl() is called for queues of a H/W queue
+	 * type only on init phase, when the queues are empty and being tested,
+	 * so there is no need for sanity checks.
+	 */
+	if (q->queue_type !=3D QUEUE_TYPE_HW) {
+		rc =3D ext_queue_sanity_checks(hdev, q, 1, false);
+		if (rc)
+			goto out;
+	}
=20
-	ext_queue_submit_bd(hdev, q, 0, cb_size, cb_ptr);
+	ext_and_hw_queue_submit_bd(hdev, q, 0, cb_size, cb_ptr);
=20
 out:
 	if (q->queue_type !=3D QUEUE_TYPE_CPU)
@@ -220,14 +266,14 @@ int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hde=
v, u32 hw_queue_id,
 }
=20
 /*
- * ext_hw_queue_schedule_job - submit a JOB to an external queue
+ * ext_queue_schedule_job - submit a JOB to an external queue
  *
  * @job: pointer to the job that needs to be submitted to the queue
  *
  * This function must be called when the scheduler mutex is taken
  *
  */
-static void ext_hw_queue_schedule_job(struct hl_cs_job *job)
+static void ext_queue_schedule_job(struct hl_cs_job *job)
 {
 	struct hl_device *hdev =3D job->cs->ctx->hdev;
 	struct hl_hw_queue *q =3D &hdev->kernel_queues[job->hw_queue_id];
@@ -260,7 +306,7 @@ static void ext_hw_queue_schedule_job(struct hl_cs_job =
*job)
 	 * H/W queues is done under the scheduler mutex
 	 *
 	 * No need to check if CQ is full because it was already
-	 * checked in hl_queue_sanity_checks
+	 * checked in ext_queue_sanity_checks
 	 */
 	cq =3D &hdev->completion_queue[q->hw_queue_id];
 	cq_addr =3D cq->bus_address + cq->pi * sizeof(struct hl_cq_entry);
@@ -274,18 +320,18 @@ static void ext_hw_queue_schedule_job(struct hl_cs_jo=
b *job)
=20
 	cq->pi =3D hl_cq_inc_ptr(cq->pi);
=20
-	ext_queue_submit_bd(hdev, q, ctl, len, ptr);
+	ext_and_hw_queue_submit_bd(hdev, q, ctl, len, ptr);
 }
=20
 /*
- * int_hw_queue_schedule_job - submit a JOB to an internal queue
+ * int_queue_schedule_job - submit a JOB to an internal queue
  *
  * @job: pointer to the job that needs to be submitted to the queue
  *
  * This function must be called when the scheduler mutex is taken
  *
  */
-static void int_hw_queue_schedule_job(struct hl_cs_job *job)
+static void int_queue_schedule_job(struct hl_cs_job *job)
 {
 	struct hl_device *hdev =3D job->cs->ctx->hdev;
 	struct hl_hw_queue *q =3D &hdev->kernel_queues[job->hw_queue_id];
@@ -307,6 +353,60 @@ static void int_hw_queue_schedule_job(struct hl_cs_job=
 *job)
 	hdev->asic_funcs->ring_doorbell(hdev, q->hw_queue_id, q->pi);
 }
=20
+/*
+ * hw_queue_schedule_job - submit a JOB to a H/W queue
+ *
+ * @job: pointer to the job that needs to be submitted to the queue
+ *
+ * This function must be called when the scheduler mutex is taken
+ *
+ */
+static void hw_queue_schedule_job(struct hl_cs_job *job)
+{
+	struct hl_device *hdev =3D job->cs->ctx->hdev;
+	struct hl_hw_queue *q =3D &hdev->kernel_queues[job->hw_queue_id];
+	struct hl_cq *cq;
+	u64 ptr;
+	u32 offset, ctl, len;
+
+	/*
+	 * Upon PQE completion, COMP_DATA is used as the write data to the
+	 * completion queue (QMAN HBW message), and COMP_OFFSET is used as the
+	 * write address offset in the SM block (QMAN LBW message).
+	 * The write address offset is calculated as "COMP_OFFSET << 2".
+	 */
+	offset =3D job->cs->sequence & (HL_MAX_PENDING_CS - 1);
+	ctl =3D ((offset << BD_CTL_COMP_OFFSET_SHIFT) & BD_CTL_COMP_OFFSET_MASK) =
|
+		((q->pi << BD_CTL_COMP_DATA_SHIFT) & BD_CTL_COMP_DATA_MASK);
+
+	len =3D job->job_cb_size;
+
+	/*
+	 * A patched CB is created only if a user CB was allocated by driver and
+	 * MMU is disabled. If MMU is enabled, the user CB should be used
+	 * instead. If the user CB wasn't allocated by driver, assume that it
+	 * holds an address.
+	 */
+	if (job->patched_cb)
+		ptr =3D job->patched_cb->bus_address;
+	else if (job->is_kernel_allocated_cb)
+		ptr =3D job->user_cb->bus_address;
+	else
+		ptr =3D (u64) (uintptr_t) job->user_cb;
+
+	/*
+	 * No need to protect pi_offset because scheduling to the
+	 * H/W queues is done under the scheduler mutex
+	 *
+	 * No need to check if CQ is full because it was already
+	 * checked in hw_queue_sanity_checks
+	 */
+	cq =3D &hdev->completion_queue[q->hw_queue_id];
+	cq->pi =3D hl_cq_inc_ptr(cq->pi);
+
+	ext_and_hw_queue_submit_bd(hdev, q, ctl, len, ptr);
+}
+
 /*
  * hl_hw_queue_schedule_cs - schedule a command submission
  *
@@ -330,23 +430,34 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 	}
=20
 	q =3D &hdev->kernel_queues[0];
-	/* This loop assumes all external queues are consecutive */
 	for (i =3D 0, cq_cnt =3D 0 ; i < HL_MAX_QUEUES ; i++, q++) {
-		if (q->queue_type =3D=3D QUEUE_TYPE_EXT) {
-			if (cs->jobs_in_queue_cnt[i]) {
+		if (cs->jobs_in_queue_cnt[i]) {
+			switch (q->queue_type) {
+			case QUEUE_TYPE_EXT:
 				rc =3D ext_queue_sanity_checks(hdev, q,
-					cs->jobs_in_queue_cnt[i], true);
-				if (rc)
-					goto unroll_cq_resv;
-				cq_cnt++;
-			}
-		} else if (q->queue_type =3D=3D QUEUE_TYPE_INT) {
-			if (cs->jobs_in_queue_cnt[i]) {
+						cs->jobs_in_queue_cnt[i], true);
+				break;
+			case QUEUE_TYPE_INT:
 				rc =3D int_queue_sanity_checks(hdev, q,
-					cs->jobs_in_queue_cnt[i]);
-				if (rc)
-					goto unroll_cq_resv;
+						cs->jobs_in_queue_cnt[i]);
+				break;
+			case QUEUE_TYPE_HW:
+				rc =3D hw_queue_sanity_checks(hdev, q,
+						cs->jobs_in_queue_cnt[i]);
+				break;
+			default:
+				dev_err(hdev->dev, "Queue type %d is invalid\n",
+					q->queue_type);
+				rc =3D -EINVAL;
+				break;
 			}
+
+			if (rc)
+				goto unroll_cq_resv;
+
+			if (q->queue_type =3D=3D QUEUE_TYPE_EXT ||
+					q->queue_type =3D=3D QUEUE_TYPE_HW)
+				cq_cnt++;
 		}
 	}
=20
@@ -373,21 +484,30 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 	}
=20
 	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
-		if (job->ext_queue)
-			ext_hw_queue_schedule_job(job);
-		else
-			int_hw_queue_schedule_job(job);
+		switch (job->queue_type) {
+		case QUEUE_TYPE_EXT:
+			ext_queue_schedule_job(job);
+			break;
+		case QUEUE_TYPE_INT:
+			int_queue_schedule_job(job);
+			break;
+		case QUEUE_TYPE_HW:
+			hw_queue_schedule_job(job);
+			break;
+		default:
+			break;
+		}
=20
 	cs->submitted =3D true;
=20
 	goto out;
=20
 unroll_cq_resv:
-	/* This loop assumes all external queues are consecutive */
 	q =3D &hdev->kernel_queues[0];
 	for (i =3D 0 ; (i < HL_MAX_QUEUES) && (cq_cnt > 0) ; i++, q++) {
-		if ((q->queue_type =3D=3D QUEUE_TYPE_EXT) &&
-				(cs->jobs_in_queue_cnt[i])) {
+		if ((q->queue_type =3D=3D QUEUE_TYPE_EXT ||
+				q->queue_type =3D=3D QUEUE_TYPE_HW) &&
+				cs->jobs_in_queue_cnt[i]) {
 			atomic_t *free_slots =3D
 				&hdev->completion_queue[i].free_slots_cnt;
 			atomic_add(cs->jobs_in_queue_cnt[i], free_slots);
@@ -414,8 +534,8 @@ void hl_hw_queue_inc_ci_kernel(struct hl_device *hdev, =
u32 hw_queue_id)
 	q->ci =3D hl_queue_inc_ptr(q->ci);
 }
=20
-static int ext_and_cpu_hw_queue_init(struct hl_device *hdev,
-				struct hl_hw_queue *q, bool is_cpu_queue)
+static int ext_and_cpu_queue_init(struct hl_device *hdev, struct hl_hw_que=
ue *q,
+					bool is_cpu_queue)
 {
 	void *p;
 	int rc;
@@ -465,7 +585,7 @@ static int ext_and_cpu_hw_queue_init(struct hl_device *=
hdev,
 	return rc;
 }
=20
-static int int_hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q=
)
+static int int_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
 {
 	void *p;
=20
@@ -485,18 +605,38 @@ static int int_hw_queue_init(struct hl_device *hdev, =
struct hl_hw_queue *q)
 	return 0;
 }
=20
-static int cpu_hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q=
)
+static int cpu_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
+{
+	return ext_and_cpu_queue_init(hdev, q, true);
+}
+
+static int ext_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
 {
-	return ext_and_cpu_hw_queue_init(hdev, q, true);
+	return ext_and_cpu_queue_init(hdev, q, false);
 }
=20
-static int ext_hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q=
)
+static int hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
 {
-	return ext_and_cpu_hw_queue_init(hdev, q, false);
+	void *p;
+
+	p =3D hdev->asic_funcs->asic_dma_alloc_coherent(hdev,
+						HL_QUEUE_SIZE_IN_BYTES,
+						&q->bus_address,
+						GFP_KERNEL | __GFP_ZERO);
+	if (!p)
+		return -ENOMEM;
+
+	q->kernel_address =3D (u64) (uintptr_t) p;
+
+	/* Make sure read/write pointers are initialized to start of queue */
+	q->ci =3D 0;
+	q->pi =3D 0;
+
+	return 0;
 }
=20
 /*
- * hw_queue_init - main initialization function for H/W queue object
+ * queue_init - main initialization function for H/W queue object
  *
  * @hdev: pointer to hl_device device structure
  * @q: pointer to hl_hw_queue queue structure
@@ -505,7 +645,7 @@ static int ext_hw_queue_init(struct hl_device *hdev, st=
ruct hl_hw_queue *q)
  * Allocate dma-able memory for the queue and initialize fields
  * Returns 0 on success
  */
-static int hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
+static int queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
 			u32 hw_queue_id)
 {
 	int rc;
@@ -516,21 +656,20 @@ static int hw_queue_init(struct hl_device *hdev, stru=
ct hl_hw_queue *q,
=20
 	switch (q->queue_type) {
 	case QUEUE_TYPE_EXT:
-		rc =3D ext_hw_queue_init(hdev, q);
+		rc =3D ext_queue_init(hdev, q);
 		break;
-
 	case QUEUE_TYPE_INT:
-		rc =3D int_hw_queue_init(hdev, q);
+		rc =3D int_queue_init(hdev, q);
 		break;
-
 	case QUEUE_TYPE_CPU:
-		rc =3D cpu_hw_queue_init(hdev, q);
+		rc =3D cpu_queue_init(hdev, q);
+		break;
+	case QUEUE_TYPE_HW:
+		rc =3D hw_queue_init(hdev, q);
 		break;
-
 	case QUEUE_TYPE_NA:
 		q->valid =3D 0;
 		return 0;
-
 	default:
 		dev_crit(hdev->dev, "wrong queue type %d during init\n",
 			q->queue_type);
@@ -554,7 +693,7 @@ static int hw_queue_init(struct hl_device *hdev, struct=
 hl_hw_queue *q,
  *
  * Free the queue memory
  */
-static void hw_queue_fini(struct hl_device *hdev, struct hl_hw_queue *q)
+static void queue_fini(struct hl_device *hdev, struct hl_hw_queue *q)
 {
 	if (!q->valid)
 		return;
@@ -612,7 +751,7 @@ int hl_hw_queues_create(struct hl_device *hdev)
 			i < HL_MAX_QUEUES ; i++, q_ready_cnt++, q++) {
=20
 		q->queue_type =3D asic->hw_queues_props[i].type;
-		rc =3D hw_queue_init(hdev, q, i);
+		rc =3D queue_init(hdev, q, i);
 		if (rc) {
 			dev_err(hdev->dev,
 				"failed to initialize queue %d\n", i);
@@ -624,7 +763,7 @@ int hl_hw_queues_create(struct hl_device *hdev)
=20
 release_queues:
 	for (i =3D 0, q =3D hdev->kernel_queues ; i < q_ready_cnt ; i++, q++)
-		hw_queue_fini(hdev, q);
+		queue_fini(hdev, q);
=20
 	kfree(hdev->kernel_queues);
=20
@@ -637,7 +776,7 @@ void hl_hw_queues_destroy(struct hl_device *hdev)
 	int i;
=20
 	for (i =3D 0, q =3D hdev->kernel_queues ; i < HL_MAX_QUEUES ; i++, q++)
-		hw_queue_fini(hdev, q);
+		queue_fini(hdev, q);
=20
 	kfree(hdev->kernel_queues);
 }
diff --git a/drivers/misc/habanalabs/include/qman_if.h b/drivers/misc/haban=
alabs/include/qman_if.h
index bf59bbe27fdc..0fdb49188ed7 100644
--- a/drivers/misc/habanalabs/include/qman_if.h
+++ b/drivers/misc/habanalabs/include/qman_if.h
@@ -23,6 +23,8 @@ struct hl_bd {
 #define HL_BD_SIZE			sizeof(struct hl_bd)
=20
 /*
+ * S/W CTL FIELDS.
+ *
  * BD_CTL_REPEAT_VALID tells the CP whether the repeat field in the BD CTL=
 is
  * valid. 1 means the repeat field is valid, 0 means not-valid,
  * i.e. repeat =3D=3D 1
@@ -33,6 +35,16 @@ struct hl_bd {
 #define BD_CTL_SHADOW_INDEX_SHIFT	0
 #define BD_CTL_SHADOW_INDEX_MASK	0x00000FFF
=20
+/*
+ * H/W CTL FIELDS
+ */
+
+#define BD_CTL_COMP_OFFSET_SHIFT	16
+#define BD_CTL_COMP_OFFSET_MASK		0x00FF0000
+
+#define BD_CTL_COMP_DATA_SHIFT		0
+#define BD_CTL_COMP_DATA_MASK		0x0000FFFF
+
 /*
  * COMPLETION QUEUE
  */
--=20
2.17.1

