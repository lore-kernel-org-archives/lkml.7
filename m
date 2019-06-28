Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09195C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAD12177B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561729484;
	bh=+0zLeWQKdKrT3YDep1cBSf2sRQS/dWfrS+5JDQ+En2Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=RUTZDk00QxypM3LHWNHEX9dLrNtc5CecfRQ1AGjJJnqMS5wEyQFTByl7tp2mgil5A
	 cAk/Ygcb58dNiGXzva+YJVAy+gpDyqh7+g5tUee++pALKYEgd3PTTsIlZEvZRBgyrS
	 jxXxdG11FVqmd5WLn9dJjZ+u1XnMHZ/PDSITMBp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfF1Non (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfF1Nom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:44:42 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 893BF20645;
        Fri, 28 Jun 2019 13:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561729481;
        bh=+0zLeWQKdKrT3YDep1cBSf2sRQS/dWfrS+5JDQ+En2Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HUXJk3hu/EvYyczTsPOuBzc1mTEOloYhiKYIScGmOtevKSzw8i7K1pIpe3ccU6r6P
         oJM8EbRaEHawjiWvkQ7ym+36/myztutVP19R63w47R4nFnbpORh3pzZUV7CzI1eGvt
         Sg2/z0Lh9Q1qw7oz9NiolJhPlxoeqCz9Trp6QQPE=
Message-ID: <1561729480.9333.10.camel@kernel.org>
Subject: Re: [PATCH 0/4] tracing: Improve error messages for histogram
 sorting
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 08:44:40 -0500
In-Reply-To: <20190628151645.a81b327d8e0d7c68d521b24e@kernel.org>
References: <cover.1561647046.git.zanussi@kernel.org>
         <20190628151645.a81b327d8e0d7c68d521b24e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, 2019-06-28 at 15:16 +0900, Masami Hiramatsu wrote:
> On Thu, 27 Jun 2019 10:35:15 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Hi,
> > 
> > These patches add some improvements for histogram sorting,
> > addressing
> > some shortcomings pointed out by Masami.
> > 
> > In order to address the specific problem pointed out by Masami, as
> > well as add additional related error messages, the first patch
> > does some simplification of assignment parsing.
> > 
> > The second patch actually adds the new error messages.
> > 
> > The fourth patch adds a new testcase for hist trigger parsing,
> > similar
> > to the same kind of tests for kprobes and uprobes.  Additional
> > tests
> > covering all possible hist trigger errors should/will be added here
> > in
> > the future.
> > 
> > The third patch just adds a missing hist: prefix to the error log
> > so
> > that the testcases work properly, and which should have been there
> > anyway.
> > 
> > Thanks,
> 
> 
> Hi Tom,
> 
> These patches look good to me :)
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> for all patches. BTW, if you think there is a bug and the 1st one
> fixes it,
> please add Fixes: tag.
> 

Yeah, I'll submit a v2 that adds that.

Thanks for the review,

Tom


> Thank you,
> > 
> > Tom
> > 
> > The following changes since commit
> > a124692b698b00026a58d89831ceda2331b2e1d0:
> > 
> >   ftrace: Enable trampoline when rec count returns back to one
> > (2019-05-25 23:04:43 -0400)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-
> > trace.git ftrace-hist-sort-err-msgs-v1
> > 
> > Tom Zanussi (4):
> >   tracing: Simplify assignment parsing for hist triggers
> >   tracing: Add hist trigger error messages for sort specification
> >   tracing: Add 'hist:' to hist trigger error log error string
> >   tracing: Add new testcases for hist trigger parsing errors
> > 
> >  kernel/trace/trace_events_hist.c                   | 94
> > +++++++++++-----------
> >  .../test.d/trigger/trigger-hist-syntax-errors.tc   | 32 ++++++++
> >  2 files changed, 78 insertions(+), 48 deletions(-)
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-
> > errors.tc
> > 
> > -- 
> > 2.14.1
> > 
> 
> 
