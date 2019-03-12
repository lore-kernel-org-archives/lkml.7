Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41685C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E77A2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWHue7HY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfCLUbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:31:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54238 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfCLUbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:31:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id e74so4087135wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ncrk1n/3SHmCjQPBpytETd8f/4+5weGykidpwmfcRuY=;
        b=IWHue7HYAKGZcIxFK52F5f/Dep+zYv7sgVrlTDgy+WbkePhehwOqDu3gAi1iXaVE05
         l+S/AcXJLqe5+2vJ0myrybsCR/3bEttw/xfuA0LAsRS+kggBNpI7cwr4hsHFBrj30fc8
         asxWNYALxiIRbIYkfy2qInx34Kx5wiuXfPaJxyzEzoX2VDIjshexT14jFml1tJizrrul
         lGYqNFnTszVlnyWtFTg5NvKVPw5CYZMad+WbKishFaYixw0A5DNg43+TzBIJep1SOETr
         VXuJhxgDniJ20nCUZ4shzpgJ/sp6z+YSVTww7niWkXG+zIpic7S2xmf+OSQNS2whUwFw
         00cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ncrk1n/3SHmCjQPBpytETd8f/4+5weGykidpwmfcRuY=;
        b=TBj3xkNfM2S/C4li/aokMY1BnxsFBjhm8KTC2be0xe3KS+3y4bZaz1fDiDBOk8s9bh
         7bqi1SAIglt4sa6TkDcXld6yQfLo5aE+7T07fhxNuIIzGOfvlLiD2xJfyEKMFhq44+qX
         q175Ll/jeD9jaiGmqVwQphAXpjcm65H6mnCUwSax6vFPK1Yei6Ih3On/xESiMNkJYze6
         c1ji7BLyWcZiJS4UiC51U11jAS/gjZfcVEMZDmB5rYovQxF/U6uPw81FgjtVqPwJ5Pl8
         M8tbMZEmOAgSL3czu+6CXxb11KWGM6JhRRw1k5KhnsA7KFzXF4caa39NZyELG+fMOywr
         n1Cg==
X-Gm-Message-State: APjAAAUJM7bptLO7yBYXxWXF9NdFjtt7Y6cDayals9XjKurnNTrDPTGs
        OQM/ChTqiWciDENJIbwejxvL91w3
X-Google-Smtp-Source: APXvYqzVXY4Vj/rm/IQVTXCHU59E0ACUjmnGuRP1sgaC8Pay1x1WWFzGG9hxN399j2xxtyx0fxDLAg==
X-Received: by 2002:a1c:cb86:: with SMTP id b128mr3644903wmg.46.1552422703262;
        Tue, 12 Mar 2019 13:31:43 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id r63sm5433167wmr.32.2019.03.12.13.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 13:31:42 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id A555E1146640; Tue, 12 Mar 2019 21:31:41 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Make some functions static
Date:   Tue, 12 Mar 2019 21:31:40 +0100
Message-Id: <20190312203140.31785-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit cb9e4d10c448 ("[POWERPC] Add support for 750CL Holly board")
new functions were added. Since these functions can be made static,
make it so. While doing so, it turns out that holly_power_off and
holly_halt are unused, so remove them.

Silence the following warnings triggered using W=1:

  arch/powerpc/platforms/embedded6xx/holly.c:47:5: error: no previous prototype for 'holly_exclude_device' [-Werror=missing-prototypes]
  arch/powerpc/platforms/embedded6xx/holly.c:190:6: error: no previous prototype for 'holly_show_cpuinfo' [-Werror=missing-prototypes]
  arch/powerpc/platforms/embedded6xx/holly.c:196:17: error: no previous prototype for 'holly_restart' [-Werror=missing-prototypes]
  arch/powerpc/platforms/embedded6xx/holly.c:236:6: error: no previous prototype for 'holly_power_off' [-Werror=missing-prototypes]
  arch/powerpc/platforms/embedded6xx/holly.c:243:6: error: no previous prototype for 'holly_halt' [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/embedded6xx/holly.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 0409714e8070..829bf3697dc9 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -44,7 +44,8 @@
 
 #define HOLLY_PCI_CFG_PHYS 0x7c000000
 
-int holly_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
+static int holly_exclude_device(struct pci_controller *hose, u_char bus,
+				u_char devfn)
 {
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -187,13 +188,13 @@ static void __init holly_init_IRQ(void)
 	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
 }
 
-void holly_show_cpuinfo(struct seq_file *m)
+static void holly_show_cpuinfo(struct seq_file *m)
 {
 	seq_printf(m, "vendor\t\t: IBM\n");
 	seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
 }
 
-void __noreturn holly_restart(char *cmd)
+static void __noreturn holly_restart(char *cmd)
 {
 	__be32 __iomem *ocn_bar1 = NULL;
 	unsigned long bar;
@@ -233,18 +234,6 @@ void __noreturn holly_restart(char *cmd)
 	for (;;) ;
 }
 
-void holly_power_off(void)
-{
-	local_irq_disable();
-	/* No way to shut power off with software */
-	for (;;) ;
-}
-
-void holly_halt(void)
-{
-	holly_power_off();
-}
-
 /*
  * Called very early, device-tree isn't unflattened
  */
-- 
2.20.1

