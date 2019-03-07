Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64042C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3485C20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fYymUQHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfCGRne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:43:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCGRne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uDq5zG4p39D8f4hJpki+ohJYfTg22afpUWbht5ITcqQ=; b=fYymUQHGX3fy/87Q1oBPhxgCI
        ki4UvMXWueM4FauNvLkprVKIjqaE7DY1+qSRwA342rMLrYn6gBHAUtxXt2O2k6Z4XOPi/+y/DSZP2
        QTHmqapc4IpAOL7+SsgXYoOGheMvEyJLXas7I+sMku8jE+BHicKodIoaooPwmJgU2Ig0BVgM2h0Uw
        3gC+ykRm3ztzewADxrWjiPNisokFlL/l6RmQiDYH76DWxZQd6gR8JbJGH/7/y5mEEHXGt77rJI/Ev
        1yoAesGjns6Yw0jSMJQw2Jf2KSi4H37WZMkyTY6RkW9lmSJzFngjAS7bFFfAOz2k5ltv1XuLpWYaS
        NL+HYwrvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1x3E-00049f-8k; Thu, 07 Mar 2019 17:43:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB07E2029B186; Thu,  7 Mar 2019 18:43:22 +0100 (CET)
Date:   Thu, 7 Mar 2019 18:43:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
Message-ID: <20190307174322.GK32477@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307120317.GD32477@hirez.programming.kicks-ass.net>
 <20190307125526.GB32534@hirez.programming.kicks-ass.net>
 <20190307131312.GC32534@hirez.programming.kicks-ass.net>
 <20190307164705.qbu4ytdfdmsighas@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307164705.qbu4ytdfdmsighas@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:47:05AM -0600, Josh Poimboeuf wrote:

> This "fixes" it, and also seems to help -Os make much code:
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 445348facea9..8de63db58fdd 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -67,7 +67,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  				.line = __LINE__,			\
>  			};						\
>  		______r = !!(cond);					\
> -		______f.miss_hit[______r]++;					\
> +		if (______r) ______f.miss_hit[1]++; else ______f.miss_hit[0]++; \
>  		______r;						\
>  	}))
>  #endif /* CONFIG_PROFILE_ALL_BRANCHES */

Excellen; let me put the kids to bed and then I'll have a poke.
