Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0991C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5362075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/OyMbMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbfCZUrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:47:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32918 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732729AbfCZUre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:47:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so3268210wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Yoprl42VcVIg+Or9Xh6MCziR7xSFWDxzJkJwkvYVkM=;
        b=l/OyMbMP6FYtklBeTYh528cFF/MOk837ueO1ug77OIPM3GBz+Av8cEaVYgUXS0HSOu
         Y8hALqPC2q/zcNCsoUdGKxNkLcjr0LwuBJmprNt1wGnzk8KrAexiMxEBxeQ60j17lvgq
         OKoj+cc0pG+YVGpLUZRXNkhDAhxkDut/ahD4UTLuG1Vy4xLNtq5KtBCBdQRRenXicjiG
         FHfQQjAI2KTqqU/6Y496B8xdp8c2k9KMYp859Vc+sMh9j88Pawkc8uT40uHN8YcqQtTw
         nN8LLoYfRTxw8wEHEMJSdbtrLxgMDFI0RaxF/SedB13kJcJQ5103nJXT2VC2I4RB0DsO
         /Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1Yoprl42VcVIg+Or9Xh6MCziR7xSFWDxzJkJwkvYVkM=;
        b=oLaL7RGUuohV5SOdS9dyV467fi2sW/rOjIM2HIdZzyP0G60dLwN+BTWOKdzr8unG77
         ct0OW1BFIdXO1RBNN7Rk7PP9gWYTI4UxXEvtxBzQFyWzG6Tr4TjPVHkwZmdHmj4xesap
         loQZP/89o7tofY3mhFt/BApsBiVh3urM02KUYkn2Hjzva4xnTUi3afX+P1SLrT5HKynH
         Fzhx/gX5XnYDXxDLJuiUtLvUWu00/LFc7yznRkNeBU/NTZ2Q2evKC8E5cnJyjwHNub35
         j42cOLZpqD7Fbbet46wmhRaDfdNL7eh9glgO6hLBN+tUJIgHqjPjAT6wtW1DhhU1s68L
         gq4w==
X-Gm-Message-State: APjAAAVwBwcMtfDFJgpeE9GcvfhN+fREdTUy6ayY/dM9DEJgR/I/71hV
        GZuXSOtTObESdyzQQspd0n0=
X-Google-Smtp-Source: APXvYqxztKxz/750qXzabQMQ4wEcM+Qcs+la49Os7Vqkfu5HIMAOPr6mJmA9WF1F4Wu2fiB2y6JRww==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr7928405wmg.132.1553633253075;
        Tue, 26 Mar 2019 13:47:33 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id b11sm107391wru.61.2019.03.26.13.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 13:47:32 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 711FC1142374; Tue, 26 Mar 2019 21:47:21 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] powerpc: Make some functions static
Date:   Tue, 26 Mar 2019 21:47:18 +0100
Message-Id: <20190326204720.18882-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312203140.31785-1-malat@debian.org>
References: <20190312203140.31785-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit cb9e4d10c448 ("[POWERPC] Add support for 750CL Holly board")
new functions were added. Since most of these functions can be made static,
make it so.

Both holly_power_off and holly_halt functions were not changed since they
are unused, making them static would have triggered the following warning
(treated as error):

  arch/powerpc/platforms/embedded6xx/holly.c:244:13: error: 'holly_halt' defined but not used [-Werror=unused-function]

Silence the following warnings triggered using W=1:

  arch/powerpc/platforms/embedded6xx/holly.c:47:5: error: no previous prototype for 'holly_exclude_device' [-Werror=missing-prototypes]
  arch/powerpc/platforms/embedded6xx/holly.c:190:6: error: no previous prototype for 'holly_show_cpuinfo' [-Werror=missing-prototypes]
  arch/powerpc/platforms/embedded6xx/holly.c:196:17: error: no previous prototype for 'holly_restart' [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: Split the patch in two operations

 arch/powerpc/platforms/embedded6xx/holly.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 0409714e8070..9d2eefef7b7b 100644
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
-- 
2.20.1

