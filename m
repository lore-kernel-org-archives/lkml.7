Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEDA20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCDTxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:53:49 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:34395 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDTxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:53:49 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N6KpF-1h2oYs00Of-016h1f; Mon, 04 Mar 2019 20:53:39 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: host1x: avoid IOMMU_API build error
Date:   Mon,  4 Mar 2019 20:53:22 +0100
Message-Id: <20190304195338.989221-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oJUIXwXXVRrNcZ0kfEQNr6srNfv8IKetG4QTMtLzlt63gs4q1Oz
 /MTDdlCEO9GlOTB4MKRMEVRLc/fHfCJJINX4qB9vKd9g/7t7inI+b/Ql7TJM+njQQ0qbVQs
 j5bQ6dZo8YOsdAyCI4tsOP2qUb9f9cVG2GD5f0ZKXoIeSV08w4SrifN3MW+JFfIVoEIFtom
 SF3Hr/+14xWCnj0mMGVdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nq66aRj+TPw=:5OAuxVOGv6qi8hT0zIJcdk
 5Ddd5n0RoOatWol1UbtA4SFuAmY75ECHP4pfaLJVmQxlOQXY7DIWqB+MQenR31Ny0B9NacTSa
 dFQrDREXhmPCFmd+o4QweyIm8EKmdHNW2jwBX0TSqrL8PYBQqG2k9T30LXm7qYJ4+8EwMrS/7
 anyU4qddN3w71s+xRFhF1KKKLlcYoEXa52p+Jc8qwnT+qy4nl8LPkaswqWATP5beqRjpJH8kJ
 Y8PyHFgbr8OBXHMwwL43fQ0uX8mnZRe/+poCz/RvuGKBvyPE0hdRZKwMosHd/OSPza34ZCIN2
 aVUlcZ/dcWIUQIGiPIFdq49dI3NpEPhWxJbWjwPHePax6AnL1HKZ5te4SR/LkF3bjE7S8iISE
 8x0cgI2KJE9dcjaxMg/gCbNivBSfl8rIFXi7tX9XIkoQBIcGkm4PUmuteo4jGioMou/VXKN6i
 asW39XeZejdd6z9PwjHgCoRWZO9fzoNaWhWx/tnNHGWvHSORCL7YvN3FW6yRZdbXsNRSY9SYV
 7z6iq/xP8z/zyJMl9gmXVtJqMsrwNTHVvlwmSU7XREbfUZrnHxXXBz+rGqSR33gUkjm2yOhMU
 rSnnInwGlH7HSlPHevpWGmqMH+TEOGdzgcfsL6lT2dMnWD+S5fjzp9+dB+9RYceUOPf8goR3l
 AlTETqqcEqc4Ooqp99K2xzUt1vanMMbpAlpyra08UylLs4xPv/Dq464+hJPRIrzXw27x4AJu9
 lLtladVVI2xpDaIDqXv3frtXa1x3ql6XkVkZQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/host1x/hw/channel_hw.c: In function 'host1x_channel_set_streamid':
drivers/gpu/host1x/hw/channel_hw.c:118:30: error: implicit declaration of function 'dev_iommu_fwspec_get'; did you mean 'iommu_fwspec_free'? [-Werror=implicit-function-declaration]
  struct iommu_fwspec *spec = dev_iommu_fwspec_get(channel->dev->parent);
                              ^~~~~~~~~~~~~~~~~~~~
                              iommu_fwspec_free
drivers/gpu/host1x/hw/channel_hw.c:118:30: error: initialization of 'struct iommu_fwspec *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
drivers/gpu/host1x/hw/channel_hw.c:119:23: error: 'struct iommu_fwspec' has no member named 'ids'
  u32 sid = spec ? spec->ids[0] & 0xffff : 0x7f;
                       ^~
cc1: all warnings being treated as errors

Fixes: de5469c21ff9 ("gpu: host1x: Program the channel stream ID")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/host1x/hw/channel_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/hw/channel_hw.c b/drivers/gpu/host1x/hw/channel_hw.c
index 27101c04a827..738dccf4ee3f 100644
--- a/drivers/gpu/host1x/hw/channel_hw.c
+++ b/drivers/gpu/host1x/hw/channel_hw.c
@@ -114,7 +114,7 @@ static inline void synchronize_syncpt_base(struct host1x_job *job)
 
 static void host1x_channel_set_streamid(struct host1x_channel *channel)
 {
-#if HOST1X_HW >= 6
+#if HOST1X_HW >= 6 && defined(CONFIG_IOMMU_API)
 	struct iommu_fwspec *spec = dev_iommu_fwspec_get(channel->dev->parent);
 	u32 sid = spec ? spec->ids[0] & 0xffff : 0x7f;
 
-- 
2.20.0

