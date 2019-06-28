Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE007C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A282064B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfF1OyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:54:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfF1OyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:54:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AEB6C057F88;
        Fri, 28 Jun 2019 14:54:15 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 396295D704;
        Fri, 28 Jun 2019 14:54:06 +0000 (UTC)
Date:   Fri, 28 Jun 2019 16:54:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        tmricht@linux.ibm.com, brueckner@linux.ibm.com,
        kan.liang@linux.intel.com, ben@decadent.org.uk,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com, ak@linux.intel.com
Subject: Re: [PATCH v3 0/4] Perf uncore PMU event alias support for Hisi
 hip08 ARM64 platform
Message-ID: <20190628145406.GA22863@krava>
References: <1561732552-143038-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561732552-143038-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 28 Jun 2019 14:54:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:35:48PM +0800, John Garry wrote:
> This patchset adds support for uncore PMU event aliasing for HiSilicon
> hip08 ARM64 platform.
> 
> We can now get proper event description for uncore events for the
> perf tool.
> 
> For HHA, DDRC, and L3C JSONs, we don't have all the event info yet, so
> I will seek it out to update the JSONs later.
> 
> Changes to v3:
> - Omit "perf pmu: Fix uncore PMU alias list for ARM64", as it has already
>   been picked up
> - Add comment for pmu_uncore_alias_match()

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> Changes to v2:
> - Use strtok_r() in pmu_uncore_alias_match()
> - from "sccl" from uncore aliases
> 
> John Garry (4):
>   perf pmu: Support more complex PMU event aliasing
>   perf jevents: Add support for Hisi hip08 DDRC PMU aliasing
>   perf jevents: Add support for Hisi hip08 HHA PMU aliasing
>   perf jevents: Add support for Hisi hip08 L3C PMU aliasing
> 
>  .../arm64/hisilicon/hip08/uncore-ddrc.json    | 44 ++++++++++++++++
>  .../arm64/hisilicon/hip08/uncore-hha.json     | 51 +++++++++++++++++++
>  .../arm64/hisilicon/hip08/uncore-l3c.json     | 37 ++++++++++++++
>  tools/perf/pmu-events/jevents.c               |  3 ++
>  tools/perf/util/pmu.c                         | 46 +++++++++++++++--
>  5 files changed, 176 insertions(+), 5 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
> 
> -- 
> 2.17.1
> 
