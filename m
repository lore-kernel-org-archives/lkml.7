Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D67C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE1B2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0qZl6Gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfCLVXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:23:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38570 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfCLVXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:23:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so4296171wrm.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H8NQNQuMFw0L9D+ZrDs+DwimCDz1lv4WmSbItCZ7xMg=;
        b=K0qZl6GcON/ccCqoRM6CUnD8DbdhQoqNUIw0YKmiprWKSoBOWUM0Q5T17+Rmql/3u1
         QslFLP0bgLCV0q1Jwk4m48bf5nmmwZeCR3Tq4E86de/eLm3rVj+8DqG1S+dhq/eJcl8v
         kc82nm/emKS7nlQuotUd+dlvEJgczzsSQup7nta9kslm/3a/fjG5y2o10w1lvmIRtYk0
         IAkP3wMHumema8VNS1ofEwiLkF4pORMd7vRp9aptTxHQYm7TtIqFmbTOlv67JMJ+Ip1e
         2GSPBgUQyuoAsl7vVGlKYogQdQ3L/NXqtzzIDpkw07R/rFvJ/hMj1IyEM9jXRaOQjLDp
         90jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=H8NQNQuMFw0L9D+ZrDs+DwimCDz1lv4WmSbItCZ7xMg=;
        b=JCHwZMg9EljRRv9s/q6HirZz3pGrV42Y1ruBztHAx/3snRrvhGx00YrzqTEOUH6u2Y
         YgucQG+JYZGq8W7xQiFXcWUtljGSdyVLmdsSbr/cfoQtxhxSmN4OZ4gIBTDGN3iQsbsH
         SsChv7XafG64PbJVRFF7oJNqmfxkpNwAEC9LfsvjZ0IB3fLYYo414wD/fWGAXJgQ9cUR
         F0mQP84NzFkx7aag8hjo8dxSZycCFF+WljUtTmV7x4LUJOpICk7Nbpnx8BjAjV4j6yeu
         kCIUDFdB4q+k4GG37poj+Rwai+RK7XMGGAnuatsL5/p94maVzk8fv6jcIse3mVlVHoYU
         QbiA==
X-Gm-Message-State: APjAAAWv8tHAOi1IxDGEJYDHlqb6wNL5jUmUotXUGvb8v6c+IoQzEZyS
        kdlbtfSFhqTQ2cvG2oYkfUE=
X-Google-Smtp-Source: APXvYqy2q7BWmTPZ/MJm9OMn6kgmtzkUVQkYRYNe4ohbpQuaG8hQuRtYD0RARooO6+Uoi/5sHyKUoA==
X-Received: by 2002:a05:6000:14d:: with SMTP id r13mr6833755wrx.231.1552425807833;
        Tue, 12 Mar 2019 14:23:27 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id i62sm2200238wmg.17.2019.03.12.14.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 14:23:27 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 3BBAD1146D74; Tue, 12 Mar 2019 22:23:21 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/32: sstep: Move variable `rc` within CONFIG_PPC64 sentinels
Date:   Tue, 12 Mar 2019 22:23:17 +0100
Message-Id: <20190312212318.17822-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312202008.29681-1-malat@debian.org>
References: <20190312202008.29681-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warnings treated as errors with W=1:

  arch/powerpc/lib/sstep.c:1172:31: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: as suggested prefer CONFIG_PPC64 sentinel instead of unused keyword

 arch/powerpc/lib/sstep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 3d33fb509ef4..9996dc7a0b46 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1169,7 +1169,10 @@ static nokprobe_inline int trap_compare(long v1, long v2)
 int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		  unsigned int instr)
 {
-	unsigned int opcode, ra, rb, rc, rd, spr, u;
+	unsigned int opcode, ra, rb, rd, spr, u;
+#ifdef CONFIG_PPC64
+	unsigned int rc;
+#endif
 	unsigned long int imm;
 	unsigned long int val, val2;
 	unsigned int mb, me, sh;
@@ -1292,7 +1295,9 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	rd = (instr >> 21) & 0x1f;
 	ra = (instr >> 16) & 0x1f;
 	rb = (instr >> 11) & 0x1f;
+#ifdef CONFIG_PPC64
 	rc = (instr >> 6) & 0x1f;
+#endif
 
 	switch (opcode) {
 #ifdef __powerpc64__
-- 
2.20.1

