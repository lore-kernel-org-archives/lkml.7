Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EE9C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482F221734
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010379;
	bh=qFsiztdLDvQWTMxiXFUptRNbM9KiUDEKG8b6B96WFkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=isrqaKTCGB4Sx6DgFLpYcaOcA4aGQXlYY2LrIuBJigzmHEpWQ2jJLai3YmRgoODV5
	 KgKYA/9yBiHQsRhXCd8UOV/ItO4c1n7VCr3Qx+DtSfolvEUWWtJoTJ3NAO6xoTSEMw
	 lEkaj2+Wm21Fa3sMHLPSTnQMNGJ9fiREbaOfUFw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfHENGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbfHENGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:06:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C1D2147A;
        Mon,  5 Aug 2019 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010374;
        bh=qFsiztdLDvQWTMxiXFUptRNbM9KiUDEKG8b6B96WFkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMdR7BxhAFFQwq5SmDlWrCLmWPlPlmMHPZ/zvugs4tn10eniLwAZKg8d1k63FFdQH
         ZdqseStTou59eKXdSEs2+5ufMgd58ATYDXenyibTL2Ln2eFsLUh7vP6D6Th/O/1xIX
         1sQs2g6GD4tXmaOooWoAQEhtjVlRbmDjlyebnA6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.9 41/42] objtool: Support GCC 9 cold subfunction naming scheme
Date:   Mon,  5 Aug 2019 15:03:07 +0200
Message-Id: <20190805124929.851335655@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124924.788666484@linuxfoundation.org>
References: <20190805124924.788666484@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit bcb6fb5da77c2a228adf07cc9cb1a0c2aa2001c6 upstream.

Starting with GCC 8, a lot of unlikely code was moved out of line to
"cold" subfunctions in .text.unlikely.

For example, the unlikely bits of:

  irq_do_set_affinity()

are moved out to the following subfunction:

  irq_do_set_affinity.cold.49()

Starting with GCC 9, the numbered suffix has been removed.  So in the
above example, the cold subfunction is instead:

  irq_do_set_affinity.cold()

Tweak the objtool subfunction detection logic so that it detects both
GCC 8 and GCC 9 naming schemes.

Reported-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/015e9544b1f188d36a7f02fa31e9e95629aa5f50.1541040800.git.jpoimboe@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -305,7 +305,7 @@ static int read_symbols(struct elf *elf)
 			if (sym->type != STT_FUNC)
 				continue;
 			sym->pfunc = sym->cfunc = sym;
-			coldstr = strstr(sym->name, ".cold.");
+			coldstr = strstr(sym->name, ".cold");
 			if (!coldstr)
 				continue;
 


