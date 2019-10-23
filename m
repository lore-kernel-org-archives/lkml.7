Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8290CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5D521906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vnM+RvIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390781AbfJWJDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:03:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46122 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390768AbfJWJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i6LtAFOvODnH5XqzqyricMUy+nwnZUTa5qYXhMKnI0Q=; b=vnM+RvIXEiRs34icSGuaYMfN/
        bmUu/35lgSwhyKs6sqSh8ILAiu6qQ5M4Jcjk4M0T6hpUs/hN4gZWVmLOYumADNK1L7p+EpVq60Mod
        mZJbAjrSp7zlQ16LJpGOc1eki2PJW3zpNs8MDbOz/5PQKi1rqkI9wb55Hu1GShP6OSjMk5fQlRuZn
        dZwpfmGuJK/WTMWCIPe7f4U1sl6H7M5oHTBguk1lzZj+xhmoL2lEzBwmZIXiZe2aAbZB3Xh5Z/hyM
        hI+HrbX692hE3PRffO5BHYX/gYafpeOHbpNCevTJ18SR5IeqPpKWjrYIokG6LmiKQe4Orojs+loT+
        ondZijbHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNCXI-0004JV-Gz; Wed, 23 Oct 2019 09:02:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A311130038D;
        Wed, 23 Oct 2019 11:01:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A265E26539495; Wed, 23 Oct 2019 11:02:29 +0200 (CEST)
Date:   Wed, 23 Oct 2019 11:02:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191023090229.GP1817@hirez.programming.kicks-ass.net>
References: <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
 <7364B113-DD65-423D-BED3-FF90C4DF8334@amacapital.net>
 <20191022234921.n5nplxlyq25mksxg@ast-mbp.dhcp.thefacebook.com>
 <CALCETrUa02muQYndyyeOZu8C6v33+A+9-2bsktxaW5N5-X6axA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUa02muQYndyyeOZu8C6v33+A+9-2bsktxaW5N5-X6axA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:20:27PM -0700, Andy Lutomirski wrote:
> Also, Alexei, are you testing on a CONFIG_FRAME_POINTER=y kernel?  The
> ftrace code has a somewhat nasty special case to make
> CONFIG_FRAME_POINTER=y work right, and your example trampoline does
> not but arguably should have exaclty the same fixup.  For good
> performance, you should be using CONFIG_FRAME_POINTER=n.

Trampolines and JITs (which both lack ORC data) should always have frame
pointers. That way, when ORC fails, it can fall back to FP and we can
still get sensible unwinds.

See:

  ae6a45a08689 ("x86/unwind/orc: Fall back to using frame pointers for generated code")
