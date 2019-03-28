Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290E2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E771C2184D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553805861;
	bh=gW237QTEXKYNJD1CqeTAqFbfJFh6E0L2DjWq2LGiZGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VkqCOXxhOASWszbquRMyeY5sGSlMD1t0eA+6ikdm+SwqLbWPb8szdKYLRPY5CSHpx
	 HVuS25KapKECZ2g2FmN7B3jXU7mGgQRj/wJi6zuGuwl6CX+vaOhZ0LFyZspq3SXGtc
	 Wu445/aTnwlsQ0JlYGoVkuw8tpNWl8L96mM1+QIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfC1UoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:44:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42668 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfC1UoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:44:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id v22so35464lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uAv+3F43JPtJ5abL4qrdGr4Zvmv4uwInWFF+gnQtmVs=;
        b=OLtVNjpiiPk/HxNXiu4xhxmm6UYvJwUtwmkosp+P6bvgPOv4BL60UehGeMpb/JXaa+
         uOjfiY7Sn9sRu3oSj+CQXUhoB4nP62vZDhDsC4J2wCKne/GXjmere2kek/mFC1O0oWw4
         6jkVnaFPto015s1GAlFPuvCUKlvwoaiL6TVMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uAv+3F43JPtJ5abL4qrdGr4Zvmv4uwInWFF+gnQtmVs=;
        b=rNsutAYQysnbvkZvvMHoi1oF67pTwAElW8XhesEIrE0VoMcJDtWH7RBSa7c/2YyeuA
         cVQxDiV7L06MLJiV+CHFQ6CWr9BxefXFMkOlXInhr25UsfZi0P+sIEBBIsVb77kSAp8i
         DtmS6gViZkMCDcBuZ/NCMPe0BUCM6WwgEy1CPrS3cKEvPCDSAdYF27oFbUAwjh8uOpyr
         kGvObVdZuRIr2bYp1ZIHmC2e+2C2SLcEZhqiEyLj1xmuM0I52hfOP1F94RAJ/qlfQB/y
         pZNzb7NCs5+31K4rmecI8JH/N8SCCkBT229wG64f73xcH0UUuFQN6qMb4Q89U4mnePSe
         vUnQ==
X-Gm-Message-State: APjAAAVgwuVBlEx5R91egz4G83bUV8t34Qv+CRtJDQdPPGHqiCsuSwEj
        6hb/s/DBL1GD3qrEQd8gqxg7F2v7ge0=
X-Google-Smtp-Source: APXvYqxfSCAIGJISo8km9BhATXyuKMjGq727zN7KNzT1m+mJE7UhQpJYslddPStOVHO1ga5llnU8sw==
X-Received: by 2002:a2e:8794:: with SMTP id n20mr20742832lji.76.1553805856233;
        Thu, 28 Mar 2019 13:44:16 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id f18sm21614lja.91.2019.03.28.13.44.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 13:44:15 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id h21so18315ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:44:14 -0700 (PDT)
X-Received: by 2002:a2e:8149:: with SMTP id t9mr24242481ljg.2.1553805854366;
 Thu, 28 Mar 2019 13:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190328181106.22887-1-longman@redhat.com> <20190328181106.22887-11-longman@redhat.com>
In-Reply-To: <20190328181106.22887-11-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Mar 2019 13:43:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiH-swkbq3aw78HwAg-OKkj96EZJzp3_rmNoHYnpA=njg@mail.gmail.com>
Message-ID: <CAHk-=wiH-swkbq3aw78HwAg-OKkj96EZJzp3_rmNoHYnpA=njg@mail.gmail.com>
Subject: Re: [PATCH 10/12] locking/rwsem: Merge owner into count on x86-64
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 11:12 AM Waiman Long <longman@redhat.com> wrote:
>
>  Reserving 2 bits for status flags,
> we will have 16 bits for the reader count.  That can supports up to
> (64k-1) readers.

Explain why that's enough, please.

I could *easily* see more than 64k threads all on the same rwsem, all
at the same time.

Just do a really slow filesystem (think fuse), map a file with lots of
pages, and then fault in one page per thread. Boom. rwsem with more
than 64k concurrent readers.

So I think this approach is completely wrong, and/or needs a *lot* of
explanation why it works.

A small reader count works for the spinning rwlocks because we're
limited to the number of CPU's in the system. For a rwsem? No.

                    Linus
