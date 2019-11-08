Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B61FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F5720650
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbfKHViH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:38:07 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:60555 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731097AbfKHViG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:38:06 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mn2Fb-1i1nwX1PPz-00k9z1; Fri, 08 Nov 2019 22:37:50 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Velikov <emil.velikov@collabora.com>,
        Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Fabio Estevam <festevam@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 15/16] drm/etnaviv: use ktime_t for timeouts
Date:   Fri,  8 Nov 2019 22:32:53 +0100
Message-Id: <20191108213257.3097633-16-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108213257.3097633-1-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0mG/AeRqRfllKNyxjsRTf1Lcjrue4mA0fTazDskyMcSc5mlcPDP
 zbVsx/cHjwgO02t9e22UWWZH0DGv7RXqjSXbPD3DPZRjW5iWLttQosFa3M1orsc35xqlood
 /rkgvkWdLpjLCGamV2uyd9Sryst2A5hYqyZWYH/dUS/hCt8Wq+k4A3DvFqlkufIJb052pjX
 VppE3uMwAwBi6LBZ1hkIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F261wtjEcT0=:5B/i1CyfuUrOw9eZBz/PLK
 hjY0gVwJQdkRM7obOi8iEsKCYl+fPz3Dv27PPeQlVcVrhOw3R+dP6IpEdAxei2BjnXxYDjh66
 aPS3OBOQHslKZ3OeyDJe9DmgX80C9S4tPkEbPHSgPVbUtvgJy8vtHxnoJ4xm7PnhRQxegtk9a
 GcsKvnDoZG+y63G/aYXmWuGOfC78Z2a4TJsnmCnF90pjnwXkC+yX1pGfkWd+FTfvrZLnSBn+v
 JGpXkQOSAzUDk/drEENpyjc5UA0Ydbigu7yyJzGxQTJUF8HL50B1HrvxI8QUI4QQsRfD85Fop
 kZ3a/3mhjjoZ9cxBYB5UbA+uWxoUe95Envho17lWGtXR8cuxetz5LiB20PGbXjCH7YTAVinpv
 VJkM63TNTTBs70tRux/sfx+Bw0nsTEzzWqeZzagG1U4LG5SgdWMO/R98kfP+KVIi1W/mC0kNX
 WGlMUs6ky38u2v1UBIUHLUm0ncTwQR6YYIngKvnAB6UFI9mYlQLkdL8q7wh3qweT4UE0o2v5d
 9vOK2DGYLusxNChy8p6OOfl6MNxMO6+EiPQMzhTKCWofZZFPuSPY6kJeTcPZWmQBaIc2WMfaF
 yUZKM7Wkw8plvQjy7E3cQ2TORmryKWPOZMd3fOeIxRw0Gevld+v64UDQRoYGqP7D7I10e2HfE
 hXQ72fC34kg8nUPPlRxm8dZdtXI/B5P3FLJ1UdMjYVWs/HD/EC+PfeiGvR1FOLBunfS81QB4y
 w1BVo7MZVUOrUaC27tXh3gQP4MIW2IQp8aYYhs2Pc5GNL3SjdDY4KNDGtcH5pUATj4TkMBpsD
 KP2LkzB5gi4EglpnawANVaSU3QqOZyZfqt8ei3wG3DyKxlUJGPpYjXvaIbX+ihtBYPK0NI0J8
 bYuwzkontVfVbF+ibFlQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct timespec is being removed from the kernel because it often leads
to code that is not y2038-safe.

In the etnaviv driver, monotonic timestamps are used, which do not suffer
from overflow, but using ktime_t still leads to better code overall.

