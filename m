Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE74C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8BD21744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPQ4ya/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgAFWR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:17:58 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44632 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFWR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:17:57 -0500
Received: by mail-qt1-f196.google.com with SMTP id t3so43735131qtr.11;
        Mon, 06 Jan 2020 14:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kfMy6wAKdoe9XuJtuHAA8yGQWyNe75AoHPg7tJJpq34=;
        b=ZPQ4ya/a0uHqBArbwb2JP5lA7k0VBAZp1Er8z/VNXG4aGQvUL3lviTa/+DK4uf68Vc
         5IsuYeqgEHYc/3UvqN3zukwxJ3iJ/QgsuUE6zgeGHYP2ccrkBFBgFZKUtd4TapgrIW9W
         UdC9Zn6doXMrLoF1lbQR6HibwFkT3lLPGeOXATGhJ7xmdRp3yf1gNu5dcHJno2daKspp
         z7uf66GiHr5zyUx3wmxdd1CtC1OAXs9WjqEuYvVcQR5iyGsF5oLmMTAy/3SC2QN/xakp
         mRfoLw4qIdHn79b0dQWLwPnXZGDmDv0J/uy3CZ0KEb/xgXQ9IoNlgEAhXKhum1M0aDj/
         y12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kfMy6wAKdoe9XuJtuHAA8yGQWyNe75AoHPg7tJJpq34=;
        b=t3IDQpJ9JxieQcDsDVpBgbz7pZT6Vb0S5JIQCtlhDvpn0SwZ8rEWghuP8Vsj0YtmT+
         pe6GWF3bICn0gQQPbhYRKFGpwBEGiMSoLEqZ87nMQZUEZJz42y0mKz2J92+pfPpiA4oN
         l4aj/YEAs9xwtLE+HVFP87J/VI9dS12HNeTWgw3QFSCyYETFN9n/yEEIA7bRnlMvfONJ
         K7Gd93nSbD6L4XvF8Pr+63AaD/Ase18ts5Re/7UV6UxAXkxSxSgAJ1a3+770i1hc4Bns
         BLQLS8hhjxTmbYcEJhvvWfcIZURu2HcCKqWe7kdngpSmBw9D6BEN+yeoYCvT0c7Vo5+Z
         3kjA==
X-Gm-Message-State: APjAAAUYf+gkoyXBXOwcCc5xL55l2qRQe47YiEK9StKyUfmcqCRR4bIe
        VGdWd1NotQd8tYLKutXohW8=
X-Google-Smtp-Source: APXvYqxRXq0cdys0rTjrOqU63zex7uXtxH0J/dikS0vNpCA8xvMDo9atRAo2frk35cSIad9/Gc4G/Q==
X-Received: by 2002:ac8:7201:: with SMTP id a1mr76514341qtp.51.1578349076629;
        Mon, 06 Jan 2020 14:17:56 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t23sm23960810qto.88.2020.01.06.14.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:17:56 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2729040DFD; Mon,  6 Jan 2020 19:17:54 -0300 (-03)
Date:   Mon, 6 Jan 2020 19:17:54 -0300
To:     Vijay Thakkar <vijaythakkar@me.com>, Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] perf vendor events amd: latest PMU events for
 zen1/zen2
Message-ID: <20200106221754.GB16851@kernel.org>
References: <20191227125536.1091387-1-vijaythakkar@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227125536.1091387-1-vijaythakkar@me.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 27, 2019 at 07:55:33AM -0500, Vijay Thakkar escreveu:
> This series of patches brings the PMU events for AMD family 17h series
> of processors up to date with the latest versions of the AMD processor
> programming reference manuals.
> 
> The first patch changes the pmu events mapfile to be more selective for
> the model number rather than blanket detecting all f17h processors to
> have the same events directory. This is required for the later patch
> where we add events for zen2 based processors.
> 
> The second patch adds the PMU events for zen2.

Borislav, can you ack these, or point to someone who can double check
this and the other 2 patches?

Thanks,

- Arnaldo
 
> Finally the third patch updates the zen1 PMU events to be in accordance
> with the latest PPR version and bumps up the events version to v2.
> 
> Vijay Thakkar (3):
>   perf vendor events amd: restrict model detection for zen1 based
>     processors
>   perf vendor events amd: add Zen2 events
>   perf vendor events amd: update Zen1 events to V2
> 
>  .../x86/{amdfam17h => amdzen1}/branch.json    |   0
>  .../x86/{amdfam17h => amdzen1}/cache.json     |   0
>  .../pmu-events/arch/x86/amdzen1/core.json     | 129 ++++++
>  .../floating-point.json                       |  56 +++
>  .../x86/{amdfam17h => amdzen1}/memory.json    |  18 +
>  .../x86/{amdfam17h => amdzen1}/other.json     |   0
>  .../pmu-events/arch/x86/amdzen2/branch.json   |  56 +++
>  .../pmu-events/arch/x86/amdzen2/cache.json    | 375 ++++++++++++++++++
>  .../arch/x86/{amdfam17h => amdzen2}/core.json |   0
>  .../arch/x86/amdzen2/floating-point.json      | 128 ++++++
>  .../pmu-events/arch/x86/amdzen2/memory.json   | 349 ++++++++++++++++
>  .../pmu-events/arch/x86/amdzen2/other.json    | 137 +++++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   4 +-
>  13 files changed, 1251 insertions(+), 1 deletion(-)
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/branch.json (100%)
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json (100%)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/core.json
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (63%)
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (93%)
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json (100%)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
>  rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen2}/core.json (100%)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json
> 
> -- 
> 2.24.1

-- 

- Arnaldo
