Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B57C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C6B2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554740295;
	bh=7Nu9QXvcI0vEF10mrCEynsPN8ROv6UmoVrwf8Folv9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VEyyX2BlXxIICL3HAx3qx4oQ4ODAZ88/6TsWWO9WKhIc+rWlZtir/6A7DUxnQnekV
	 gmGQ/cz2TvYZJsJHsCnAintiE2jmFejjUADjPgg+TAFVJINen43kduNsbbcR4UduNm
	 tOiADi3wOKsn2/toC6hEGH4TZRUDGmta0AtKD9OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfDHQSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:18:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfDHQSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:18:13 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C5521874
        for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2019 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554740293;
        bh=7Nu9QXvcI0vEF10mrCEynsPN8ROv6UmoVrwf8Folv9w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UV4jNJDky2SjzQFhe1zoqjj57aiUKZ7K27mCBSIReawC/43mWhYpKymoWXrR9UJBA
         gHKcuyuPhMsYAV7h/MJUkdWvsVv2jzAc87Kun+n6P43Bs/Mhf6WvL0SMEh8eUK8aBB
         RYQLncI67mSplO1metmFZ6ibUX6oADCVv3wD+elo=
Received: by mail-wr1-f48.google.com with SMTP id k17so17092581wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:18:12 -0700 (PDT)
X-Gm-Message-State: APjAAAVdJBsDFBXUuFdkH5GFMucozcw8SFHUFsotmPVmZ6m3NZFm3bIJ
        cJ3081BzX11YObqrWnod0SLx938dXv5E0EJFE7perA==
X-Google-Smtp-Source: APXvYqyzggfHsIweLj7oq9QZYJ+zvKZpBvd4p6ctMbSXrs9DIRmjrj9d9ZXl6wdgEo/SKMcXu2nVjgrxNC8gBexykag=
X-Received: by 2002:adf:efc1:: with SMTP id i1mr19176947wrp.199.1554740291374;
 Mon, 08 Apr 2019 09:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190405150658.237064784@linutronix.de> <20190405150930.967389183@linutronix.de>
 <CALCETrWF_YgQODJ=Rpm2MnhFxJXCfoo4H792hUQni0GS9on7og@mail.gmail.com>
 <alpine.DEB.2.21.1904080043390.1840@nanos.tec.linutronix.de>
 <CALCETrXyfEu5MHCDp+OiRdHcYQ1tMNhTMSxcAhWkOx_8r2rxsA@mail.gmail.com> <alpine.DEB.2.21.1904080839480.1840@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904080839480.1840@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 8 Apr 2019 09:18:00 -0700
X-Gmail-Original-Message-ID: <CALCETrX_Pyo-H8H2feZz1+hiz_E99ZqVBqb+xvZfZ+gvFGL5gw@mail.gmail.com>
Message-ID: <CALCETrX_Pyo-H8H2feZz1+hiz_E99ZqVBqb+xvZfZ+gvFGL5gw@mail.gmail.com>
Subject: Re: [patch V2 28/29] x86/irq/64: Remap the IRQ stack with guard pages
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 11:46 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sun, 7 Apr 2019, Andy Lutomirski wrote:
> > On Sun, Apr 7, 2019 at 3:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > Actually we have: save_stack_trace()
> > >
> >
> > Like I did here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=WIP.x86/stackguards
>
> Kinda, but what that code wants is to skip any entry before 'caller'. So we
> either add something like save_stack_trace_from() which is trivial on x86
> because unwind_start() already has an argument to hand in the start of
> stack or we filter out the entries up to 'caller' in that code.
>
>

Whoops!

I could add a save_stack_trace_from() or I could add a "caller"
argument to struct stack_trace.  Any preference as to which looks
better?  The latter seems a little nicer to me.
