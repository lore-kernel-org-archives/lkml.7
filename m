Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAE5C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF07212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559920877;
	bh=wSA9+DEHwIHYbrjI6rB2FJbnN9VPE/h6ycu0SC0xEOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=J/b+5LafsiTbHs62pW/pmND+HfByFMES4lea2hbqC/tbgLJqiufDkbbehpSVbQF9y
	 JxfZG/V6cMJEEeMKWxUR0D0WgmxWuGzbdnKOWe5Qwn5T9I21IHmiqq94xhUuztWnW+
	 uXdhlR9BgOZUOPczVTCrA44t8UcOjuQWYCWm/O1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfFGPVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbfFGPVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:21:16 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ED4D2089E;
        Fri,  7 Jun 2019 15:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559920875;
        bh=wSA9+DEHwIHYbrjI6rB2FJbnN9VPE/h6ycu0SC0xEOw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p343FTxfeSAM/E5VDYkxZLhAnjNQDez+iK0gcSp+nJAL7C70RhIrBquis3RHUyuPn
         W3R5Fez3zQzDKBl4QiitU5/d1SA0qkebSYAdi+tU/VFeYf/BlZR4OoPqpgcaLmWVib
         pWByQv15U6DMJvlz3iXDOBC73t0ou2cKDFAaUF+8=
Date:   Sat, 8 Jun 2019 00:21:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 03/15] x86/kprobes: Fix frame pointer annotations
Message-Id: <20190608002109.aee01e9a0e0787dc9e419e0c@kernel.org>
In-Reply-To: <20190607133602.os7st57epo3otbc4@treble>
References: <20190605130753.327195108@infradead.org>
        <20190605131944.711054227@infradead.org>
        <20190607220210.328ed88f2f7598e757c3564f@kernel.org>
        <20190607133602.os7st57epo3otbc4@treble>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019 09:36:02 -0400
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Fri, Jun 07, 2019 at 10:02:10PM +0900, Masami Hiramatsu wrote:
> > On Wed, 05 Jun 2019 15:07:56 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > The kprobe trampolines have a FRAME_POINTER annotation that makes no
> > > sense. It marks the frame in the middle of pt_regs, at the place of
> > > saving BP.
> > 
> > commit ee213fc72fd67 introduced this code, and this is for unwinder which
> > uses frame pointer. I think current code stores the address of previous
> > (original context's) frame pointer into %rbp. So with that, if unwinder
> > tries to decode frame pointer, it can get the original %rbp value,
> > instead of &pt_regs from current %rbp.
> > 
> > > 
> > > Change it to mark the pt_regs frame as per the ENCODE_FRAME_POINTER
> > > from the respective entry_*.S.
> > > 
> > 
> > With this change, I think stack unwinder can not get the original %rbp
> > value. Peter, could you check the above commit?
> 
> The unwinder knows how to decode the encoded frame pointer.  So it can
> find regs by decoding the new rbp value, and it also knows that regs->bp
> is the original rbp value.
> 
> Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 

Ah, OK. My misunderstood. So this encode framepointer as same as other
interrupt entry stack.
Then, it looks good to me too.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you Josh!




> -- 
> Josh


-- 
Masami Hiramatsu <mhiramat@kernel.org>
