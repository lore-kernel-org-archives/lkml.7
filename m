Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6F8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1382920863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582033;
	bh=MOKzbVwrt4MCqVHzleJx4ExOmkk6ye6OoqOgh33Qhms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=My4Whu+GmXw3OWUe9FJdRofTnfcnAWkettIj29ciVVvCEG1I8ys5WT1aImBmGBvyw
	 QbfJKjyzI2oA3Pjrnt8KBtXILeRqS7iWcTU++gbPGlLbjLQOC7sijWaFJyb2FLooTs
	 Enz+hqwxw0TZzuBjmLdaSZGvgs5L9bEuA+9tj3Vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbfCZGdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731732AbfCZGdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:33:49 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5B520857;
        Tue, 26 Mar 2019 06:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582028;
        bh=MOKzbVwrt4MCqVHzleJx4ExOmkk6ye6OoqOgh33Qhms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atmqitnrMmwDWeNAn2fuwRqg5RXh1cr9cW2paHD99GKlWQV5IPXo3H6c82T6xLbdD
         lXFVLglY8ZDWN8wwQCmE8NtNfhm5Ai0sOqJV+vWS8706lDGd8j0q6W0cAwAAUBf5OO
         reXxTAa5LEIWXoalVEOngdm9UI/0JTdRLcC9k7LY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Archer Yan <ayan@wavecomp.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH 4.14 08/41] MIPS: Fix kernel crash for R6 in jump label branch function
Date:   Tue, 26 Mar 2019 15:29:45 +0900
Message-Id: <20190326042650.327730679@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Archer Yan <ayan@wavecomp.com>

commit 47c25036b60f27b86ab44b66a8861bcf81cde39b upstream.

Insert Branch instruction instead of NOP to make sure assembler don't
patch code in forbidden slot. In jump label function, it might
be possible to patch Control Transfer Instructions(CTIs) into
forbidden slot, which will generate Reserved Instruction exception
in MIPS release 6.

Signed-off-by: Archer Yan <ayan@wavecomp.com>
Reviewed-by: Paul Burton <paul.burton@mips.com>
[paul.burton@mips.com:
  - Add MIPS prefix to subject.
  - Mark for stable from v4.0, which introduced r6 support, onwards.]
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: stable@vger.kernel.org # v4.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/jump_label.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -21,15 +21,15 @@
 #endif
 
 #ifdef CONFIG_CPU_MICROMIPS
-#define NOP_INSN "nop32"
+#define B_INSN "b32"
 #else
-#define NOP_INSN "nop"
+#define B_INSN "b"
 #endif
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:\t" NOP_INSN "\n\t"
-		"nop\n\t"
+	asm_volatile_goto("1:\t" B_INSN " 2f\n\t"
+		"2:\tnop\n\t"
 		".pushsection __jump_table,  \"aw\"\n\t"
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
 		".popsection\n\t"


