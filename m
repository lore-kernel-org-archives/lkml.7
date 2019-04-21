Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9275AC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5974420833
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BgEkhnIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfDUSfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 14:35:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfDUSfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 14:35:31 -0400
Received: from zn.tnic (p200300EC2F27140051B6078FF3B255AE.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:1400:51b6:78f:f3b2:55ae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECB801EC082D;
        Sun, 21 Apr 2019 20:35:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555871730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1Celz1md2PicnKBOOAGtioL0ASi81cFr5apmaFdm5JY=;
        b=BgEkhnImi+klLcsWkQWe4VRIguFub6mxDJsLkJHhTtflwnxR0yyONbP5zQWvU6W0ewDMxb
        TfVm+lj/0Wk+qdmR2V2eC6oJjc5Yk0XiRb0Q+Ezc698MEniXyu/AZszgsUoqyA5osMsMri
        WzI8TK4lthIjaGajPLnK3U9kEOjUsMw=
Date:   Sun, 21 Apr 2019 20:35:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     hpa@zytor.com, torvalds@linux-foundation.org, luto@kernel.org,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        riel@surriel.com, dave.hansen@linux.intel.com,
        yu-cheng.yu@intel.com
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] x86/fault: Decode and print #PF oops in human
 readable form
Message-ID: <20190421183524.GC6048@zn.tnic>
References: <20181221213657.27628-3-sean.j.christopherson@intel.com>
 <tip-18ea35c5ed9921867194a8efc2a0ac2d5a3c7d2a@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tip-18ea35c5ed9921867194a8efc2a0ac2d5a3c7d2a@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 11:35:51AM -0700, tip-bot for Sean Christopherson wrote:
>     BUG: kernel NULL pointer dereference, address = 0000000000000008
>     #PF: supervisor-privileged instruction fetch from kernel code
>     #PF: error_code(0x0010) - not-present page
> 
>     BUG: unable to handle page fault for address = ffffbeef00000000
>     #PF: supervisor-privileged instruction fetch from kernel code
>     #PF: error_code(0x0010) - not-present page
> 
>     BUG: unable to handle page fault for address = ffffc90000230000
>     #PF: supervisor-privileged write access from kernel code
>     #PF: error_code(0x000b) - reserved bit violation

Writing those in human-readable form is nice. May I suggest making those
messages more succinct, though - we'll be staring at them for years,
after all.

---
From: Borislav Petkov <bp@suse.de>
Date: Sun, 21 Apr 2019 20:24:08 +0200
Subject: [PATCH] x86/fault: Make fault messages more succinct

So we are going to be staring at those in the next years, let's make
them more succinct. In particular:

 - change "address = " to "address: "
 - "-privileged" reads funny. It should be simply "kernel" or "user"
 - "from kernel code" reads funny too. "kernel mode" or "user mode" is
   more natural.

An actual example says more than 1000 words, of course:

  [    0.248370] BUG: kernel NULL pointer dereference, address: 00000000000005b8
  [    0.249120] #PF: supervisor write access in kernel mode
  [    0.249717] #PF: error_code(0x0002) - not-present page

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/mm/fault.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 74c9204c5751..a0df19b0897d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -630,13 +630,13 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 	}
 
 	if (address < PAGE_SIZE && !user_mode(regs))
-		pr_alert("BUG: kernel NULL pointer dereference, address = %px\n",
+		pr_alert("BUG: kernel NULL pointer dereference, address: %px\n",
 			(void *)address);
 	else
-		pr_alert("BUG: unable to handle page fault for address = %px\n",
+		pr_alert("BUG: unable to handle page fault for address: %px\n",
 			(void *)address);
 
-	pr_alert("#PF: %s-privileged %s from %s code\n",
+	pr_alert("#PF: %s %s in %s mode\n",
 		 (error_code & X86_PF_USER)  ? "user" : "supervisor",
 		 (error_code & X86_PF_INSTR) ? "instruction fetch" :
 		 (error_code & X86_PF_WRITE) ? "write access" :
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
