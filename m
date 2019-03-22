Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBBEC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF655218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o3eZ3722";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fO5IzmkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfCVUX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:23:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33258 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfCVUX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:23:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C5C71621A8; Fri, 22 Mar 2019 20:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553286206;
        bh=DPSBMUvJpltSgiYg2l+3Y4MQBD0VvrTTAHlZvUidg5E=;
        h=From:To:Cc:Subject:Date:From;
        b=o3eZ3722bqevnkaBf77x8k7116YBDXZW/3MXwNOC5z+pcwvzANjkyKmjfUd+kY9tV
         dg/jcx5hlkMJGufFLtBtzynOvHz6qRRcGLLbExL8hYMaZolZHubIy7Pbnbp7XqTP5C
         TgwVWsT/142baqjRR27U/lZgoREuH0upon1GWxus=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 618DA62B3C;
        Fri, 22 Mar 2019 20:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553286087;
        bh=DPSBMUvJpltSgiYg2l+3Y4MQBD0VvrTTAHlZvUidg5E=;
        h=From:To:Cc:Subject:Date:From;
        b=fO5IzmkKX04rwoCXa3ERc1aaRiALg2zOzS4sPJr3gDE5VRXM+jcbtAy74Jo0X3Mdq
         TcvleXbET2gS0ROAfT34uJgHkuchPcloxNXxUxlDXFyXPKuETShiFFkIFfPaHt3I8z
         bIo5sAatZW0n3W1TOU8eAwLsMSXFqwX38i4o3Ut8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 618DA62B3C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2] drm/msm/gpu: Add submit queue queries
Date:   Fri, 22 Mar 2019 14:21:22 -0600
Message-Id: <1553286082-5455-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the capability to query information from a submit queue.
The first available parameter is for querying the number of GPU faults
(hangs) that can be attributed to the queue.

This is useful for implementing context robustness. A user context can
regularly query the number of faults to see if it is responsible for any
and if so it can invalidate itself.

This is also helpful for testing by confirming to the user  driver if a
particular command stream caused a fault (or not as the case may be).

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/msm_drv.c         |  9 +++++++-
 drivers/gpu/drm/msm/msm_drv.h         |  2 ++
 drivers/gpu/drm/msm/msm_gpu.c         |  3 +++
 drivers/gpu/drm/msm/msm_submitqueue.c | 41 +++++++++++++++++++++++++++++++++++
 include/uapi/drm/msm_drm.h            | 12 ++++++++++
 5 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 906b2bb..b8671bd 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -39,9 +39,10 @@
  *           MSM_GEM_INFO ioctl.
  * - 1.4.0 - softpin, MSM_RELOC_BO_DUMP, and GEM_INFO support to set/get
  *           GEM object's debug name
+ * - 1.5.0 - Add SUBMITQUERY_QUERY ioctl
  */
 #define MSM_VERSION_MAJOR	1
-#define MSM_VERSION_MINOR	4
+#define MSM_VERSION_MINOR	5
 #define MSM_VERSION_PATCHLEVEL	0
 
 static const struct drm_mode_config_funcs mode_config_funcs = {
@@ -964,6 +965,11 @@ static int msm_ioctl_submitqueue_new(struct drm_device *dev, void *data,
 		args->flags, &args->id);
 }
 
+static int msm_ioctl_submitqueue_query(struct drm_device *dev, void *data,
+		struct drm_file *file)
+{
+	return msm_submitqueue_query(dev, file->driver_priv, data);
+}
 
 static int msm_ioctl_submitqueue_close(struct drm_device *dev, void *data,
 		struct drm_file *file)
