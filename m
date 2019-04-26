Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17096C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5086206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDZO43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:56:29 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDZO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:56:29 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MiMIY-1gpuFN2ziA-00fWM8; Fri, 26 Apr 2019 16:56:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] amba: tegra-ahb: mark PM functions as __maybe_unused
Date:   Fri, 26 Apr 2019 16:56:03 +0200
Message-Id: <20190426145617.2342824-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sOT3r6fkwRywuIzcyDd5YHhYsKXG8TCD1p+LxyP5gEak1TT7Ua4
 28esKCt19z9DcJNB8IwAZJBnmgdQTuaj2KbfxqExadgrpi+NQKv5Bc8DCc5QlxEzy2y4TVQ
 iLT4kitQLxSAV2QIbwH3TxzxHAmlt3/+XjrwYD1YJ1+bITyFvVMlOyeSPAEvKcItrPMC4+n
 HEzOqlyLHeRyPa5zrG1AQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yjC718efDKQ=:2BlhEIXX9lB49C0yktOLhd
 CaK7PnyEdKOtSA4EpiLHcQglg9Eim5sHI6u6Zm3mZyu72S18EnbCDCXj9TJ8PoYTJWG2yQUQ+
 2IKLjgcmYDJRNi3Ye3J2OPPqlyNomLa/HJ3GbJJpvbF/fZdFq+fw5eJRmLdv1cJEhqI2+/oxR
 5TMfzRiIv7XKkAJMQX4ZGEiSCpHaucTONqGi1KfwKZPiSqr4uko3sPhLmZnTuOWqDxyoTPkb2
 8AHqelY1PEjhgmMT3l+aCXMRpAnX31U6TTIa7ZwP+m5QN9Vrz6OW4x+nxZgYrnWW/j0YHNtRn
 oLrgcUlyIGqpAjmgi23yZwPlMXFKS8iYyL1Pl4iU34U+gfCuv3ds5TtgxkpWa1ZV6htKrEjbg
 BbwDnc05n3YiWiH8q6nXuPEUQDq+DYJLbE7sPvR6TxIT3S3fTdnnwyPiahIj5J5LvHfBmUu3W
 yTMXURDLV+FYy/2HPckyzn+gNdNazxt8SQV2ZQHSVebYexmNJ2d7TfsDFyO69EkR+z/6aw/1o
 9cgbF4ImsnoKgtjsx/IVOTG/ULxx8/BHiiTpOje8r+mt42a/Teown/xF7zZi3EoHA4OrgSyNB
 2A6V5eVRIO8axEaMxPo7w2VHcE92i1f2L2io0NLcq3i/Q+rF0/RLlZQBGAB6K6WI59RSVQadJ
 g+zGoNwCAImzRgASsxmImFTOfXrt3AuheNTu9qBsfnj+hSbI7RaegM0y7mBpDzGbVWmRdOJ2K
 sq85zbsY+gV5Vv7PDijtyicmlDyTSBFsBKcxqw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns about an unused variable when CONFIG_PM is disabled,
since it is only referenced from an #ifdef:

drivers/amba/tegra-ahb.c:97:18: error: variable 'tegra_ahb_gizmo' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]

Rather than trying to get the #ifdef right, remove it and
use __maybe_unused here, which is less error prone.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/amba/tegra-ahb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index b0b688c481e8..3751d811be39 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -170,8 +170,7 @@ int tegra_ahb_enable_smmu(struct device_node *dn)
 EXPORT_SYMBOL(tegra_ahb_enable_smmu);
 #endif
 
-#ifdef CONFIG_PM
-static int tegra_ahb_suspend(struct device *dev)
+static int __maybe_unused tegra_ahb_suspend(struct device *dev)
 {
 	int i;
 	struct tegra_ahb *ahb = dev_get_drvdata(dev);
@@ -181,7 +180,7 @@ static int tegra_ahb_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_ahb_resume(struct device *dev)
+static int __maybe_unused tegra_ahb_resume(struct device *dev)
 {
 	int i;
 	struct tegra_ahb *ahb = dev_get_drvdata(dev);
@@ -190,7 +189,6 @@ static int tegra_ahb_resume(struct device *dev)
 		gizmo_writel(ahb, ahb->ctx[i], tegra_ahb_gizmo[i]);
 	return 0;
 }
-#endif
 
 static UNIVERSAL_DEV_PM_OPS(tegra_ahb_pm,
 			    tegra_ahb_suspend,
-- 
2.20.0

