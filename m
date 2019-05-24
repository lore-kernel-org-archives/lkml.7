Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A82C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D59D21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N86Ag8yF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390900AbfEXLMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:12:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48532 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390535AbfEXLMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nZrEddtZN/QHm9VyiIK9Xeruw6OpbBwJb1qEWWfnmO4=; b=N86Ag8yFfzsqZ0IGfLtN6IkfL
        54F3ZotahoxB4fxDv0QfhwAOxp5DUfxTvNImbMNy8mTBKs7qr24E0AJSfXcLeYiQA8Pvl/rGkFVXB
        icvBo+mm6QfoCUWMM7O8unEQ2Kv7Ad+H7h7UgrsxYq3DS16Cse1PHuQ8Js9ACRwq+ePdWbd+KuRG1
        +lF8ICbdENcWyJT5Kj7OdT/kSOWFHnEuMttU+XShoTwinT5QQRc5HSN9Dqn/XPGhtnxz4AIyrMeaI
        OYp4f4cafmX3icLEPSAOotYQH3ea8DI7yXz039spII0wwfnpsLfsc7pSKl41SJdWo7iALY7WjRDpC
        pIApS6Yzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hU86z-000851-TZ; Fri, 24 May 2019 11:11:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 48B8520281C32; Fri, 24 May 2019 13:11:44 +0200 (CEST)
Date:   Fri, 24 May 2019 13:11:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC][PATCH 01/14 v2] function_graph: Convert ret_stack to a
 series of longs
Message-ID: <20190524111144.GI2589@hirez.programming.kicks-ass.net>
References: <20190520142001.270067280@goodmis.org>
 <20190520142156.704372433@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520142156.704372433@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:20:02AM -0400, Steven Rostedt wrote:

> +#define FGRAPH_RET_SIZE (sizeof(struct ftrace_ret_stack))
> +#define FGRAPH_RET_INDEX (ALIGN(FGRAPH_RET_SIZE, sizeof(long)) / sizeof(long))

I think you want to write that like:

	BUILD_BUG_ON(sizeof(ftrace_ret_stack) % sizeof(long));

It'd be very weird for that sizeof not to be right.

> +#define SHADOW_STACK_SIZE (PAGE_SIZE)

Do we really need that big a shadow stack?

> +#define SHADOW_STACK_INDEX			\
> +	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
> +/* Leave on a buffer at the end */
> +#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
> +
> +#define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
> +#define RET_STACK_INC(c) ({ c += FGRAPH_RET_INDEX; })
> +#define RET_STACK_DEC(c) ({ c -= FGRAPH_RET_INDEX; })

I'm thinking something like:

#define RET_PUSH(s, val)				\
do {							\
	(s) -= sizeof(val);				\
	(typeof(val) *)(s) = val;			\
} while (0)

#define RET_POP(s, type)				\
({							\
	type *__ptr = (void *)(s);			\
	(s) += sizeof(type);				\
	*__ptr;						\
})

Would me clearer?
