Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA788C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD2720862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwM3iXO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfJDTGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 15:06:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41666 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfJDTGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:06:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id d16so9968938qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TEfJlWUhWrJ8EeojdnNO6PIunlwDcbHqhfWR6PvLzw8=;
        b=SwM3iXO/Zm76pvGJxa6lfP9dIfeUoT8EKT7pc+VkF5tLZ29A/3QuMdKfgRI20Htdit
         JR3XeGxDUw9dSfKTGXtCylfe4hMH8osiiv/QI3+SJL79soMhEnAXE93U95l9WKlILlxj
         CPzeGRrB6yvwHEnF/+LrtlUcHb7K9f0GFAa6Qb8mnJF8uHs/3Oy5yCePfGdweOeYa9N0
         9HrXHlaLNTjvyyTkwkmg5V1vDZgNm1xgPyMjtYCCj2oPlxpQFxRQQnp23+91YJeOceEY
         PTH+ZhwCrhZQvbUMNZJWWNmGLBSrLo+gpdEdtqcpSOf6cltgQj5t3IiEwjFVGSz7blll
         ZdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TEfJlWUhWrJ8EeojdnNO6PIunlwDcbHqhfWR6PvLzw8=;
        b=KBDHlNfe6mdS6r+PejILu4T11QhSnZEaA3t2jETrDjZgyTNKgeVJO5UgrcTURDPmfV
         /HR9ahafHMzCWvwo7kEt04Ko9IzV3kf6gbWTxzhrdFgDi5twVBAfq4fKBsbFmiojUfg3
         aaCOZvYJ/l4BVzRtfB30Qj63UI6gsUe/Dd+MvqeF34OYdepdjHdggpt4VgH/ksN51Q+f
         lIGRrAspZz5O/6+8c0ESGN6XofMvSlU/OckgEIZfFfVBh6R6z+zELThzdJgSzGvL14al
         R+4n14gglZNrID+a+L2cfwHH3KgK0vxw2yqX4AF8Q1qFff7oed30wqL60a0DDtm3c7xs
         ZY9Q==
X-Gm-Message-State: APjAAAXIWH+uYwElWO/0anNzQBmRcRF7KZMv/KhwdHnpv0rjyQ+ZdS+Z
        FdKkBOLY3fLtAga4Z/F10Zk=
X-Google-Smtp-Source: APXvYqzATPXAuYYYxeHBEbxZ5lfXCtCHYNoHnY7fSBZYOfqetMpKZjHyuAWkpz8RpewriaqO8MvTMg==
X-Received: by 2002:ac8:f33:: with SMTP id e48mr17930787qtk.123.1570216003764;
        Fri, 04 Oct 2019 12:06:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-136-122.3g.claro.net.br. [179.240.136.122])
        by smtp.gmail.com with ESMTPSA id n192sm3186811qke.9.2019.10.04.12.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 12:06:42 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 39F9E40DD3; Fri,  4 Oct 2019 16:06:39 -0300 (-03)
Date:   Fri, 4 Oct 2019 16:06:39 -0300
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com, will@kernel.org,
        mark.rutland@arm.com, zhangshaokun@hisilicon.com,
        James Clark <James.Clark@arm.com>
Subject: Re: [PATCH 0/4] HiSilicon hip08 uncore PMU events additions
Message-ID: <20191004190639.GB5399@kernel.org>
References: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
 <27e693fd-124e-1aa8-3b8a-62301a5a1d10@huawei.com>
 <20191004143658.GA17687@kernel.org>
 <20191004143835.GB17687@kernel.org>
 <969729ce-6246-6fa7-45c9-3dd9cb07059d@huawei.com>
 <20191004151853.GC17687@kernel.org>
 <0492ebd9-f867-423d-034c-9fe1c74902e7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0492ebd9-f867-423d-034c-9fe1c74902e7@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 04, 2019 at 05:30:46PM +0100, John Garry escreveu:
> > 
> > > > > > > The missing events were originally mentioned in
> > > > > > > https://lkml.org/lkml/2019/6/14/645, when upstreaming the JSONs initially.
> > 
> > > > > > > It also includes a fix for a DDRC eventname.
> > 
> > > > > > Could I get these JSON updates picked up please? Maybe they were missed
> > > > > > earlier. Let me know if I should re-post.
> > 
> > > > > Looking at them now.
> > 
> > > > It would be really good if somehow we managed to have someone from the
> > > > ARM community to check and provide a Reviewed-by for those, i.e. someone
> > > > else than the poster to look at it and check that its ok, would that be
> > > > possible?
> > 
> > > For this specific case, I'm not sure how much traction or value there would
> > > be since we're just adding some missing events for custom IP.
> > 
> > Someone else inside your organization?
> 
> For this, sure. Colleague Shaokun (cc'ed) provided me the metadata for these
> JSON additions, so when he returns from national vacation I can ask him to
> provide necessary tags.

Ok
 
>  If nobody is available, then so
> > be it, let that be clear in the JSON file (see below) and then I
> > wouldn't be waiting for acks/reviewed-by messages for such cases.
> > 
> > > But I do agree that more review of JSONs from the community is required - as
> > > I brought up here regarding a recent addition:
> > > https://lore.kernel.org/lkml/749a0b8e-2bfd-28f6-b34d-dc72ef3d3a74@huawei.com/
> > > 
> > > Can we enforce that at least linux-arm-kernel@lists.infradead.org and/or
> > > get_maintainer.pl results is cc'ed on anything ARM specific as a start?
> > 
> > I think this should be the case, would you be willing to add a note to
> > that effect at the top of the JSON files?
> 
> Adding notes to JSONs would be painful unless the parser is updated to to
> filter them out. And, as I understand, the x86 JSONs are autogenerated, so
> that tooling would need to handle this also.

Ok
 
> > 
> > And an extra note at tools/perf/pmu-events/README telling users to look
> > at the json files to figure out what Reviewed-by tags are required for
> > something to get merged? One extra Reviewed-by would be ok?Who would be
> > the reviewers for each arch? Would that be at the top of the JSON file?
> 
> There is no per-arch JSON, and, in addition, I think that would be hard to
> formulate such formal rules.

Ok
 
> As an alternative, how about just add a maintainers entry for reviewers per
> arch? As a start, I don't mind being added there for arm64:
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12767,6 +12767,10 @@ F:     arch/*/events/*
>  F:     arch/*/events/*/*
>  F:     tools/perf/
> 
> +PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> +R:     John Garry <john.garry@huawei.com>
> +F:     tools/perf/pmu-events/arch/arm64
> +
> 
> Patches per-arch should have some nod/tag from a member of the respective
> list. Or at very least be cc'ed :)

Another Ok, please send a formal patch, and it would be really nice if
the other ARM folks would... Ack that ;-) :-) And provide extra entries
for the other pmu-events directories or even for specific files, which
is a possibility, right?

On my side I'll script a bit more and make sure that a post commit hook
warns me if the right tag is not present.

- Arnaldo
