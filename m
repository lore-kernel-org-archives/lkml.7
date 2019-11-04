Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC474CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C71121D71
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfKDOA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:00:26 -0500
Received: from foss.arm.com ([217.140.110.172]:43644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbfKDOA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:00:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7498F1FB;
        Mon,  4 Nov 2019 06:00:25 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 371433F6C4;
        Mon,  4 Nov 2019 06:00:23 -0800 (PST)
Date:   Mon, 4 Nov 2019 14:00:21 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Torsten Duwe <duwe@suse.de>, linux-arm-kernel@lists.infradead.org,
        Jessica Yu <jeyu@kernel.org>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, amit.kachhap@arm.com,
        catalin.marinas@arm.com, james.morse@arm.com, jpoimboe@redhat.com,
        jthierry@redhat.com, linux-parisc@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 2/8] module/ftrace: handle patchable-function-entry
Message-ID: <20191104140020.GI45140@lakrids.cambridge.arm.com>
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <20191029165832.33606-3-mark.rutland@arm.com>
 <20191030150302.GA965@suse.de>
 <20191031090231.GA3340@blommer>
 <20191031114223.GA11684@suse.de>
 <20191031130022.GB3477@blommer>
 <20191104082810.70f1b72a@grimm.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104082810.70f1b72a@grimm.local.home>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 08:28:10AM -0500, Steven Rostedt wrote:
> On Thu, 31 Oct 2019 13:00:22 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Sure. I've folded the above into this patch, and pushed out an updated branch:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/ftrace-with-regs
> 
> Just to keep this change in lore, can you at a minimum reply to this
> patch's thread with the new update?

The new change is below (with all else unchanged). I can send a v3 of
the series if you want the whole patch?

Thanks,
Mark.

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index dae64600ccbf..a9c4e4721434 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -110,17 +110,17 @@
 #endif
 
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
-#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
-#define MCOUNT_REC()   . = ALIGN(8);                           \
-                       __start_mcount_loc = .;                 \
-                       KEEP(*(__patchable_function_entries))   \
-                       __stop_mcount_loc = .;
-#else
+/*
+ * The ftrace call sites are logged to a section whose name depends on the
+ * compiler option used. A given kernel image will only use one, AKA
+ * FTRACE_CALLSITE_SECTION. We capture all of them here to avoid header
+ * dependencies for FTRACE_CALLSITE_SECTION's definition.
+ */
 #define MCOUNT_REC()   . = ALIGN(8);                           \
                        __start_mcount_loc = .;                 \
                        KEEP(*(__mcount_loc))                   \
+                       KEEP(*(__patchable_function_entries))   \
                        __stop_mcount_loc = .;
-#endif
 #else
 #define MCOUNT_REC()
 #endif

