Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87C6C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7969E2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="BMSrEExC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfJCImb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:42:31 -0400
Received: from mail-eopbgr00116.outbound.protection.outlook.com ([40.107.0.116]:36543
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727382AbfJCIma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:42:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIyrUl8dqqdQeUDDur4+m6pWyOzqRp7ROnwTou3/caQlpd3WSJCCi8d6j53wqMPKT6icgEmLdbv394LVOF+BSqJAkbxM15i81gxnJmDLUkSHTNN7Bd087yVa463AgCMCGMUPpmEl7VQ2mzUneqcF7D+sUP7jkkBoHqtpYjMp43SzUdvbQj53NkoW0zO9FldELPiVcyzSczIySkGddIOVwvxM/9PZQWCGRwdMFtRDB4AFhJzOsTSnErOS7CXvtkLI9LvK1UBRpHAX8+wEIM1oxbQ+Y/3d09PSeX0pUnz+sCD4GUUJzf3jgPpLApw+pucNti/kvs3wB0+diTgqIUmFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKGIdSGsb3IS6HBEx6v6Sb/k7OG0QWrfuQZeR9/JUu0=;
 b=PeMA6fddv990pvDFiJO4hMGnJmm5WcDOh3SWmBI4/WWtJFJCRBko+p7Vfk1PoHm2MWRbCgtM24/Dukr5bIM0lT7WB40TFeDHFvIgROYM6ZkIDIH6QHrEK0t7Z4DJ8avi+ff0IGD2jSp3UEjawteK1RxZ3fFOK2gyyIppdA7EtiCa1/IoMj24xwtHnvIDsXBIHnHHr/Q2Fs9fV5b3Ru55TY6SBc8Uqdfv1O+B8Gh+P6HiYaPRW30OU7RIxh3IN77k2jy1+qSq+7iJbuvkweQcgn1GcuVAVn7G5fNZzHIGYPnky4bv19A1XT4uT5T5R2Fq5BIzXThT58Tb+TpdJlMxWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKGIdSGsb3IS6HBEx6v6Sb/k7OG0QWrfuQZeR9/JUu0=;
 b=BMSrEExC9p3culvDEsxowtg0EwlxvJB2VTedsLbFYc0JKSZGB0zid8XN2BQwmd9IJat5VApsCzjiPRG5qFaKhmFKLCHmb4jMQ29k1gQgOrHPPTG+RHz0UhZHPFky/AjUOThCTMxtAdrd8K/dWVL0SENMEpobOi6KE8wR7Q6FS58=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB3245.eurprd02.prod.outlook.com (10.170.237.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 08:42:19 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78a3:56d0:8d09:1604]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78a3:56d0:8d09:1604%6]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 08:42:19 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] habanalabs: Add IRQ handler for CS completions
