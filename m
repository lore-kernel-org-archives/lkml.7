Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0045CC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6556208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnoKHeR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389930AbfHHN4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:56:40 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40150 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732882AbfHHN4k (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:56:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id s145so68832711qke.7
        for <Linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fPpcBry2HdcdHyWE0YooFTbsmsPTHzKrgGgAZPQcj1U=;
        b=BnoKHeR5aIXCoGFdQXnge4eTzTLcBUyB06hllb1KE5MHGZwkKArEDqQokIh2fIJaVT
         tsvEINRAd0weAYWsNoc5VoH1QokLDCKBgbLlQR0jqDspzhdZ96W4HolyomchPAfSp7UX
         ucJx0ljJWVfwN5vRDFjSqdwvdPbPsG6E7SoF+TghzG+4h3f6CPzOhvynnbdvol49bxwj
         gpHl0HRy0syFEC59xbT0Hp24CDYuGsZBIkqy7iBcJJzLK83B3CzLlU+71dxJ3CAtrlE8
         MXDqPZfGdxvG3wnJhqLPLQCT/mW/Zk+hNnvv6SR1fu/yuUywpEsv+ktPHGrza9WV8K8v
         YkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fPpcBry2HdcdHyWE0YooFTbsmsPTHzKrgGgAZPQcj1U=;
        b=VWWdAVoTkfb8EmgPkavHEqxBSx5BPTSfhNJQaxNIKyAjPZmwoDwxrMK1Uzd+yPwY7j
         WF522k417C265JdEiev+r4j0fx1a4oox17G7O9xvbBokRXgcfN0Uhj4fls5AATRJofIK
         8jZRtu6a/2qFA05r/Nb1GGgtTJm9OjjIdjFENC18UaUMAoVrB1ykWcs+iXNP5J65MFom
         FW+v8Lygc4V6KYhfKdzeKZA9gXcTTCMRG874HUDTjkutpImc2NR2yxBeJqFHMUUOWBIH
         wnaKxsiNpIZltA/UfpCGp7HbjdhNpfQTtAg/S5RWGd/xqcNpBW/tkeQeAzpLvWBBH0ga
         VdTQ==
X-Gm-Message-State: APjAAAXP8wSWRYKY/zAZtHJlfUNJs1k531UMaonbaIMKnJj7xOApCWXR
        Bl9wOq+YfgXzgr61kEo62gg=
X-Google-Smtp-Source: APXvYqw6f/AyMYCN1DXJp6coIYfoBGKJ+ShpPcx0GsrfkPP8Xoy4Hoh4KKLnm6WHXkxAVIfnlvFCVg==
X-Received: by 2002:ae9:efc6:: with SMTP id d189mr12968677qkg.323.1565272599403;
        Thu, 08 Aug 2019 06:56:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id r40sm56849282qtk.2.2019.08.08.06.56.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 06:56:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1249540340; Thu,  8 Aug 2019 10:56:36 -0300 (-03)
Date:   Thu, 8 Aug 2019 10:56:36 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf pmu-events: Fix the missing "cpu_clk_unhalted.core"
Message-ID: <20190808135636.GI19444@kernel.org>
References: <20190729072755.2166-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729072755.2166-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 29, 2019 at 03:27:55PM +0800, Jin Yao escreveu:
> The events defined in pmu-events JSON are parsed and added into
> perf tool. For fixed counters, we handle the encodings between
> JSON and perf by using a static array fixed[].
> 
> But the fixed[] has missed an important event "cpu_clk_unhalted.core".
> 
> For example, on tremont platform,
> 
> [root@localhost ~]# perf stat -e cpu_clk_unhalted.core -a
> event syntax error: 'cpu_clk_unhalted.core'
>                      \___ parser error
> 
> With this patch, the event cpu_clk_unhalted.core can be parsed.
> 
> [root@localhost perf]# ./perf stat -e cpu_clk_unhalted.core -a -vvv
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4
>   size                             112
>   config                           0x3c
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------

Thanks, applied, next time please do not add lines starting with ---,
prefix it with two spaces so that git am scripts don't get confused.


- Arnaldo

> ...
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/pmu-events/jevents.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 1a91a197cafb..d413761621b0 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -453,6 +453,7 @@ static struct fixed {
>  	{ "inst_retired.any_p", "event=0xc0" },
>  	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
>  	{ "cpu_clk_unhalted.thread", "event=0x3c" },
> +	{ "cpu_clk_unhalted.core", "event=0x3c" },
>  	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1" },
>  	{ NULL, NULL},
>  };
> -- 
> 2.17.1

-- 

- Arnaldo
