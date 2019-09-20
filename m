Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2085C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A06208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pj8jIhS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392989AbfITPlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:41:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37038 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392871AbfITPlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:41:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id f16so2718724wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G9rxy00ZIE0J9oTLHWg18q2mcebTff8MKdbRpMtgQiE=;
        b=pj8jIhS3MfHDWFaGUFRN0DWdCEPx48aiDB3T/KuVJk5bF+IcXQEO/QYOz+DHCfj5wU
         nZnXcBdqoATCpnSRKTiuAJNg247vXe9s4w4rwRUPdO3pYXp0MpwUePpLFlRpcGwzPuHg
         GMYTRrq4+ukC+Fn/jik5sdMRQJ1C8Iuyn0fQUGniCUt0pRFH8Fvub/l60Uhfcy9DigqX
         lUAayDhrDwN+/stHfcbu5mh8CikB0K+XlDa58+NXltWpcR6jW0WksiTn/6ZMYe8ewWQ8
         jTD29XgSPIZj2bxYPJ4rdEFpG43y6bMAGMINN6ZnoP0XNpbFw3Qj9Qr9gE7MweNpBFem
         TUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G9rxy00ZIE0J9oTLHWg18q2mcebTff8MKdbRpMtgQiE=;
        b=V/5nBP7uYSsw6fmCdudKNDc2krdOsIBbxmlZKBxsidoi/pA/xKbcMPeuJaQakDSDGk
         oSK6LgtkjhqAD281GKfZPwdLaKjKmILkHptwgph2ADbTLlbewjkPk0wdkLZcjvTqiUF2
         dMyi7tZX99aZwVePTQUtUMaEOR0Hs8/CvoVnzWVrT0v6WOgMnoXdYWD6aJT9JE2VD1pv
         EgiCuMCC8785W4ON8FpxkhwvHI8K0+DrOcWNlavMPeWPx93uYpcYIyVQY9b9EvZ6Ckfo
         9ZuvhQaExLy7yCaPaYIsQV2HFa4hmlEu9NR9l2VXHVIbEk1RHO+HnWB0+XPx6FcbmifP
         LwgA==
X-Gm-Message-State: APjAAAX9TEKf909wzKesABhEo8qw9+tXKMPEXxm4ukvhqsEtnzR1/ilA
        ZjW2nL2KlaLfp9N/dVLcgH4=
X-Google-Smtp-Source: APXvYqyB2XK1sqdhE1BqdnoRFRwpnohUADqLVaHceuij08hty0iZggkbHEgIzc81lHxQ+Tgpkw9YJQ==
X-Received: by 2002:a1c:60c1:: with SMTP id u184mr3871598wmb.32.1568994059713;
        Fri, 20 Sep 2019 08:40:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a58:8166:7500:adc0:6801:a7c2:8ba2])
        by smtp.gmail.com with ESMTPSA id x129sm3249186wmg.8.2019.09.20.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 08:40:58 -0700 (PDT)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com,
        Ilie Halip <ilie.halip@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pmac/smp: avoid unused-variable warnings
Date:   Fri, 20 Sep 2019 18:39:51 +0300
Message-Id: <20190920153951.25762-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with ppc64_defconfig, the compiler reports
that these 2 variables are not used:
    warning: unused variable 'core99_l2_cache' [-Wunused-variable]
    warning: unused variable 'core99_l3_cache' [-Wunused-variable]

They are only used when CONFIG_PPC64 is not defined. Move
them into a section which does the same macro check.

Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
---
 arch/powerpc/platforms/powermac/smp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index f95fbdee6efe..e44c606f119e 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -648,6 +648,10 @@ static void smp_core99_pfunc_tb_freeze(int freeze)
 
 static unsigned int core99_tb_gpio;	/* Timebase freeze GPIO */
 
+/* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
+volatile static long int core99_l2_cache;
+volatile static long int core99_l3_cache;
+
 static void smp_core99_gpio_tb_freeze(int freeze)
 {
 	if (freeze)
@@ -660,10 +664,6 @@ static void smp_core99_gpio_tb_freeze(int freeze)
 
 #endif /* !CONFIG_PPC64 */
 
-/* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
-volatile static long int core99_l2_cache;
-volatile static long int core99_l3_cache;
-
 static void core99_init_caches(int cpu)
 {
 #ifndef CONFIG_PPC64
-- 
2.17.1

