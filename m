Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBADC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CE6206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWTlJgAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfDPTgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:36:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46094 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPTgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:36:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id x18so711275qkf.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 12:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mRyeopdXxSK53USmYH1b/Hy8x7B1wPcKegG51sXIj/o=;
        b=cWTlJgAnXTG40NN/ViJfr2H+2YEoekaq6mdbBumSEs4yDmfTE/nangww0P1dw8Pqe8
         OVYm2DgO1E+xAYw/6lYp59KmsRzo2ZB64/YjE2jtIYq8SdV2sEFLHEfsSCR3i7OO8QPS
         JIetCKLDAT6jPwALOfNudnKOrPCl56uDadhS5KK0cm1bpDNgvY6SCTOBE8nm6fCeHj1F
         GKiThbwRBCCKnSLjz91jNlkZtRuvZVFtOtsYrX33xPSNc2aaNZ96C8eZdesJk4fE8Rkw
         2zkF5DSvogW2Vb8geERwm9NepRNgFscVYOXnumuC/yE1I60fvQ8311FwWHkL3ilDRseL
         2sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mRyeopdXxSK53USmYH1b/Hy8x7B1wPcKegG51sXIj/o=;
        b=F4IF7D86ArkveQGGCOjH50z3quNQLVBzje78aXq1s/5zD+b0AcScNqoZ4PRA0zrdwJ
         o0j26Kd6MxR3E4dQ1oC2P+fC2aasU6LkoLezurSyTMluZTeDCyVPVUIY/mt2rxdTBPTg
         fGF3BGkvKkiMSp9o5N0cutFHCoaw9odM3BVSeN+4Bj19S71xUTAh8jUJir5UJMkP4vrV
         tnL4iifiOa5dTPIu3iW41n5AZNP1S4rRn9Q7aUM1TxKB3k4LOKKcscPWjPAI3zDM783E
         EjQb/K6niFY7UWuIMAhaWk87jebQDGV5O7T1YL/gw4YMetrAxoots/axyr2JIesf+Jee
         QZMQ==
X-Gm-Message-State: APjAAAXFZVRt3AEFjKjfcGZNUcwsaXKRTfpZ/l8r2GV+yiPjFnHl4CRf
        2dzoOOgJ3u9Ze883XZTTp4o=
X-Google-Smtp-Source: APXvYqy57/Tcfx88+BsSj38pVfZHr5cX3t3SaAG738jFbvtCunsKCFChB76/IM+lJ5bEKaKiFwhAMA==
X-Received: by 2002:a37:64a:: with SMTP id 71mr61675858qkg.41.1555443409877;
        Tue, 16 Apr 2019 12:36:49 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-182-11.3g.claro.net.br. [179.240.182.11])
        by smtp.gmail.com with ESMTPSA id h186sm33447899qke.45.2019.04.16.12.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 12:36:48 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 29C054039C; Tue, 16 Apr 2019 16:36:45 -0300 (-03)
Date:   Tue, 16 Apr 2019 16:36:45 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Subject: Re: [PATCH 09/12] perf tools: Fix map reference counting
Message-ID: <20190416193645.GD9247@kernel.org>
References: <20190416160127.30203-1-jolsa@kernel.org>
 <20190416160127.30203-10-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416160127.30203-10-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 16, 2019 at 06:01:24PM +0200, Jiri Olsa escreveu:
> By calling maps__insert we assume to get 2 references
> on the map, which we relese within maps__remove call.
> 
> However if there's already same map name, we currently
> don't bump the reference and can crash, like:
> 
>   Program received signal SIGABRT, Aborted.
>   0x00007ffff75e60f5 in raise () from /lib64/libc.so.6
> 
>   (gdb) bt
>   #0  0x00007ffff75e60f5 in raise () from /lib64/libc.so.6
>   #1  0x00007ffff75d0895 in abort () from /lib64/libc.so.6
>   #2  0x00007ffff75d0769 in __assert_fail_base.cold () from /lib64/libc.so.6
>   #3  0x00007ffff75de596 in __assert_fail () from /lib64/libc.so.6
>   #4  0x00000000004fc006 in refcount_sub_and_test (i=1, r=0x1224e88) at tools/include/linux/refcount.h:131
>   #5  refcount_dec_and_test (r=0x1224e88) at tools/include/linux/refcount.h:148
>   #6  map__put (map=0x1224df0) at util/map.c:299
>   #7  0x00000000004fdb95 in __maps__remove (map=0x1224df0, maps=0xb17d80) at util/map.c:953
>   #8  maps__remove (maps=0xb17d80, map=0x1224df0) at util/map.c:959
>   #9  0x00000000004f7d8a in map_groups__remove (map=<optimized out>, mg=<optimized out>) at util/map_groups.h:65
>   #10 machine__process_ksymbol_unregister (sample=<optimized out>, event=0x7ffff7279670, machine=<optimized out>) at util/machine.c:728
>   #11 machine__process_ksymbol (machine=<optimized out>, event=0x7ffff7279670, sample=<optimized out>) at util/machine.c:741
>   #12 0x00000000004fffbb in perf_session__deliver_event (session=0xb11390, event=0x7ffff7279670, tool=0x7fffffffc7b0, file_offset=13936) at util/session.c:1362
>   #13 0x00000000005039bb in do_flush (show_progress=false, oe=0xb17e80) at util/ordered-events.c:243
>   #14 __ordered_events__flush (oe=0xb17e80, how=OE_FLUSH__ROUND, timestamp=<optimized out>) at util/ordered-events.c:322
>   #15 0x00000000005005e4 in perf_session__process_user_event (session=session@entry=0xb11390, event=event@entry=0x7ffff72a4af8,
>   ...
> 
> Adding the map on the list and getting the reference event
> if we find the map with same name.

Added:

Fixes: 1e6285699b30 ("perf symbols: Fix slowness due to -ffunction-section")

Ccing Eric Saint-Etienne <eric.saint.etienne@oracle.com>, the author of
the patch that introduced that function.

And applied to perf/urgent
 
> Cc: Song Liu <songliubraving@fb.com>
> Link: http://lkml.kernel.org/n/tip-38t1ihcy32lvu4xfpm0p7yex@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/map.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 28d484ef74ae..ee71efb9db62 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -926,10 +926,8 @@ static void __maps__insert_name(struct maps *maps, struct map *map)
>  		rc = strcmp(m->dso->short_name, map->dso->short_name);
>  		if (rc < 0)
>  			p = &(*p)->rb_left;
> -		else if (rc  > 0)
> -			p = &(*p)->rb_right;
>  		else
> -			return;
> +			p = &(*p)->rb_right;
>  	}
>  	rb_link_node(&map->rb_node_name, parent, p);
>  	rb_insert_color(&map->rb_node_name, &maps->names);
> -- 
> 2.17.2

-- 

- Arnaldo
