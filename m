Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A746C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AF620863
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfEYAyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 20:54:50 -0400
Received: from ozlabs.org ([203.11.71.1]:42955 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbfEYAyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:54:49 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 459lBb45HVz9sB8; Sat, 25 May 2019 10:54:47 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3202e35ec1c8fc19cea24253ff83edf702a60a02
X-Patchwork-Hint: ignore
In-Reply-To: <20190511024217.4013-2-ravi.bangoria@linux.ibm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, peterz@infradead.org,
        jolsa@redhat.com, maddy@linux.vnet.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH 2/2] powerpc/perf: Fix mmcra corruption by bhrb_filter
Message-Id: <459lBb45HVz9sB8@ozlabs.org>
Date:   Sat, 25 May 2019 10:54:47 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-11 at 02:42:17 UTC, Ravi Bangoria wrote:
> Consider a scenario where user creates two events:
> 
>   1st event:
>     attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
>     attr.branch_sample_type = PERF_SAMPLE_BRANCH_ANY;
>     fd = perf_event_open(attr, 0, 1, -1, 0);
> 
>   This sets cpuhw->bhrb_filter to 0 and returns valid fd.
> 
>   2nd event:
>     attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
>     attr.branch_sample_type = PERF_SAMPLE_BRANCH_CALL;
>     fd = perf_event_open(attr, 0, 1, -1, 0);
> 
>   It overrides cpuhw->bhrb_filter to -1 and returns with error.
> 
> Now if power_pmu_enable() gets called by any path other than
> power_pmu_add(), ppmu->config_bhrb(-1) will set mmcra to -1.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/3202e35ec1c8fc19cea24253ff83edf7

cheers
