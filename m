Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6752320679
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKKQ0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:26:01 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:38101 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfKKQ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:26:01 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MORR2-1iGX0h2h7G-00PwVX; Mon, 11 Nov 2019 17:25:53 +0100
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
Subject: [PATCH 1/2] drm/etnaviv: reject timeouts with tv_nsec >= NSEC_PER_SEC
Date:   Mon, 11 Nov 2019 17:25:31 +0100
Message-Id: <20191111162547.2221524-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y9yDrcxX3JXaAKVSf2Wk0UqIhlycN6gZyle2jPk/xT9EE6YMi9D
 7ymITaQ7apv6xrtn0JzSfzsgJB9I6691k3NAhZROfyW9sb573cpSp1BArGRozUJ7yf1BahM
 n/iqnEfl6KDsP8LVgANAzfDxR4X/WyOKAK5s0v5Ld/9s1SATJqUXjo4weaeUxCyiqTwRkbu
 GAzwQeVhb9Mm+uAWzRSiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nZsPNPkFQvQ=:Ucf0PZ6GcWhH6i5ePGy4rK
 8g6OuBjV2jgWkBM7tp1FTviB697Tz1JahKavUoJ1LkN7LeLCVIliSERKLYYSPTKAKImQEOHdV
 f/nUOReIF66bT/01JiNoct1Vgoo9wpMGPa7w3rY/XWrZMWNHnC3ogWso4VjoWd+wiwbBEj+uG
 L2LpC6MAjqWBLjIC6oVSHeneOV3hV4AsKXIvgaEEqxJgH1hUN67mhEA1CuXbj4mue/hN2Yk3Z
 f4ISXe/g+lkzvLNMLZ2Fr7vneEV7iFUbAs5cHnOaETE/91j8DSovRJiJNq3y4+phBlhD2zsB9
 qpt827ytyRhQdXvVRUvqJu2oVbsxGrGf3HrAkwatzS2GL2vA6waSgY4ZIAlarzHZXTlJaT+WL
 v6UgYgYvpZzRwn9POXsQu/ShPUYR7pVILKJOP/ah+T6Pm8NW4U2baQ0iw4Ih5bRZvVPprVdWa
 JyI6Z+9FAEm0qFPVJw2KkmAnqNFpQGrzuNFYfumQ94RtIgaAFBjSqeX3x+3Y9ErWQOznrAW1Q
 tM1qzWWXa/kF+jiFIyNNLn4sJIkKVY9pkq3wGTxNm6j/FVHtjZahv2vKHp6w+mTELXMKMoKoE
 HWDF3iPGT3Rcz0RSSaOH3gojpNGyEjKO8c1MWqD1Oct4Ijc+tvi8b6mUIkQ3Hlf17srkmJy3l
 fL3N/RoAyeTJt3b8wUsINPyFKTsc2thXdCu0B8f6EFtPqIg+VBuBzO5grhkE0AzVDLl05HQoM
 qc5AVkSQWenBH8ADII9vIySDu4WSLDPgS3A6yn+Rs4HObFPfe1q7UTTczol84GDWAgqbqlO6r
 hQfG1l3QcpoGzgnGskRgT5OdGVT4HLfgtB1T99Vni+iw8sVmXOkHYd9jcpK+OWWnU71i8abqe
 i5KubW7ExhZfj9AUaAWQ==
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

