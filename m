Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E34C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9612073F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555972823;
	bh=pWYNOxpuildrZ7gyqTZSgxCmXISULAhZNGxQEDvE2pk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Mlu/rVmuvRkUuS8/oj3oKN14UcaSAh4Lm+UODALlmr6eEGjHdCEYyLr3HbCJsEXe2
	 KF49X0O9x9wLErI2aXTnqlSkPOHDDHsdugEHZ20H3yHhDgWd/sIXi9xR2X7mmmlyJY
	 O9jpQreXpPfgLVkSX/JunBKdAUCqWZdWJSvrPUvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfDVWkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:40:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33795 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfDVWkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:40:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id y16so840442ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 15:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4+uIj7flcxGFYwj/tSELT+9Omb2XPMc6XJsVtpD7rM=;
        b=RxxH0fkU/TvgkBeVGHr1NeVrwv1sCkt3Lv8R0pHGRYrVi3TSay2ZUu5f8wEptb5i1/
         VsBgIRAi0mIzTvUEMoZ/6sCE+vA11AN1tuItLytFfErPkcy7z+CMRAwkqhMFYisWPW19
         SEGKgfH6yqS/Ea0zjmHGg1l6o51jENsOkRl/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4+uIj7flcxGFYwj/tSELT+9Omb2XPMc6XJsVtpD7rM=;
        b=V1V7VdyuPFOhQoZIkwREYVCx6CinFc2Gt24RhkWqxmbRJkoRtE50017llAxSe4UQZX
         FKNAAQAjcgJw6AzFZBqcpvDIVEzS1HRRk8uIsn7QB0umCo0WnxuRhe4JHNATeqXujMRB
         sLSBIiW1LXw77t0PR2My7tYxq29xZqA8W5KputqxcO4dKUJeP0NA0ZxMWB9Di+QuIVSd
         oWnR49uvUdbLyS26dzDizp5N1YFC6DWMUafBTpzlcAmKYvU96chkNXS9kzyIap+F7U0U
         vRNQdHgVFLrJvV2rpQrMC4lldTye9a4sr3VJpUmXhxpK6uefDL+kOOIDN+Qo9kFrBw0P
         8kvQ==
X-Gm-Message-State: APjAAAU61FxMjEhFyROIqi1H+aJN0qAwhruczY/D1D9uV6LCGQMWJOMf
        /MUleDPAipCJNCnk1onWChz7I6nv4y4=
X-Google-Smtp-Source: APXvYqxXihHRcy4yjE66kJ6HIw+3j6y9VDR7f0wycGELD48nM8AAW2Epzlg5FfZeafIXLnbFlz8bAw==
X-Received: by 2002:a2e:8684:: with SMTP id l4mr12225528lji.121.1555972818914;
        Mon, 22 Apr 2019 15:40:18 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id s64sm2962411lje.49.2019.04.22.15.40.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 15:40:17 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id h16so11620732ljg.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 15:40:17 -0700 (PDT)
X-Received: by 2002:a2e:9213:: with SMTP id k19mr11005423ljg.118.1555972817211;
 Mon, 22 Apr 2019 15:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190421160600.GA31092@avx2>
In-Reply-To: <20190421160600.GA31092@avx2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Apr 2019 15:40:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijYb1Ci2Sx2xxggxdqHuMT4HJ5WtW+eGJP-+Fa9b1YtA@mail.gmail.com>
Message-ID: <CAHk-=wijYb1Ci2Sx2xxggxdqHuMT4HJ5WtW+eGJP-+Fa9b1YtA@mail.gmail.com>
Subject: Re: [PATCH] x86_64: uninline TASK_SIZE
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 9:06 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> TASK_SIZE macro is quite deceptive: it looks like a constant but in fact
> compiles to 50+ bytes.

Honestly, if you are interested in improving TASK_SIZE, I'd really
like to see you try to go even further than this.

TASK_SIZE _used_ to just be a fixed constant, which is why it has that
name and why the usage patterns are what they are.

But since that isn't true any more, I'd much rather fix the _name_,
and I'd much rather fix the nasty complex hidden behavior, rather than
just keep the name and keep the behavior, but turning it from an
inline macro to a function call.

And as Ingo points out, we should be able to just make it a field of
its own, instead of that complex dance of TIF_ADDR32 etc.

However, I think it would be better if that field would be in "struct
mm_struct" instead of Ingo's suggestion of the thread. Because while
it's currently a per-thread flag, I think it is only set by execve(),
so it always ends up being the same per-mm. No?

Also, we could/should just make the existing *users* of TASK_SIZE know
that it's no longer a simple constant, so all those functions that use
it many times could just do

        unsigned long task_size = TASK_SIZE;

rather than re-compute it multiple times like they do now.

In fact, making it a function call in many ways makes things *worse*,
although maybe we could at least mark the function "pure" so that gcc
would be able to cache the end result. But that would actually be
wrong for the sequences that maybe do change the thread flags, so I
hate that idea too.

Much better to just cache it explicitly in the cases where we see that
it's currently generating bad code.

                Linus
