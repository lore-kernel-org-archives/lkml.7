Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405B3C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E73222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8zghAh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgABLoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 06:44:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32999 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgABLon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:44:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13so17737049pls.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 03:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6U2yJYk127ctRg14NrrsWVwD7Ngw7Y1GqOGpRYJgEGc=;
        b=E8zghAh2PE5ehvIUHLP0Qg6ieDIO7TTL5zfyeV54/6bQRwjp8NB2sGI1DQOxVAS+Ix
         QDf7kxl3MU4tAbj8XQWZkRE4RbOw+DjkQJ+aizH5uAMXBMp87Fz444fH9gSlCBTuP24j
         TX5b3feIFtaTA9779g8eMb1JGEQECqutRlJ53aijYq/aXcOoqKnImrKZIVyg0KDxZpUP
         SRVcwEyu53a5L5tSaeh6pGydm1UfM3OlDBMKjbyIDPSbLl53QmV4PrVbtHHs+4Kz+IFF
         0bzmKcCvw0H4dPboEGgdfsk4VZLFId4Vy6LtCSa7nHKKGkwRljFU5jkGOMCdCBXvPgQJ
         LHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6U2yJYk127ctRg14NrrsWVwD7Ngw7Y1GqOGpRYJgEGc=;
        b=pPlQwCNPj1uJgX+eF0D1qCDMJc2pI9bSTQ2BsjqwHtuOgrtm+Mr1jWETxcZ6sWbADu
         yxNTvMpmVgFX7QCbSvZsmZrvqsoEgsloBHm1MuCpVDw9h2LODl05HSTBgH2AGjC8CV4T
         E4OEkItDbKfTZ1OKeKcnL4nQSTfzO5gYrWc6x5tV34BfXNZBIAHd9R+yMBnV6KRXEN2x
         N8LQza8gvKKF8OA16e8r77+41WscAms/oGIi6yRe8veOJEdjlxfZ4+mUVVzLfABd41c9
         pxLXlz12cCobdWJ3cJF2cn7B8kf/J89MJkcaVswMoTPkrWuI0lBr1tD0XrDPMFM95Ze7
         90zw==
X-Gm-Message-State: APjAAAXesoT2NimIoRtl62q61zgBxFSlHoS+FkxEqO9JuCECoZR5f3uG
        kq999XKsRujxMDFVbDBe+EDGww==
X-Google-Smtp-Source: APXvYqyd62pDIPVU9OWE0J0j3OtsA7m0DozWf3Cz4xsUqgy8dizFBO8YAI2snX+te7YlhTgliLzuXw==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24mr84502335plp.300.1577965482895;
        Thu, 02 Jan 2020 03:44:42 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id o31sm59523934pgb.56.2020.01.02.03.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jan 2020 03:44:42 -0800 (PST)
Date:   Thu, 2 Jan 2020 19:44:33 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <James.Clark@arm.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Igor Lubashev <ilubashe@akamai.com>
Subject: Re: [PATCH] perf tools: Fix bug when recording SPE and non SPE events
Message-ID: <20200102114433.GA18709@leoy-ThinkPad-X240s>
References: <20191220110525.30131-1-james.clark@arm.com>
 <20191223034852.GB3981@leoy-ThinkPad-X240s>
 <591d2827-55f7-130d-ab43-2a6bd715fe5e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <591d2827-55f7-130d-ab43-2a6bd715fe5e@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Jan 02, 2020 at 11:05:53AM +0000, James Clark wrote:
> Hi Leo,
> 
> Do you mean that you would never expect there to be more than one SPE file like /sys/bus/event_source/devices/arm_spe_0?

Yeah.

To be more accurate, I'd suggest to be only one SPE file if CPUs have
the same SPE version.  If there have multiple SPE files under
'/sys/bus/event_source/devices/', this means the CPUs have different
SPE versions

Let's see an example for SMP platform with 4xCA53 CPUs:
/sys/bus/event_source/devices/armv8_cortex_a53

For big.LITTLE system, we can see below nodes:
/sys/bus/event_source/devices/armv8_cortex_a53
/sys/bus/event_source/devices/armv8_cortex_a72

If SPE has the same IP for all CPUs, this would be simple to only
create on file under /sys/bus/event_source/devices/.

> If that is the case then do you know why there is still a number appended to the file?

This is caused by the code [1].  But I don't know what's the reason
for adding index to PMU event name.

