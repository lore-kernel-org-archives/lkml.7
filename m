Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497A6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA242063F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CDthoel5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfDJR50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:57:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730819AbfDJR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aOfrBofw/0QJ/2jPcHKrqREkEIvcRBqkblnnWA45Bjc=; b=CDthoel5H8xYFyZbgdeOb41Rt
        KYOJhdNpVJ+CjDx9Uv0Exg+8vtWzK4L02uEXpILNqPd7f9I9ERHoWnyQGloKXP/s/CsUFqD7QBffY
        pcyVMxFzLIqmdz62w4OlAUEmyGpk9UYBJ0TCNQNkSaFOtIEldg8KyrMw1arLxDq2DtfaiO+QIGYWn
        V/OGej49KPIV+Cq3WGoBUxUL31Y1I6HRS4xWWiP/hbS8n1CekedeI7H3yNYFsmVokh+nyxkcFA4cN
        U9T31GCiAOs/c09eQMaKfHowHgTkn3ZMM5f8V858BORrUopYG1F0QnKS9B/BnM7KfsUGIdB/+9gus
        Kxdn+oP0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEHTD-0004oB-Se; Wed, 10 Apr 2019 17:57:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0657B2029FA03; Wed, 10 Apr 2019 19:57:10 +0200 (CEST)
Date:   Wed, 10 Apr 2019 19:57:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>, x86 <x86@kernel.org>
Subject: Re: rseq/x86: choosing rseq code signature
Message-ID: <20190410175709.GW4038@hirez.programming.kicks-ass.net>
References: <11513896.2624.1554838336494.JavaMail.zimbra@efficios.com>
 <913288111.2663.1554842622822.JavaMail.zimbra@efficios.com>
 <20190410065417.GU11158@hirez.programming.kicks-ass.net>
 <608558890.3157.1554911260089.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <608558890.3157.1554911260089.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:47:40AM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 10, 2019, at 2:54 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Tue, Apr 09, 2019 at 04:43:42PM -0400, Mathieu Desnoyers wrote:
> >> +/*
> >> + * RSEQ_SIG is used with the following privileged instructions, which trap in
> >> user-space:
> >> + * x86-32:    0f 01 3d 53 30 05 53      invlpg 0x53053053
> >> + * x86-64:    0f 01 3d 53 30 05 53      invlpg 0x53053053(%rip)
> >> + */
> > 
> > Right, and the alternative is: 0f b9 3d $SIG, which decodes to:
> > 
> >  UD1 $SIG(%rip),%edi
> > 
> > which will trap unconditionally. The only problem is that gas will not
> > actually assemble it, but since we're .byte coding it, it doesn't
> > matter.
> > 
> > UD1 is specified by both AMD and Intel to take a ModR/M, unlike UD0
> > where they disagree on the ModR/M.
> 
> UD1 is even better from a code emulator perspective. It won't have to
> try to emulate invlpg if it sees it.

Some emulators terminate on UD2, not aware of any special UD1 behaviour.

> Byte coding UD1 as your example above gives the following objdump output,
> is it expected ?
> 
> objdump --version
> GNU objdump (GNU Binutils for Debian) 2.28
> 
> x86-32:
> 
>   14:	0f b9                	ud1    
>   16:	3d 53 30 05 53       	cmp    $0x53053053,%eax
> 
> x86-64:
> 
>    b:	0f b9                	ud1    
>    d:	3d 53 30 05 53       	cmp    $0x53053053,%eax

GNU objdump (GNU Binutils for Debian) 2.31.1

     0f b9 3d 78 56 34 12    ud1    0x12345678(%rip),%edi

So I suppose your objdump is too old :/
