Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B564BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF69214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhzIYV8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfCLUUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:20:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53332 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCLUUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:20:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id e74so4058702wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IeWM4AXVY/e4lDQuN3ToH4SBkbwPxft+9TDRwgvEvBs=;
        b=jhzIYV8cVGg4JVIrmaONRCp7pEMdS+N6PONtCtg3RduPoubskkxozYeGyDDUNmGlkk
         PZ21bveBsO6Qf7W+ynvpZ9OdHyFaP9Xwi404CN1qy90r4VuvDaru2ksI+ouZu1QN5OL7
         sMzoSRP/e8bG2Ml0lCaXt8mUtglACoRmIH+I1vYAEQcaR92LPVcM5LhzLxgOOqk6Fmxn
         HxveI2fiGndThJ7x7Bg+iO4KvIEhfq6ZB9aFkzOtCyUkA+VTe440VD9dW5GhjBhCMHAP
         aIlytgntiKJrg3g12gcA7rCs4Pcedq7AJN0ijG9eu24OAEZGHeYtSDUbT2HGQowAa4Y3
         g0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=IeWM4AXVY/e4lDQuN3ToH4SBkbwPxft+9TDRwgvEvBs=;
        b=aNFQgPgppjo87F0jbL00wF5unCk+Q8QGVf0KTojWwzguFaD/9oO/cQakp2RwpZxkJJ
         +SlnVCi+oQetqLMz7xIZnWLJjwfBgOkYg6lXM3SOUf3RD0xWXuie/PViWKarn4mJ4mJz
         MIzGr59RRa378FvszKHkBBVN1SPPKpLsaPGEBi4tWSI3IfiQ7/3N6+xvWAPy+AyUKGNy
         9ia8Y4R9f1sy+2TJ7IKQ/5bVGLrbAYm6s9gFB6imRv4ZcceJ1nt/183Sn0hI0HSbTwcm
         MuCCTIKkEqdVk0Puw45AQPY8p8CFKEC749sdhhAdKLTvIgEW0Tvs4IJ1s06dSGPVMZbf
         fbtQ==
X-Gm-Message-State: APjAAAXqxCiyHrs6VLy08/iydmBBSCral8t700c2VEXQnarHpZ++Yu8U
        xMUCMMDTbOuMxrE+Uqqzg1U=
X-Google-Smtp-Source: APXvYqzK5U3aqvyYy8LSaY2voahC9WGDRNFVZkU0VUkW9XqX/CX1y9GWafnJBPeylWVcOnyrPZYjQA==
X-Received: by 2002:a1c:35c5:: with SMTP id c188mr3514485wma.79.1552422014832;
        Tue, 12 Mar 2019 13:20:14 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id t2sm1601787wra.9.2019.03.12.13.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 13:20:14 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 2BD9F114655E; Tue, 12 Mar 2019 21:20:13 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: sstep: Mark variable `rc` as unused in function 'analyse_instr'
Date:   Tue, 12 Mar 2019 21:20:08 +0100
Message-Id: <20190312202008.29681-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gcc attribute unused for `rc` variable.

Fix warnings treated as errors with W=1:

  arch/powerpc/lib/sstep.c:1172:31: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/lib/sstep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 3d33fb509ef4..32d092f62ae0 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1169,7 +1169,7 @@ static nokprobe_inline int trap_compare(long v1, long v2)
 int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		  unsigned int instr)
 {
-	unsigned int opcode, ra, rb, rc, rd, spr, u;
+	unsigned int opcode, ra, rb, rc __maybe_unused, rd, spr, u;
 	unsigned long int imm;
 	unsigned long int val, val2;
 	unsigned int mb, me, sh;
-- 
2.20.1

