Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812CBC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7702063F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfF1IFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:05:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfF1IFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:05:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD03781DF9;
        Fri, 28 Jun 2019 08:05:11 +0000 (UTC)
Received: from krava (unknown [10.40.205.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 660E95D962;
        Fri, 28 Jun 2019 08:05:08 +0000 (UTC)
Date:   Fri, 28 Jun 2019 10:05:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf tools: Fix bison warnings for pure parser
Message-ID: <20190628080507.GB3427@krava>
References: <20190627222021.14980-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627222021.14980-1-andi@firstfloor.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 28 Jun 2019 08:05:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 03:20:21PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> bison 3.4.1 complains during a perf build:
> 
> util/parse-events.y:1.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
>     1 | %pure-parser
>       | ^~~~~~~~~~~~
>   CC       /home/andi/lsrc/obj-perf/ui/browsers/map.o
> util/parse-events.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]
> 
> util/expr.y:13.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
>    13 | %pure-parser
>       | ^~~~~~~~~~~~
> util/expr.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]
> 
> Change the declarations to %define api.pure
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

looks good, let's hope it'll pass Arnaldo's build test

jirka

> ---
>  tools/perf/util/expr.y         | 2 +-
>  tools/perf/util/parse-events.y | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 432b8560cf51..803c0929c205 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -10,7 +10,7 @@
>  #define MAXIDLEN 256
>  %}
>  
> -%pure-parser
> +%define api.pure
>  %parse-param { double *final_val }
>  %parse-param { struct parse_ctx *ctx }
>  %parse-param { const char **pp }
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 6ad8d4914969..4eb10c27c30f 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -1,4 +1,4 @@
> -%pure-parser
> +%define api.pure
>  %parse-param {void *_parse_state}
>  %parse-param {void *scanner}
>  %lex-param {void* scanner}
> -- 
> 2.21.0
> 
