Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B33C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59605206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boHK9Ps/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfLLSCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:02:20 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45080 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730034AbfLLSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:02:20 -0500
Received: by mail-vs1-f65.google.com with SMTP id l24so2181638vsr.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6VMaTbelWuQ+1FodCcr2BEYuHHsLNCijzy+nxpRewBA=;
        b=boHK9Ps/ESS/aYcUZu1ZxqkMcdJ0k0BtqwQZqXT0KMGomi75+BfdFmrXe1YyeJpTor
         KPyM4/8ob8vUBLt3h/yJbxTGvNkH7rC2urbftztqL7uOS1DmFKysPcLyi1/ov1BZ2si0
         39leXy1UZ4h04po4twpp5EO8Ujy29guLkTLUgG2bHB337NAaFVD0CRUUKcR3MCFYq0am
         OuGHGIphm1g3YyY4v840tdLy4jKhk+gi7yvky2PidUAnSvV4007ouFvpkiQZFArjLwjp
         ndh+Q9sbmk6zKJjlyQuqjuiRU7lALZxhIiW1fw6vA79mt05Zwpo4mBDmoor7GtbU7LZ2
         pjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6VMaTbelWuQ+1FodCcr2BEYuHHsLNCijzy+nxpRewBA=;
        b=eCxae46nUzU+2/cAtnuDsprp3TrZ/gYzm3NwIixsomiEtHKaIKjI2/d4251KOgJ+36
         /yucQSoGnjlOIM7rUnMnpV6mR43p3k4sXpKy6WFfiKBcr0OuIHuInUtDxgL54iLlGtkX
         PHLxmxT3MySgHWzdHu7NxbAGJZfP/G+IovFs/cq9UeAlf/4560+pMqfczG14nzdS2+Vu
         CnkPFmOs+bsgVkcwpoc0MHZ0jI7QteodJ5RVr88bhZqwBVy65LP99URw+mG2whwdiBiZ
         70Aytq4p6ojSrTB+p7Kyza9nuJLqSe48rLUFaB2NXmMQ4dvQ2KQ2bKDEcq7uGgD5/pyu
         S75w==
X-Gm-Message-State: APjAAAXunaHmpHuYlMiCc35ekAXOIA8Qz1QEa91XIQ2BssSPhaK5osdb
        EahZS16FHfLULv4ByiwGOUs=
X-Google-Smtp-Source: APXvYqwNdFlfEvGETvtQkPzx2uUXeHrLSfdDsyGme4tg+9ysPo6anVAqrynEkzQm8qDaNIXw1jJ+8Q==
X-Received: by 2002:a67:6ec7:: with SMTP id j190mr8316132vsc.101.1576173738962;
        Thu, 12 Dec 2019 10:02:18 -0800 (PST)
Received: from quaco.ghostprotocols.net ([177.195.210.207])
        by smtp.gmail.com with ESMTPSA id i20sm4248987vkn.51.2019.12.12.10.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 10:02:18 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A9CD40352; Thu, 12 Dec 2019 15:02:14 -0300 (-03)
Date:   Thu, 12 Dec 2019 15:02:13 -0300
To:     Ed Maste <emaste@freefall.freebsd.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>, emaste@freebsd.org,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf list: remove name from L1D_RO_EXCL_WRITES
 description
Message-ID: <20191212180213.GI13965@kernel.org>
References: <20191212145346.5026-1-emaste@freefall.freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212145346.5026-1-emaste@freefall.freebsd.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 12, 2019 at 02:53:46PM +0000, Ed Maste escreveu:
> From: Ed Maste <emaste@freebsd.org>
> 
> In 7fcfa9a2d9 an unintended prefix "Counter:18 Name:" was removed from
> the description for L1D_RO_EXCL_WRITES, but the extra name remained in
> the description.  Remove it too.

Also trivially correct, applied and added a Fixes tag with that cset
(7fcfa9a2d9).

- Arnaldo
 
> Signed-off-by: Ed Maste <emaste@freebsd.org>
> ---
>  tools/perf/pmu-events/arch/s390/cf_z14/extended.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
> index e6478dff0af7..4942b20a1ea1 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
> @@ -4,7 +4,7 @@
>  		"EventCode": "128",
>  		"EventName": "L1D_RO_EXCL_WRITES",
>  		"BriefDescription": "L1D Read-only Exclusive Writes",
> -		"PublicDescription": "L1D_RO_EXCL_WRITES A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
> +		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
>  	},
>  	{
>  		"Unit": "CPU-M-CF",
> -- 
> 2.24.0

-- 

- Arnaldo
