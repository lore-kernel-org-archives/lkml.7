Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF43C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB8021783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfKKQ0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:26:38 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:40315 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKQ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:26:37 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MI4gb-1iipMW3UJz-00FAzq; Mon, 11 Nov 2019 17:26:31 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [v2] drm/etnaviv: avoid deprecated timespec
Date:   Mon, 11 Nov 2019 17:25:32 +0100
Message-Id: <20191111162547.2221524-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111162547.2221524-1-arnd@arndb.de>
References: <20191111162547.2221524-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RnQ+mfEVAlKYgxL5lmB1o2ooX//bBZbsI9rNFLD36UF/KkPz7BG
 4xpUbcY2ykHcP7iyX5tRrPhkGXwF56JAAG0DruikQKuZZSxzUzt0zgoqmq/9jWvsXBx1xKv
 RBMVIcu4kaG7C9HKeYneRxC1LACW0pvU85ykgKq8CKLHGxxFC6fx2c0jL6LlWQzPN0YeraV
 fQrERd1v0oERemb7cxReg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ExkpKdVh5SY=:gHsJ0Dcl3xyb2seQp8MhE5
 Ap9Cuv4+poI0xjdJFHPQQ5ZLPezz54C12AJBviqk3FLQdz2VAGZkS30Vwvq4MCCM8i79I9MDe
 RHjMdtyMqtj46iFMzi4qeXLdyj4VuJBA8PyNkwvMfVJIGi4NZmtKJ1oQcl/wB4eBUA/Zkg+cI
 QJ3XxmYmmgQkTyFRg1x8DXri5ouc9bYcPQdlKToh3bs1wRI6hz/o3sx2SNK1pRVgJvYc3JIaJ
 vCBWIfXb7dWGDTKMmeR+SjOSaMytkOlRfFBN0HAdVsRdKAzR/ZThEA+nAjrffz3IqWJtrpI+d
 mobHfRxxnxE3x1+pMwxRAraI6SFsVon+5P5viOkMt/m/rEf0ZT/fo9WLwXCyVCggKwrsDK6Ax
 0DcnnEapyXAH08FSVVgFupjCRQHgcjR4ZRvlr/VvUzJTnWxUzwmTfhNthNUbRLvCTbc+Vcwp8
 Tcz44Gfa6J42JGCf/1ToePSahjhJBh9mujvuTPLK/RDWUR2mNWYOa4De08atNop6wza0uy0/+
 DKfdqmF96ewU5f80U24dC/Tf2BIY5VKApMfXD98/EKnHSK/YFuoIQsjGhHmfPiF4KYRzjyHpD
 ObajI7S52SD4+9FTe4u7mJ4WWbtRKLaSJv8W+JJqlmlDfdHJVueAodaUdV7YftYf7bamv9hPQ
 h8FqGbm4PCKf+1MlRzzaNWl3boncPV+DZTHyioJ7Lx2UjvYqXvCUMDxZ+cXmJaM4Ux9gl+1jn
 QhrBNvf0xNQ7cArrtitRkadgpzXtRGnSrwx0U0taRAIB/Nafs3S7kFsjbGXZKPm38CoKcn1jp
 fXnLG5EPEfZbvV0qxwuqRJ9jbh9Akp2MKpVIDCCnlH+2CG2Fbwhjx4AOL0/Llz9p9ZwPbSOL3
 am+sI0cm0bdWDFv8eJfQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct timespec is being removed from the kernel because it often leads
to code that is not y2038-safe.

In the etnaviv driver, monotonic timestamps are used, which do not suffer
from overflow, but the usage of timespec here gets in the way of removing
the interface completely.

Pass down the user-supplied 64-bit value here rather than converting
it to an intermediate timespec to avoid the conversion.

The conversion is transparent for all regular CLOCK_MONOTONIC values,
but is a small change in behavior for excessively large values: the
existing code would treat e.g. tv_sec=0x100000000 the same as tv_sec=0
and not block, while the new code it would block for up to 2^31
seconds. The new behavior is more logical here, but if it causes problems,
the truncation can be put back.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 11 +++--------
 drivers/gpu/drm/etnaviv/etnaviv_drv.h | 11 ++++++-----
 drivers/gpu/drm/etnaviv/etnaviv_gem.c |  4 ++--
 drivers/gpu/drm/etnaviv/etnaviv_gem.h |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  5 +++--
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  5 +++--
 6 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 95d72dc00280..3eb0f9223bea 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -282,11 +282,6 @@ static int etnaviv_ioctl_gem_new(struct drm_device *dev, void *data,
 			args->flags, &args->handle);
 }
 