Thanks,
Leo Yan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.5-rc4#n911

> On 23/12/2019 03:48, Leo Yan wrote:
> > Hi James,
> > 
> > On Fri, Dec 20, 2019 at 11:05:25AM +0000, James Clark wrote:
> >> This patch fixes an issue when non Arm SPE events are specified after an
> >> Arm SPE event. In that case, perf will exit with an error code and not
> >> produce a record file. This is because a loop index is used to store the
> >> location of the relevant Arm SPE PMU, but if non SPE PMUs follow, that
> >> index will be overwritten. Fix this issue by saving the PMU into a
> >> variable instead of using the index, and also add an error message.
> >>
> >> Before the fix:
> >>     ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
> >>     237
> >>
> >> After the fix:
> >>     ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
> >>     ...
> >>     0
> > 
> > Just bring up a question related with PMU event registration.  Let's
> > see the DT binding in arch/arm64/boot/dts/arm/fvp-base-revc.dts:
> > 
> >          spe-pmu {
> >                  compatible = "arm,statistical-profiling-extension-v1";
> >                  interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> >          };
> > 
> > 
> > Now SPE registers PMU event for every CPU; seem to me, though SPE is an
> > IP binding per CPU, it should register into perf framework with single
> > pmu event, ARM's PMU/ETM/IntelPT all use this way to regsiter PMU event;
> > this can allow perf tool logic to be more neat.
> > 
> > After the driver changes to use single PMU registration, the perf tool
> > code can be changed to use simple way to find perf_pmu and this data
> > structure can be not bound to a specific CPU.  Finally, this bug can
> > be smoothly dismissed.
> > 
> > Thanks,
> > Leo
> > 
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Cc: Jiri Olsa <jolsa@redhat.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> Cc: Igor Lubashev <ilubashe@akamai.com>
> >> ---
> >>  tools/perf/arch/arm/util/auxtrace.c  | 10 +++++-----
> >>  tools/perf/arch/arm64/util/arm-spe.c |  1 +
> >>  2 files changed, 6 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> >> index 0a6e75b8777a..230f03b622e1 100644
> >> --- a/tools/perf/arch/arm/util/auxtrace.c
> >> +++ b/tools/perf/arch/arm/util/auxtrace.c
> >> @@ -54,9 +54,9 @@ struct auxtrace_record
> >>  *auxtrace_record__init(struct evlist *evlist, int *err)
> >>  {
> >>  	struct perf_pmu	*cs_etm_pmu;
> >> +	struct perf_pmu *arm_spe_pmu = NULL;
> >>  	struct evsel *evsel;
> >>  	bool found_etm = false;
> >> -	bool found_spe = false;
> >>  	static struct perf_pmu **arm_spe_pmus = NULL;
> >>  	static int nr_spes = 0;
> >>  	int i = 0;
> >> @@ -79,13 +79,13 @@ struct auxtrace_record
> >>  
> >>  		for (i = 0; i < nr_spes; i++) {
> >>  			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
> >> -				found_spe = true;
> >> +				arm_spe_pmu = arm_spe_pmus[i];
> >>  				break;
> >>  			}
> >>  		}
> >>  	}
> >>  
> >> -	if (found_etm && found_spe) {
> >> +	if (found_etm && arm_spe_pmu) {
> >>  		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
> >>  		*err = -EOPNOTSUPP;
> >>  		return NULL;
> >> @@ -95,8 +95,8 @@ struct auxtrace_record
> >>  		return cs_etm_record_init(err);
> >>  
> >>  #if defined(__aarch64__)
> >> -	if (found_spe)
> >> -		return arm_spe_recording_init(err, arm_spe_pmus[i]);
> >> +	if (arm_spe_pmu)
> >> +		return arm_spe_recording_init(err, arm_spe_pmu);
> >>  #endif
> >>  
> >>  	/*
> >> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> >> index eba6541ec0f1..b7d17d8724df 100644
> >> --- a/tools/perf/arch/arm64/util/arm-spe.c
> >> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> >> @@ -178,6 +178,7 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
> >>  	struct arm_spe_recording *sper;
> >>  
> >>  	if (!arm_spe_pmu) {
> >> +		pr_err("Attempted to initialise null SPE PMU\n");
> >>  		*err = -ENODEV;
> >>  		return NULL;
> >>  	}
> >> -- 
> >> 2.24.0
> >>
