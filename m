Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAD2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F8C20659
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lGo8GOy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632746AbfJRIU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:20:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34876 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395519AbfJRIU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jBCOpRwa39BQ6uD9AOxTn4qOOmYrnoZ3gcFRI3cGQs4=; b=lGo8GOy5fjZWHsAZB76O2/TqN
        H8GElbvSyuGoAa4M0GYoNtHHe+gYc200X4G7y5pkDUpTI1ug/13vL+zyOExqv3EdfzOefjkDe1NUL
        2nU6uGG5eIyf9xc5uroByRVTY3YPwR7Yaa9eldj0GofuhN5hrjqVX9br6xTtTLZVEQZ5kH07uyrww
        2HXOjT3VfJf91WS8csEkpg4+42JkI09lT3nakrZMl0IAcdqVQj/XOt0cfHvoOM76VJrQTSqaDA2ym
        ydJe+J2zgeyNQZAEEF0TgX9FgKbtO7DdWriQKeTsdGW8AKOtvJMcADhE7mhwQ2Asof2vzyfjBfp3U
        qC2M0FInw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLNV2-0008Mb-9Q; Fri, 18 Oct 2019 08:20:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2163C3032F8;
        Fri, 18 Oct 2019 10:19:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC16F200DE9FA; Fri, 18 Oct 2019 10:20:37 +0200 (CEST)
Date:   Fri, 18 Oct 2019 10:20:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 16/16] ftrace: Merge ftrace_module_{init,enable}()
Message-ID: <20191018082037.GF2328@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.858645375@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018074634.858645375@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 09:35:41AM +0200, Peter Zijlstra wrote:
> Because of how some architectures used set_all_modules_text_*() there
> was a dependency between the module state and its memory protection
> state. This then required ftrace to be split into two functions, see
> commit:
> 
>   a949ae560a51 ("ftrace/module: Hardcode ftrace_module_init() call into load_module()")
> 
> Now that set_all_modules_text_*() is dead and burried, this is no
> longer relevant and we can merge the ftrace_module hooks again.

NOTE that by also getting rid of the ftrace_arch_code_modify_prepare() /
ftrace_arch_code_modify_post_process() callbacks in the
ftrace_module_enable() callback, both x86 and ARM will use direct poking
instead of doing the alias thing.

