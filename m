Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E7CC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2252186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563565926;
	bh=7L3QZNi97cTcmEXPZwlcfCwjYMv5BtcPgEj05eENOSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tZLDJOuzK99Co7UbEDwUehAnKD9sITxuQvPbRQkZ1svsdsSgsBqgmxpeQFvFpkzQJ
	 bqMXghX5e2kHj15MXroUF4tR+Oihqa7ZOjni9k98WIeBq1Agx7RQnsE2yiEAquTi5T
	 ShzZ16m+UhWoLd0N9z8HKeLKPnNYF2h3KYCxh5nQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfGSTwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:52:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39812 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfGSTwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:52:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id v85so22504115lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2JBPzk0GKH4lUlpKCVDWG4mMPT72Qbn0Zt06lp0yJB8=;
        b=bGVdOgW2JTU6muEF91T6h+WM7K/XI2h3ynxFwrkqpdKawloxvtybTe+8mV2/2+8jHT
         MF16TPa9wCYi5UhSi3pDpmzQOg7gelG2HJ36L0Ji3irig5oNQifTXitmgNKENk67BgCm
         d7pXY+QPWUTOF3XDtiaL8QH5UpfDQWxv9Poo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2JBPzk0GKH4lUlpKCVDWG4mMPT72Qbn0Zt06lp0yJB8=;
        b=gK/F3ip5N6Opm1agOadaWlsawbw229Zm+qTPZHQKBr8ed9VZv3IIm4zMVW8a0zZEyS
         /UrltBG46dhBHWrwPijZ1pdADKII1jKNnRAF8xcgKTmRkRLUW1GYs7FiCdMJmrC9S6Q7
         h0UamlJDM8t4phWymglO+rKZkTG1G8LM89TjHUkhweJlHDKtuK2IbjzbBq4PBnSV/Yh2
         4kox8FDqrIxcM6euv3652f80o0m1TqY6fKLJLF53KFMy+iQPxeSpJTcJlozbSCacB4SD
         3rGHNK4GXPstGbnQYhzYNLaN2W7OEm0KEQuQ99M1CZXL+y1jsad1DPzN6QsbqrBruoZK
         GXXQ==
X-Gm-Message-State: APjAAAV5K59E5cnUOPpBq1YSEbz5bf//XD54b4bs8z3y8J1mAautBvdJ
        rSdVTYp0sT7ybM2ihtHZAM4/EIZxeo8=
X-Google-Smtp-Source: APXvYqyAliNXWe7S37LTJjBsHcMq+e2PR+6/76MprbtN/W5ZTsyY1huJwwaaBZ7CJfAMAg7paocElQ==
X-Received: by 2002:a19:234c:: with SMTP id j73mr24396796lfj.96.1563565921299;
        Fri, 19 Jul 2019 12:52:01 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id v14sm5886343ljh.51.2019.07.19.12.52.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 12:52:00 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id v24so31894753ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 12:52:00 -0700 (PDT)
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr6981816ljm.180.1563565919973;
 Fri, 19 Jul 2019 12:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190520205918.22251-1-longman@redhat.com> <20190520205918.22251-14-longman@redhat.com>
 <20190719184538.GA20324@hermes.olymp> <2ed44afa-4528-a785-f188-2daf24343f97@redhat.com>
In-Reply-To: <2ed44afa-4528-a785-f188-2daf24343f97@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Jul 2019 12:51:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioLqXBWWQywZGfxumsY_H6dFE3R=+WJ3mAL_WYV1fm9Q@mail.gmail.com>
Message-ID: <CAHk-=wioLqXBWWQywZGfxumsY_H6dFE3R=+WJ3mAL_WYV1fm9Q@mail.gmail.com>
Subject: Re: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an atomic_long_t
To:     Waiman Long <longman@redhat.com>
Cc:     Luis Henriques <lhenriques@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 12:32 PM Waiman Long <longman@redhat.com> wrote:
>
> This patch shouldn't change the behavior of the rwsem code. The code
> only access data within the rw_semaphore structures. I don't know why it
> will cause a KASAN error. I will have to reproduce it and figure out
> exactly which statement is doing the invalid access.

The stack traces should show line numbers if you run them through
scripts/decode_stacktrace.sh.

You need to have debug info enabled for that, though.

Luis?

             Linus
