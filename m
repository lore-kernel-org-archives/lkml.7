Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F1AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A9B2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/p43d/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfLKHTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 02:19:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44962 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfLKHTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:19:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so22797632wrm.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 23:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ypLvgvGtDw9j9CPyIJrLnPSn6hKTQUTD19ZeLZRvxyc=;
        b=l/p43d/nyC2Il3XgYnTbQBZzH91ar6R7qhAFoSM0+yk6c7oNFKaTJLd98O7asmmSVv
         IHqFaj3mSxWEG8kMXqB+g0iPXEqOgegmpMQJVRCNcF15Pn5vYJgrDXvTwPlwB89hmlSZ
         lQPraPHoZnF1rvR6/it9bAcLiYoDz6foEnrlAoYSzTIVIZFR8rz/dLzw73MzsZVy15RS
         XGvhXJDc9WT2CAt9pYO8c8w0Cs6zqqcL/ZE1+UidC/MzDJwjm2KcPL7KM1GVZTa7dZSk
         w4gx1XNjLedQCetFLLF0VCKs7Em8tvnXtMHG8BJyVBE3Pt4U1R5Gtm4Ki2Jz4fYzuynL
         T7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ypLvgvGtDw9j9CPyIJrLnPSn6hKTQUTD19ZeLZRvxyc=;
        b=k5d6xGg1v8TUdH34t0HORvewDv4+GYFOJgeryJnZlMOKxh4BDIPYUlAUIOFcZGgjYQ
         u+Y8ih3vKSkS3hZD76TnJHBfogmMBgDf6pOdKB5Y+Ppkv0dyIMu0HXAE1NOvrh7hYLfQ
         czuuWtvMPkDjjzoHdcYEQO/PAgQMPbj1UXWAiYGMG61i+poa6bCJSpMYfZhUFibVCanG
         VhJhbdFvWoDbDQXAhEAiFJt2GjV+ETEn2KgbeSXyNuxUEFY7eD0J9dMmxIDPooc1KH5j
         ZpB2Qj/9TueON1ouhO71g7qRdh3o8i1knzr1yZB5eb3kfKL8VZrQ1nrhcUnzW6i512dP
         VEMA==
X-Gm-Message-State: APjAAAWaZ/MMHqpWqgKSdXbreTX4Ic94yxI8dp4zcBJvzoFJxSCgWtJF
        02t9ggZUdhlyD4UOO68sEA==
X-Google-Smtp-Source: APXvYqwR7YJ7wiLAIU/BCwXHX5tud0RNbgFhw976ys2u0UlpO6zQkFrDshf9aFEW9bmtPzv7BlEcxg==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr1936907wrj.225.1576048786403;
        Tue, 10 Dec 2019 23:19:46 -0800 (PST)
Received: from avx2 ([46.53.249.49])
        by smtp.gmail.com with ESMTPSA id s8sm1203367wrt.57.2019.12.10.23.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 23:19:45 -0800 (PST)
Date:   Wed, 11 Dec 2019 10:19:43 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ELF: don't copy ELF header around
Message-ID: <20191211071943.GA3700@avx2>
References: <20191208171242.GA19716@avx2>
 <20191210175611.d615f21e177d5a550a8926f0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210175611.d615f21e177d5a550a8926f0@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 05:56:11PM -0800, Andrew Morton wrote:
> On Sun, 8 Dec 2019 20:12:42 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > ELF header is read into bprm->buf[] by generic execve code.
> > 
> > Save a memcpy and allocate just one header for the interpreter instead
> > of two headers (64 bytes instead of 128 on 64-bit).
> 
> Hard to review.  Why were there two copies in the first place?

That's a good question. Both can live on stack in fact
but [rsp+disp32] addressing generates a lot of bloat (few KB).

> Because of the need to modify the caller's version when we do
> `loc->elf_ex.e_entry += load_bias', yes?  Any other place?

No, but I'll double check. It was written this way presumably to not
allocate one more stack variable.

> Local variable `loc' can go away now, yes?

It can.

I have big plans to get rid of all allocations in the common case
and "fetch" headers from pagecache. This is why all headers better to be
"const" which this patch partially progresses to.
