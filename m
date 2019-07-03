Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAC0C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06ADF218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGCPb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:31:28 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38449 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCPb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:31:28 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mzydy-1iUMAW1lo6-00x4Qf; Wed, 03 Jul 2019 17:31:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] soc: rockchip: work around clang warning
Date:   Wed,  3 Jul 2019 17:30:59 +0200
Message-Id: <20190703153112.2767411-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XhYN2YwFmRnHuLt/LPjA4QgGN1dD8AZdZLrGYulKXSmnG+wM+mk
 r3uKfZiRw7itpLtvFc/6nvJy0WVlm3sWR4DdR8MPgQFR+rxcSM/4eV8l8xSfNgVmTr8iGkm
 R/3ogU4ZLI8adAxrn+oZ0lhaS8sFjSsnLXpLAloUw9SepZS85PUkSHWcl90jIVAlZaUg0Gg
 XR68lNqCj594xOI1MUSiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U1ujgT2aKp8=:LyVR7eelcj8GEuXdj65Dvg
 eWeDTrgLawxByHs5WnbwEl4LY9hMwNSYPLSKqOLHC1qQ/bEgdW/VasUIBPTfXXiz80yIIB9Te
 frZhaKzC3N1QiAslKiQvlHx/kY85+dgUtoUOupJ1nNlVL6iZqb1GD53TYPZXc79Ldb9frnK+j
 bLVSs36JEp7c6SFJcbtQVoWh2loyMPrvnHbxpRS+FfOfONzvpsNu0wfTNeVkUINoPyuLMNuqw
 w+QvkeEqXXD7CXty+xcYFbmlujPyunz2ObBhrDJ43yId/loRMY1O7lm1pkpN6QKMBEGZpkkgO
 z/zlXZ+oxo/NiZ8dOprsh6X8HMuEHvhQ6vQH7qcLtuaaJzr9L4byn8TXeqK4wI7NLJwG27+kn
 CUpiOmwVrDQjrloyAwsB3uHBJuHlhaB6znyzRvjPEIF75t/vBedncPtZoAtEa8b3TNgelt1Mv
 S6vf6lM7j4D9Sb47juC4L8cTggOHexlRPXAQyWzqGj38Rm6JRUK/HCoOvUWcI1Ms0nvJBEMlT
 JEzlEA4DIwJN28sqYCCDUDGk/6ChOQaAEBX1CoM3RQU+GHUvSpZ2/lBsfAUlT9nciqnLq2Vyp
 3j9vO2p8s0nvbjgsq51ogK8PijhR8uFqBbpayN8TsV8YHEFxdQmVjm4JpBByezGgw7baVEmvc
 D5YfS+Fv4jKCF9zJQDosCexdpDJtUj2gqOWZ4MBJHHlg298pm8RmTNpnV81WFYCienLvv3tED
 pUA8I0TAtkOkaiFBrlSIAXN6c0/miZrLmae53w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang emits a warning about a negative shift count for an
unused part of a conditional constant expression:

drivers/soc/rockchip/pm_domains.c:795:21: error: shift count is negative [-Werror,-Wshift-count-negative]
        [RK3328_PD_VIO]         = DOMAIN_RK3328(-1, 8, 8, false),
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/soc/rockchip/pm_domains.c:129:2: note: expanded from macro 'DOMAIN_RK3328'
        DOMAIN_M(pwr, pwr, req, (req) + 10, req, wakeup)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/soc/rockchip/pm_domains.c:105:33: note: expanded from macro 'DOMAIN_M'
        .status_mask = (status >= 0) ? BIT(status) : 0, \
                                       ^~~~~~~~~~~
include/linux/bits.h:6:24: note: expanded from macro 'BIT'

This is a bug in clang that will be fixed in the future, but in order
to build cleanly with clang-8, it would be helpful to shut up this
warning. This file is the only instance reported by kernelci at the
moment.

The best solution I could come up with is to move the BIT() usage
out of the macro into the instantiation, so we can avoid using
BIT(-1).

