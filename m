Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA52C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A59C208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e5RJGnpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfGKIF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:05:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53644 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGKIF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IPSfomtHuYyD/Zm6ExVXi3c9MiHEqn+oFR7ETfQXE8M=; b=e5RJGnpl7j6oc/4VSLR5nJVa9
        c/ZF/bgP61ILWcoNuoMDymxMTIaY07CGbTLk8z467Zxpmds5Zl3h1dVYOa3+WXeWBtICyinPLKZjL
        BbyV/m8R1Bk8SKx4Zwn94yh0LDPo9mYR0Sn87NuGb2m+ZgVXUJHSNbnME3Puy/eTG/FN2iNetIMl4
        6dfcSHPw5slwHAqBLI6MvvIhcLKKkT5Impu+AsoGl2oypNWehWymheAfsDpgmwX7PWGNxElNpQUMp
        rHSVEQtg0p8sQxtoJOyLqxXzvb2VFL/8qggqJ+ljjPX5t/To8kXKq0kulUN97RblP2CRgm22Sn5tJ
        H+y08PQBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlU4s-0002Nn-Nv; Thu, 11 Jul 2019 08:05:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7906120213043; Thu, 11 Jul 2019 10:05:17 +0200 (CEST)
Date:   Thu, 11 Jul 2019 10:05:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        luto@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
Subject: Re: [PATCH v2 6/7] x86/entry/64: Remove TRACE_IRQS_*_DEBUG
Message-ID: <20190711080517.GU3402@hirez.programming.kicks-ass.net>
References: <20190704195555.580363209@infradead.org>
 <20190704200050.591915266@infradead.org>
 <20190710232456.5f2de961@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710232456.5f2de961@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 11:24:56PM -0400, Steven Rostedt wrote:
> On Thu, 04 Jul 2019 21:56:01 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Since INT3/#BP no longer runs on an IST, this workaround is no longer
> > required.
> > 
> > Tested by running lockdep+ftrace as described in the initial commit:
> > 
> >   5963e317b1e9 ("ftrace/x86: Do not change stacks in DEBUG when calling lockdep")
> 
> It looks like a clean revert, and it passed my ftrace smoke tests with
> lockdep enabled (although I triggered a locked warning unrelated to
> this, with the text_mutex and module_mutex, but I'm hoping my tree has
> the fixes for that).
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks!

> Hmm, does this mean we can remove the IDT switching in the NMI handler
> as well?

I'll have to go look at that; there still are ISTs and NMIs can still
hit those.
