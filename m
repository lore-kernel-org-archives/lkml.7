Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4675ECA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 06:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045E620862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 06:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QbiM/OtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfKBGLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 02:11:39 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41363 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKBGLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 02:11:39 -0400
Received: by mail-yb1-f193.google.com with SMTP id b2so5398441ybr.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 23:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mjOrQcYKLW2930x7QuK0UD/Ug/m/wLd6/vzT6tFMVg0=;
        b=QbiM/OtBQBsVGjrINfMco5zXT8ZDez2zNcAZRW+8hDnrU017iIVmeCfe8+88eWgEa4
         cAYabisKmvnihBEjbnsMEMxJoJBYpnS6XpZSG6j+Ra4RNm6BxAcvCjpTL5VGeFMlccXK
         gR2cgWCTOFZOEmb2aW9+xV7aXL0uC4xQdeb1+6RLJcFe2FaQ3j6dVwAyoWNk1UoVD99H
         eMqKHqgdjzHTDnxhT2mcl4xyXBFnujxKq0FlIAcO5uNldCXlsXO5BX2g0gZEO7+Zuj7q
         K1p8jCTlwzzZBgi+fxSmYPAlTQ4rz5AygRNCr8cYQgzUaWF+8JDIYBHPyg0gZAv7HEl2
         NC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mjOrQcYKLW2930x7QuK0UD/Ug/m/wLd6/vzT6tFMVg0=;
        b=ocJ8jQzKLe7njWgxp4OIFb0rnAlmBaU+vgn0asre/A5nA8WHnwu+MUCJsTpQdaTTmh
         OoDvU8NAHN7LisJWdlNZhYDUFCKUdR58/rzLUjozzBTpLW5u3IKDBEd6dNrkph3qHM2t
         2ZhTHiwRfB1TjSUV+YLhzfVFi33CHAms+YS3xt3o4YxPOtP3tP0n8opSiPeFkDYCAXxH
         PkqDur5otyKc9TwBC/ExW2d4i3DouNQThQlfes6CS3ruMHO94qQowafmtvJ+pM+B0cDO
         /D1klX14ka7Nvns1znGu2N9bgTDE/NMZnaqyp2uO4Lfod8dsrPLMyI5YXOhGL1+N/m9x
         7Pbg==
X-Gm-Message-State: APjAAAUfSzO1UGWqJ0HDEY5X4oEWbcuTvSxNE01krMGU9jO6Iurwtcz7
        n/wsFZRC9AphrpUEbJJQbYAXQg==
X-Google-Smtp-Source: APXvYqxQAHaNExjSPjK0OQY1oZaTxr6QlVF2NqjriATi9ryeAv5RZRe9aIdkwtMvDHW211RNbxih7Q==
X-Received: by 2002:a5b:f11:: with SMTP id x17mr390973ybr.430.1572675098338;
        Fri, 01 Nov 2019 23:11:38 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id u205sm2583186ywa.65.2019.11.01.23.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 23:11:37 -0700 (PDT)
Date:   Sat, 2 Nov 2019 14:11:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Robert Walker <robert.walker@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v2 1/4] perf cs-etm: Continuously record last branches
Message-ID: <20191102061128.GB26019@leoy-ThinkPad-X240s>
References: <20191101020750.29063-1-leo.yan@linaro.org>
 <20191101020750.29063-2-leo.yan@linaro.org>
 <3dd30190-b266-826d-3e2d-91f1446cc5fc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dd30190-b266-826d-3e2d-91f1446cc5fc@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Nov 01, 2019 at 03:30:19PM +0000, Robert Walker wrote:
> On 01/11/2019 02:07, Leo Yan wrote:
> > Every time synthesize instruction sample, the last branches recording
> > will be reset.  This would be fine if the instruction period is big
> > enough, for example if we use the option '--itrace=i100000', the last
> > branch array is reset for every instruction sample (10000 instructions
> > per period); before generate the next instruction sample, there has the
> > enough packets coming to fill last branch array.  On the other hand,
> > if set a very small period, the packets will be significantly reduced
> > between two continuous instruction samples, thus if the last branch
> > array is reset for the previous instruction sample, it's almost empty
> > for the next instruction sample.
> > 
> > To allow the last branches to work for any instruction periods, this
> > patch avoids to reset the last branches for every instruction sample
> > and only reset it when flush the trace data.  The last branches will
> > be reset only for two cases, one is for trace starting, another case
> > is for discontinuous trace; thus it can continuously record last
> > branches.
> 
> Is this the right thing to do?

Thanks for reviewing and bringing up the questions.  To be honest, my
concern was mainly related with AudoFDO but I don't aware other
potential issues.  So any concern is welcome, in case I miss anything;
hope we can get conclusion with some dicussion.  Please see more
detailed explanation in below.

> This would cause profiling tools to count
> the same branch several times if it appears in multiple instruction samples,
> which could result in a biased profile.

Let's clarify for this.  Firstly, here the 'branch' doesn't refer to
'branch' sample, it means the last branch recording for instruction
samples.  So basically, neither instruction sample nor branch sample
will be changed with this patch.

This patch tries to fix the issue as below:

Before this patch:

  ffff800010083580 <el0_sync>:
  ffff800010083580:  stp     x0, x1, [sp]         -> synthesize instruction sample(n),
                                                     record the last branch,
                                                     reset the last branch.
  ffff800010083584:  stp     x2, x3, [sp,#16]
  ffff800010083588:  stp     x4, x5, [sp,#32]     -> synthesize instruction sample(n+1),
                                                     the last branch is empty which is
                                                     reset by the instructiom sample(n).
  ffff80001008358c:  stp     x6, x7, [sp,#48]
  ffff800010083590:  stp     x8, x9, [sp,#64]     -> synthesize instruction sample(n+2),
                                                     the last branch is empty which is
                                                     reset by the instructiom sample(n).
  [...]


After this patch:

  ffff800010083580 <el0_sync>:
  ffff800010083580:  stp     x0, x1, [sp]         -> synthesize instruction sample(n),
                                                     record the last branch.
  ffff800010083584:  stp     x2, x3, [sp,#16]
  ffff800010083588:  stp     x4, x5, [sp,#32]     -> synthesize instruction sample(n+1),
                                                     record the last branch.
  ffff80001008358c:  stp     x6, x7, [sp,#48]
  ffff800010083590:  stp     x8, x9, [sp,#64]     -> synthesize instruction sample(n+2),
                                                     record the last branch.
  [...]


So from my understanding, the last branch recording works as the
affiliate info for instruction samples and it allows us (or tools) to
know what's the execution flow for the instruction samples.  Seems to
me, it doesn't change value for instruction sample, but we can have
correct info of the last branch recording for every instruction samples.

> The current implementation matches the behavior of intel_pt where the branch
> buffer is reset after each sample, so  the instruction sample only includes
> branches since the previous sample.

Exactly.

@Adrian, it would be nice if you could confirm intel_pt should apply
the samiliar fixing or not?

> However x86 lbr (perf record -b) does appear to repeat the same full branch
> stack on several samples until a new stack is captured.
> 
> I'm not sure what the right or wrong answer is here.  For AutoFDO, we're
> likely to use a much bigger period (>10000 instructions) so won't be
> affected, but other tools might be.

Agree, if AutoFDO uses big period (e.g. --itrace=i10000), this patch
will not change anything.  With big period, it has enough packets to
generate branch recording between two instruction samples.

Could you elaborate what's 'other tools'?  If it's open sourced tool,
I can try to test with this patch set.

Thanks,
Leo Yan
