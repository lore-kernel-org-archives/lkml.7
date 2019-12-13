Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34426C4D2D7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F585246C8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfLMUzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:55:25 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:42731 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:55:24 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MmUcL-1hxQSf3K9x-00iQa3; Fri, 13 Dec 2019 21:55:12 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Velikov <emil.velikov@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 13/24] drm/etnaviv: reject timeouts with tv_nsec >= NSEC_PER_SEC
Date:   Fri, 13 Dec 2019 21:53:41 +0100
Message-Id: <20191213205417.3871055-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FtcvkRP+PxTuM1kB/nONVs3z2xlMBVJVd9+R6nDY92C5vgjuYmC
 BxkfZJviB6exJbAT+s5FqrACns+dIYWedVsSQH9vpfEn6Tdd3xkx2Y1Dw0iBSRfN40+Tuuc
 uCsxnZ0cpiOB0iZh0DN/b4KGJdHFOJmdi7tw3SQx+zCAHahyUH4Ov0bSe+pLy/Omb0Ac78/
 hez/uq0rgQ0VgO+oUQn8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gIg+rV75Vvo=:zI2EcLL6lmBx+OCsRoc1e5
 MmRS3WIMSHuTTcT9/PtTyry4RW+qEysUDyVEHsrs2M5oFZ/EaugmFtOcQNiuKbd2vNn9mOuX5
 n66LaOonAY1Ugd9fiHDV+v3QRa8uomPJ/xMzvrgTLY1Yhu4mD6BsKl2Vk1XJU53FrdMSrMX4z
 v7MssgxRY3yPDFHuFrIoxlHbhp+QYcxM+W2+++e/pPomSxrw4kwHMYxPvu9XwF0Z0sKr69c9k
 v7K2j56CXz3idaZ4scBjDNfsLks09PJgPW4dujia7Jz2qD+897HyjWVlzhg62wRluIn3X/yEw
 hywPROlcXgvvsI/YyHbRnVkXdqe4dqNSE0jjlhc5fsPQximRVQcVf0XZzKlFf8/r+PKG75bui
 J0LkVvImNrvWe46lP/5rQLED7zS77at9LWQ3Swxve0GUItDjpRi0X4mfFibml8XZ1jc0fluI6
 mVHpS3+LgV8a+YGPXvxZ4hNuu9zzfQAllcbzYaV3YamYlv4eWngiu74j1NHN/Wf7Y4Bgo9SYz
 nk8PpHC2bMFzV3peDQH8SkQIpNyMwpeaqSYGL2RIx03mPdpt5bojTh/qXSXeIyi/MmmslB7+0
 10f2MhJCHTbbshfGeiCuJoQenbOalmyCYrg2MovmyJQM52JZVO4aa2MgNxtJCUv124QKgVYXq
 itKQFWfHUILXo26guQ1rJUObv0JMM0yHAeYiiHNLWwsbYoxPdhNisSMLY2RPQiPie14SP/Ds0
 8U4Kw2jmMyf7SpeTO7hziC7Ve7s9pAlz3ncZIie/erUHgtvxX4kk/VzK1nL9qmZIwxPg+4pCq
 EaAy0IIuHERsu9ppg0MTvc6V/iA6/sqcvJNxH/rXkzSmIUVVEoCyRTKxBzB6vbX+GdBxHSr+B
 EVFmgnFtc9yvY4/XQHiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most kernel interfaces that take a timespec require normalized
representation with tv_nsec between 0 and NSEC_PER_SEC.

Passing values larger than 0x100000000ull further behaves differently
on 32-bit and 64-bit kernels, and can cause the latter to spend a long
time counting seconds in timespec64_sub()/set_normalized_timespec64().

Reject those large values at the user interface to enforce sane and
portable behavior.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 1f9c01be40d7..95d72dc00280 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -297,6 +297,9 @@ static int etnaviv_ioctl_gem_cpu_prep(struct drm_device *dev, void *data,
 	if (args->op & ~(ETNA_PREP_READ | ETNA_PREP_WRITE | ETNA_PREP_NOSYNC))
 		return -EINVAL;
 
+	if (args->timeout.tv_nsec > NSEC_PER_SEC)
+		return -EINVAL;
+
 	obj = drm_gem_object_lookup(file, args->handle);
 	if (!obj)
 		return -ENOENT;
@@ -360,6 +363,9 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
 	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
 		return -EINVAL;
 
+	if (args->timeout.tv_nsec > NSEC_PER_SEC)
+		return -EINVAL;
+
 	if (args->pipe >= ETNA_MAX_PIPES)
 		return -EINVAL;
 
@@ -411,6 +417,9 @@ static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
 	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
 		return -EINVAL;
 
+	if (args->timeout.tv_nsec > NSEC_PER_SEC)
+		return -EINVAL;
+
 	if (args->pipe >= ETNA_MAX_PIPES)
 		return -EINVAL;
 
-- 
2.20.0

