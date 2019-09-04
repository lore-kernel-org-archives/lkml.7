Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14528C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56A522CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrwA+4vK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfIDI7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:59:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36855 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDI7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:59:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id o12so11946944qtf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 01:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jFVKdea45mJrNywU948vMYq5u5WRFPo01K8iIYZKsrw=;
        b=OrwA+4vKkCB9cklKzP5BVFlg4BG6lgl69PUYcGp5Pb5zditO/wJGwJljrVy1GIHLs2
         i8KYGCQ2pFe6T7LNzk2gleAPCJOhYY3jJE+0CVcnCJOVRWvimJbt4Pq7cdcU2rospPhh
         Ce2FnYU077ib318/G8aFjuNh7rkCLS0A9qHtTVi7PMiPx6Ouhqy3jXQsZx4S9pumNicD
         6B7HTb9f+D/8uUppfMCB9SMt2kZDq8/fRhhPK24rXlr8GIqSNPiihRI5qcnJvObPM2Dr
         vkxJQBQ3QWSk1uDOG3fm1WEV3fUYRJ1WDVuR5qE5TRBU8Qemj1A0qK4EqjU1xkT/snKR
         RyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jFVKdea45mJrNywU948vMYq5u5WRFPo01K8iIYZKsrw=;
        b=YL8fDNOaaSuXwTbFkTjdbM/4yvR7V28tBT5FBue+9xbqW1ER4O2iiSNoKmUPQEZ4ee
         LqQr+n3EniYUfWppWoOZWWLg8/tN4eu/RQ6bp/ww2BICXXOLMHz56jmt146UZUnmzySo
         gUWSUHGZyEjpi1vm4QKKgmYP/awTusd7F9ylEDLfUhJW13wMlKdFz9Ash0HNjogfbZl1
         nMEU2AG3/ERQS8OyTV3lODTJ/RV9bHhqbh/z7rxj+1eW9/WJTAyY3Y3PruuvgzL6hMfC
         Y0Bq4CWk5P/3W/A/gWWtXGq0SQFssKci5hZP+lQ84LzqKJWDoxii/BY9GuSxogGluezy
         23fQ==
X-Gm-Message-State: APjAAAVA1qViP5uF4pZJVHUfyQi4MK2vBskphkABnFSBcuTkeZbPPmm6
        vARgWnagBY7omrUUQ8C6dO6Hpw==
X-Google-Smtp-Source: APXvYqyJag4ggmgi7xh2Gz1Sw+DPkf0OQ7myIaHWJXxifbKX1zyv/8Shs9SPwXg8QVxvQm6vfC0MZw==
X-Received: by 2002:ac8:3a84:: with SMTP id x4mr14802700qte.334.1567587562863;
        Wed, 04 Sep 2019 01:59:22 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1320-244.members.linode.com. [45.79.221.244])
        by smtp.gmail.com with ESMTPSA id c1sm665566qkm.70.2019.09.04.01.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 01:59:22 -0700 (PDT)
Date:   Wed, 4 Sep 2019 16:59:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] perf machine: arm/arm64: Improve completeness for
 kernel address space
Message-ID: <20190904085912.GA27922@leoy-ThinkPad-X240s>
References: <20190815082521.16885-1-leo.yan@linaro.org>
 <d874e6b3-c115-6c8c-bb12-160cfd600505@intel.com>
 <20190815113242.GA28881@leoy-ThinkPad-X240s>
 <e0919e39-7607-815b-3a12-96f098e45a5f@intel.com>
 <20190816014541.GA17960@leoy-ThinkPad-X240s>
 <363577f1-097e-eddd-a6ca-b23f644dd8ce@intel.com>
 <20190826125105.GA3288@leoy-ThinkPad-X240s>
 <20190902141511.GF4931@leoy-ThinkPad-X240s>
 <c16ee888-73cc-588d-6156-bb5528d635cf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c16ee888-73cc-588d-6156-bb5528d635cf@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Sep 04, 2019 at 10:26:13AM +0300, Adrian Hunter wrote:

[...]

