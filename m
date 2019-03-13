Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF66C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B880721855
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfCMVTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:19:52 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39541 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfCMVTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:19:51 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MHWvH-1hH3Ji2Grh-00Dbj0; Wed, 13 Mar 2019 22:19:39 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org, Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: milbeaut: fix build with !CONFIG_HOTPLUG_CPU
Date:   Wed, 13 Mar 2019 22:19:16 +0100
Message-Id: <20190313211935.646291-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SXNlNulCXyLfbw3+cDxZgf8+Ve61fMFD/kBGzv32wV3NS3KBZo3
 AN7WLkc4lnMo5SL3uuaKu/fdNbVsYTtURYh1xWJD+DB0JBpqe58kcpE8ql4ruMwLjTPXIhk
 J6yy36IutXXCoJf/Lp5LNQ0Ci3uc4eAu/7DPcggIF62hP72NFPrPqeCtSqF86ZF4uXnI8Fb
 GQ3hWUvtjvOLcGNbRDyAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:koQHp+Ff5cs=:EyXCijsl/sN0QymrsycCo0
 cGmdLjAFCs8ei+kVtpTD4E0t+VvkY4DGk0SolvM/hUVQqMmKoMW9jgW/GyRBMiSkAKpFfTkYj
 opcrVXoSeA3PlQ+TAnCrfAhhJ17JrDdJBs1c41z5uE5KwtujN3xw/G/xjH7qdUbD9V8PEnQnd
 bHiu8abuT3yJP3yBoAgUpDh2jnLN74aEB4+Q1CrbrlYWhla+CpLRIm3Iw1gYJCxNzWiQzzRYs
 32ZtvJp3wPqh2Anf0HNGHhBnLnWRwVMTIxh6DRCmL8zPG3K2Eo0qCfXv0P2ZWJAStDUNqF2Xn
 6Rowqpr/uqtPdbZP4djWq0pM5RyRJEsvdbP8W0j36CQZ1e7ad2cRnu4E0TF2RuUFlmx+YSE7K
 Nt848T72u5+VqxkFLpaSSpF5nC/qWL4AAg54tUNlzDnadIjUjsE0Ju5nWNEu/bMw0p5FIKMh/
 /xFwUdvlFSGSB0nIcpUoNm4l+eYgAUIZK1RIrM6Joy/O6h7lqEwkIMViTM4OF3hVmth9ngl2e
 Pnx3a4EVXTlofr8dn+qA2KXU7H0JEAjdff+5gZubSENvdQIfpe1RQO0FASGsB6hhLfnpwmONC
 CPTr7F2bu/nfBbOS+GaMv3EexGWlrLa6XV3jO1KdMM/gsfXGR9GGMSsEXkJmsOraPSvL0nnm6
 49b9yNLea3zhHgYy87KBQqaTsFNqBMrBhu1lNnCkXcKPGFdLBH9HNdoZBXr7JXKBP+CqCydqz
 JBSxGEZ+blq29Ksr5Qzi2Ib7Lq+VzLdaJ4lepg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When HOTPLUG_CPU is disabled, some fields in the smp operations
are not available or needed:

arch/arm/mach-milbeaut/platsmp.c:90:3: error: field designator 'cpu_die' does not refer to any field in type
      'struct smp_operations'
        .cpu_die                = m10v_cpu_die,
         ^
arch/arm/mach-milbeaut/platsmp.c:91:3: error: field designator 'cpu_kill' does not refer to any field in type
      'struct smp_operations'
        .cpu_kill               = m10v_cpu_kill,
         ^

Hide them in an #ifdef like the other platforms do.

Fixes: 9fb29c734f9e ("ARM: milbeaut: Add basic support for Milbeaut m10v SoC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-milbeaut/platsmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-milbeaut/platsmp.c b/arch/arm/mach-milbeaut/platsmp.c
index 591543c81399..3ea880f5fcb7 100644
--- a/arch/arm/mach-milbeaut/platsmp.c
+++ b/arch/arm/mach-milbeaut/platsmp.c
@@ -65,6 +65,7 @@ static void m10v_smp_init(unsigned int max_cpus)
 		writel(KERNEL_UNBOOT_FLAG, m10v_smp_base + cpu * 4);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 static void m10v_cpu_die(unsigned int l_cpu)
 {
 	gic_cpu_if_down(0);
@@ -83,12 +84,15 @@ static int m10v_cpu_kill(unsigned int l_cpu)
 
 	return 1;
 }
+#endif
 
 static struct smp_operations m10v_smp_ops __initdata = {
 	.smp_prepare_cpus	= m10v_smp_init,
 	.smp_boot_secondary	= m10v_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= m10v_cpu_die,
 	.cpu_kill		= m10v_cpu_kill,
+#endif
 };
 CPU_METHOD_OF_DECLARE(m10v_smp, "socionext,milbeaut-m10v-smp", &m10v_smp_ops);
 
-- 
2.20.0

