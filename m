Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1360120880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139856;
	bh=WJ4IdmD/ee7c8tvgcLCc8//t8XYXhdkyz7fkjZ7xkMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z0mp+0CxoKWMWqNeCaloR0puu2Y4A52dwK9etV76na720obeCz8SXiSf+OYGe/4nC
	 4a4avFp7qlKTaZUFSVvtv4RlyQ9VWmS2l0QNLDpb1kz/40nUWkbA0EUXOm+RCNZtUM
	 VMbiboONYpVNeqK0OGDu4c48OhOg0JIAZDEsQiJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbfDARaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733163AbfDARav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE7B2070B;
        Mon,  1 Apr 2019 17:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139850;
        bh=WJ4IdmD/ee7c8tvgcLCc8//t8XYXhdkyz7fkjZ7xkMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bs+luqT2MLS8g7dYFMMPtU7uFnpBLeo73dxbjK1oIZ3TOeNz6yYmLBHg5zd2bZ1cL
         xs2hJ9DtG+Nj507ix2y1E5eoUHPJTeeW0KtD7e0H+T8vVYAXho69qs6AjkpjqiDFcp
         TlukWEN5XBjMADW9I046axAcDtNARggxUjoxqAos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Archer Yan <ayan@wavecomp.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH 4.4 005/131] MIPS: Fix kernel crash for R6 in jump label branch function
Date:   Mon,  1 Apr 2019 19:01:15 +0200
Message-Id: <20190401170052.155960886@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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