-#define TS(t) ((struct timespec){ \
-	.tv_sec = (t).tv_sec, \
-	.tv_nsec = (t).tv_nsec \
-})
-
 static int etnaviv_ioctl_gem_cpu_prep(struct drm_device *dev, void *data,
 		struct drm_file *file)
 {
@@ -304,7 +299,7 @@ static int etnaviv_ioctl_gem_cpu_prep(struct drm_device *dev, void *data,
 	if (!obj)
 		return -ENOENT;
 
-	ret = etnaviv_gem_cpu_prep(obj, args->op, &TS(args->timeout));
+	ret = etnaviv_gem_cpu_prep(obj, args->op, &args->timeout);
 
 	drm_gem_object_put_unlocked(obj);
 
@@ -357,7 +352,7 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
 {
 	struct drm_etnaviv_wait_fence *args = data;
 	struct etnaviv_drm_private *priv = dev->dev_private;
-	struct timespec *timeout = &TS(args->timeout);
+	struct drm_etnaviv_timespec *timeout = &args->timeout;
 	struct etnaviv_gpu *gpu;
 
 	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
@@ -409,7 +404,7 @@ static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
 {
 	struct etnaviv_drm_private *priv = dev->dev_private;
 	struct drm_etnaviv_gem_wait *args = data;
-	struct timespec *timeout = &TS(args->timeout);
+	struct drm_etnaviv_timespec *timeout = &args->timeout;
 	struct drm_gem_object *obj;
 	struct etnaviv_gpu *gpu;
 	int ret;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index 32cfa5a48d42..efc656efeb0f 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -61,7 +61,7 @@ int etnaviv_gem_prime_pin(struct drm_gem_object *obj);
 void etnaviv_gem_prime_unpin(struct drm_gem_object *obj);
 void *etnaviv_gem_vmap(struct drm_gem_object *obj);
 int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
-		struct timespec *timeout);
+		struct drm_etnaviv_timespec *timeout);
 int etnaviv_gem_cpu_fini(struct drm_gem_object *obj);
 void etnaviv_gem_free_object(struct drm_gem_object *obj);
 int etnaviv_gem_new_handle(struct drm_device *dev, struct drm_file *file,
@@ -107,11 +107,12 @@ static inline size_t size_vstruct(size_t nelem, size_t elem_size, size_t base)
  * between the specified timeout and the current CLOCK_MONOTONIC time.
  */
 static inline unsigned long etnaviv_timeout_to_jiffies(
-	const struct timespec *timeout)
+	const struct drm_etnaviv_timespec *timeout)
 {
-	struct timespec64 ts, to;
-
-	to = timespec_to_timespec64(*timeout);
+	struct timespec64 ts, to = {
+		.tv_sec = timeout->tv_sec,
+		.tv_nsec = timeout->tv_nsec,
+	};
 
 	ktime_get_ts64(&ts);
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index cb1faaac380a..6adea180d629 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -373,7 +373,7 @@ static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
 }
 
 int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
-		struct timespec *timeout)
+		struct drm_etnaviv_timespec *timeout)
 {
 	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
 	struct drm_device *dev = obj->dev;
@@ -431,7 +431,7 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
 }
 
 int etnaviv_gem_wait_bo(struct etnaviv_gpu *gpu, struct drm_gem_object *obj,
-	struct timespec *timeout)
+	struct drm_etnaviv_timespec *timeout)
 {
 	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
index d6270acce619..6b68fe16041b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
@@ -112,7 +112,7 @@ struct etnaviv_gem_submit {
 void etnaviv_submit_put(struct etnaviv_gem_submit * submit);
 
 int etnaviv_gem_wait_bo(struct etnaviv_gpu *gpu, struct drm_gem_object *obj,
-	struct timespec *timeout);
+	struct drm_etnaviv_timespec *timeout);
 int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
 	const struct etnaviv_gem_ops *ops, struct etnaviv_gem_object **res);
 void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index d47d1a8e0219..799ec20b267d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1132,7 +1132,7 @@ static void event_free(struct etnaviv_gpu *gpu, unsigned int event)
  * Cmdstream submission/retirement:
  */
 int etnaviv_gpu_wait_fence_interruptible(struct etnaviv_gpu *gpu,
-	u32 id, struct timespec *timeout)
+	u32 id, struct drm_etnaviv_timespec *timeout)
 {
 	struct dma_fence *fence;
 	int ret;
@@ -1179,7 +1179,8 @@ int etnaviv_gpu_wait_fence_interruptible(struct etnaviv_gpu *gpu,
  * that lock in this function while waiting.
  */
 int etnaviv_gpu_wait_obj_inactive(struct etnaviv_gpu *gpu,
-	struct etnaviv_gem_object *etnaviv_obj, struct timespec *timeout)
+	struct etnaviv_gem_object *etnaviv_obj,
+	struct drm_etnaviv_timespec *timeout)
 {
 	unsigned long remaining;
 	long ret;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 8f9bd4edc96a..97bb48042b4d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -169,9 +169,10 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m);
 void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu);
 void etnaviv_gpu_retire(struct etnaviv_gpu *gpu);
 int etnaviv_gpu_wait_fence_interruptible(struct etnaviv_gpu *gpu,
-	u32 fence, struct timespec *timeout);
+	u32 fence, struct drm_etnaviv_timespec *timeout);
 int etnaviv_gpu_wait_obj_inactive(struct etnaviv_gpu *gpu,
-	struct etnaviv_gem_object *etnaviv_obj, struct timespec *timeout);
+	struct etnaviv_gem_object *etnaviv_obj,
+	struct drm_etnaviv_timespec *timeout);
 struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit);
 int etnaviv_gpu_pm_get_sync(struct etnaviv_gpu *gpu);
 void etnaviv_gpu_pm_put(struct etnaviv_gpu *gpu);
-- 
2.20.0

