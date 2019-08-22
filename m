Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1B9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADBB20870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxIyKWuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390739AbfHVVYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:24:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45192 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbfHVVYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:24:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so6467861qki.12;
        Thu, 22 Aug 2019 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fGMHwmLZtQlLJtrdcUD+HwKBDGb+ADX9zeL4WMTeND8=;
        b=BxIyKWuMtl0HQHTny/43dSS5JOhPx18kPJM+JANGAdVTO/tNzWroWNliJqQyCCMO1s
         dBRufq7H16b7EsGTIlvcEJ3UfgevqfEpqyJP7gx0h8RwsL+5zI1+iwG2saehEWwf9mBy
         rVLwg7YwFhhQnEpjZ1aVgg/oZJT/HXsUUhooXmYg1aS77gVw00v0z8Rne/cphEwb4+/A
         U8P8U3ULU526Mq/2KWsFGYbWs524rxJnPVD/syGbtlJiGyCv29HDM/KXgwBIjqPfbYKb
         mAR4XdYsFULdCl2M9k9uGWJzP37mNPyxidl8efWr7HNw9v+tYyZniIVB96ZS30+h0u/i
         JLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fGMHwmLZtQlLJtrdcUD+HwKBDGb+ADX9zeL4WMTeND8=;
        b=RRLnnrkZdHbW9x1gOjKFFcvxZNFJ7U7HNz/Glfih96IgSkXESA/rsygL6gnYJrHzET
         W3IxoGbtRVBckjFvRL6Be6iNeLaPeqEGjNhrZ5FOapwFj8nPJIjAjNQ/YJ1u25X2d6VZ
         OSOLdWFiHPxEntVYlYERg4FoX9Gaaleajaw0oqIrjvhVKlri1AlzcEuirFriue4209gj
         WybyLzlq1AEN7W9CxeIYbMx43Tu1H106ymxm9gt3pOHEzVGLWD9n7PqqwbGPZq5mT/hy
         BEdvJ1TUUZ/G8f+OlpJafEHHUTvtdbArhdak94ganSPuEZ3hAC/IUwyjs5qD5OmnFcMT
         QDpA==
X-Gm-Message-State: APjAAAV/EzA0Zy3b0eqqG4cJS+7a+N7PAxHqkDHaOmgO555T8KrcEgVn
        DppQl3UIkfRFSmsugooVJvM=
X-Google-Smtp-Source: APXvYqzi4XdlBdtcE6Og/zlWx9ifhUXCGEg1dQA8Q0eASeFp7cLE72vPWQfGviWUROjRN+OCXq1Yxg==
X-Received: by 2002:a05:620a:151b:: with SMTP id i27mr1098648qkk.78.1566509054279;
        Thu, 22 Aug 2019 14:24:14 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.158.141.211])
        by smtp.gmail.com with ESMTPSA id x5sm324272qts.14.2019.08.22.14.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 14:24:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 492FA40340; Thu, 22 Aug 2019 18:24:07 -0300 (-03)
Date:   Thu, 22 Aug 2019 18:24:07 -0300
To:     James Clark <James.Clark@arm.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>
Subject: Re: [PATCH] Fixes hang in zstd compression test by changing the
 source of random data.
Message-ID: <20190822212407.GJ3929@kernel.org>
References: <3d8cc701-df4e-f949-1715-5118b530e990@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d8cc701-df4e-f949-1715-5118b530e990@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 22, 2019 at 01:55:15PM +0000, James Clark escreveu:
> Running 'perf test' with zstd compression linked will hang at the test
> 'Zstd perf.data compression/decompression' because /dev/random blocks
> reads until there is enough entropy. This means that the test will
> appear to never complete unless the mouse is continually moved while
> running it.

message came mangled, had to do it by hand and then hook up your header
so as to get the correct date, attribution, etc, please check
Documentation/process/email-clients.rst,

- Arnaldo
 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/shell/record+zstd_comp_decomp.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> index 899604d1..63a91ec 100755
> --- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> +++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
> @@ -13,7 +13,7 @@ skip_if_no_z_record() {
>  collect_z_record() {
>  	echo "Collecting compressed record file:"
>  	$perf_tool record -o $trace_file -g -z -F 5000 -- \
> -		dd count=500 if=/dev/random of=/dev/null
> +		dd count=500 if=/dev/urandom of=/dev/null
>  }
>  
>  check_compressed_stats() {
> -- 
> 2.7.4
> 

-- 

- Arnaldo
