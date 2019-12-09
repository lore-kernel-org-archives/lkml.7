Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AF7C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0C0208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575914841;
	bh=ohH8zduCKM5iKFuWC84pzcG6Huw5EBpjWoLp0eAIqfM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=D8J0M377TdC+ZElS6aT5uHQ4EM9VmwBmlKkToGUgngcP+oQOaE7BVGgvVNu02PATX
	 HjkvqD/TJLNZbVQdwBKPqgYFPd8H0YRUC7wu+WzXijEzOIUB8ZwkFnDCbePXeMdY9s
	 GbNPLdkwfMwKPFnHObjb5CO1Av13xUNIbWKLAfu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfLISHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:07:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47006 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLISHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:07:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id f15so10641492lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 10:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGi/ifhcVcI/E7pSJWWfjvPUeH7vDYT4NuvZCBxi0tA=;
        b=b6hKlGMRX7yTmceZ+5D7sqF0IFlNCKrzfcCnpql1G/S92AqZQAUm3hh5oDzaZhut4n
         YYRCBGTP1bICBVQ/a7TLGl5T/VHNpGlobuD9h8sO1/Fn4bPUtFRvFuqe+JLo1wi0yAcQ
         XsNnYHAD+bu6DBKVSe3Zer0X0ALtsv6uXA184=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGi/ifhcVcI/E7pSJWWfjvPUeH7vDYT4NuvZCBxi0tA=;
        b=hRrlPuWxPEL4hGK1krWi5Fqvj5AOSyOVlkjDw9Xhekd2W9INVkiqKrAM/gcx2SMwHn
         al/8DQ410P6JGD74WTOgdxznz9UXXSKqGMzPculZB1gnVPnNPGUX8JfCIdfB2FoDqt/D
         Y/GC3pUeOkBRD8vrwPSO7AX/f7wk868I856FVYhhXpKHsFVCxuJ0+F6Qz/tI4NaPJ5lN
         BjlJAuKHecC4KroqZf6D4NGTBVqXkvtOpXP3+O+2CfnXt6wiibKcRCLGLP0RqcTG9UVq
         dawy1Uvp3VBfmPycxduWIrctW28YTvY9gNT8neu3R37zPtx3hHQK3kXkGGZXkdHvyyvG
         RLtQ==
X-Gm-Message-State: APjAAAW3NIQjm28eqBFQXwgXTxRKxa6sIdUwGs+sMuwzCT3sAXkYSY1/
        BjDfkcw7bviBqcGzFPxA5lFpn6wgf5M=
X-Google-Smtp-Source: APXvYqwau80/qVxVKlXOS63SpJS42tYpttQD8S2JG6BsPZeGnTNHMFhCvEndVqitNb6kI+5dn/Q+4A==
X-Received: by 2002:a19:ca59:: with SMTP id h25mr16028978lfj.27.1575914837223;
        Mon, 09 Dec 2019 10:07:17 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id s22sm325949ljm.41.2019.12.09.10.07.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 10:07:16 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id n12so11477584lfe.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 10:07:16 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr16222969lfi.170.1575914835885;
 Mon, 09 Dec 2019 10:07:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
 <20191209091813.GA41320@gmail.com> <20191209102759.GA123769@gmail.com>
In-Reply-To: <20191209102759.GA123769@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Dec 2019 10:06:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpfd2cmuGj4NYjJ-UoJnoGPyaTZH-dA0xEAeTvgYZFZA@mail.gmail.com>
Message-ID: <CAHk-=whpfd2cmuGj4NYjJ-UoJnoGPyaTZH-dA0xEAeTvgYZFZA@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/wait: Make interruptible exclusive waitqueue
 wakeups reliable
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 2:28 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Totally untested, but shows the principle: I believe interrupted
> exclusive waits should not auto-cleanup in prepare_to_wait_event().

Oleg convinced me I was wrong, and that there is no bug, so I don't
think we need anything after all.

Yes, there's a "race" between wakeup and returning the error, but
since any correct code already relies on the condition having become
true before the wakeup (and it needs to be a stable condition -
otherwise the exclusive waiters wouldn't work in the first place), the
code that returns the error will never get reached because of the

>                 if (condition)
>                         break;

part of the ___wait_event() macro.

            Linus