@@ -984,6 +990,7 @@ static const struct drm_ioctl_desc msm_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(MSM_GEM_MADVISE,  msm_ioctl_gem_madvise,  DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_NEW,   msm_ioctl_submitqueue_new,   DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_CLOSE, msm_ioctl_submitqueue_close, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_QUERY, msm_ioctl_submitqueue_query, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct vm_operations_struct vm_ops = {
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index cb642fe..afb9171 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -420,6 +420,8 @@ struct msm_gpu_submitqueue *msm_submitqueue_get(struct msm_file_private *ctx,
 		u32 id);
 int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
 		u32 prio, u32 flags, u32 *id);
+int msm_submitqueue_query(struct drm_device *drm, struct msm_file_private *ctx,
+		struct drm_msm_submitqueue_query *args);
 int msm_submitqueue_remove(struct msm_file_private *ctx, u32 id);
 void msm_submitqueue_close(struct msm_file_private *ctx);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 10babd1..c2237a5 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -443,6 +443,9 @@ static void recover_worker(struct work_struct *work)
 	if (submit) {
 		struct task_struct *task;
 
+		/* Increment the submitqueue fault count */
+		submit->queue->faults++;
+
 		task = get_pid_task(submit->pid, PIDTYPE_PID);
 		if (task) {
 			comm = kstrdup(task->comm, GFP_KERNEL);
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 5115f75..f160ec4 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -120,6 +120,47 @@ int msm_submitqueue_init(struct drm_device *drm, struct msm_file_private *ctx)
 	return msm_submitqueue_create(drm, ctx, default_prio, 0, NULL);
 }
 
+static int msm_submitqueue_query_faults(struct msm_gpu_submitqueue *queue,
+		struct drm_msm_submitqueue_query *args)
+{
+	size_t size = min_t(size_t, args->len, sizeof(queue->faults));
+	int ret;
+
+	/* If a zero length was passed in, return the data size we expect */
+	if (!args->len) {
+		args->len = sizeof(queue->faults);
+		return 0;
+	}
+
+	/* Set the length to the actual size of the data */
+	args->len = size;
+
+	ret = copy_to_user(u64_to_user_ptr(args->data), &queue->faults, size);
+
+	return ret ? -EFAULT : 0;
+}
+
+int msm_submitqueue_query(struct drm_device *drm, struct msm_file_private *ctx,
+		struct drm_msm_submitqueue_query *args)
+{
+	struct msm_gpu_submitqueue *queue;
+	int ret = -EINVAL;
+
+	if (args->pad)
+		return -EINVAL;
+
+	queue = msm_submitqueue_get(ctx, args->id);
+	if (!queue)
+		return -ENOENT;
+
+	if (args->param == MSM_SUBMITQUEUE_PARAM_FAULTS)
+		ret = msm_submitqueue_query_faults(queue, args);
+
+	msm_submitqueue_put(queue);
+
+	return ret;
+}
+
 int msm_submitqueue_remove(struct msm_file_private *ctx, u32 id)
 {
 	struct msm_gpu_submitqueue *entry;
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 91a16b3..cba69d2 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -286,6 +286,16 @@ struct drm_msm_submitqueue {
 	__u32 id;      /* out, identifier */
 };
 
+#define MSM_SUBMITQUEUE_PARAM_FAULTS   0
+
+struct drm_msm_submitqueue_query {
+	__u64 data;
+	__u32 id;
+	__u32 param;
+	__u32 len;
+	__u32 pad;
+};
+
 #define DRM_MSM_GET_PARAM              0x00
 /* placeholder:
 #define DRM_MSM_SET_PARAM              0x01
@@ -302,6 +312,7 @@ struct drm_msm_submitqueue {
  */
 #define DRM_MSM_SUBMITQUEUE_NEW        0x0A
 #define DRM_MSM_SUBMITQUEUE_CLOSE      0x0B
+#define DRM_MSM_SUBMITQUEUE_QUERY      0x0C
 
 #define DRM_IOCTL_MSM_GET_PARAM        DRM_IOWR(DRM_COMMAND_BASE + DRM_MSM_GET_PARAM, struct drm_msm_param)
 #define DRM_IOCTL_MSM_GEM_NEW          DRM_IOWR(DRM_COMMAND_BASE + DRM_MSM_GEM_NEW, struct drm_msm_gem_new)
@@ -313,6 +324,7 @@ struct drm_msm_submitqueue {
 #define DRM_IOCTL_MSM_GEM_MADVISE      DRM_IOWR(DRM_COMMAND_BASE + DRM_MSM_GEM_MADVISE, struct drm_msm_gem_madvise)
 #define DRM_IOCTL_MSM_SUBMITQUEUE_NEW    DRM_IOWR(DRM_COMMAND_BASE + DRM_MSM_SUBMITQUEUE_NEW, struct drm_msm_submitqueue)
 #define DRM_IOCTL_MSM_SUBMITQUEUE_CLOSE  DRM_IOW (DRM_COMMAND_BASE + DRM_MSM_SUBMITQUEUE_CLOSE, __u32)
+#define DRM_IOCTL_MSM_SUBMITQUEUE_QUERY  DRM_IOW (DRM_COMMAND_BASE + DRM_MSM_SUBMITQUEUE_QUERY, struct drm_msm_submitqueue_query)
 
 #if defined(__cplusplus)
 }
-- 
2.7.4