Thread-Topic: [PATCH 4/4] habanalabs: Add IRQ handler for CS completions
Thread-Index: AQHVecZ3SCsUmJ1r9EGM3mwUn/xIvQ==
Date:   Thu, 3 Oct 2019 08:42:18 +0000
Message-ID: <20191003084209.9547-4-ttayar@habana.ai>
References: <20191003084209.9547-1-ttayar@habana.ai>
In-Reply-To: <20191003084209.9547-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0004.eurprd04.prod.outlook.com
 (2603:10a6:208:15::17) To VI1PR02MB3054.eurprd02.prod.outlook.com
 (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97998e27-8b5a-47f7-8e8c-08d747dd998a
x-ms-traffictypediagnostic: VI1PR02MB3245:
x-microsoft-antispam-prvs: <VI1PR02MB3245EE9525CC73ED7A6CFD63D29F0@VI1PR02MB3245.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39830400003)(366004)(189003)(199004)(51234002)(5660300002)(8676002)(2351001)(486006)(66476007)(66946007)(66446008)(64756008)(66556008)(6506007)(66066001)(102836004)(25786009)(71190400001)(11346002)(446003)(2616005)(71200400001)(386003)(186003)(36756003)(26005)(6116002)(1076003)(4326008)(3846002)(476003)(8936002)(6436002)(6916009)(305945005)(50226002)(99286004)(5640700003)(2501003)(316002)(478600001)(2906002)(86362001)(6512007)(14444005)(81156014)(7736002)(256004)(14454004)(1361003)(6486002)(52116002)(81166006)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3245;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OEgDXaJBm3c5obbfrWAxwN9ItPS4v6T4Dy8/V1+U3OfbuJ+FcWdjyheZEJHtoLTkpZMK84mXkpMsdEDtI8oY2MUvJyGYoAFDQHMYFugfrGy71a+X5+bf0jHd+Ms6R6lPP+U1rXx+uDUa10dMv/tGfAw30NZ6BFMOj4MTGvHIpUDz4cbsnQNxek12n4ECIiA1EmzmKRBcnSHVUGW+gaLXg0f3IJrUeryv9QdCQz16A8goclSsSV8k0eg+4sKfiykOT5p63OHCiQcElPO5v9xtNuwEqownhAnznI4xNW7hbjCKfv0lrgFrQLOlex3jE9bE4cJNi0DJoGKQn56dK9yuHm3JQ6T8Nqd32hm1bNkkTCWGH8YIb82zkTsNueiKZUp23zfzj5WkJdlRjsCWHihKogjnW3qCBWiF+51/bEkfUU8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 97998e27-8b5a-47f7-8e8c-08d747dd998a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 08:42:18.7552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kldymWPncZBTAGgdLVbS2amNehQ0jWeTZkrdOby2CEzMGJNsUFZUuQTSrP8y25aNtvaz2H2W0iXptqvsj5UzNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an IRQ handler for CS completions of CS jobs which are
sent on H/W queues.
The patch adds a CS shadow queue, from which the handler retrieves the
CS, and a dedicated workqueue, on which the handler queues a work to
free the CS jobs.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/command_submission.c | 16 +++++++
 drivers/misc/habanalabs/device.c             | 27 +++++++++++-
 drivers/misc/habanalabs/habanalabs.h         | 18 ++++++++
 drivers/misc/habanalabs/hw_queue.c           |  2 +
 drivers/misc/habanalabs/irq.c                | 46 ++++++++++++++++++++
 5 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/ha=
banalabs/command_submission.c
index 25dc7308da19..b995a02a31dd 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -267,6 +267,8 @@ static void cs_do_release(struct kref *ref)
=20
 	hl_ctx_put(cs->ctx);
=20
+	hdev->shadow_cs_queue[cs->sequence & (HL_MAX_PENDING_CS - 1)] =3D NULL;
+
 	if (cs->timedout)
 		dma_fence_set_error(cs->fence, -ETIMEDOUT);
 	else if (cs->aborted)
@@ -391,6 +393,7 @@ void hl_cs_rollback_all(struct hl_device *hdev)
=20
 	/* flush all completions */
 	flush_workqueue(hdev->cq_wq);
+	flush_workqueue(hdev->cs_cmplt_wq);
=20
 	/* Make sure we don't have leftovers in the H/W queues mirror list */
 	list_for_each_entry_safe(cs, tmp, &hdev->hw_queues_mirror_list,
@@ -415,6 +418,16 @@ static void job_wq_completion(struct work_struct *work=
)
 	free_job(hdev, job);
 }
=20
+static void cs_completion(struct work_struct *work)
+{
+	struct hl_cs *cs =3D container_of(work, struct hl_cs, finish_work);
+	struct hl_device *hdev =3D cs->ctx->hdev;
+	struct hl_cs_job *job, *tmp;
+
+	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
+		free_job(hdev, job);
+}
+
 static int validate_queue_index(struct hl_device *hdev,
 				struct hl_cs_chunk *chunk,
 				enum hl_queue_type *queue_type,
@@ -625,6 +638,9 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __=
user *chunks,
 		goto free_cs_object;
 	}
=20
+	if (job->queue_type =3D=3D QUEUE_TYPE_HW)
+		INIT_WORK(&cs->finish_work, cs_completion);
+
 	rc =3D hl_hw_queue_schedule_cs(cs);
 	if (rc) {
 		dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/dev=
ice.c
index 2f5a4da707e7..6c13f05c3120 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -284,11 +284,19 @@ static int device_early_init(struct hl_device *hdev)
 		goto free_cq_wq;
 	}
=20
+	hdev->cs_cmplt_wq =3D alloc_workqueue("hl-cs-completions", WQ_UNBOUND, 0)=
;
+	if (!hdev->cs_cmplt_wq) {
+		dev_err(hdev->dev,
+			"Failed to allocate CS completions workqueue\n");
+		rc =3D -ENOMEM;
+		goto free_eq_wq;
+	}
+
 	hdev->hl_chip_info =3D kzalloc(sizeof(struct hwmon_chip_info),
 					GFP_KERNEL);
 	if (!hdev->hl_chip_info) {
 		rc =3D -ENOMEM;
-		goto free_eq_wq;
+		goto free_cs_cmplt_wq;
 	}
