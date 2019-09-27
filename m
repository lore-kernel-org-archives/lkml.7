Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFEBC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A42207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHKeEW3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfI0Pvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:51:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40553 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfI0Pvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 11:51:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id y144so2336216qkb.7;
        Fri, 27 Sep 2019 08:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5w8UestP55hry1M5GHZRvCfuVzHAIAhGR1CWjTpb5bk=;
        b=nHKeEW3n+lp5f691ik7mpqFlDpsNTpzudIqrSaXXCfm3bUfoHKV7u+YDgQqx/hAZP5
         bfjlxykuAxFXe3XqKJEF0BmdaO0LbcaF86wz4+0zMqHeC4Q4Hs02PuZt+C3x5saJwx13
         cYX2IY7OmBkWqIpmsboHc5heHfLHFH9bZOM3SX9UyY8P2/CJ9S1VSVOwUM4i6c51EPAz
         0i3cXHXLRlHZEA4ilVBBFxFgwFrGBuKk1vKjcuzvasI4jvZsh2vOQdYdmGs9pZQjINaw
         RM1DEUoR9fr79pQe0cr9lPi/mbieXHaOZB3dz1WE9THSIoog2u66PSWYrhs2wlBjANsB
         v3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5w8UestP55hry1M5GHZRvCfuVzHAIAhGR1CWjTpb5bk=;
        b=enBLtIPEjNpXnEoBwpSbD5simyFMFpHN6AcLRSjsxWX2TQI0nidl+MepyKe3Q7ZE2j
         7DjI6sGqFJRVpSH8UokroadXo5uQAtLCPqAV8e+8EvJpm0IGuW76ODq1MPtGqgJ7Pd3I
         CVRa30fosVgsNKPcRJeg84bXYOEVJoMrzODXY+4uOFbAGTu4o4IjqnNRcCjVwv5Y4GaS
         b5MGVr4+Zd0i2gooK2HgLxXJms14gdUbRzIexy5ampZNtXzm0nFEFJc8AYos23GNUVQI
         83FADhKziWVc9nuGlOR2kLXjo0gdoorLBY3jP3KfUUENN422lI8wZ70LHjmmE1ruXq8M
         W7JQ==
X-Gm-Message-State: APjAAAXmMuGM3KW0VG654gGxEvOk7dX4PdtsCMOY/vQ/66c35LK9ZqGg
        GbWcBqOOhbZcVEsjm3KCn2g=
X-Google-Smtp-Source: APXvYqyQpRrFqQ9ilj/9BJCxfO+BdgICZ1DqCcDVg1eK9V5b/goGc3r3Bo1nN2GjvGSuRUB/sMMLFA==
X-Received: by 2002:a37:7303:: with SMTP id o3mr5118896qkc.439.1569599508835;
        Fri, 27 Sep 2019 08:51:48 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id g10sm1267333qkm.38.2019.09.27.08.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 08:51:48 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7F63140396; Fri, 27 Sep 2019 12:51:45 -0300 (-03)
Date:   Fri, 27 Sep 2019 12:51:45 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 2/2] perf/pmu_events: Use s390 machine name instead of
 type 8561
Message-ID: <20190927155145.GD20644@kernel.org>
References: <20190927081147.18345-1-tmricht@linux.ibm.com>
 <20190927081147.18345-2-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927081147.18345-2-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 27, 2019 at 10:11:47AM +0200, Thomas Richter escreveu:
> In the pmu-events directory for JSON file definitions use the
> official machine name IBM z15 instead of machine type number
> 8561. This is consistent with previous machines.

Thanks, applied both patches.

- Arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/basic.json | 0
>  .../perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto.json  | 0
>  .../perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto6.json | 0
>  .../pmu-events/arch/s390/{cf_m8561 => cf_z15}/extended.json     | 0
>  .../pmu-events/arch/s390/{cf_m8561 => cf_z15}/transaction.json  | 0
>  tools/perf/pmu-events/arch/s390/mapfile.csv                     | 2 +-
>  6 files changed, 1 insertion(+), 1 deletion(-)
>  rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/basic.json (100%)
>  rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto.json (100%)
>  rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto6.json (100%)
>  rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/extended.json (100%)
>  rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/transaction.json (100%)
> 
> diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/basic.json b/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/s390/cf_m8561/basic.json
> rename to tools/perf/pmu-events/arch/s390/cf_z15/basic.json
> diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json
> rename to tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
> diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json
> rename to tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
> diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/extended.json b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/s390/cf_m8561/extended.json
> rename to tools/perf/pmu-events/arch/s390/cf_z15/extended.json
> diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json
> rename to tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
> diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
> index bd3fc577139c..61641a3480e0 100644
> --- a/tools/perf/pmu-events/arch/s390/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
> @@ -4,4 +4,4 @@ Family-model,Version,Filename,EventType
>  ^IBM.282[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_zec12,core
>  ^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
>  ^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
> -^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_m8561,core
> +^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_z15,core
> -- 
> 2.19.1

-- 

- Arnaldo