> > Could you take chance to review my below replying?  I'd like to get
> > your confirmation before I send out offical patch.
> 
> It is not necessary to do kallsyms__parse for x86_64, so it would be better
> to check the arch before calling that.

Thanks for suggestion, will do it in the formal patch.

> However in general, having to copy and use kallsyms with perf.data if on a
> different arch does not seem very user friendly.

Agree.  Seems it's more reasonable to save related info in
perf.data; TBH, I have no idea for how to do that.

> But really that is up to Arnaldo.

@Arnaldo, if possible could you take a look for below change?

If you don't think below code is the right thing and it's not a common
issue, then maybe it's more feasible to resolve this issue only for
Arm CoreSight specific.

Please let me know how about you think for this?

Thanks,
Leo Yan

> >> For your question for taking a perf.data file to a machine with a
> >> different architecture, we can firstly use command 'perf buildid-list'
> >> to print out the buildid for kallsyms, based on the dumped buildid we
> >> can find out the location for the saved kallsyms file; then we can use
> >> option '--kallsyms' to specify the offline kallsyms file and use the
> >> offline kallsyms to fixup kernel start address.  The detailed commands
> >> are listed as below:
> >>
> >> root@debian:~# perf buildid-list
> >> 7b36dfca8317ef74974ebd7ee5ec0a8b35c97640 [kernel.kallsyms]
> >> 56b84aa88a1bcfe222a97a53698b92723a3977ca /usr/lib/systemd/systemd
> >> 0956b952e9cd673d48ff2cfeb1a9dbd0c853e686 /usr/lib/aarch64-linux-gnu/libm-2.28.so
> >> [...]
> >>
> >> root@debian:~# perf script --kallsyms ~/.debug/\[kernel.kallsyms\]/7b36dfca8317ef74974ebd7ee5ec0a8b35c97640/kallsyms
> >>
> >> The amended patch is as below, please review and always welcome
> >> any suggestions or comments!
> >>
> >> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> >> index 5734460fc89e..593f05cc453f 100644
> >> --- a/tools/perf/util/machine.c
> >> +++ b/tools/perf/util/machine.c
> >> @@ -2672,9 +2672,26 @@ int machine__nr_cpus_avail(struct machine *machine)
> >>  	return machine ? perf_env__nr_cpus_avail(machine->env) : 0;
> >>  }
> >>  
> >> +static int machine__fixup_kernel_start(void *arg,
> >> +				       const char *name __maybe_unused,
> >> +				       char type,
> >> +				       u64 start)
> >> +{
> >> +	struct machine *machine = arg;
> >> +
> >> +	type = toupper(type);
> >> +
> >> +	/* Fixup for text, weak, data and bss sections. */
> >> +	if (type == 'T' || type == 'W' || type == 'D' || type == 'B')
> >> +		machine->kernel_start = min(machine->kernel_start, start);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  int machine__get_kernel_start(struct machine *machine)
> >>  {
> >>  	struct map *map = machine__kernel_map(machine);
> >> +	char filename[PATH_MAX];
> >>  	int err = 0;
> >>  
> >>  	/*
> >> @@ -2696,6 +2713,22 @@ int machine__get_kernel_start(struct machine *machine)
> >>  		if (!err && !machine__is(machine, "x86_64"))
> >>  			machine->kernel_start = map->start;
> >>  	}
> >> +
> >> +	if (symbol_conf.kallsyms_name != NULL) {
> >> +		strncpy(filename, symbol_conf.kallsyms_name, PATH_MAX);
> >> +	} else {
> >> +		machine__get_kallsyms_filename(machine, filename, PATH_MAX);
> >> +
> >> +		if (symbol__restricted_filename(filename, "/proc/kallsyms"))
> >> +			goto out;
> >> +	}
> >> +
> >> +	if (kallsyms__parse(filename, machine, machine__fixup_kernel_start))
> >> +		pr_warning("Fail to fixup kernel start address. skipping...\n");
> >> +
> >> +out:
> >>  	return err;
> >>  }
> >>  
> >>
> >> Thanks,
> >> Leo Yan
> > 
> 
