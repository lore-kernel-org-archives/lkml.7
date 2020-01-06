Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE032C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46CA215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HijrWx5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgAFIXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:23:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFIXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nYOr/sf0nD1L6E/qjNg4zuKpPzCSoERM7P4MkiuiORA=; b=HijrWx5DY7NCS/gFZmqZ8abiU
        e+aI9JakRwOWAEkl0/WwuV8+FIDdWoVILFVDZ6FO3AemSQ8V2zNHPBoXpqS0YodhIClCmaiRBBOk+
        22aJFGVf4Un+DQolK0M2k2DNHpN9lp2f/mm+dyAnzoNs0w4N58fSwZJ+1TWQw5rvTbqHya0Io0aaR
        Ype2ZK+wVhWx3Ir23o3L6fY/3AQXbLqxD+CYOwHYCHsqT+LaIZ22xcwmvXSAMgv1KKOMnHYSOuz1e
        c1ljrjJTCkQKr+HQbhe2SzhZ4Npnpl6Y4ci6Euyuuo0QTJXOm4RcXPmYQPOCfvwKUzxfbJy8EzVbf
        xoZM56CVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioNfT-0003Np-16; Mon, 06 Jan 2020 08:23:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB4DE304124;
        Mon,  6 Jan 2020 09:21:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AAEAC2B627466; Mon,  6 Jan 2020 09:23:15 +0100 (CET)
Date:   Mon, 6 Jan 2020 09:23:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     KP Singh <kpsingh@chromium.org>,
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
Message-ID: <20200106082315.GL2810@hirez.programming.kicks-ass.net>
References: <20200103234725.22846-1-kpsingh@chromium.org>
 <F25C9071-A7A7-4221-BC49-A769E1677EE1@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F25C9071-A7A7-4221-BC49-A769E1677EE1@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 09:49:10AM +0900, Andy Lutomirski wrote:

> > - Mark memory as non executable (set_memory_nx). While module_alloc for
> > x86 allocates the memory as PAGE_KERNEL and not PAGE_KERNEL_EXEC, not
> > all implementations of module_alloc do so
> 
> How about fixing this instead?

We only care about STRICT_MODULE_RMW (iow, arm, arm64, s390, x86). Of
those only s390 seems to be 'off'.
