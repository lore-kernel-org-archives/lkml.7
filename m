Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5435C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA9421773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfDXKfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:35:01 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37775 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfDXKe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:34:59 -0400
Received: from orion.localdomain ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MIMOy-1hXUrf1As0-00EMiV; Wed, 24 Apr 2019 12:34:51 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] drivers: nvme: target: core: fix build break
Date:   Wed, 24 Apr 2019 12:34:39 +0200
Message-Id: <1556102081-11820-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556102081-11820-1-git-send-email-info@metux.net>
References: <1556102081-11820-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:JIJa60MgCLYfsCVEtja+ZNwi6Nh7ryNozR5rx1XJQm46Ttr/VAU
 lhNmBEgXb0AAPxZWu/M6IKARrllglAUgcykj8p5EFE+oSGDc21AcsZRPuEPX03Tkh3G6pWY
 Bj3XpBEVZuZYgzYG63xE0wX+gpWQJGOkvrQmK6RTkQUcJxgLh+s3spYmTcc0bDQ72ypWH3V
 +Mh1XGVWRwibM8DC2fAVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1gDUjChnQmE=:SsOBK/idME24zIhnOurG1i
 8FkjY1OOlHMtWD2fU+H7PShKk6HO+TtJRAWYe0CXlbjUfts0eHU7a7zOQDRhNRX14hbmg0dvi
 LDZT+m3D0h8YlTusr2k2QBByK58KcL/q1Kg4vFDZdC85DQNfux8AzPwvQ1ISMi48LzEqEhwig
 GhPgEFdq0a3slKoTyRBOGeQkVNLUjwkF9AG+KzB6x8OpcWcFdXIt+N3jSt1itoj9HaXodkQzb
 5f4wtV8YuCsMeZcD6opCfztnHJ+qYEujx0sn189bUwEx/mR2ZDJf7zWpjVCn30xOQN1hvx5z2
 R59qaD5+bwjkXbjeT9lDKMb5FIhQOSoIo7D3jzctBznkHjWFAN6knQp68t5N7A57FNVHB675p
 T3XyiVEvvkVroXuAWfoj7lB2z/YnwPqcEqWoVjuBwaHWrFpktq9gN3H9F8W5igQrN6Kl0KHr5
 Zr5RJLCMv7VV0f5OouSBKqPR+lx0jWJIwV+H4UkTXids7IixgPEoyZDHkbi2n5KKjJHWYEpM0
 IbM+i568qhbtp1/T7gAH0IG8ekIey6NzpJwFpf7yp1dKlMwKeaydbUploI2dPIFmsvG7IoNwV
 qkQ0fyPXXQm/++Ww39rSpkhLjScYdGuE3lgRRYflRSfkgr7HhZiIFjGX1S4Uhfkb/U1/lplP7
 9Ybq3qZ4zDLL1TX1L99owMCNh8mbwCUGObb+LG+GKi8FeMYTjn67UxTVsEthK7L1rI9+URI8K
 gAkC1KZQP6+XK/pFBVQEib7YVkSUnTXxWvcDiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build breaks:

    drivers/nvme/target/core.c: In function 'nvmet_req_alloc_sgl':
    drivers/nvme/target/core.c:939:12: error: implicit declaration of \
function 'sgl_alloc'; did you mean 'bio_alloc'? \
[-Werror=implicit-function-declaration]
      req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
                ^~~~~~~~~
                bio_alloc
    drivers/nvme/target/core.c:939:10: warning: assignment makes pointer \
from integer without a cast [-Wint-conversion]
      req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
              ^
    drivers/nvme/target/core.c: In function 'nvmet_req_free_sgl':
    drivers/nvme/target/core.c:952:3: error: implicit declaration of \
function 'sgl_free'; did you mean 'ida_free'? [-Werror=implicit-function-declaration]
       sgl_free(req->sg);
       ^~~~~~~~
       ida_free

Cause:

    1. missing include to <linux/scatterlist.h>
    2. SGL_ALLOC needs to be enabled

Therefore adding the missing include, as well as Kconfig dependency.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/nvme/target/Kconfig | 1 +
 drivers/nvme/target/core.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index d94f25c..3ef0a4e 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -3,6 +3,7 @@ config NVME_TARGET
 	tristate "NVMe Target support"
 	depends on BLOCK
 	depends on CONFIGFS_FS
+	select SGL_ALLOC
 	help
 	  This enabled target side support for the NVMe protocol, that is
 	  it allows the Linux kernel to implement NVMe subsystems and
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b3e765a..08851f5 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -8,6 +8,7 @@
 #include <linux/random.h>
 #include <linux/rculist.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/scatterlist.h>
 
 #include "nvmet.h"
 
-- 
1.9.1