=20
 	hdev->idle_busy_ts_arr =3D kmalloc_array(HL_IDLE_BUSY_TS_ARR_SIZE,
@@ -314,6 +322,8 @@ static int device_early_init(struct hl_device *hdev)
=20
 free_chip_info:
 	kfree(hdev->hl_chip_info);
+free_cs_cmplt_wq:
+	destroy_workqueue(hdev->cs_cmplt_wq);
 free_eq_wq:
 	destroy_workqueue(hdev->eq_wq);
 free_cq_wq:
@@ -346,6 +356,7 @@ static void device_early_fini(struct hl_device *hdev)
 	kfree(hdev->idle_busy_ts_arr);
 	kfree(hdev->hl_chip_info);
=20
+	destroy_workqueue(hdev->cs_cmplt_wq);
 	destroy_workqueue(hdev->eq_wq);
 	destroy_workqueue(hdev->cq_wq);
=20
@@ -1138,6 +1149,14 @@ int hl_device_init(struct hl_device *hdev, struct cl=
ass *hclass)
 		}
 	}
=20
+	hdev->shadow_cs_queue =3D kmalloc_array(HL_MAX_PENDING_CS,
+						sizeof(*hdev->shadow_cs_queue),
+						GFP_KERNEL | __GFP_ZERO);
+	if (!hdev->shadow_cs_queue) {
+		rc =3D -ENOMEM;
+		goto cq_fini;
+	}
+
 	/*
 	 * Initialize the event queue. Must be done before hw_init,
 	 * because there the address of the event queue is being
@@ -1146,7 +1165,7 @@ int hl_device_init(struct hl_device *hdev, struct cla=
ss *hclass)
 	rc =3D hl_eq_init(hdev, &hdev->event_queue);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize event queue\n");
-		goto cq_fini;
+		goto free_shadow_cs_queue;
 	}
=20
 	/* MMU S/W must be initialized before kernel context is created */
@@ -1269,6 +1288,8 @@ int hl_device_init(struct hl_device *hdev, struct cla=
ss *hclass)
 	hl_mmu_fini(hdev);
 eq_fini:
 	hl_eq_fini(hdev, &hdev->event_queue);
+free_shadow_cs_queue:
+	kfree(hdev->shadow_cs_queue);
 cq_fini:
 	for (i =3D 0 ; i < cq_ready_cnt ; i++)
 		hl_cq_fini(hdev, &hdev->completion_queue[i]);
@@ -1383,6 +1404,8 @@ void hl_device_fini(struct hl_device *hdev)
=20
 	hl_eq_fini(hdev, &hdev->event_queue);
