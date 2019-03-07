Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869082064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jal32ZZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfCGRlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:41:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54702 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCGRly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5NFwPc6UCvFA0j2D0XVt1B4Q0/2B+HiX3ycSiYAbn5A=; b=jal32ZZEq9Nd4jormQvW4J7AQ
        aBaNjhGEtOlHgev5qup52MyzcyurDKPYfCaEyowJIUS9PQfsg8mNEZ4szqHLMk/wzMPJ51qbH9cqD
        WRghGSTo1unneSduojeTTXxTufdCTsGDm9kS8o8uMIKfDTNe/m9qKGookzbm6mjJ+6ZI/Ggk2ZE9V
        /czCY1PmnX5W4+oRQ4cefDu7BHEYQxLAiKFlJSlsrc2tNXwi20m5g0XNkB1FwPZXZ8q9TDP1lCb7k
        2rdBliumNinQ2wYIQTuVyKjstnqbJZ0OaLBHc0ZlR9gvs39Rd2eLY0afuWF4PQCy5Qs55lB1bbgH/
        h9/T/6Rlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1x1V-0008Om-E5; Thu, 07 Mar 2019 17:41:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57FBD2029B186; Thu,  7 Mar 2019 18:41:35 +0100 (CET)
Date:   Thu, 7 Mar 2019 18:41:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
Message-ID: <20190307174135.GJ32477@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 08:33:26AM -0800, Linus Torvalds wrote:
> On Thu, Mar 7, 2019 at 3:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > XXX: are we sure we want __memset marked AC-safe?
> 
> It's certainly one of the safer functions to call with AC set, but it
> sounds wrong anyway. It's not like it's likely to leak kernel data
> (most memset's are with 0, and even the non-zero ones I can't imagine
> are sensitive - more like poison values etc).
> 
> What's the call site that made you go "just add __memset() to the list"?

__asan_{,un}poinson_stack_memory()
  kasan_{,un}poison_shadow()
    __memset()


