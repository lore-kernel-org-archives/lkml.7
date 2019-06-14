Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD5AC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077C12133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lBEX2ynm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfFNHJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:09:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35032 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfFNHJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k4RbWCbwBcKE2XaM1Q8HPG0quV1RdhqSycPKyg7Zrao=; b=lBEX2ynm4Dm3tZONdLQa1fe75
        KnebKJCLoxzlvi0RMdFG7oJnvKBMFVyYXunjh3eHJYXL4X3WhyZtUB/2wYMaO3eJ6gQR4JiPmI9E1
        JiOMxL8PPvdfhoL3ydZJMBiBM6WfZ89J5X5lSqtWW0Gi1yNg+AwzE76UYPZPmMASz000/ZHV3sGeW
        iAduEXHKODxPrAsPwo3VuIW/4Z4T5xKM00hB9q+Z916GkPNpzOZuIvb+wr5ko4Rmi2wGgi39oUSvf
        GDxQs5kfwaKjwUn1+fKPKI0zbVm17BfhnJIkpDhkXL0cfsNMCCZqKB87mkKgqQLrDmaO71aeaWWJU
        QQ96qSbuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbgKU-0004cU-Te; Fri, 14 Jun 2019 07:08:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43EA020A15636; Fri, 14 Jun 2019 09:08:52 +0200 (CEST)
Date:   Fri, 14 Jun 2019 09:08:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>
Subject: Re: [PATCH 2/9] objtool: Fix ORC unwinding in non-JIT BPF generated
 code
Message-ID: <20190614070852.GQ3436@hirez.programming.kicks-ass.net>
References: <cover.1560431531.git.jpoimboe@redhat.com>
 <99c22bbd79e72855f4bc9049981602d537a54e70.1560431531.git.jpoimboe@redhat.com>
 <20190613205710.et5fywop4gfalsa6@ast-mbp.dhcp.thefacebook.com>
 <20190614012030.b6eujm7b4psu62kj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614012030.b6eujm7b4psu62kj@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 08:20:30PM -0500, Josh Poimboeuf wrote:
> On Thu, Jun 13, 2019 at 01:57:11PM -0700, Alexei Starovoitov wrote:

> > and to patches 8 and 9.
> 
> Well, it's your code, but ... can I ask why?  AT&T syntax is the
> standard for Linux, which is in fact the OS we are developing for.

I agree, all assembly in Linux is AT&T, adding Intel notation only
serves to cause confusion.
