Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9E2C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884792086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 15:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfI2P3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 11:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfI2P3S (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 11:29:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0945783F3D;
        Sun, 29 Sep 2019 15:29:18 +0000 (UTC)
Received: from krava (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5D54D60C05;
        Sun, 29 Sep 2019 15:29:14 +0000 (UTC)
Date:   Sun, 29 Sep 2019 17:29:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/2] perf stat: Support --all-kernel and --all-user
Message-ID: <20190929151022.GA16309@krava>
References: <20190925020218.8288-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925020218.8288-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 29 Sep 2019 15:29:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:02:16AM +0800, Jin Yao wrote:
> This patch series supports the new options "--all-kernel" and "--all-user"
> in perf-stat.
> 
> For example,
> 
> root@kbl:~# perf stat -e cycles,instructions --all-kernel --all-user -a -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>         19,156,665      cycles:k
>          7,265,342      instructions:k            #    0.38  insn per cycle
>      4,511,186,293      cycles:u
>        121,881,436      instructions:u            #    0.03  insn per cycle

hi,
I think we should follow --all-kernel/--all-user behaviour from record
command, adding extra events seems like unnecesary complexity to me

jirka

> 
>        1.001153540 seconds time elapsed
> 
> 
>  root@kbl:~# perf stat -a --topdown --all-kernel -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>                                   retiring:k    bad speculation:k     frontend bound:k      backend bound:k
> S0-D0-C0           2                 7.6%                 1.8%                40.5%                50.0%
> S0-D0-C1           2                15.4%                 3.4%                14.4%                66.8%
> S0-D0-C2           2                15.8%                 5.1%                26.9%                52.2%
> S0-D0-C3           2                 5.7%                 5.7%                46.2%                42.4%
> 
>        1.000771709 seconds time elapsed
> 
> More detail information are in the patch descriptions.
> 
> Jin Yao (2):
>   perf stat: Support --all-kernel and --all-user options
>   perf stat: Support topdown with --all-kernel/--all-user
> 
>  tools/perf/Documentation/perf-record.txt |   3 +-
>  tools/perf/Documentation/perf-stat.txt   |   7 +
>  tools/perf/builtin-stat.c                | 200 ++++++++++++++++++++++-
>  tools/perf/util/stat-shadow.c            | 167 ++++++++++++++-----
>  tools/perf/util/stat.h                   |  23 +++
>  5 files changed, 353 insertions(+), 47 deletions(-)
> 
> -- 
> 2.17.1
> 
