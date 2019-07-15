Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B79C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 23:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C2B2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 23:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563232252;
	bh=A+H7lExhC1UuXWzvoUebhOsOihZ7vut0x21xHCfor1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wXnKHZLBC8cOMBdFJPAcAuKhDZS2v7VEl8E636t5m61mrUBGZREDUoDO8DYl5+Akv
	 pwTyn09D/xklvbWWLwN0How1OQd0MhaBFMQehwpdLlzjCsyQ0KqK4cLu3vRvFgyXni
	 EimcUgM2LLZH0dSbNrYmvX67R7pOInZ61saepU9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbfGOXKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 19:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731058AbfGOXKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 19:10:50 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A64C2171F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 23:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563232249;
        bh=A+H7lExhC1UuXWzvoUebhOsOihZ7vut0x21xHCfor1Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MWf47KVYSWEMLAqUy9+8NVn3HRFGZK4boSzehs34yzz8vxourGXzSU8VIJ/m6SxvB
         WtV2njNLyp9vGHT2p9ncIYonkltuEPA2U/YGYM+5ypb/lTCHquWnVapKLxWJev1rcx
         HK78JoGxMyGiVOE0W81Tgi11uYJUsq4ZTh/PYbuE=
Received: by mail-wr1-f42.google.com with SMTP id c2so15625035wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 16:10:49 -0700 (PDT)
X-Gm-Message-State: APjAAAW/rRMF7f9qOnbuUQ8QEw0x+CgJ0DZrddpW6f8jXhdJgh+YSVcI
        ICcwG5EN0QPu1U3UobWBoZHixhOyOdZn977cmJlIXw==
X-Google-Smtp-Source: APXvYqxCv8C//vKUVgWzdGEyB9tyC3FWvOUP2DifxOfUNwVxuehWOQoZR6tJHcs4CJYlWjdIjtp2sBtl8Vrq6OrGeN4=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr29401659wrj.47.1563232248100;
 Mon, 15 Jul 2019 16:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
 <8736j7gsza.fsf@linux.intel.com> <alpine.DEB.2.21.1907152033020.1767@nanos.tec.linutronix.de>
 <CAFULd4bcB8tsgZuxZJm_ksp5zyDQXjO=v_Ov622Bmhx=fr7KuA@mail.gmail.com>
 <alpine.DEB.2.21.1907152129350.1767@nanos.tec.linutronix.de>
 <20190715193836.GF32439@tassilo.jf.intel.com> <CALCETrVonxn6tDkxZnbetM9W4Uxxm7-M-tv1e7YsieX3U5OBKA@mail.gmail.com>
 <20190715225305.GI32439@tassilo.jf.intel.com>
In-Reply-To: <20190715225305.GI32439@tassilo.jf.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Jul 2019 16:10:36 -0700
X-Gmail-Original-Message-ID: <CALCETrW8yTRyP3qnOv04B2XvR5ZHDUky15CCBR2gtNVG3bea-Q@mail.gmail.com>
Message-ID: <CALCETrW8yTRyP3qnOv04B2XvR5ZHDUky15CCBR2gtNVG3bea-Q@mail.gmail.com>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop targets
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 3:53 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > I haven't tested on a real kernel with i915.  Does i915 really hit
> > this code path?  Does it happen more than once or twice at boot?
>
> Yes some workloads allocate/free a lot of write combined memory
> for graphics objects.
>

But where does that memory come from?  If it's from device memory
(i.e. memory that's not in the kernel direct map), then, unless I
missed something, we're never changing the cache mode per se -- we're
just ioremap_wc-ing it, which doesn't require a flush.

IOW I'm wondering if there's any workload where this patch makes a difference.
