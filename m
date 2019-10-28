Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC66FCA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A1D208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572281287;
	bh=bbAcMWRdFqGrmy2OuA3CTz7sLtDh6gOvZ+wqs7mptqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dmg/lRQ81A8LSgaBqCtUbinfZRN3NfzCANtfQWmkNtvb/Ho8YMMATZYbEHpnf5bzz
	 14La+6E0JczFqwvT/aQraAX2MFoRaQUodHf4rVBkfyMwkPu2itVmaYVR5osrUWDt1e
	 Gj5UbtOIytlAjVGlZYWXuPWCiI73sQd9UjQq6KlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403889AbfJ1QsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403879AbfJ1QsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:48:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5395921744;
        Mon, 28 Oct 2019 16:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572281285;
        bh=bbAcMWRdFqGrmy2OuA3CTz7sLtDh6gOvZ+wqs7mptqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x4dioR8DAvAWhOCE0qby3MBEkKc9wMrAmJgXt1Q/vAGLgRN0MNBDHsqYcZ9KG8MjW
         UOsfENg19XlYbNruJmLyBGF3jRXMM019HEi/1H2vuhu/+fn939SldCEHukgCSb77qR
         ZjTp3x4Rjjqe4f4awXIyOJ6t85e48ShF1suaKSX4=
Date:   Mon, 28 Oct 2019 16:47:59 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        rabin@rab.in, Mark Rutland <mark.rutland@arm.com>,
        james.morse@arm.com
Subject: Re: [PATCH v4 13/16] arm/ftrace: Use __patch_text_real()
Message-ID: <20191028164758.GH5576@willie-the-truck>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.687479693@infradead.org>
 <20191028162525.GF5576@willie-the-truck>
 <20191028163421.GI4097@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028163421.GI4097@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 05:34:21PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 28, 2019 at 04:25:26PM +0000, Will Deacon wrote:
> > On Fri, Oct 18, 2019 at 09:35:38AM +0200, Peter Zijlstra wrote:
> > > @@ -97,10 +100,7 @@ static int ftrace_modify_code(unsigned l
> > >  			return -EINVAL;
> > >  	}
> > >  
> > > -	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
> > > -		return -EPERM;
> > > -
> > > -	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
> > > +	__patch_text_real((void *)pc, new, patch_text_remap);
> > 
> > Why can't you just pass 'true' for patch_text_remap? AFAICT, the only
> > time you want to pass false is during early boot when the text is
> > assumedly still writable without the fixmap.
> 
> Ah, it will also become true for module loading once we rework where we
> flip the module text RO,X. See this patch:
> 
>   https://lkml.kernel.org/r/20191018074634.858645375@infradead.org
> 
> But for that to land, there's still a few other issues to fix (KLP).

Passing 'true' would still work though, right? Just feels a bit error
prone having to maintain the state of patch_test_remap() and remember
that 'ftrace_lock' is holding the concurrency together.

Will