=20
+	kfree(hdev->shadow_cs_queue);
+
 	for (i =3D 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		hl_cq_fini(hdev, &hdev->completion_queue[i]);
 	kfree(hdev->completion_queue);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs=
/habanalabs.h
index c1af83f96415..2efb5e1e62cb 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -722,6 +722,7 @@ struct hl_userptr {
  * @job_lock: spinlock for the CS's jobs list. Needed for free_job.
  * @refcount: reference counter for usage of the CS.
  * @fence: pointer to the fence object of this CS.
+ * @finish_work: workqueue object to run when CS is completed by H/W.
  * @work_tdr: delayed work node for TDR.
  * @mirror_node : node in device mirror list of command submissions.
  * @debugfs_list: node in debugfs list of command submissions.
@@ -741,6 +742,7 @@ struct hl_cs {
 	spinlock_t		job_lock;
 	struct kref		refcount;
 	struct dma_fence	*fence;
+	struct work_struct	finish_work;
 	struct delayed_work	work_tdr;
 	struct list_head	mirror_node;
 	struct list_head	debugfs_list;
@@ -1203,8 +1205,12 @@ struct hl_device_idle_busy_ts {
  * @asic_name: ASIC specific nmae.
  * @asic_type: ASIC specific type.
  * @completion_queue: array of hl_cq.
+ * @shadow_cs_queue: pointer to a shadow queue that holds pointers to
+ *                   outstanding command submissions.
  * @cq_wq: work queue of completion queues for executing work in process c=
ontext
  * @eq_wq: work queue of event queue for executing work in process context=
.
+ * @cs_cmplt_wq: work queue of CS completions for executing work in proces=
s
+ *               context.
  * @kernel_ctx: Kernel driver context structure.
  * @kernel_queues: array of hl_hw_queue.
  * @hw_queues_mirror_list: CS mirror list for TDR.
@@ -1284,8 +1290,10 @@ struct hl_device {
 	char				asic_name[16];
 	enum hl_asic_type		asic_type;
 	struct hl_cq			*completion_queue;
+	struct hl_cs			**shadow_cs_queue;
 	struct workqueue_struct		*cq_wq;
 	struct workqueue_struct		*eq_wq;
+	struct workqueue_struct		*cs_cmplt_wq;
 	struct hl_ctx			*kernel_ctx;
 	struct hl_hw_queue		*kernel_queues;
 	struct list_head		hw_queues_mirror_list;
@@ -1359,6 +1367,15 @@ struct hl_device {
 	u8				pldm;
 };
=20
+/**
+ * struct hl_cs_irq_info - IRQ info structure for CS completion interrupt.
+ * @hdev: pointer to habanalabs device structure.
+ * @relative_idx: CS completion relative interrupt index (0-based).
+ */
+struct hl_cs_irq_info {
+	struct hl_device *hdev;
+	int relative_idx;
+};
=20
 /*
  * IOCTLs
@@ -1470,6 +1487,7 @@ void hl_cq_reset(struct hl_device *hdev, struct hl_cq=
 *q);
 void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q);
 irqreturn_t hl_irq_handler_cq(int irq, void *arg);
 irqreturn_t hl_irq_handler_eq(int irq, void *arg);
+irqreturn_t hl_irq_handler_cs_cmplt(int irq, void *arg);
 u32 hl_cq_inc_ptr(u32 ptr);
=20
 int hl_asid_init(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/h=
w_queue.c
index a1205ae47250..7b80e571a27c 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -469,6 +469,8 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 		goto unroll_cq_resv;
 	}
=20
+	hdev->shadow_cs_queue[cs->sequence & (HL_MAX_PENDING_CS - 1)] =3D cs;
+
 	spin_lock(&hdev->hw_queues_mirror_lock);
 	list_add_tail(&cs->mirror_node, &hdev->hw_queues_mirror_list);
=20
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index fac65fbd70e8..93fa13218dd4 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -205,6 +205,52 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
=20
+/*
+ * hl_irq_handler_cs_cmplt() - irq handler for CS completions.
+ * @irq: IRQ number
+ * @arg: pointer to hl_device structure.
+ */
+irqreturn_t hl_irq_handler_cs_cmplt(int irq, void *arg)
+{
+	struct hl_cs_irq_info *cs_irq_info =3D arg;
+	struct hl_device *hdev =3D cs_irq_info->hdev;
+	struct hl_cs *cs;
+	struct hl_cs_job *job;
+	struct hl_cq *cq;
+	int relative_idx =3D cs_irq_info->relative_idx;
+
+	if (hdev->disabled) {
+		dev_dbg(hdev->dev,
+			"Device disabled but received IRQ %d for CS completion\n",
+			irq);
+		goto out;
+	}
+
+	cs =3D hdev->shadow_cs_queue[relative_idx & (HL_MAX_PENDING_CS - 1)];
+	if (!cs) {
+		dev_warn(hdev->dev,
+			"No pointer to CS in shadow array at index %d\n",
+			relative_idx);
+		goto out;
+	}
+
+	queue_work(hdev->cs_cmplt_wq, &cs->finish_work);
+
+	/*
+	 * The same CQs can be accessed from parallel IRQ handlers that handle
+	 * the completion of different CSs. However, locking is not needed
+	 * because the "free_slots_cnt" variable is atomic.
+	 * There is no need to update the CI counters of the queues/CQs, as they
+	 * are not needed/used for the H/W queue type.
+	 */
+	list_for_each_entry(job, &cs->job_list, cs_node) {
+		cq =3D &hdev->completion_queue[job->hw_queue_id];
+		atomic_inc(&cq->free_slots_cnt);
+	}
+out:
+	return IRQ_HANDLED;
+}
+
 /*
  * hl_cq_init - main initialization function for an cq object
  *
--=20
2.17.1

