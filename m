Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB1AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75112084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BJQs4oC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfJDS20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:28:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41122 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDS2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:28:25 -0400
Received: by mail-io1-f67.google.com with SMTP id n26so15552350ioj.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Fk8zqqB0DvKX1W+/xtDSBwvEx3/VT0qa/q3V+wIeS+4=;
        b=BJQs4oC2tQPqVsTxzbgiivHy+/6Ct+K69IBnhkhd6z1mC5a/kwh5ihWtOSqVtGW2Rh
         blUYdZmYKWkDY6MGhgOrCfw57rt2fLAH18FjnBmEjb/YfqJe8NDjYYFkMkmz94/vbmuu
         hFhKvlmP2BavH2D5lmn2EspTFZJv0GlZuGVKpDLinWdiswK/OA7FEnR/ovhp2o31dD63
         Nw3OPrQ3kgfG7SMfrlfBBG4m+nir+5gWG2MtMrb2v71HF0bEjVYGxaBCguxP2eKSwxnC
         u/E1MvSzBUK6TMTjMRe8BOrdPgBJMLk3Yf5JdfX6zYg3eUV1FZ621OcySCTZt1p4+DoM
         ekNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Fk8zqqB0DvKX1W+/xtDSBwvEx3/VT0qa/q3V+wIeS+4=;
        b=umSRsE4FRUyEt8I1LnVlUYCoen6On0ryIClHJ28lsAopyFsI5d4gN3MzAZT5Bx7WBn
         tNlSidRRQ++mU3QKqmR7/9aoAjS4FS6zupgT92bpgGTHBkRf3s3fwGAcraT3Cv2bG5Y0
         TIV+GcFcETPgELRjhmv2LTPtrQ0NXglQuKsmXZyRLZco17XNV+iCYCrUmtLnmHf2r2xZ
         kBcHKK7jjY7cwhTxKaz2yA06I7NuqWKM1Ru325t8PfZXHxIo97KSeZaOZwOLYjfTtLPx
         yiFDnvil2Jpuz6wSfpNFypvKQWU6oU5GdJNfMDVgMRWLllIsXVDHUcLPB4YZrNu4op0b
         aGjg==
X-Gm-Message-State: APjAAAUd56D0yDdB/MdXwahu9Tu7blz6r7syWy1F1cZJcV3+63DfHKr3
        IagSiUwnG8e1nP8iNdkEx6pJtnhy4CQ=
X-Google-Smtp-Source: APXvYqy2YoyT0hpqneriwFplV402hIYoJCPRTxh9qzs3ve8YY/hj5XUj1AoPbQWVL0IPAUyYv/D8bg==
X-Received: by 2002:a92:498c:: with SMTP id k12mr16757053ilg.88.1570213705113;
        Fri, 04 Oct 2019 11:28:25 -0700 (PDT)
Received: from localhost (67-0-10-3.albq.qwest.net. [67.0.10.3])
        by smtp.gmail.com with ESMTPSA id d18sm3912869ild.63.2019.10.04.11.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:28:24 -0700 (PDT)
Date:   Fri, 4 Oct 2019 11:28:23 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Vincent Chen <vincent.chen@sifive.com>
cc:     linux-riscv@lists.infradead.org, palmer@sifive.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] riscv: Correct the handling of unexpected ebreak in
 do_trap_break()
In-Reply-To: <1569199517-5884-4-git-send-email-vincent.chen@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1910041126420.15827@viisi.sifive.com>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com> <1569199517-5884-4-git-send-email-vincent.chen@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019, Vincent Chen wrote:

> For the kernel space, all ebreak instructions are determined at compile
> time because the kernel space debugging module is currently unsupported.
> Hence, it should be treated as a bug if an ebreak instruction which does
> not belong to BUG_TRAP_TYPE_WARN or BUG_TRAP_TYPE_BUG is executed in
> kernel space. For the userspace, debugging module or user problem may
> intentionally insert an ebreak instruction to trigger a SIGTRAP signal.
> To approach the above two situations, the do_trap_break() will direct
> the BUG_TRAP_TYPE_NONE ebreak exception issued in kernel space to die()
> and will send a SIGTRAP to the trapped process only when the ebreak is
> in userspace.
> 
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>

Thanks, queued the following for v5.4-rc.


- Paul

From: Vincent Chen <vincent.chen@sifive.com>
Date: Mon, 23 Sep 2019 08:45:16 +0800
Subject: [PATCH] riscv: Correct the handling of unexpected ebreak in
 do_trap_break()

For the kernel space, all ebreak instructions are determined at compile
time because the kernel space debugging module is currently unsupported.
Hence, it should be treated as a bug if an ebreak instruction which does
not belong to BUG_TRAP_TYPE_WARN or BUG_TRAP_TYPE_BUG is executed in
kernel space. For the userspace, debugging module or user problem may
intentionally insert an ebreak instruction to trigger a SIGTRAP signal.
To approach the above two situations, the do_trap_break() will direct
the BUG_TRAP_TYPE_NONE ebreak exception issued in kernel space to die()
and will send a SIGTRAP to the trapped process only when the ebreak is
in userspace.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
[paul.walmsley@sifive.com: fixed checkpatch issue]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/kernel/traps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 82f42a55451e..93742df9067f 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -130,8 +130,6 @@ asmlinkage void do_trap_break(struct pt_regs *regs)
 		type = report_bug(regs->sepc, regs);
 		switch (type) {
 #ifdef CONFIG_GENERIC_BUG
-		case BUG_TRAP_TYPE_NONE:
-			break;
 		case BUG_TRAP_TYPE_WARN:
 			regs->sepc += get_break_insn_length(regs->sepc);
 			return;
@@ -140,8 +138,10 @@ asmlinkage void do_trap_break(struct pt_regs *regs)
 		default:
 			die(regs, "Kernel BUG");
 		}
+	} else {
+		force_sig_fault(SIGTRAP, TRAP_BRKPT,
+				(void __user *)(regs->sepc));
 	}
-	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)(regs->sepc));
 }
 
 #ifdef CONFIG_GENERIC_BUG
-- 
2.23.0