The conversion is straightforward for the most part, except for
etnaviv_timeout_to_jiffies(), which needs to handle arguments larger
than MAX_JIFFY_OFFSET on 32-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 19 +++++++++----------
 drivers/gpu/drm/etnaviv/etnaviv_drv.h | 21 +++++++++------------
 drivers/gpu/drm/etnaviv/etnaviv_gem.c |  5 ++---
 drivers/gpu/drm/etnaviv/etnaviv_gem.h |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  4 ++--
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  4 ++--
 6 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 1f9c01be40d7..1250c5e06329 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -282,16 +282,13 @@ static int etnaviv_ioctl_gem_new(struct drm_device *dev, void *data,
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
 	struct drm_etnaviv_gem_cpu_prep *args = data;
 	struct drm_gem_object *obj;
+	ktime_t timeout = ktime_set(args->timeout.tv_sec,
+				    args->timeout.tv_nsec);
 	int ret;
 
 	if (args->op & ~(ETNA_PREP_READ | ETNA_PREP_WRITE | ETNA_PREP_NOSYNC))
@@ -301,7 +298,7 @@ static int etnaviv_ioctl_gem_cpu_prep(struct drm_device *dev, void *data,
 	if (!obj)
 		return -ENOENT;
 
-	ret = etnaviv_gem_cpu_prep(obj, args->op, &TS(args->timeout));
+	ret = etnaviv_gem_cpu_prep(obj, args->op, timeout);
 
 	drm_gem_object_put_unlocked(obj);
 
@@ -354,7 +351,8 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
 {
 	struct drm_etnaviv_wait_fence *args = data;
 	struct etnaviv_drm_private *priv = dev->dev_private;
-	struct timespec *timeout = &TS(args->timeout);
+	ktime_t timeout = ktime_set(args->timeout.tv_sec,
+				    args->timeout.tv_nsec);
 	struct etnaviv_gpu *gpu;
 
 	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
@@ -368,7 +366,7 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
 		return -ENXIO;
 
 	if (args->flags & ETNA_WAIT_NONBLOCK)
-		timeout = NULL;
+		timeout = ktime_set(0, 0);
 
 	return etnaviv_gpu_wait_fence_interruptible(gpu, args->fence,
 						    timeout);
@@ -403,7 +401,8 @@ static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
 {
 	struct etnaviv_drm_private *priv = dev->dev_private;
 	struct drm_etnaviv_gem_wait *args = data;
-	struct timespec *timeout = &TS(args->timeout);
+	ktime_t timeout = ktime_set(args->timeout.tv_sec,
+				    args->timeout.tv_nsec);
 	struct drm_gem_object *obj;
 	struct etnaviv_gpu *gpu;
 	int ret;
@@ -423,7 +422,7 @@ static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
 		return -ENOENT;
 
 	if (args->flags & ETNA_WAIT_NONBLOCK)
-		timeout = NULL;
+		timeout = ktime_set(0, 0);
 
 	ret = etnaviv_gem_wait_bo(gpu, obj, timeout);
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index 32cfa5a48d42..57a4e247bbcf 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -60,8 +60,7 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
 int etnaviv_gem_prime_pin(struct drm_gem_object *obj);
 void etnaviv_gem_prime_unpin(struct drm_gem_object *obj);
 void *etnaviv_gem_vmap(struct drm_gem_object *obj);
-int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
-		struct timespec *timeout);
+int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op, ktime_t timeout);
 int etnaviv_gem_cpu_fini(struct drm_gem_object *obj);
 void etnaviv_gem_free_object(struct drm_gem_object *obj);
 int etnaviv_gem_new_handle(struct drm_device *dev, struct drm_file *file,
@@ -106,22 +105,20 @@ static inline size_t size_vstruct(size_t nelem, size_t elem_size, size_t base)
  * We need to calculate the timeout in terms of number of jiffies
  * between the specified timeout and the current CLOCK_MONOTONIC time.
  */
-static inline unsigned long etnaviv_timeout_to_jiffies(
-	const struct timespec *timeout)
+static inline unsigned long etnaviv_timeout_to_jiffies(ktime_t timeout)
 {
-	struct timespec64 ts, to;
-
-	to = timespec_to_timespec64(*timeout);
-
-	ktime_get_ts64(&ts);
+	s64 remain = ktime_to_ns(ktime_sub(timeout, ktime_get()));
 
 	/* timeouts before "now" have already expired */
-	if (timespec64_compare(&to, &ts) <= 0)
+	if (remain < 0)
 		return 0;
 
-	ts = timespec64_sub(to, ts);
+#ifndef CONFIG_64BIT
+	if (remain > ((s64)MAX_JIFFY_OFFSET * NSEC_PER_SEC / HZ))
+		return MAX_JIFFY_OFFSET;
+#endif
 
-	return timespec64_to_jiffies(&ts);
+	return nsecs_to_jiffies(remain);
 }
 
 #endif /* __ETNAVIV_DRV_H__ */
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index cb1faaac380a..febe5196788e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -372,8 +372,7 @@ static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
 		return DMA_BIDIRECTIONAL;
 }
 
-int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
-		struct timespec *timeout)
+int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op, ktime_t timeout)
 {
 	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
 	struct drm_device *dev = obj->dev;
@@ -431,7 +430,7 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
 }
 
 int etnaviv_gem_wait_bo(struct etnaviv_gpu *gpu, struct drm_gem_object *obj,
-	struct timespec *timeout)
+			ktime_t timeout)
 {
 	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
index d6270acce619..a3461a554a6c 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
@@ -112,7 +112,7 @@ struct etnaviv_gem_submit {
 void etnaviv_submit_put(struct etnaviv_gem_submit * submit);
 
 int etnaviv_gem_wait_bo(struct etnaviv_gpu *gpu, struct drm_gem_object *obj,
-	struct timespec *timeout);
+	ktime_t timeout);
 int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
 	const struct etnaviv_gem_ops *ops, struct etnaviv_gem_object **res);
 void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index d47d1a8e0219..e42b1c4d902c 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1132,7 +1132,7 @@ static void event_free(struct etnaviv_gpu *gpu, unsigned int event)
  * Cmdstream submission/retirement:
  */
 int etnaviv_gpu_wait_fence_interruptible(struct etnaviv_gpu *gpu,
-	u32 id, struct timespec *timeout)
+	u32 id, ktime_t timeout)
 {
 	struct dma_fence *fence;
 	int ret;
@@ -1179,7 +1179,7 @@ int etnaviv_gpu_wait_fence_interruptible(struct etnaviv_gpu *gpu,
  * that lock in this function while waiting.
  */
 int etnaviv_gpu_wait_obj_inactive(struct etnaviv_gpu *gpu,
-	struct etnaviv_gem_object *etnaviv_obj, struct timespec *timeout)
+	struct etnaviv_gem_object *etnaviv_obj, ktime_t timeout)
 {
 	unsigned long remaining;
 	long ret;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 8f9bd4edc96a..6d352a435427 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -169,9 +169,9 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m);
 void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu);
 void etnaviv_gpu_retire(struct etnaviv_gpu *gpu);
 int etnaviv_gpu_wait_fence_interruptible(struct etnaviv_gpu *gpu,
-	u32 fence, struct timespec *timeout);
+	u32 fence, ktime_t timeout);
 int etnaviv_gpu_wait_obj_inactive(struct etnaviv_gpu *gpu,
-	struct etnaviv_gem_object *etnaviv_obj, struct timespec *timeout);
+	struct etnaviv_gem_object *etnaviv_obj, ktime_t timeout);
 struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit);
 int etnaviv_gpu_pm_get_sync(struct etnaviv_gpu *gpu);
 void etnaviv_gpu_pm_put(struct etnaviv_gpu *gpu);
-- 
2.20.0

