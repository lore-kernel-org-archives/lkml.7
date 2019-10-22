Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457FDCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5B520700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZh3QHiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbfJVNna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:43:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38660 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731408AbfJVNn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:43:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id o25so13403609qtr.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=65KxlUgC9dSPCPxluWGpG2Vl2DybtBrKpaxLtCDmHzc=;
        b=sZh3QHiWg0ErSkdchcq9C2bNHfaB9FFK1TxVvrTpcladz6F6MxvNFYgfj9igb1TMYi
         20N2iPQ7JIdvKsXYIPCra8KZvODJlp+v2xUSAfVyBo6b0s+8UzRGrFFv9lv/fX0KVqgm
         VP7vpiOze4N6BvhqkCnu6x8fAobTKNtR1QuAm+jA1aiBnLj5cHE78Npe46S2HytmuTPC
         uG2iNSTJIBm4nfiw1LxIq94TBbgUr5sD5kjAq3X5ihjenBsbd0xvxo5rqd+A+01k47eY
         jGMH1LSVy8+/Rhikeqc56iHpvhqNvTF1YAZZqg0rVPzvCkQjOAE7YlFnbknzCHpatDr2
         C6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=65KxlUgC9dSPCPxluWGpG2Vl2DybtBrKpaxLtCDmHzc=;
        b=DlPpj2pluqKGDtJUSXaure7/2cP7bf0fWo4hjvwb+wdMmTy0CuwXPJzJwgHtI/MeZ9
         EFibn3M1zu9fxyPjAFEM6/74fErag7QyC56Y7U1QyAVe1GSThUq/qyQbPhkB4BKOF7bC
         Qt5b7LGFcNie7KTFjn1GTwDPkgvbSYRAepjJU6r8GTEZe2oWbGlHUFpWcI4yvap2YssQ
         EE6EZ7wLTuW+JIvOSDLOpvKVBZtU2wDptkXNmplWaDpHM2uDW2+lEMWqaj7OJTdkjr8k
         br4CNJC1Njy4Z6caABXKThu6+IwHneDxLw62jVYEV2pUPEQWlcYRjWUkKnYs3FfeiqdJ
         Qy4w==
X-Gm-Message-State: APjAAAVAIqPfC8VPcsGedqdWJGNB6fm0HjI7iE5KkbrohyBmqtLJ7Gy4
        TmLh7Cx9qRL9vMm4nLMPp++3ZQ==
X-Google-Smtp-Source: APXvYqzCGQx5Type9/3R4qna/nTI9GQItYm4YhOPt3qdM0/D7iFzAiNaQAlIDY7dcqE9vYIXIEd0HA==
X-Received: by 2002:ac8:28e3:: with SMTP id j32mr3149168qtj.212.1571751808706;
        Tue, 22 Oct 2019 06:43:28 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id f10sm8191127qth.40.2019.10.22.06.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 06:43:26 -0700 (PDT)
Date:   Tue, 22 Oct 2019 21:43:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: perf/core] perf tests: Disable bp_signal testing for arm64
Message-ID: <20191022134308.GD32731@leoy-ThinkPad-X240s>
References: <20191018085531.6348-3-leo.yan@linaro.org>
 <157169993406.29376.12473771029179755767.tip-bot2@tip-bot2>
 <20191022131423.GA17920@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022131423.GA17920@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 02:14:25PM +0100, Will Deacon wrote:

[...]

> > diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> > index c1c2c13..166f411 100644
> > --- a/tools/perf/tests/bp_signal.c
> > +++ b/tools/perf/tests/bp_signal.c
> > @@ -49,14 +49,6 @@ asm (
> >  	"__test_function:\n"
> >  	"incq (%rdi)\n"
> >  	"ret\n");
> > -#elif defined (__aarch64__)
> > -extern void __test_function(volatile long *ptr);
> > -asm (
> > -	".globl __test_function\n"
> > -	"__test_function:\n"
> > -	"str x30, [x0]\n"
> > -	"ret\n");
> > -
> >  #else
> >  static void __test_function(volatile long *ptr)
> >  {
> > @@ -302,10 +294,15 @@ bool test__bp_signal_is_supported(void)
> >  	 * stepping into the SIGIO handler and getting stuck on the
> >  	 * breakpointed instruction.
> >  	 *
> > +	 * Since arm64 has the same issue with arm for the single-step
> > +	 * handling, this case also gets suck on the breakpointed
> > +	 * instruction.
> 
> Freudian slip?

:D  sorry for typo: s/suck/stuck.

Thanks for review and will send a patch to fix it.

Thanks,
Leo Yan
