Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDE1C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978FC205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i1yGJLhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfJGQIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:08:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32989 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfJGQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:08:25 -0400
Received: by mail-io1-f67.google.com with SMTP id z19so29916643ior.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OYnf5Eb8n9ykt/uD7msDqCGImCXIjmz3mqehpAtin5w=;
        b=i1yGJLhiLyuMdojyTXTTab15PI1V480jrKDuDZL9zx2s46oSYkji95PIveIRZxXRvm
         JNOhyzE2x/SaKj9y0VqFm6ds+W6txWfFoYz9wBw8d9f6eo+OMEVxNl+gjjtZx++LvFOW
         ay1YMXKcJNTrjhrGkSxiqABUUzgTRSjIRsjNo2IQ89+kqwHJY4jnuCbOWXy4TQ30nrCx
         wZekK7T5a/L9b9D8dNZIYOEwEpXZgOAuzr5uQtmWYwCQfyv57dWxGD/D1WAbIPsgP3NZ
         pDemS16N8xJPf/hJUlo9oCOl8ouutkgwl2UU/YSeHP9u0VX3rVC1AXDqSyyaMnCtyd4a
         tywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=OYnf5Eb8n9ykt/uD7msDqCGImCXIjmz3mqehpAtin5w=;
        b=jGBTsGKWE8+F/EUlfE9zNzf1fiBsdVtO2rPbyvnDR+3fsgF9+NRSS4hRbIMcKrcM4s
         PJMRZFwIEeNhwCAY+p6+zrkY1gUynZZTdfZSDuC0uYXnpvxSWQShnfvp0GuXrRu/JY9h
         b6YThYLXSBYLdEYD9Q5/B5Cm9A3tvBN1izQP2jwOVQJr0vSZ+Ai86DPIFPF0xXdOnTq0
         eHbLFDyVQdiuyqZ6bsMlUg/egOPzoQ09csmsm9jIIADfRpeYc9bbDz/2983B/mYfbi1v
         Jsxfef6nJ7IKdsLZSa/zdod5e0etX9hTV0K0wv2dCMqOTxU+WxE9ST+MawKB76jXvpfW
         Fg8w==
X-Gm-Message-State: APjAAAXjr5PruQxCYmUUsUmSWLUmV5DQVzEGTOL+Yvub24Fw93mbTNxr
        uPFwa2q4iZpU7e/nGkqkb3G2IA==
X-Google-Smtp-Source: APXvYqysgSod7rlGeElbwsjIxKd06AgfXKGvqpl8gz5zmmcjW+EOSfeoq40wCwPIGBZVOvP4zx3kAg==
X-Received: by 2002:a02:c654:: with SMTP id k20mr27301575jan.96.1570464504223;
        Mon, 07 Oct 2019 09:08:24 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id k66sm6121262iof.25.2019.10.07.09.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:08:23 -0700 (PDT)
Date:   Mon, 7 Oct 2019 09:08:23 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Vincent Chen <vincent.chen@sifive.com>
cc:     Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu
Subject: Re: [PATCH 4/4] riscv: remove the switch statement in
 do_trap_break()
In-Reply-To: <20190927224711.GI4700@infradead.org>
Message-ID: <alpine.DEB.2.21.9999.1910070906570.10936@viisi.sifive.com>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com> <1569199517-5884-5-git-send-email-vincent.chen@sifive.com> <20190927224711.GI4700@infradead.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent,

On Fri, 27 Sep 2019, Christoph Hellwig wrote:

> On Mon, Sep 23, 2019 at 08:45:17AM +0800, Vincent Chen wrote:
> > To make the code more straightforward, replacing the switch statement
> > with if statement.
> > 
> > Suggested-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>

...

> I like where this is going, but I think this can be improved further
> given that fact that report_bug has a nice stub for the
> !CONFIG_GENERIC_BUG case.
> 
> How about:
> 
> 	if (user_mode(regs))
> 		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->sepc);
> 	else if (report_bug(regs->sepc, regs) == BUG_TRAP_TYPE_WARN)
> 		regs->sepc += get_break_insn_length(regs->sepc);
> 	else
> 		die(regs, "Kernel BUG");
> 

Christoph's suggestion looks good to me.  What do you think about this 
modification to your patch?

- Paul


From: Vincent Chen <vincent.chen@sifive.com>
Date: Mon, 23 Sep 2019 08:45:17 +0800
Subject: [PATCH] riscv: remove the switch statement in do_trap_break()

To make the code more straightforward, replace the switch statement
with an if statement.

Suggested-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
[paul.walmsley@sifive.com: removed CONFIG_GENERIC_BUG tests per
 Christoph's suggestion; cleaned up patch description]
Cc: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-riscv/20190927224711.GI4700@infradead.org/
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/kernel/traps.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 93742df9067f..45b82be00714 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -124,24 +124,13 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 
 asmlinkage void do_trap_break(struct pt_regs *regs)
 {
-	if (!user_mode(regs)) {
-		enum bug_trap_type type;
-
-		type = report_bug(regs->sepc, regs);
-		switch (type) {
-#ifdef CONFIG_GENERIC_BUG
-		case BUG_TRAP_TYPE_WARN:
-			regs->sepc += get_break_insn_length(regs->sepc);
-			return;
-		case BUG_TRAP_TYPE_BUG:
-#endif /* CONFIG_GENERIC_BUG */
-		default:
-			die(regs, "Kernel BUG");
-		}
-	} else {
+	if (user_mode(regs))
 		force_sig_fault(SIGTRAP, TRAP_BRKPT,
 				(void __user *)(regs->sepc));
-	}
+	else if (report_bug(regs->sepc, regs) == BUG_TRAP_TYPE_WARN)
+		regs->sepc += get_break_insn_length(regs->sepc);
+	else
+		die(regs, "Kernel BUG");
 }
 
 #ifdef CONFIG_GENERIC_BUG
-- 
2.23.0