Link: https://bugs.llvm.org/show_bug.cgi?id=38789
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/rockchip/pm_domains.c | 230 +++++++++++++++---------------
 1 file changed, 115 insertions(+), 115 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 3342332cc007..54eb6cfc5d5b 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -86,47 +86,47 @@ struct rockchip_pmu {
 #define to_rockchip_pd(gpd) container_of(gpd, struct rockchip_pm_domain, genpd)
 
 #define DOMAIN(pwr, status, req, idle, ack, wakeup)	\
-{						\
-	.pwr_mask = (pwr >= 0) ? BIT(pwr) : 0,		\
-	.status_mask = (status >= 0) ? BIT(status) : 0,	\
-	.req_mask = (req >= 0) ? BIT(req) : 0,		\
-	.idle_mask = (idle >= 0) ? BIT(idle) : 0,	\
-	.ack_mask = (ack >= 0) ? BIT(ack) : 0,		\
-	.active_wakeup = wakeup,			\
+{							\
+	.pwr_mask = (pwr),				\
+	.status_mask = (status),			\
+	.req_mask = (req),				\
+	.idle_mask = (idle),				\
+	.ack_mask = (ack),				\
+	.active_wakeup = (wakeup),			\
 }
 
 #define DOMAIN_M(pwr, status, req, idle, ack, wakeup)	\
 {							\
-	.pwr_w_mask = (pwr >= 0) ? BIT(pwr + 16) : 0,	\
-	.pwr_mask = (pwr >= 0) ? BIT(pwr) : 0,		\
-	.status_mask = (status >= 0) ? BIT(status) : 0,	\
-	.req_w_mask = (req >= 0) ?  BIT(req + 16) : 0,	\
-	.req_mask = (req >= 0) ?  BIT(req) : 0,		\
-	.idle_mask = (idle >= 0) ? BIT(idle) : 0,	\
-	.ack_mask = (ack >= 0) ? BIT(ack) : 0,		\
+	.pwr_w_mask = (pwr) << 16,			\
+	.pwr_mask = (pwr),				\
+	.status_mask = (status),			\
+	.req_w_mask = (req) << 16,			\
+	.req_mask = (req),				\
+	.idle_mask = (idle),				\
+	.ack_mask = (ack),				\
 	.active_wakeup = wakeup,			\
 }
 
 #define DOMAIN_RK3036(req, ack, idle, wakeup)		\
 {							\
-	.req_mask = (req >= 0) ? BIT(req) : 0,		\
-	.req_w_mask = (req >= 0) ?  BIT(req + 16) : 0,	\
-	.ack_mask = (ack >= 0) ? BIT(ack) : 0,		\
-	.idle_mask = (idle >= 0) ? BIT(idle) : 0,	\
+	.req_mask = (req),				\
+	.req_w_mask = (req) << 16,			\
+	.ack_mask = (ack),				\
+	.idle_mask = (idle),				\
 	.active_wakeup = wakeup,			\
 }
 
 #define DOMAIN_PX30(pwr, status, req, wakeup)		\
-	DOMAIN_M(pwr, status, req, (req) + 16, req, wakeup)
+	DOMAIN_M(pwr, status, req, (req) << 16, req, wakeup)
 
 #define DOMAIN_RK3288(pwr, status, req, wakeup)		\
-	DOMAIN(pwr, status, req, req, (req) + 16, wakeup)
+	DOMAIN(pwr, status, req, req, (req) << 16, wakeup)
 
 #define DOMAIN_RK3328(pwr, status, req, wakeup)		\
-	DOMAIN_M(pwr, pwr, req, (req) + 10, req, wakeup)
+	DOMAIN_M(pwr, pwr, req, (req) << 10, req, wakeup)
 
 #define DOMAIN_RK3368(pwr, status, req, wakeup)		\
-	DOMAIN(pwr, status, req, (req) + 16, req, wakeup)
+	DOMAIN(pwr, status, req, (req) << 16, req, wakeup)
 
 #define DOMAIN_RK3399(pwr, status, req, wakeup)		\
 	DOMAIN(pwr, status, req, req, req, wakeup)
@@ -716,129 +716,129 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 }
 
 static const struct rockchip_domain_info px30_pm_domains[] = {
-	[PX30_PD_USB]		= DOMAIN_PX30(5, 5, 10, false),
-	[PX30_PD_SDCARD]	= DOMAIN_PX30(8, 8, 9, false),
-	[PX30_PD_GMAC]		= DOMAIN_PX30(10, 10, 6, false),
-	[PX30_PD_MMC_NAND]	= DOMAIN_PX30(11, 11, 5, false),
-	[PX30_PD_VPU]		= DOMAIN_PX30(12, 12, 14, false),
-	[PX30_PD_VO]		= DOMAIN_PX30(13, 13, 7, false),
-	[PX30_PD_VI]		= DOMAIN_PX30(14, 14, 8, false),
-	[PX30_PD_GPU]		= DOMAIN_PX30(15, 15, 2, false),
+	[PX30_PD_USB]		= DOMAIN_PX30(BIT(5),  BIT(5),  BIT(10), false),
+	[PX30_PD_SDCARD]	= DOMAIN_PX30(BIT(8),  BIT(8),  BIT(9),  false),
+	[PX30_PD_GMAC]		= DOMAIN_PX30(BIT(10), BIT(10), BIT(6),  false),
+	[PX30_PD_MMC_NAND]	= DOMAIN_PX30(BIT(11), BIT(11), BIT(5),  false),
+	[PX30_PD_VPU]		= DOMAIN_PX30(BIT(12), BIT(12), BIT(14), false),
+	[PX30_PD_VO]		= DOMAIN_PX30(BIT(13), BIT(13), BIT(7),  false),
+	[PX30_PD_VI]		= DOMAIN_PX30(BIT(14), BIT(14), BIT(8),  false),
+	[PX30_PD_GPU]		= DOMAIN_PX30(BIT(15), BIT(15), BIT(2),  false),
 };
 
 static const struct rockchip_domain_info rk3036_pm_domains[] = {
-	[RK3036_PD_MSCH]	= DOMAIN_RK3036(14, 23, 30, true),
-	[RK3036_PD_CORE]	= DOMAIN_RK3036(13, 17, 24, false),
-	[RK3036_PD_PERI]	= DOMAIN_RK3036(12, 18, 25, false),
-	[RK3036_PD_VIO]		= DOMAIN_RK3036(11, 19, 26, false),
-	[RK3036_PD_VPU]		= DOMAIN_RK3036(10, 20, 27, false),
-	[RK3036_PD_GPU]		= DOMAIN_RK3036(9, 21, 28, false),
-	[RK3036_PD_SYS]		= DOMAIN_RK3036(8, 22, 29, false),
+	[RK3036_PD_MSCH]	= DOMAIN_RK3036(BIT(14), BIT(23), BIT(30), true),
+	[RK3036_PD_CORE]	= DOMAIN_RK3036(BIT(13), BIT(17), BIT(24), false),
+	[RK3036_PD_PERI]	= DOMAIN_RK3036(BIT(12), BIT(18), BIT(25), false),
+	[RK3036_PD_VIO]		= DOMAIN_RK3036(BIT(11), BIT(19), BIT(26), false),
+	[RK3036_PD_VPU]		= DOMAIN_RK3036(BIT(10), BIT(20), BIT(27), false),
+	[RK3036_PD_GPU]		= DOMAIN_RK3036(BIT(9),  BIT(21), BIT(28), false),
+	[RK3036_PD_SYS]		= DOMAIN_RK3036(BIT(8),  BIT(22), BIT(29), false),
 };
 
 static const struct rockchip_domain_info rk3066_pm_domains[] = {
-	[RK3066_PD_GPU]		= DOMAIN(9, 9, 3, 24, 29, false),
-	[RK3066_PD_VIDEO]	= DOMAIN(8, 8, 4, 23, 28, false),
-	[RK3066_PD_VIO]		= DOMAIN(7, 7, 5, 22, 27, false),
-	[RK3066_PD_PERI]	= DOMAIN(6, 6, 2, 25, 30, false),
-	[RK3066_PD_CPU]		= DOMAIN(-1, 5, 1, 26, 31, false),
+	[RK3066_PD_GPU]		= DOMAIN(BIT(9), BIT(9), BIT(3), BIT(24), BIT(29), false),
+	[RK3066_PD_VIDEO]	= DOMAIN(BIT(8), BIT(8), BIT(4), BIT(23), BIT(28), false),
+	[RK3066_PD_VIO]		= DOMAIN(BIT(7), BIT(7), BIT(5), BIT(22), BIT(27), false),
+	[RK3066_PD_PERI]	= DOMAIN(BIT(6), BIT(6), BIT(2), BIT(25), BIT(30), false),
+	[RK3066_PD_CPU]		= DOMAIN(0,      BIT(5), BIT(1), BIT(26), BIT(31), false),
 };
 
 static const struct rockchip_domain_info rk3128_pm_domains[] = {
-	[RK3128_PD_CORE]	= DOMAIN_RK3288(0, 0, 4, false),
-	[RK3128_PD_MSCH]	= DOMAIN_RK3288(-1, -1, 6, true),
-	[RK3128_PD_VIO]		= DOMAIN_RK3288(3, 3, 2, false),
-	[RK3128_PD_VIDEO]	= DOMAIN_RK3288(2, 2, 1, false),
-	[RK3128_PD_GPU]		= DOMAIN_RK3288(1, 1, 3, false),
+	[RK3128_PD_CORE]	= DOMAIN_RK3288(BIT(0), BIT(0), BIT(4), false),
+	[RK3128_PD_MSCH]	= DOMAIN_RK3288(0,      0,      BIT(6), true),
+	[RK3128_PD_VIO]		= DOMAIN_RK3288(BIT(3), BIT(3), BIT(2), false),
+	[RK3128_PD_VIDEO]	= DOMAIN_RK3288(BIT(2), BIT(2), BIT(1), false),
+	[RK3128_PD_GPU]		= DOMAIN_RK3288(BIT(1), BIT(1), BIT(3), false),
 };
 
 static const struct rockchip_domain_info rk3188_pm_domains[] = {
-	[RK3188_PD_GPU]		= DOMAIN(9, 9, 3, 24, 29, false),
-	[RK3188_PD_VIDEO]	= DOMAIN(8, 8, 4, 23, 28, false),
-	[RK3188_PD_VIO]		= DOMAIN(7, 7, 5, 22, 27, false),
-	[RK3188_PD_PERI]	= DOMAIN(6, 6, 2, 25, 30, false),
-	[RK3188_PD_CPU]		= DOMAIN(5, 5, 1, 26, 31, false),
+	[RK3188_PD_GPU]		= DOMAIN(BIT(9), BIT(9), BIT(3), BIT(24), BIT(29), false),
+	[RK3188_PD_VIDEO]	= DOMAIN(BIT(8), BIT(8), BIT(4), BIT(23), BIT(28), false),
+	[RK3188_PD_VIO]		= DOMAIN(BIT(7), BIT(7), BIT(5), BIT(22), BIT(27), false),
+	[RK3188_PD_PERI]	= DOMAIN(BIT(6), BIT(6), BIT(2), BIT(25), BIT(30), false),
+	[RK3188_PD_CPU]		= DOMAIN(BIT(5), BIT(5), BIT(1), BIT(26), BIT(31), false),
 };
 
 static const struct rockchip_domain_info rk3228_pm_domains[] = {
-	[RK3228_PD_CORE]	= DOMAIN_RK3036(0, 0, 16, true),
-	[RK3228_PD_MSCH]	= DOMAIN_RK3036(1, 1, 17, true),
-	[RK3228_PD_BUS]		= DOMAIN_RK3036(2, 2, 18, true),
-	[RK3228_PD_SYS]		= DOMAIN_RK3036(3, 3, 19, true),
-	[RK3228_PD_VIO]		= DOMAIN_RK3036(4, 4, 20, false),
-	[RK3228_PD_VOP]		= DOMAIN_RK3036(5, 5, 21, false),
-	[RK3228_PD_VPU]		= DOMAIN_RK3036(6, 6, 22, false),
-	[RK3228_PD_RKVDEC]	= DOMAIN_RK3036(7, 7, 23, false),
-	[RK3228_PD_GPU]		= DOMAIN_RK3036(8, 8, 24, false),
-	[RK3228_PD_PERI]	= DOMAIN_RK3036(9, 9, 25, true),
-	[RK3228_PD_GMAC]	= DOMAIN_RK3036(10, 10, 26, false),
+	[RK3228_PD_CORE]	= DOMAIN_RK3036(BIT(0),  BIT(0),  BIT(16), true),
+	[RK3228_PD_MSCH]	= DOMAIN_RK3036(BIT(1),  BIT(1),  BIT(17), true),
+	[RK3228_PD_BUS]		= DOMAIN_RK3036(BIT(2),  BIT(2),  BIT(18), true),
+	[RK3228_PD_SYS]		= DOMAIN_RK3036(BIT(3),  BIT(3),  BIT(19), true),
+	[RK3228_PD_VIO]		= DOMAIN_RK3036(BIT(4),  BIT(4),  BIT(20), false),
+	[RK3228_PD_VOP]		= DOMAIN_RK3036(BIT(5),  BIT(5),  BIT(21), false),
+	[RK3228_PD_VPU]		= DOMAIN_RK3036(BIT(6),  BIT(6),  BIT(22), false),
+	[RK3228_PD_RKVDEC]	= DOMAIN_RK3036(BIT(7),  BIT(7),  BIT(23), false),
+	[RK3228_PD_GPU]		= DOMAIN_RK3036(BIT(8),  BIT(8),  BIT(24), false),
+	[RK3228_PD_PERI]	= DOMAIN_RK3036(BIT(9),  BIT(9),  BIT(25), true),
+	[RK3228_PD_GMAC]	= DOMAIN_RK3036(BIT(10), BIT(10), BIT(26), false),
 };
 
 static const struct rockchip_domain_info rk3288_pm_domains[] = {
-	[RK3288_PD_VIO]		= DOMAIN_RK3288(7, 7, 4, false),
-	[RK3288_PD_HEVC]	= DOMAIN_RK3288(14, 10, 9, false),
-	[RK3288_PD_VIDEO]	= DOMAIN_RK3288(8, 8, 3, false),
-	[RK3288_PD_GPU]		= DOMAIN_RK3288(9, 9, 2, false),
+	[RK3288_PD_VIO]		= DOMAIN_RK3288(BIT(7),  BIT(7),  BIT(4), false),
+	[RK3288_PD_HEVC]	= DOMAIN_RK3288(BIT(14), BIT(10), BIT(9), false),
+	[RK3288_PD_VIDEO]	= DOMAIN_RK3288(BIT(8),  BIT(8),  BIT(3), false),
+	[RK3288_PD_GPU]		= DOMAIN_RK3288(BIT(9),  BIT(9),  BIT(2), false),
 };
 
 static const struct rockchip_domain_info rk3328_pm_domains[] = {
-	[RK3328_PD_CORE]	= DOMAIN_RK3328(-1, 0, 0, false),
-	[RK3328_PD_GPU]		= DOMAIN_RK3328(-1, 1, 1, false),
-	[RK3328_PD_BUS]		= DOMAIN_RK3328(-1, 2, 2, true),
-	[RK3328_PD_MSCH]	= DOMAIN_RK3328(-1, 3, 3, true),
-	[RK3328_PD_PERI]	= DOMAIN_RK3328(-1, 4, 4, true),
-	[RK3328_PD_VIDEO]	= DOMAIN_RK3328(-1, 5, 5, false),
-	[RK3328_PD_HEVC]	= DOMAIN_RK3328(-1, 6, 6, false),
-	[RK3328_PD_VIO]		= DOMAIN_RK3328(-1, 8, 8, false),
-	[RK3328_PD_VPU]		= DOMAIN_RK3328(-1, 9, 9, false),
+	[RK3328_PD_CORE]	= DOMAIN_RK3328(0, BIT(0), BIT(0), false),
+	[RK3328_PD_GPU]		= DOMAIN_RK3328(0, BIT(1), BIT(1), false),
+	[RK3328_PD_BUS]		= DOMAIN_RK3328(0, BIT(2), BIT(2), true),
+	[RK3328_PD_MSCH]	= DOMAIN_RK3328(0, BIT(3), BIT(3), true),
+	[RK3328_PD_PERI]	= DOMAIN_RK3328(0, BIT(4), BIT(4), true),
+	[RK3328_PD_VIDEO]	= DOMAIN_RK3328(0, BIT(5), BIT(5), false),
+	[RK3328_PD_HEVC]	= DOMAIN_RK3328(0, BIT(6), BIT(6), false),
+	[RK3328_PD_VIO]		= DOMAIN_RK3328(0, BIT(8), BIT(8), false),
+	[RK3328_PD_VPU]		= DOMAIN_RK3328(0, BIT(9), BIT(9), false),
 };
 
 static const struct rockchip_domain_info rk3366_pm_domains[] = {
-	[RK3366_PD_PERI]	= DOMAIN_RK3368(10, 10, 6, true),
-	[RK3366_PD_VIO]		= DOMAIN_RK3368(14, 14, 8, false),
-	[RK3366_PD_VIDEO]	= DOMAIN_RK3368(13, 13, 7, false),
-	[RK3366_PD_RKVDEC]	= DOMAIN_RK3368(11, 11, 7, false),
-	[RK3366_PD_WIFIBT]	= DOMAIN_RK3368(8, 8, 9, false),
-	[RK3366_PD_VPU]		= DOMAIN_RK3368(12, 12, 7, false),
-	[RK3366_PD_GPU]		= DOMAIN_RK3368(15, 15, 2, false),
+	[RK3366_PD_PERI]	= DOMAIN_RK3368(BIT(10), BIT(10), BIT(6), true),
+	[RK3366_PD_VIO]		= DOMAIN_RK3368(BIT(14), BIT(14), BIT(8), false),
+	[RK3366_PD_VIDEO]	= DOMAIN_RK3368(BIT(13), BIT(13), BIT(7), false),
+	[RK3366_PD_RKVDEC]	= DOMAIN_RK3368(BIT(11), BIT(11), BIT(7), false),
+	[RK3366_PD_WIFIBT]	= DOMAIN_RK3368(BIT(8),  BIT(8),  BIT(9), false),
+	[RK3366_PD_VPU]		= DOMAIN_RK3368(BIT(12), BIT(12), BIT(7), false),
+	[RK3366_PD_GPU]		= DOMAIN_RK3368(BIT(15), BIT(15), BIT(2), false),
 };
 
 static const struct rockchip_domain_info rk3368_pm_domains[] = {
-	[RK3368_PD_PERI]	= DOMAIN_RK3368(13, 12, 6, true),
-	[RK3368_PD_VIO]		= DOMAIN_RK3368(15, 14, 8, false),
-	[RK3368_PD_VIDEO]	= DOMAIN_RK3368(14, 13, 7, false),
-	[RK3368_PD_GPU_0]	= DOMAIN_RK3368(16, 15, 2, false),
-	[RK3368_PD_GPU_1]	= DOMAIN_RK3368(17, 16, 2, false),
+	[RK3368_PD_PERI]	= DOMAIN_RK3368(BIT(13), BIT(12), BIT(6), true),
+	[RK3368_PD_VIO]		= DOMAIN_RK3368(BIT(15), BIT(14), BIT(8), false),
+	[RK3368_PD_VIDEO]	= DOMAIN_RK3368(BIT(14), BIT(13), BIT(7), false),
+	[RK3368_PD_GPU_0]	= DOMAIN_RK3368(BIT(16), BIT(15), BIT(2), false),
+	[RK3368_PD_GPU_1]	= DOMAIN_RK3368(BIT(17), BIT(16), BIT(2), false),
 };
 
 static const struct rockchip_domain_info rk3399_pm_domains[] = {
-	[RK3399_PD_TCPD0]	= DOMAIN_RK3399(8, 8, -1, false),
-	[RK3399_PD_TCPD1]	= DOMAIN_RK3399(9, 9, -1, false),
-	[RK3399_PD_CCI]		= DOMAIN_RK3399(10, 10, -1, true),
-	[RK3399_PD_CCI0]	= DOMAIN_RK3399(-1, -1, 15, true),
-	[RK3399_PD_CCI1]	= DOMAIN_RK3399(-1, -1, 16, true),
-	[RK3399_PD_PERILP]	= DOMAIN_RK3399(11, 11, 1, true),
-	[RK3399_PD_PERIHP]	= DOMAIN_RK3399(12, 12, 2, true),
-	[RK3399_PD_CENTER]	= DOMAIN_RK3399(13, 13, 14, true),
-	[RK3399_PD_VIO]		= DOMAIN_RK3399(14, 14, 17, false),
-	[RK3399_PD_GPU]		= DOMAIN_RK3399(15, 15, 0, false),
-	[RK3399_PD_VCODEC]	= DOMAIN_RK3399(16, 16, 3, false),
-	[RK3399_PD_VDU]		= DOMAIN_RK3399(17, 17, 4, false),
-	[RK3399_PD_RGA]		= DOMAIN_RK3399(18, 18, 5, false),
-	[RK3399_PD_IEP]		= DOMAIN_RK3399(19, 19, 6, false),
-	[RK3399_PD_VO]		= DOMAIN_RK3399(20, 20, -1, false),
-	[RK3399_PD_VOPB]	= DOMAIN_RK3399(-1, -1, 7, false),
-	[RK3399_PD_VOPL]	= DOMAIN_RK3399(-1, -1, 8, false),
-	[RK3399_PD_ISP0]	= DOMAIN_RK3399(22, 22, 9, false),
-	[RK3399_PD_ISP1]	= DOMAIN_RK3399(23, 23, 10, false),
-	[RK3399_PD_HDCP]	= DOMAIN_RK3399(24, 24, 11, false),
-	[RK3399_PD_GMAC]	= DOMAIN_RK3399(25, 25, 23, true),
-	[RK3399_PD_EMMC]	= DOMAIN_RK3399(26, 26, 24, true),
-	[RK3399_PD_USB3]	= DOMAIN_RK3399(27, 27, 12, true),
-	[RK3399_PD_EDP]		= DOMAIN_RK3399(28, 28, 22, false),
-	[RK3399_PD_GIC]		= DOMAIN_RK3399(29, 29, 27, true),
-	[RK3399_PD_SD]		= DOMAIN_RK3399(30, 30, 28, true),
-	[RK3399_PD_SDIOAUDIO]	= DOMAIN_RK3399(31, 31, 29, true),
+	[RK3399_PD_TCPD0]	= DOMAIN_RK3399(BIT(8),  BIT(8),  0,	   false),
+	[RK3399_PD_TCPD1]	= DOMAIN_RK3399(BIT(9),  BIT(9),  0,	   false),
+	[RK3399_PD_CCI]		= DOMAIN_RK3399(BIT(10), BIT(10), 0,	   true),
+	[RK3399_PD_CCI0]	= DOMAIN_RK3399(0,	 0,	  BIT(15), true),
+	[RK3399_PD_CCI1]	= DOMAIN_RK3399(0,	 0,	  BIT(16), true),
+	[RK3399_PD_PERILP]	= DOMAIN_RK3399(BIT(11), BIT(11), BIT(1),  true),
+	[RK3399_PD_PERIHP]	= DOMAIN_RK3399(BIT(12), BIT(12), BIT(2),  true),
+	[RK3399_PD_CENTER]	= DOMAIN_RK3399(BIT(13), BIT(13), BIT(14), true),
+	[RK3399_PD_VIO]		= DOMAIN_RK3399(BIT(14), BIT(14), BIT(17), false),
+	[RK3399_PD_GPU]		= DOMAIN_RK3399(BIT(15), BIT(15), BIT(0),  false),
+	[RK3399_PD_VCODEC]	= DOMAIN_RK3399(BIT(16), BIT(16), BIT(3),  false),
+	[RK3399_PD_VDU]		= DOMAIN_RK3399(BIT(17), BIT(17), BIT(4),  false),
+	[RK3399_PD_RGA]		= DOMAIN_RK3399(BIT(18), BIT(18), BIT(5),  false),
+	[RK3399_PD_IEP]		= DOMAIN_RK3399(BIT(19), BIT(19), BIT(6),  false),
+	[RK3399_PD_VO]		= DOMAIN_RK3399(BIT(20), BIT(20), 0,	   false),
+	[RK3399_PD_VOPB]	= DOMAIN_RK3399(0,	 0,	  BIT(7),  false),
+	[RK3399_PD_VOPL]	= DOMAIN_RK3399(0, 	 0,	  BIT(8),  false),
+	[RK3399_PD_ISP0]	= DOMAIN_RK3399(BIT(22), BIT(22), BIT(9),  false),
+	[RK3399_PD_ISP1]	= DOMAIN_RK3399(BIT(23), BIT(23), BIT(10), false),
+	[RK3399_PD_HDCP]	= DOMAIN_RK3399(BIT(24), BIT(24), BIT(11), false),
+	[RK3399_PD_GMAC]	= DOMAIN_RK3399(BIT(25), BIT(25), BIT(23), true),
+	[RK3399_PD_EMMC]	= DOMAIN_RK3399(BIT(26), BIT(26), BIT(24), true),
+	[RK3399_PD_USB3]	= DOMAIN_RK3399(BIT(27), BIT(27), BIT(12), true),
+	[RK3399_PD_EDP]		= DOMAIN_RK3399(BIT(28), BIT(28), BIT(22), false),
+	[RK3399_PD_GIC]		= DOMAIN_RK3399(BIT(29), BIT(29), BIT(27), true),
+	[RK3399_PD_SD]		= DOMAIN_RK3399(BIT(30), BIT(30), BIT(28), true),
+	[RK3399_PD_SDIOAUDIO]	= DOMAIN_RK3399(BIT(31), BIT(31), BIT(29), true),
 };
 
 static const struct rockchip_pmu_info px30_pmu = {
-- 
2.20.0

