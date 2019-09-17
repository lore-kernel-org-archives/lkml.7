Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76233C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559A821848
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568744022;
	bh=Sb7COfNfJpxJkUSHRJ1guEJgVsL2/84sGgi4Wp0MnW8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bfLSJk6Rn0qCcnbqcLk07a01x2xoHqT5FVdF9ZMxu9YxBY3fZXvXbWZGJR7hW+yUA
	 EApmrVDxixuOnW3pCIq/iZMS4dnnMenKkuBg83ClI/foTjSDR31pgBmw4qT+oDvChH
	 GnuRpsUYVjYFoIU9/KJiONicXMXWkjax7fREkSQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfIQSNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:13:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36232 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfIQSNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:13:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so4566872ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8qAugY0cWb/Nh5PiOGvYcjpfPizYQ3b0rrAHVS81LI=;
        b=C9s5lYXXnHH4d+z/+qNm0BLqoth+3NHKNzuo1ZEI/HAzdKsJ9mbYCKk1HyB2MXQWc4
         g7DESB29IDpwLwXUyLD2QMRJW0dTAGzD36P5AoUFEoBKpasOJi1gUIzqaIujz90uWdov
         G6KhlJOJryZ9dQ3M2tUWgN7mJypOZpW/64GDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8qAugY0cWb/Nh5PiOGvYcjpfPizYQ3b0rrAHVS81LI=;
        b=Y6jy6NtYFuJSQ2PgnZTWG30PPgJcnKYhNy2M+RE3ZQ9sIAy+9gR2mkLs3vTGvwxF8f
         uqn6/oDJVFwl8+SBUI8Gj1LR95GFuKe3T+aSfehxDuKfFFWc+9Qy8H70tBmO5k7H7bp5
         sTidQ0xc5ykwOshd0mxjRAjBQ6vLYm3nLRHtXXyBpwMDnY07hw3KKZ/e4nttLkfhr4wx
         W45VAPpZ2NyBW02wSLv/Yey8oVxnuVWhEEdEYKGsthKGJXw5Tan93zP2Cq66pka5iick
         GrMfo+Tjy1xIS5ilwSm/T4CsJ2XSwWyYdAPQft/4dWs1eJKag1pAraxmhGyMk2/ukPqA
         1W8Q==
X-Gm-Message-State: APjAAAUx6ufZYIyCqjLnXNQVOxGP+hcxFIXN1XMwy8kUt1qk6xOcsyY4
        vWTWSUHejYhiAYEg9fN9jXQfuiFwGa4=
X-Google-Smtp-Source: APXvYqyKSfao28YAltPfyl7eNTvbgk/V2sIJKKiEnLGVj4IDBE+SNI8u2GQkyhGFLmSPTOTD8Qi9ag==
X-Received: by 2002:a2e:974c:: with SMTP id f12mr2638505ljj.15.1568744017275;
        Tue, 17 Sep 2019 11:13:37 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id n3sm564411lfl.62.2019.09.17.11.13.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 11:13:36 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 72so3643945lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 11:13:36 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr2838284lfp.61.1568744015985;
 Tue, 17 Sep 2019 11:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
In-Reply-To: <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 11:13:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQJaNbQe3fmFU19_wawkx-WT9Sv=h5mWCA9=LL34g_3Q@mail.gmail.com>
Message-ID: <CAHk-=wjQJaNbQe3fmFU19_wawkx-WT9Sv=h5mWCA9=LL34g_3Q@mail.gmail.com>
Subject: Re: [GIT pull] x86/pti for 5.4-rc1
To:     Thomas Gleixner <tglx@linutronix.de>,
        Song Liu <songliubraving@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 6:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>   - Handle unaligned addresses gracefully in pti_clone_pagetable(). Not an
>     issue with current callers, but a correctness problem. Adds a warning
>     so any caller which hands in an unaligned address gets pointed out
>     clearly.

Hmm. I actually thing this one is incomplete.

Yes, it does it correctly now for the "those addresses are missing" cases.

But if somebody passes in an unaligned address, it still does the
wrong thing for the

                if (pmd_large(*pmd) || level == PTI_CLONE_PMD) {

case. No?

I've pulled this, since the change is not _wrong_, but it does look
incomplete to me. Am I missing something?

Also, it would have been lovely to have some background on how this
was even noticed. The link in the commit message goes to the
development thread, but that one doesn't have the original report from
Song either.

                Linus
