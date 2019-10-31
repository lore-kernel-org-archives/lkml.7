Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367E7CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A019208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MAlgB0uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfJaRO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 13:14:27 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41862 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfJaRO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:14:27 -0400
Received: by mail-il1-f193.google.com with SMTP id z10so6049722ilo.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/oQbUrLxzCFxSXaMBW51XHkJmtd4pn/y99rXYOWrkw=;
        b=MAlgB0uBqzuhtFTfYmLyMxFFpONdoI5/VWbG2WlqRhIbxtoHyINwTblMx5ZJl++Q1n
         GLyXlK0maDw4a14GrRsGiv0loH3883wNDvMgaCbHz5BOm3Az5FjdwMsL6Gj97rfpoHoK
         /Z30ThzxPpBT+nsheY4LRR0KPtJ0MYgWPUgW9uU12inuCfLdBjLYNFjeL6K6IfZB+Gcv
         G9IjBqmA0aM7pe18CuWUk6X3WihR1OxQsK3T4+LlBvSRr6YHNuYEqYANbBcW9NwQF/64
         cacbSJiLaffDMs/hRowxOuQSDaHedLDPhR4Nby7PKXqR/dOzhL6xpionBwirVT/gK3ek
         wLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/oQbUrLxzCFxSXaMBW51XHkJmtd4pn/y99rXYOWrkw=;
        b=k6WmiH53buUmXnO0/+DtFhODLvXgsPvNZPledIZ8vlhY5adNtAkyN6PwdEayIIonaY
         WMAtbK9Pt1noKisc0ZnwwLnFLNGc+p3NhVHu9v+JJAhnXjXnd4jPNGYfqegDbrpYzB29
         FH+g5kzMhU5+6JnMjXniCn3Ee1WhJAPccDWuvTjQv7+UPE+4/kqtsJ79o4RjN4qK6HS/
         l/tmJ5Qaqs4uoPPgoZXsKdLvbKDLP0kLR786hrfqG4DnLw2flVUNnrtEOK2YElF0g8li
         4eI03+nJwFgrU4Tn1NfMg0KcRYagPmtdwOC+gDWoIzBNv6RApXlLTHAd1wQyR6ign8fr
         YH2g==
X-Gm-Message-State: APjAAAU6phXpv/g1ZMpA/e3MhKmY7m2+7nJN24VwNoKFc1dNttyxGQoX
        SYUas7k3ChJIWacmY5J0DdNi10jugrE0oCnZobPnww==
X-Google-Smtp-Source: APXvYqze3SlsQZNFScaS5sJPjKwOg8mZYClWIkEjiqcbU0pp4edztHY6mx36sdZdgZaf7Cy9UzY//sBKr4k79oSg1xI=
X-Received: by 2002:a92:1907:: with SMTP id 7mr7540052ilz.72.1572542066045;
 Thu, 31 Oct 2019 10:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191024151325.28623-1-leo.yan@linaro.org>
In-Reply-To: <20191024151325.28623-1-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 31 Oct 2019 11:14:15 -0600
Message-ID: <CANLsYkzaB2kU20ibuDJVokYeEEuR8wd7MoHzX9+UKnM0jNV1Jg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] perf cs-etm: Fix synthesizing instruction samples
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Robert Walker <robert.walker@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 at 09:15, Leo Yan <leo.yan@linaro.org> wrote:
>
> This patch series is to address the issue for synthesizing instruction
> samples, especially when the instruction sample period is small enough,
> the current logic cannot synthesize multiple instruction samples within
> one instruction range packet.
>
> To fix this issue, patch 0001 avoids to reset the last branches for
> every instruction sample; if reset the last branches when every time
> generate instruction sample, then the later samples in the same range
> packet cannot use the last branches anymore.
>
> Patch 0002 is the main patch to fix the logic for synthesizing
> instruction samples; it allows to handle different instruction periods.
>
> Patch 0003 is an optimization for copying last branches; it only copies
> last branches once if the instruction samples share the same last
> branches.
>
> Patch 0004 is a minor fix for unsigned variable comparison to zero.
>
> To verify my changing for synthesizing instruction samples, I added
> some logs in the code, and reviewed the output log manually for
> instuctions samples.  The below commands are tested on DB410c board:
>
>   # perf script --itrace=i2
>   # perf script --itrace=i2li16
>   # perf inject --itrace=i2il16 -i perf.data -o perf.data.new
>   # perf inject --itrace=i100il16 -i perf.data -o perf.data.new
>
>
> Leo Yan (4):
>   perf cs-etm: Continuously record last branches
>   perf cs-etm: Correct synthesizing instruction samples
>   perf cs-etm: Optimize copying last branches
>   perf cs-etm: Fix unsigned variable comparison to zero

I have reviewed and agree with the changes in this set but won't move
forward until Mike has looked at patch 2/4.

Thanks,
Mathieu

>
>  tools/perf/util/cs-etm.c | 137 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 115 insertions(+), 22 deletions(-)
>
> --
> 2.17.1
>
