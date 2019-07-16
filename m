Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A20EC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB92B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKYEDpBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbfGPOIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:08:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42039 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGPOIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 10:08:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so9168295pff.9;
        Tue, 16 Jul 2019 07:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2p5yNB9Fr54gFlTDgHP10Sy9vEwRFeMQvHFiEZuA438=;
        b=aKYEDpBl++j6Z+a9BhBDhIxY5CbfJ/+EEYObi3h17m/9O4CKQZBGVFubw4N5lG0O1q
         YRKAVpnuVHVl4o95IGdObu2WBSNTcoW2M2H1F1oRO/OT9ToPmMmyUQ/Pu8b+wTK/T1Xx
         q10qAI+DCgCA47SjxmPdZv3fPlxlB/0W0gTWV88XNWZ5TVAFnuNyaZ1ZegYV67jN4nLQ
         3kczgUENKTNic5f1Kjatpmozpj1co8jj2E5aHO3ohTNA4/hOzP/zCoozh93Z7utHVV8h
         NFX9QG6Vz7fNu9tRmV2sjcGlZEdwaSQolcJ0IuqI+EWNmwrk9RsTvpPybUo7KfbVIypY
         GJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2p5yNB9Fr54gFlTDgHP10Sy9vEwRFeMQvHFiEZuA438=;
        b=NDhUCA9IbBr0uB2oE+PD3/YIKzDABvJ7LEFuwPOSET7bCGNOA5IYsaGAO/hDZTp1xj
         8768zdIOltTRDyLBDgGDeMDYhfAtKQ7IodzyHQe0B1y7PxU4sFCPlgoicICh+WrIPU7r
         pxR9dOW7RDakeRUb8hcQHbDxHTvpHE93zplpIKHWNQWZtKpUHF3kcsnXVWhrLSfdPGx0
         hDU6Kc/RHqPrWq38c98cygfyx0bZq01QyhVVs83bDuLruMeKNZj/dghhokpbkUDaFIg0
         KowQhKJGBFHPz6ie7elqY04CD4igqLqBYI7HCTXWjvagFCWVbRWmVr3HojFbJkM2lRA/
         GX1A==
X-Gm-Message-State: APjAAAVs4+Ks62T98Q4zTvg/3ZVkUgqH2UyNozdOJQb2fTC71zH/USg6
        n6ZAr1Be5NId5Y8BQ0n3hnk=
X-Google-Smtp-Source: APXvYqzXpC63Aq383Ig6mtxbu2pKS8pBKp355OE6zLLHJi/TnGO3GwbhnVGRoMB+h1scO6W8iCKeXA==
X-Received: by 2002:a17:90a:9a83:: with SMTP id e3mr36023349pjp.105.1563286109956;
        Tue, 16 Jul 2019 07:08:29 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id c23sm12665035pgj.62.2019.07.16.07.08.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 07:08:29 -0700 (PDT)
Date:   Tue, 16 Jul 2019 22:08:18 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Changbin Du <changbin.du@gmail.com>,
        rostedt@goodmis.org, mingo@redhat.com, corbet@lwn.net,
        linux@armlinux.org.uk, catalin.marinas@arm.com, tglx@linutronix.de,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tracing/fgraph: support recording function return values
Message-ID: <20190716140817.za4rad3hx76efqgp@mail.google.com>
References: <20190713121026.11030-1-changbin.du@gmail.com>
 <20190715082930.uyxn2kklgw4yri5l@willie-the-truck>
 <20190715101231.GB3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715101231.GB3419@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 12:12:31PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 15, 2019 at 09:29:30AM +0100, Will Deacon wrote:
> > On Sat, Jul 13, 2019 at 08:10:26PM +0800, Changbin Du wrote:
> > > This patch adds a new trace option 'funcgraph-retval' and is disabled by
> > > default. When this option is enabled, fgraph tracer will show the return
> > > value of each function. This is useful to find/analyze a original error
> > > source in a call graph.
> > > 
> > > One limitation is that the kernel doesn't know the prototype of functions.
> > > So fgraph assumes all functions have a retvalue of type int. You must ignore
> > > the value of *void* function. And if the retvalue looks like an error code
> > > then both hexadecimal and decimal number are displayed.
> > 
> > This seems like quite a significant drawback and I think it could be pretty
> > confusing if you have to filter out bogus return values from the trace.
> > 
> > For example, in your snippet:
> > 
> > >  3)               |  kvm_vm_ioctl() {
> > >  3)               |    mutex_lock() {
> > >  3)               |      _cond_resched() {
> > >  3)   0.234 us    |        rcu_all_qs(); /* ret=0x80000000 */
> > >  3)   0.704 us    |      } /* ret=0x0 */
> > >  3)   1.226 us    |    } /* ret=0x0 */
> > >  3)   0.247 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
> > 
> > mutex_unlock() is wrongly listed as returning something.
> > 
> > How much of this could be achieved from userspace by placing kretprobes on
> > non-void functions instead?
> 
> Alternatively, we can have recordmcount (or objtool) mark all functions
> with a return value when the build has DEBUG_INFO on. The dwarves know
> the function signature.
>
We can extend the recordmcount tool to search 'subprogram' tag in the DIE tree.
In below example, the 'DW_AT_type' is the type of function pidfd_create().

$ readelf -w kernel/pid.o
 [...]
 <1><1b914>: Abbrev Number: 232 (DW_TAG_subprogram)
    <1b916>   DW_AT_name        : (indirect string, offset: 0x415e): pidfd_create
    <1b91a>   DW_AT_decl_file   : 1
    <1b91b>   DW_AT_decl_line   : 471
    <1b91d>   DW_AT_decl_column : 12
    <1b91e>   DW_AT_prototyped  : 1
    <1b91e>   DW_AT_type        : <0xcc>
    <1b922>   DW_AT_low_pc      : 0x450
    <1b92a>   DW_AT_high_pc     : 0x50
    <1b932>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
    <1b934>   DW_AT_GNU_all_call_sites: 1
    <1b934>   DW_AT_sibling     : <0x1b9d9>
 [...]

To that end, we need to introduce libdw library for recordmcount. I will have a
try this week.

And probably, we can also record the parameters?

-- 
Cheers,
Changbin Du
