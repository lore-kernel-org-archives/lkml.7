Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E9FC04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C3121670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556642664;
	bh=X+93M0oEsG72OeT0c4AH+IZFAW8t4zob5MBGfr+nR9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zdwzRUckajYFvPZbyzX14cucBXxSp9Ce1PvpS3U3q4y6Josc7fB1TlBiEHS0bJwt9
	 Y0fhjwrjrtg8sFq4xW1ARVSOEwjT9wRoGm51dws+tOcWOlHjnyZk45YAMWDbzXVsqD
	 mcF4Uey8QT4YiuDUi+DzvDr6YBRAY9Qq96eDzQE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfD3QoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfD3QoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:44:23 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F063C21841
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 16:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556642662;
        bh=X+93M0oEsG72OeT0c4AH+IZFAW8t4zob5MBGfr+nR9E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0Cwgl455POKYMyoluPcjKgBdy7MMFfOBK6PhZ3vnyEg4hzP6tOhml4qkU7KTNKmik
         4VEYMrW936vYFJxKyXvtLznG+d7qY7wXLGmlS8zYEz+zTbTOHnlvichZVCogwT8K2S
         a0CWqzM+0emJWwLc4qdt1sFhXsGIjcES73x5topM=
Received: by mail-wr1-f53.google.com with SMTP id r7so2078171wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:44:21 -0700 (PDT)
X-Gm-Message-State: APjAAAVrP9Q7rMZvrZHs/ZTCmAqLvjL6KsmY4k68hCuHoHrr1CRN2Mae
        Id2e4oDF3twt4wJ8Xsab1y4bM6lfCxQIvxvLzcMQKw==
X-Google-Smtp-Source: APXvYqwmRLneEnqXQEbOJA/L2bWsSlfAUGQerC/zm4ptlEgZmV5GyD4IYe9tQCLb3tp1+jSLHrsjgQ5TXiBOMhcfeBs=
X-Received: by 2002:a5d:424e:: with SMTP id s14mr22195947wrr.77.1556642660479;
 Tue, 30 Apr 2019 09:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-6-git-send-email-rppt@linux.ibm.com> <20190426074223.GY4038@hirez.programming.kicks-ass.net>
 <20190428054711.GD14896@rapoport-lnx>
In-Reply-To: <20190428054711.GD14896@rapoport-lnx>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 30 Apr 2019 09:44:09 -0700
X-Gmail-Original-Message-ID: <CALCETrWrtRo1PqdVmJQQ95J8ORy9WBkUraJCqL6JNmmAkw=H0w@mail.gmail.com>
Message-ID: <CALCETrWrtRo1PqdVmJQQ95J8ORy9WBkUraJCqL6JNmmAkw=H0w@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] x86/mm/fault: hook up SCI verification
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 10:47 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Fri, Apr 26, 2019 at 09:42:23AM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 26, 2019 at 12:45:52AM +0300, Mike Rapoport wrote:
> > > If a system call runs in isolated context, it's accesses to kernel code and
> > > data will be verified by SCI susbsytem.
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > >  arch/x86/mm/fault.c | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> >
> > There's a distinct lack of touching do_double_fault(). It appears to me
> > that you'll instantly trigger #DF when you #PF, because the #PF handler
> > itself will not be able to run.
>
> The #PF handler is able to run. On interrupt/error entry the cr3 is
> switched to the full kernel page tables, pretty much like PTI does for
> user <-> kernel transitions. It's in the patch 3.
>
>

PeterZ meant page_fault, not do_page_fault.  In your patch, page_fault
and some of error_entry run before that magic switchover happens.  If
they're not in the page tables, you double-fault.

And don't even try to do SCI magic in the double-fault handler.  As I
understand it, the SDM and APM aren't kidding when they say that #DF
is an abort, not a fault.  There is a single case in the kernel where
we recover from #DF, and it was vetted by microcode people.
