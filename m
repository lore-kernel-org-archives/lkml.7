Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4CFC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12442190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553192946;
	bh=8vA1OJVCZ31wkQbkue70iC+rTbS9b5d5y1HT+3WO2kY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pRHPgsUI1PuahKkFbPBvVa36iYn+WK3iUcsMnM/AFFd+6zsLrmiv1IgG1Ruj3mPUY
	 ff+MnpUL7h4fVJeTCFVwTj7Le95QL3hm4UTOL4CQxKyPby/EmfTTVs2S0LqrsHGrPS
	 8sbKuETVLSeEDt1TEzwuDHsIXwzrE277PngPVkjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfCUS3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbfCUS3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:29:04 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D75AC2192B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553192943;
        bh=8vA1OJVCZ31wkQbkue70iC+rTbS9b5d5y1HT+3WO2kY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0JmadI1nWM4N3pSDoZrl8mnPr4OHGOj56N6xzdlcYUwcEvUxn/XrfbJ5N8wnjnv7k
         ZXpFKFQ9QwUc6z5rvXan8j2oU8ilywXHDZ7NGVXSPJk5qzjzJWikljJ1Uxiq+1JHBe
         p6qNpqeDWgxO4CJgkuvPNwCYvAi6NefziBori32Y=
Received: by mail-wr1-f44.google.com with SMTP id t5so7730783wri.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:29:02 -0700 (PDT)
X-Gm-Message-State: APjAAAX6LiN7/h9K+EpH17BPVv3hJmxSk7Ouh9q9v9AiMCIfH47Pj95n
        QcoU0sB7+UW6k0KfXo5KURRW8+6SyGqz3vGzLUPqtg==
X-Google-Smtp-Source: APXvYqx+1SFaMTECGAMxhQUaQftB3AlaxjkHwl9sRzeqy+UEDH8QYza+MY5xDLiDRvZc/4BKzC/qbFT2imzYaoo7YPo=
X-Received: by 2002:a5d:4710:: with SMTP id y16mr3462909wrq.176.1553192941472;
 Thu, 21 Mar 2019 11:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190320221534.165ab87b@oasis.local.home> <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net> <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home> <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com> <20190321182745.GU5996@hirez.programming.kicks-ass.net>
In-Reply-To: <20190321182745.GU5996@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 21 Mar 2019 11:28:50 -0700
X-Gmail-Original-Message-ID: <CALCETrVd8i9xmGT9GPXU6tuvte+M9e3otYa8YNLEgPE+W81E2w@mail.gmail.com>
Message-ID: <CALCETrVd8i9xmGT9GPXU6tuvte+M9e3otYa8YNLEgPE+W81E2w@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on error_entry
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 21, 2019 at 11:05:06AM -0700, Andy Lutomirski wrote:
>
> > Ugh.
> >
> > I certainly agree in principle that sticking the CR2 read into the asm
> > is the right solution.  But this patch makes the spaghetti even more
> > tangled.  Maybe we can rearrange the code a bit so that the entry
> > sequence saves at least one register before calling error_entry, so we
> > can do it the obvious way.
>
> What is the obvious way? Note that with all the Xen/paravirt-me-harder
> bits on, we need to clobber at least RAX to get CR2.
>
> And most of the patch was munging the paravirt bits to make that happen.
>
> Another thing I did notices is that CLAC and CLD are not next to one
> another in these paths.

The thing I really don't like is all the EBX crud to try to get
everything in to the right order.
