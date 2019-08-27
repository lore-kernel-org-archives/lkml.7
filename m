Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3FBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9E42070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566947930;
	bh=wezWlEj+emEAu/Y4km3hAy77vGxp7GmMxShBOXaNH/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iSVnw04De8cqrhsc7o73m6CXg8uY+oMoDvV2M+Zu9Iam6aQNZwG6fuOT02hYnI08X
	 QsNtcXiZAb05CRrnJZKznbFUeYt0WJsFlfycLgncb6Bc5MNBGOxjFUORiFGAvB9fjn
	 0Vn4iTC6/WfRSt8d4XpbgX4mKVaL69EL1aWyalyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfH0XSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfH0XSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:18:49 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B37522CED
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 23:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566947928;
        bh=wezWlEj+emEAu/Y4km3hAy77vGxp7GmMxShBOXaNH/c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YEJFwa6DH4Bi9vKBliGQJdbs7QdCdl5CbUFaGLRDKMA7LgI6h2h2NcafiO3+IsK9o
         tLJ8mT037k7E0TtSc5Ddk6vtN5x0csky5M7Y2YexteucMMuvtSg/dxNxE77sjWcLrC
         6lqi1qXbkBZZ0/8rTnVXVd/qMgGk3WsfLZpdBFIA=
Received: by mail-wr1-f41.google.com with SMTP id y19so498405wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:18:48 -0700 (PDT)
X-Gm-Message-State: APjAAAVLsUI4friSv2M7nGYkx7Irz+kOuUYY+C3mwkuuMqymSpDeOpEE
        csemNfMkL8NFvfW0OvBQhFuSoZ1oK71C1ddwB7gRxw==
X-Google-Smtp-Source: APXvYqwSUdp/lqhW1U0dtbF7rLBy8AT2EHKbCelREPiXzd2YDve5b2ICpPC2Dcq6/Z+AEEDJuhe1SpnESWbrbaM7Ayw=
X-Received: by 2002:a05:6000:4f:: with SMTP id k15mr491850wrx.221.1566947926809;
 Tue, 27 Aug 2019 16:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190823224635.15387-1-namit@vmware.com>
In-Reply-To: <20190823224635.15387-1-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 27 Aug 2019 16:18:35 -0700
X-Gmail-Original-Message-ID: <CALCETrX+h7FeyY290kvYRHAjMVDrmHivc55g+o0hnXrmm-wZRw@mail.gmail.com>
Message-ID: <CALCETrX+h7FeyY290kvYRHAjMVDrmHivc55g+o0hnXrmm-wZRw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] x86/mm/tlb: Defer TLB flushes with PTI
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 11:07 PM Nadav Amit <namit@vmware.com> wrote:
>
> INVPCID is considerably slower than INVLPG of a single PTE, but it is
> currently used to flush PTEs in the user page-table when PTI is used.
>
> Instead, it is possible to defer TLB flushes until after the user
> page-tables are loaded. Preventing speculation over the TLB flushes
> should keep the whole thing safe. In some cases, deferring TLB flushes
> in such a way can result in more full TLB flushes, but arguably this
> behavior is oftentimes beneficial.

I have a somewhat horrible suggestion.

Would it make sense to refactor this so that it works for user *and*
kernel tables?  In particular, if we flush a *kernel* mapping (vfree,
vunmap, set_memory_ro, etc), we shouldn't need to send an IPI to a
task that is running user code to flush most kernel mappings or even
to free kernel pagetables.  The same trick could be done if we treat
idle like user mode for this purpose.

In code, this could mostly consist of changing all the "user" data
structures involved to something like struct deferred_flush_info and
having one for user and one for kernel.

I think this is horrible because it will enable certain workloads to
work considerably faster with PTI on than with PTI off, and that would
be a barely excusable moral failing. :-p

For what it's worth, other than register clobber issues, the whole
"switch CR3 for PTI" logic ought to be doable in C.  I don't know a
priori whether that would end up being an improvement.
