Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DB1C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2F6218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="taHtVk2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfGCIRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:17:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40353 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfGCIRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:17:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id e8so1435507otl.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 01:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KbUJk2ldtGkFXbb/hUiSZglrGE0E+zl75r+apGMwxXc=;
        b=taHtVk2prlLVdkCLv7izJLUW8aglmKjNUhvyHAfVNVSnYnAW3untkvdgmFWHmoiuwi
         uQ8enVGVbsPu+lIBQi6hrm2Au6jS5v209ePxq8WxNT16IrRx4heT1SvAS+fgiHDSZWGp
         7eFBC72rZ19FCVg7ZYwIBT8Ck8L5IhR/+dLEk/3fq5F50Bm5Cp0labne5B2MNjOmdkHc
         bzdQNCIZCMNySeqcr+VsOB9MkTA6+T36eeEAVvhXXf/hmU4lNZGVKVt74Ar8obEX9bS+
         cdAIhdpiL5/KzW1J9yHW1xqM8vM340ZZYmRcSXGMjRROIQw645spS05tc0xGNMfN9wFd
         AOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KbUJk2ldtGkFXbb/hUiSZglrGE0E+zl75r+apGMwxXc=;
        b=G+63Ch+HSWGgPS4BDdpKR1AnAyZpUcEY+OVySylHIS149pkwUWi0ii8Ae7W9oe11GA
         chRL/nw4olL+Fr9jrgDU8qTi+hy22aWjBEeDXP2AbbdUUsD1ipbP8B5QcrILGRpXN4ly
         cuuSm3VyigJGFNP4M9wED6yKdtF/z3qKOUeZy/Jprg+kKgjRJqfAjOdP/HoqMali6EnK
         I3lVysEZ3y7ijE0MJRAATxsD+yNsJHCVq4uuT2r20ulniopCt5411KMQSJjx+8fl187r
         7Pqz1dmXVEPD9p7CxGN1rOCoMQEqImBINHYFa0j8YGDE6g3ABxN4ngfJJpA94nkx2g5L
         kGWA==
X-Gm-Message-State: APjAAAWG6RMroRPyCM2HC4VVKa6D3lGuYleec39DqHcz+I016BxS1St9
        7oUAjJPUUD1Z7+iOE8Kcp+l9Lg==
X-Google-Smtp-Source: APXvYqx99yi1XCUO1gr95zNH/ZhvnymqBxz9z0Odjb8hu2+hmpd3LCWQlN/dWNdu5Dn+13anYfM4hA==
X-Received: by 2002:a9d:1718:: with SMTP id i24mr26800741ota.269.1562141831330;
        Wed, 03 Jul 2019 01:17:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id d200sm554816oih.26.2019.07.03.01.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 01:17:10 -0700 (PDT)
Date:   Wed, 3 Jul 2019 16:16:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 10/11] perf intel-pt: Smatch: Fix potential NULL
 pointer dereference
Message-ID: <20190703081657.GD6852@leoy-ThinkPad-X240s>
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702103420.27540-11-leo.yan@linaro.org>
 <cfef1777-141e-4223-e0c1-1a3f3aee1d3c@intel.com>
 <20190703013553.GB6852@leoy-ThinkPad-X240s>
 <b65cf4c6-3484-85c8-d191-35021ed6ed3e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b65cf4c6-3484-85c8-d191-35021ed6ed3e@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 08:19:19AM +0300, Adrian Hunter wrote:
> On 3/07/19 4:35 AM, Leo Yan wrote:
> > Hi Adrian,
> > 
> > On Tue, Jul 02, 2019 at 02:07:40PM +0300, Adrian Hunter wrote:
> >> On 2/07/19 1:34 PM, Leo Yan wrote:
> >>> Based on the following report from Smatch, fix the potential
> >>> NULL pointer dereference check.
> >>
> >> It never is NULL.  Remove the NULL test if you want:
> >>
> >> -	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> >> +	if (session->itrace_synth_opts->set) {
> >>
> >> But blindly making changes like below is questionable.
> > 
> > Thanks for suggestions.
> > 
> > I checked report and script commands, as you said, both command will
> > always set session->itrace_synth_opts.  For these two commands, we can
> > safely remove the NULL test.
> > 
> > Because perf tool contains many sub commands, so I don't have much
> > confidence it's very safe to remove the NULL test for all cases; e.g.
> > there have cases which will process aux trace buffer but without
> > itrace options; for this case, session->itrace_synth_opts might be NULL.
> > 
> > For either way (remove NULL test or keep NULL test), I don't want to
> > introduce regression and extra efforts by my patch.  So want to double
> > confirm with you for this :)
> 
> Yes, intel_pt_process_auxtrace_info() only gets called if a tool sets up the
> tools->auxtrace_info() callback.  The tools that do that also set
> session->itrace_synth_opts.

Yes.

I also checked the another case for 'perf inject', just as you said,
it sets both inject->tool.auxtrace_info and session->itrace_synth_opts
if we use 'itrace' option.  So it's safe to remove the NULL test for
session->itrace_synth_opts.

Will follow your suggestion for new patches.  Thanks a lot for
confirmation and suggestions.

Thanks,
Leo Yan
