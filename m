Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF1CC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74442073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I1o26tz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAGJML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:12:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48356 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgAGJML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=A1bVLjosQRKXXi47Ohrd213MIJXML0aJ/z3lXdqGhps=; b=I1o26tz08SFbCJG4E70ntK+rt+
        Tr4fOu9Fg8ogt5Liv4rRYtzCiNIgPRvbPqgPqsGoYzOfOzLIcWcjd/Bv81T4TI1L1Gh5JxoEMJUhc
        iwjsOiB5q38fPqxxhmbMn2VLdC6pkiT58JrZntSNSsrt7mCzZK54lR4RfRAraqSg1WP8UqiekXSHH
        tOMuGMYV85vEYJ3JPlkVzi/4Y99SXm9M11zwQ7/aMfBLPVFadlAWUTOPNm+v82jhLs3Z6N/K8sPLh
        3ow6llWRv50EEH9wZ033z9piEV15LRqtXYIwFIFdi9NjHYZqwXpG9Ik+7I4j5RVLxkcZNVNX55SMJ
        niQG05NQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioktm-0004Te-0G; Tue, 07 Jan 2020 09:11:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 329343012C3;
        Tue,  7 Jan 2020 10:10:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A66B42B2844EA; Tue,  7 Jan 2020 10:11:32 +0100 (CET)
Date:   Tue, 7 Jan 2020 10:11:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Justin Capella <justincapella@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        linux-security-module@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Thomas Garnier <thgarnie@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Halcrow <mhalcrow@google.com>
Subject: Re: [PATCH bpf-next] bpf: Make trampolines W^X
Message-ID: <20200107091132.GR2844@hirez.programming.kicks-ass.net>
References: <CAMrEMU8Vsn8rfULqf1gfuYL_-ybqzit29CLYReskaZ8XUroZww@mail.gmail.com>
 <768BAF04-BEBF-489A-8737-B645816B262A@amacapital.net>
 <20200106221317.wpwut2rgw23tdaoo@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200106221317.wpwut2rgw23tdaoo@ast-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 02:13:18PM -0800, Alexei Starovoitov wrote:
> On Sun, Jan 05, 2020 at 10:33:54AM +0900, Andy Lutomirski wrote:
> > 
> > >> On Jan 4, 2020, at 8:03 PM, Justin Capella <justincapella@gmail.com> wrote:
> > > ﻿
> > > I'm rather ignorant about this topic but it would make sense to check prior to making executable from a security standpoint wouldn't it? (In support of the (set_memory_ro + set_memory_x)
> > > 
> > 
> > Maybe, depends if it’s structured in a way that’s actually helpful from a security perspective.
> > 
> > It doesn’t help that set_memory_x and friends are not optimized at all. These functions are very, very, very slow and adversely affect all CPUs.
> 
> That was one of the reason it wasn't done in the first.
> Also ftrace trampoline break w^x as well.

Didn't I fix that?
