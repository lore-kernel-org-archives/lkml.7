Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B57C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17DC20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfCGKgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:36:15 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:54813 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGKgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:36:14 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1My3In-1gsYQg1Oxz-00zTVM; Thu, 07 Mar 2019 11:36:01 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Paul Walmsley <paul@pwsan.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: omap2: remove incorrect __init annotation
Date:   Thu,  7 Mar 2019 11:35:50 +0100
Message-Id: <20190307103557.1688556-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LCeZ8nJDgheXtzbal88ne6DVF2b1EjKAznFCO0b7vu1q4X+VgKO
 DsTTgM5j0Jik5I+eQblHhjfjC208TgdYt0orWo7fY6QVf8v+/YMdV6n0+HjMLjSJW4nya8Y
 Xpe59qL1tAY0m8tzUUiXyMND50PpLAhYk7mvvQexydQrrLr1QBpbz8JKSzjhAd9tiPVMCI+
 iD71CHv/o0b7YsTczQYcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D06kPh9TurA=:fafGtZQkGBhTcoJXDoeBQd
 DuKhaNiFM1I2T7f6EjmoKBxPqEvk+WONoQiTuYJMN8Gzdq8tq0ToIR9RZDaUi4UTP1fih21eJ
 OZI6et8DLsI/gAgsyl4nypuqFbdYG05ppZhc58RhnODeGMgxA6I7CS1lnMTBxYKefBgpICmQ4
 GgzzoQ4h5pekUQtsfo/rj/mTcSwwM6VvKQFDYM4lQTEEjOV5qzXJGi33gXCOX3iXapQL3Hwwb
 094uo/J7cnjTFodDM/mYQ4jWVYLDVBdZDXzJzNafgTpSMRdDevk/pbwAyzlUgzIYbRhP8ewwm
 /5oArmAWjFY/C4AWmS8FkgSexwbTCn/Jx1u0/JiX4Ivd5Vd/6cF7XhBgR56itxZyx4DzJjHr7
 maM0txBcwXDgHGjnTjAmyVpX0uDSK5PqMnA+khj+3bYfHK5REPZEf7tpsrzZTP6+idc2MpLbN
 +aUlcCGZnGqK/MlcYaoyKvyOCMxUtZOdls5pxI82VOVxyKlRDAeTYAYhrNWX/qHc/fbArFsMM
 sQAPeRdNpBHr5LapO1gV9CqurMovr8IuTEtE7Unh4fRKVlBW7AYkRjxqH8guTu9C+xeRHu4mu
 gR8kJ0uJ4aUlJm2p5/vlC881pfuKBVXFaVBbghuowdvxZLSB9ZP4zl35ArIrVB1tftRqy5mu/
 emMoPAi0r6sKayhXHtyhEN1hAW4FP7+/aX2XFvGLo2xUaGl0gCd75fAb+IbF4OpvXfhJpFdt9
 bMaEZiECVIMDnYXvEPNOX7DGoOb9l+iluyTvpg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

omap3xxx_prm_enable_io_wakeup() is marked __init, but its caller is not, so
we get a warning with clang-8:

WARNING: vmlinux.o(.text+0x343c8): Section mismatch in reference from the function omap3xxx_prm_late_init() to the function .init.text:omap3xxx_prm_enable_io_wakeup()
The function omap3xxx_prm_late_init() references
the function __init omap3xxx_prm_enable_io_wakeup().
This is often because omap3xxx_prm_late_init lacks a __init
annotation or the annotation of omap3xxx_prm_enable_io_wakeup is wrong.

When building with gcc, omap3xxx_prm_enable_io_wakeup() is always
inlined, so we never noticed in the past.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/prm3xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 05858f966f7d..dfa65fc2c82b 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -433,7 +433,7 @@ static void omap3_prm_reconfigure_io_chain(void)
  * registers, and omap3xxx_prm_reconfigure_io_chain() must be called.
  * No return value.
  */
-static void __init omap3xxx_prm_enable_io_wakeup(void)
+static void omap3xxx_prm_enable_io_wakeup(void)
 {
 	if (prm_features & PRM_HAS_IO_WAKEUP)
 		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
-- 
2.20.0

