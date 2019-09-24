Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BA1C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533C720872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437901AbfIXHoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:44:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56847 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503745AbfIXHoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:44:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDF0818C4265;
        Tue, 24 Sep 2019 07:44:09 +0000 (UTC)
Received: from krava (unknown [10.43.17.52])
        by smtp.corp.redhat.com (Postfix) with SMTP id BA89580A5;
        Tue, 24 Sep 2019 07:44:08 +0000 (UTC)
Date:   Tue, 24 Sep 2019 09:44:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/3] perf, expr: Remove assert usage
Message-ID: <20190924074407.GB26797@krava>
References: <20190923233339.25326-1-andi@firstfloor.org>
 <20190923233339.25326-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923233339.25326-2-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Tue, 24 Sep 2019 07:44:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 04:33:38PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> My "compile perf statically" setup doesn't like this assert
> for unknown reasons. Replace it with a standard BUG_ON
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/util/expr.y | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index f9a20a39b64a..5086a941295a 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -6,7 +6,6 @@
>  #define IN_EXPR_Y 1
>  #include "expr.h"
>  #include "smt.h"
> -#include <assert.h>
>  #include <string.h>
>  
>  #define MAXIDLEN 256
> @@ -172,7 +171,8 @@ static int expr__lex(YYSTYPE *res, const char **pp)
>  void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
>  {
>  	int idx;
> -	assert(ctx->num_ids < MAX_PARSE_ID);
> +
> +	BUG_ON(ctx->num_ids >= MAX_PARSE_ID);

hi,
getting compilation fail

  LINK     perf
/usr/bin/ld: perf-in.o: in function `expr__add_id':
/home/jolsa/kernel/linux-perf/tools/perf/util/expr.y:175: undefined reference to `BUG_ON'
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile.perf:609: perf] Error 1
make[1]: *** [Makefile.perf:221: sub-make] Error 2
make: *** [Makefile:70: all] Error 2

jirka

>  	idx = ctx->num_ids++;
>  	ctx->ids[idx].name = name;
>  	ctx->ids[idx].val = val;
> -- 
> 2.21.0
> 
