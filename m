Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B63C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28252215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfF2PNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:13:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38634 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfF2PNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 11:13:08 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hhF2I-0000kC-BW; Sat, 29 Jun 2019 17:13:06 +0200
Date:   Sat, 29 Jun 2019 17:13:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x6@kernel.org
Subject: [GIT pull] smp fixes for 5.2
Message-ID: <alpine.DEB.2.21.1906291709410.1802@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus

up to:  33d4a5a7a5b4: cpu/hotplug: Fix out-of-bounds read when setting fail state

Two small changes for the cpu hotplug code:

    - Prevent out of bounds access which actually might crash the machine
      caused by a missing bounds check in the fail injection code
      
    - Warn about unsupported migitation mode command line arguments to make
      people aware that they typoed the paramater. Not necessarily a fix
      but quite some people tripped over that.

Thanks,

	tglx

------------------>
Eiichi Tsukata (1):
      cpu/hotplug: Fix out-of-bounds read when setting fail state

Geert Uytterhoeven (1):
      cpu/speculation: Warn on unsupported mitigations= parameter


 kernel/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 077fde6fb953..ef1c565edc5d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1964,6 +1964,9 @@ static ssize_t write_cpuhp_fail(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (fail < CPUHP_OFFLINE || fail > CPUHP_ONLINE)
+		return -EINVAL;
+
 	/*
 	 * Cannot fail STARTING/DYING callbacks.
 	 */
@@ -2339,6 +2342,9 @@ static int __init mitigations_parse_cmdline(char *arg)
 		cpu_mitigations = CPU_MITIGATIONS_AUTO;
 	else if (!strcmp(arg, "auto,nosmt"))
 		cpu_mitigations = CPU_MITIGATIONS_AUTO_NOSMT;
+	else
+		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",
+			arg);
 
 	return 0;
 }
