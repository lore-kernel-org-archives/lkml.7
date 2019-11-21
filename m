Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014F7C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAAF2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574358678;
	bh=w4NAhbBGXkWtjvEN68neI3i+vdEAQADQDNA6Ic6Csho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S+EYlzrLii3ARWSE/bDNxKX94w221YwJsft7pP0MDTabQ+FvDeLhHr3Q3kgI0Mqxs
	 jMsGcHoNbtf7QPPNSheMZf3qGpDREuu9nOKBD1eOes3tvhqC1/qf8xnY8sO/wpy6zE
	 7Fh9gXS60/zmcbPGNWtGK4TkN0cZihAzpyY9eNQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKURvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:51:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKURvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:51:17 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6921A2067D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 17:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574358676;
        bh=w4NAhbBGXkWtjvEN68neI3i+vdEAQADQDNA6Ic6Csho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a72zGENTurAjwkxNrguv79ToysR9/vqimQ1KABqMtEiifaIv0dEL73uz2CbLeAamh
         AOz5ifQ6VbgP0OHLQXfT4maGV5cH/4tR7B9OGBLUEbdPGKRckM9368baApMZMCUy42
         US87iNGQsF8JenXCksNW0uj7LqKmXZ89cuZ6EgJs=
Received: by mail-wr1-f52.google.com with SMTP id i12so5474198wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 09:51:16 -0800 (PST)
X-Gm-Message-State: APjAAAUWuW9bKYg2Pp+wF2/wh8RIwrCfjqIqnKUSOS4kl0hBEfi53ie6
        Ydo4IapqIPqp4FRJXEXTXneVaqcs6zn4Zc2ru9J2qg==
X-Google-Smtp-Source: APXvYqxdiJLDnQw8UU2EeWdLX7qQ22bTHBv7+gxospgDYrqjglq1Tdu/7KmWrU0OU8WILZ1cqc1rHPQQnAG1DplpdzM=
X-Received: by 2002:adf:b457:: with SMTP id v23mr12299661wrd.149.1574358674973;
 Thu, 21 Nov 2019 09:51:14 -0800 (PST)
MIME-Version: 1.0
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com> <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net> <20191121171214.GD12042@gmail.com>
 <3481175cbe14457a947f934343946d52@AcuMS.aculab.com>
In-Reply-To: <3481175cbe14457a947f934343946d52@AcuMS.aculab.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 21 Nov 2019 09:51:03 -0800
X-Gmail-Original-Message-ID: <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
Message-ID: <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
To:     David Laight <David.Laight@aculab.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 9:43 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Ingo Molnar
> > Sent: 21 November 2019 17:12
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> ...
> > > This feature MUST be default enabled, otherwise everything will
> > > be/remain broken and we'll end up in the situation where you can't use
> > > it even if you wanted to.
> >
> > Agreed.
>
> Before it can be enabled by default someone needs to go through the
> kernel and fix all the code that abuses the 'bit' functions by using them
> on int[] instead of long[].
>
> I've only seen one fix go through for one use case of one piece of code
> that repeatedly uses potentially misaligned int[] arrays for bitmasks.
>

Can we really not just change the lock asm to use 32-bit accesses for
set_bit(), etc?  Sure, it will fail if the bit index is greater than
2^32, but that seems nuts.

(Why the *hell* do the bitops use long anyway?  They're *bit masks*
for crying out loud.  As in, users generally want to operate on fixed
numbers of bits.)

--Andy
