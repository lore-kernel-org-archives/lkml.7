Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF3CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73092075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555436728;
	bh=n+SI/KwKSN6qnedLNUxay7EHNJxz/xbHPyUxQC1Q3Bs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mbC9gRcH9m0G9lQvUHsey6HrShVmQhr5iZWSPq6V9E6Jk/RpLhmEMdj6yl+LGuZlr
	 bwA/FgfYShkIbSGhdpH6pVsDY0VXQFEpxTYM7l3evA7RgWGS8oSx7SpOWthmnpE6nE
	 d+oC1eCblDro8l3SkA3Z4lZSyY/zAYDZhOZw2ACI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfDPRp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:45:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44887 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfDPRp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:45:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id h18so16662164lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbpWKY6ZmrFjccvhc7yiQ3HEAkuYcCFw7H49vIbWGjs=;
        b=RiDL4i+raBb8yY/GfV78XTsPIIlrSYywM2lvZDtopV5EinY1JSnpHRs83ytbv8ATYe
         0E41jmh8xrwbeM5uRQuhllKrjPNYWTE5NtTVXA+V+SYTYHmcT3NWpvFEHHmLy0bH+HoC
         saX3cMfFGovtVndn9F/SJ4YM5dw+784WRdG2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbpWKY6ZmrFjccvhc7yiQ3HEAkuYcCFw7H49vIbWGjs=;
        b=lBU4sQo9eAyIp2n+DSnkbWN9m/OIAcVDxvKMo7r0CMUESI434WcuIcrax3+EWsgyfY
         9AV93Y3vJ1z+ol9nBPUNT+Yrz1Xi4ozyyLpDT2+d0p8soY2jltXmUIeGlhKk6wZeBaxI
         gaHWcnNemT2FxMQP06LF036iOCXqzVz1WHUb7gYc7mXtGJnBeJgACezaz78xb6FeXQHD
         xFMhT+8Sz33jQ+wIWIiLWR8YCcupG2/X9ONnprsqIyxvrCDuKV5JPsC8FYXS339D4w8p
         VPW5TM3bU/PefdMRIN4/CRUHm2IXFixk8I67NfJAlLZMO+e4XKxl7NNh8X5lqoRhqt3W
         H7Kw==
X-Gm-Message-State: APjAAAVz1u7FGpIOmdX8q7uG1yvKXzqhwQtTOU+xQAsxo9DVpoYhVZ/c
        tQkpbkc21GZOmes3drARzwpGXsz445Q=
X-Google-Smtp-Source: APXvYqwk/earP3MM68S6QqR2G6XG7EdWL7Qk6z7I9Q6HV9DJ92Dnwdzg019KzoyTwDr3qG5rgWELkw==
X-Received: by 2002:ac2:5381:: with SMTP id g1mr45064025lfh.130.1555436723355;
        Tue, 16 Apr 2019 10:45:23 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id g24sm10799383lfb.49.2019.04.16.10.45.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:45:22 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id h18so16662070lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:45:21 -0700 (PDT)
X-Received: by 2002:ac2:5505:: with SMTP id j5mr8685489lfk.121.1555436721366;
 Tue, 16 Apr 2019 10:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190416080335.GM7905@worktop.programming.kicks-ass.net>
In-Reply-To: <20190416080335.GM7905@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Apr 2019 10:45:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgXyXCy9vHY2hKJ9Pa8PnwdwKo9eOQ3jDbCs_FkdDvkQ@mail.gmail.com>
Message-ID: <CAHk-=whgXyXCy9vHY2hKJ9Pa8PnwdwKo9eOQ3jDbCs_FkdDvkQ@mail.gmail.com>
Subject: Re: [PATCH] x86/tlb: Revert: Align TLB invalidation info
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 1:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Using 320 bytes of stack space for a 40 byte structure is ludicrous and
> clearly not right.

Ack.

That said, I wish we didn't have these stack structures at all. Or at
least were more careful about them. For example, another case of this
struct on the stack looks really iffy too:

                struct flush_tlb_info info;
                info.start = start;
                info.end = end;
                on_each_cpu(do_kernel_range_flush, &info, 1);

note how it only initializes two of the fields, and leaves the others
entirely randomly initialized with garbage?

Yeah, yeah, "do_kernel_range_flush()" only uses those two fields, but
it still makes my skin crawl how we basically pass a largely
uninitialized structure and have other CPU's look at it.

And in another case we do have a nicely initialized structure

    void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
    {
        struct flush_tlb_info info = {
                .mm = NULL,
                .start = 0UL,
                .end = TLB_FLUSH_ALL,
        };

but it looks like it shouldn't have been on the stack in the first
place, because as far as I can tell it's entirely constant, and it
should just be a "static const" structure initialized at compile time.

So as far as I can tell, we could do something like

-static void flush_tlb_func_local(void *info, enum tlb_flush_reason reason)
+static void flush_tlb_func_local(const void *info, enum
tlb_flush_reason reason)
-       struct flush_tlb_info info = {
+       static const struct flush_tlb_info info = {

for that case.

End result: it looks like we have three of these stack things, and all
three had something odd in them.

So very much Ack on that patch, but maybe we could do a bit more cleanup here?

                   Linus
