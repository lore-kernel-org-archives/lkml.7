Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C213FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981642075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574677805;
	bh=wcr4Dbs+GKk3yIBshMMLNEN248Wy+1lMokXYm9xs71E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wEbJfuBpyiOg1Fl5LrDguxZIu7S7oLg4ZwQYUBHew6XW2EN9k3+IDOItN+KgOxkxd
	 sGiheQQAqJDHafdNKuzgyg0BRTSeAnVBiyW3VzTgpbuZ/6TM5AG8Nn8v6YdyUHCUwP
	 1l702wXq32HRHiEZzCKdThBryk+hbjX38A0gkWu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfKYKaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:30:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43437 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfKYKaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:30:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so17296570wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 02:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=P4mQAf1F6Wws3NlD+mJiOOwSaE1RlOjFXhpxEh/DmBs=;
        b=ZQ2zGJPmxuzfV1CxjlD2sPcIGsgDMqCELCbAknwwwACeiU6ulOFOTO3YvKSN/LQt5Y
         gatHTI4vJdanika65aU4XeVMCzNNPh/I2ZWstO6hRDzffWzPTLMll/ja5OKZoRZiNt2i
         e6OjbkAN3HG5MnNusTEUUSUpaVkM5cx4F15J7ztHO2R+sWifPv4K1z+K7VraPagjr4Az
         n0UqRQZPlOyjqeClD5OlfQSULt9mMgzB/18wBzdqVOOKuiI8627uvpnkxlFd0bMzRPh6
         d2BROEe/30f/9Gjly9AZnQDKt13nx05c2JRCgv7gLMYOJMT+jpM/HztEOm+UfQporWtO
         COwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=P4mQAf1F6Wws3NlD+mJiOOwSaE1RlOjFXhpxEh/DmBs=;
        b=F83E2jHdac0XABjkufx3ZYcUwIKHj6S1w1noU5XRH4YnbYaB3CW8sOaKQI4hO3wxAx
         F7g7S64i44XkhpftjBj9cIE8R42zndmKHOwWQfkpzfBEEdLpFa8YWT4PfJOIujsb56Sk
         9jAalkRiA/FSxt/4Qs3Ampy4Qs0HQOUjiDopfqYiIimkJ06VJllF3ryoLlcwkbNYXR5A
         9q6z7r7DxKKYIKQPba9x76yXKhxkdNU0629MtoxofuUVZsrx/I3j20m7kQhj0RIX8yTc
         8/a2nzQRr31usDZm+U6z2UWajBIWvMDXMtuGHQEzJ1sdcwum88UnvT7c0iv+fpDcri6p
         lJvA==
X-Gm-Message-State: APjAAAXwdQl2/CXAlMq11EfD8BxULAPXBKNoKdQJsgOIXRE8a5uxD81b
        SR7Z7QmpZtNcrtXLwZ7fmbg=
X-Google-Smtp-Source: APXvYqwcSuhX02h/frUmHKWdWv/luZzJ6KbP72qQ3pR3amrHyI7X4yuEYI6jjKo/ZA/yBq7tqkFkqQ==
X-Received: by 2002:a5d:4684:: with SMTP id u4mr29928191wrq.352.1574677801595;
        Mon, 25 Nov 2019 02:30:01 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id j17sm10085094wrr.75.2019.11.25.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 02:30:00 -0800 (PST)
Date:   Mon, 25 Nov 2019 11:29:59 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [GIT PULL] x86/decoder change for v5.5
Message-ID: <20191125102959.GA107197@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-objtool-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-objtool-for-linus

   # HEAD: 700c1018b86d0d4b3f1f2d459708c0cdf42b521d x86/insn: Fix awk regexp warnings

Fix a gawk 5.0 incompatibility in gen-insn-attr-x86.awk. Most distros are 
still on gawk 4.2.x.

 Thanks,

	Ingo

------------------>
Alexander Kapshuk (1):
      x86/insn: Fix awk regexp warnings


 arch/x86/tools/gen-insn-attr-x86.awk       | 4 ++--
 tools/arch/x86/tools/gen-insn-attr-x86.awk | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index b02a36b2c14f..a42015b305f4 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -69,7 +69,7 @@ BEGIN {
 
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
-	lprefix3_expr = "\\((F2|!F3|66\\&F2)\\)"
+	lprefix3_expr = "\\((F2|!F3|66&F2)\\)"
 	lprefix_expr = "\\((66|F2|F3)\\)"
 	max_lprefix = 4
 
@@ -257,7 +257,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 	return add_flags(imm, mod)
 }
 
-/^[0-9a-f]+\:/ {
+/^[0-9a-f]+:/ {
 	if (NR == 1)
 		next
 	# get index
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
index b02a36b2c14f..a42015b305f4 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -69,7 +69,7 @@ BEGIN {
 
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
-	lprefix3_expr = "\\((F2|!F3|66\\&F2)\\)"
+	lprefix3_expr = "\\((F2|!F3|66&F2)\\)"
 	lprefix_expr = "\\((66|F2|F3)\\)"
 	max_lprefix = 4
 
@@ -257,7 +257,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 	return add_flags(imm, mod)
 }
 
-/^[0-9a-f]+\:/ {
+/^[0-9a-f]+:/ {
 	if (NR == 1)
 		next
 	# get index
