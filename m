Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A7CC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BD12083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561126360;
	bh=G84cVl5U5XlLByeL5a0wTKaDWpH+c8GB7sbMdafSIyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tgEZp3H7InoGrYBNhl4XuHuqgeR/JWN+TkGopgjEoodzXvSmOtrUiQyE9PHcWRMz+
	 YEDmGuluiN9aW0zwScr4jLVH7x/HlFx1FEAkZaigwIEViYdRTK9EzUTQmozm0LOxoE
	 kgW8ojd7+QWTyjgH5niHBLKKlES7iFzcnAPeMOTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfFUOMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUOMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:12:38 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B003B20679;
        Fri, 21 Jun 2019 14:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561126357;
        bh=G84cVl5U5XlLByeL5a0wTKaDWpH+c8GB7sbMdafSIyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iWxgDadIIMQNr42MRK4sNX1lV++z1lT0Tex5UZtMnkMExk7i5Q4ZfzPJz6ip5stCQ
         UnzWAGwftOy6ujrpdIQbZJHOe6P2e7GE9bWBW3hNpqhrTpwL1ZqjYcwrZIQTcanN/k
         qsc/lS+UOYx7/A8Q4wm5ecSjXRJL4Vep+aw9qPLc=
Date:   Fri, 21 Jun 2019 23:12:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: WARN_ON: userstacktrace on irq events
Message-Id: <20190621231232.259536faeea4b19cf39a7688@kernel.org>
In-Reply-To: <20190405093209.7a5c5133@gandalf.local.home>
References: <20190403121640.70128095@gandalf.local.home>
        <alpine.DEB.2.21.1904051000290.1802@nanos.tec.linutronix.de>
        <20190405093209.7a5c5133@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2019 09:32:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 5 Apr 2019 10:12:27 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > BOOM! Warn on.
> > > 
> > > Can we make that access_ok() call in the copy_stack_frame not trigger
> > > the warning just if we are in an interrupt?  
> > 
> > You really want to have access_ok_atomic() or such which does not have the
> > WARN and use that in copy_stack_frame(). That's fine here because the
> > actual copy is inside a pagefault disabled region.
> 
> I was thinking the same.
> 
> Masami, did you post patches to do something like this?
> "access_ok_inatomic()" or something?

Yeah, last month I sent 
"x86/uaccess: Allow access_ok() in irq context if pagefault_disabled"

If you correctly disables the pagefault, access_ok() shouldn't warn it.
Ah, I see.

copy_stack_frame(const void __user *fp, struct stack_frame_user *frame)
{
        int ret;

        if (!access_ok(fp, sizeof(*frame))) <== this is out of pagefault_disable()!
                return 0;

        ret = 1;
        pagefault_disable();
        if (__copy_from_user_inatomic(frame, fp, sizeof(*frame)))
                ret = 0;
        pagefault_enable();

        return ret;
}

How is below patch?

---
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 2abf27d7df6b..36ff77c801f7 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -98,14 +98,11 @@ struct stack_frame_user {
 static int
 copy_stack_frame(const void __user *fp, struct stack_frame_user *frame)
 {
-	int ret;
+	int ret = 1;
 
-	if (!access_ok(fp, sizeof(*frame)))
-		return 0;
-
-	ret = 1;
 	pagefault_disable();
-	if (__copy_from_user_inatomic(frame, fp, sizeof(*frame)))
+	if (!access_ok(fp, sizeof(*frame)) ||
+	    __copy_from_user_inatomic(frame, fp, sizeof(*frame)))
 		ret = 0;
 	pagefault_enable();
 

-- 
Masami Hiramatsu <mhiramat@kernel.org>
