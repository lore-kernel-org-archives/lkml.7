Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFE4C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2E0214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555951712;
	bh=8dBuTMuCKP2mILmHiOtnnnXNuiXQZ9Do67D/ZzGwocY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qVnWDSVP+UWUBL4hHDUMmTqjsOrWAB0D4NfC7hy70nyCwME302q+slJ/g2d4OlPrx
	 ruJOKIs/SgP+zxI01+fWpwrNfftK0Y8uq6h66R6fk86OJsgGYEXI9JiBqUjToW7hB/
	 MZ1FUy5QSTDvTfAeKboYLzzff1/w1topWFnbAHz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfDVQsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:48:31 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:46867 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfDVQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:48:30 -0400
Received: by mail-lj1-f171.google.com with SMTP id h21so10833240ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSrB0Et0D+AV5ELkYZg39V1gZm27DaKVPxoadzxyXZs=;
        b=bWVK4FYnD/qyeZ81E2zzaVoAmJJcvcVuH09eiO5Xn3W3kdua0mcLavKZhUa1pmynHv
         B/RicnrvR2h4G6KFl+InQfcPhPVWX+U1e5UqtwlzcuS+CnwxFAUuFT/TbQ21uuSgUHix
         SPzkCWmAHTeAf7B42XOYtbBKnXmgzXfmN4K/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSrB0Et0D+AV5ELkYZg39V1gZm27DaKVPxoadzxyXZs=;
        b=ETgF+LBul0BA+8Aq6NSKtJh66k0SOR4u9mYEjQA/YIAR8fXcVPJkjGNPN4LX+R9TYj
         V42KD9/GBFvv/RFp8jWtYVQBvh5P1AQZrq8TAtos55gXhMDwUZbmmcgNBiFuZ/P2lZ3h
         Ahx8VNH6Cs8hXhfsAadqkpmRGSfN3YdcYd0da9amv70n6DFbdKBuB/04xpRJSr0ECOkR
         TG5cXHtwr4a1NtDeHwZF7+vMHw1c5jDLu4zOvtsLtnIQET9cZ6Q7/bCDIDv2OUvQplFQ
         DsSNOitfrjNdjpHS0qnjfLC61h6fwkz5MirIUmFaOBf1DTSzv+RYVyVwxxs1rjuk/U4S
         CXPA==
X-Gm-Message-State: APjAAAXQlpjqUnJCUO+RVYMUiYQg6S+u6BNWBoKGK2cndMAlIh+AmD1O
        6ZZtjv6bWtVEWi/Jec80M2rkGcF34sQ=
X-Google-Smtp-Source: APXvYqwe6IodoeLW+pcVkjqcQr6uP2VK6WpHArFszcEJ9i0VR3sV0gIqujg7jJhynxAbt6tzzT/6MA==
X-Received: by 2002:a2e:5bcc:: with SMTP id m73mr11011698lje.100.1555951706956;
        Mon, 22 Apr 2019 09:48:26 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id r20sm2742894ljj.22.2019.04.22.09.48.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:48:25 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id a28so9424656lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 09:48:24 -0700 (PDT)
X-Received: by 2002:a19:f50e:: with SMTP id j14mr9831758lfb.11.1555951704551;
 Mon, 22 Apr 2019 09:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000043fe9c058720a5d3@google.com> <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
 <CAHk-=wgG=RqK8T5kWiZfH7da6rBuqp3kAesP=ETgceb6RzvZng@mail.gmail.com>
 <53a17444-9539-5810-82a0-ceeefa742508@kernel.dk> <cfa6be6d-4125-6d1e-8993-e9ec9dbaa7bb@kernel.dk>
In-Reply-To: <cfa6be6d-4125-6d1e-8993-e9ec9dbaa7bb@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Apr 2019 09:48:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=kKEb6qbuhnSWh5S55SbQBOE33991ULSFUgVrEnzivA@mail.gmail.com>
Message-ID: <CAHk-=wh=kKEb6qbuhnSWh5S55SbQBOE33991ULSFUgVrEnzivA@mail.gmail.com>
Subject: Re: WARNING in percpu_ref_kill_and_confirm
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 9:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> With the mutex change in, I can trigger it in a second or so. Just ran
> the reproducer with that change reverted, and I'm not seeing any badness.
> So I do wonder if the bisect results are accurate?

Looking at the syzbot report, it's syzbot being confused.

The actual WARNING in percpu_ref_kill_and_confirm() only happens with
recent kernels.

But then syzbot mixes it up with a completely different bug:

   crash: BUG: MAX_STACK_TRACE_ENTRIES too low!
   BUG: MAX_STACK_TRACE_ENTRIES too low!

and for some reason decides that *that* bug is the same thing entirely.

So yeah, I think the simple percpu_ref_is_dying() check is sufficient,
and that the syzbot bisection is completely bogus.

                Linus
