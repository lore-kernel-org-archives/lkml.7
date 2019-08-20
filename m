Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA2C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0139D22DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fvh58Q77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfHTNVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:21:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jTJbNtWSYKy75ac9nrDMS4DD8w6zR87+w5MdrKdbeMw=; b=Fvh58Q77mLxjeT7XJUaQiRbN5
        6oZAsZT6f8O4rm6zT1QFGryCbpB/D4cwG18gXEMCQuQXaIDx6O/Iu5HMLSYKwMDF0qD4NN6na0WRA
        5YyWqnaUP4GTro8uLGiC2UlbyUCdgLRhz31RS+JKkSsM3UOeEkDPU+6gRROOrQ1zUIZHf3BDT09AN
        6zY/D7B85pm/gf5DY9HR5w2wdq6xVofJNQ4ZvNp4hXFrQfpfJAS0uA/StQrI0oQtQzNGhgdnM9Znq
        RTA/xVbFLi1LJ80P8DaO3kECRm68p5w1kQpQZiAOPCpfSk85exV6/LiV0SMjp9Rb0FrEsI4GMET4A
        CRUK0A34w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i044X-00024h-5t; Tue, 20 Aug 2019 13:21:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D62A43075FF;
        Tue, 20 Aug 2019 15:20:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 244AB20A99A00; Tue, 20 Aug 2019 15:21:10 +0200 (CEST)
Date:   Tue, 20 Aug 2019 15:21:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Message-ID: <20190820132110.GP2332@hirez.programming.kicks-ass.net>
References: <20190820113928.1971900c@xhacker.debian>
 <20190820114109.4624d56b@xhacker.debian>
 <alpine.DEB.2.21.1908201050370.2223@nanos.tec.linutronix.de>
 <20190820165152.20275268@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820165152.20275268@xhacker.debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 09:02:59AM +0000, Jisheng Zhang wrote:
> In v2, actually, the arm64 version's kprobe_ftrace_handler() is the same
> as x86's, the only difference is comment, e.g
> 
> /* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
> 
> while in arm64
> 
> /* Kprobe handler expects regs->pc = ip + 1 as breakpoint hit */

What's weird; I thought ARM has fixed sized instructions and they are
all 4 bytes? So how does a single byte offset make sense for ARM?
