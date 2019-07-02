Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA9BC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F12E2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpSAyqlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGBP5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:57:35 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:47066 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:57:35 -0400
Received: by mail-qk1-f194.google.com with SMTP id r4so9238qkm.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JmDRDsaiTAvNz09zPKj9Qnqocr/diRUogR8+llXYcIo=;
        b=HpSAyqlWTk7vFpx041op7veM0uf8hhopdUh0kEbzfTY2PN4fy466M3HIRlGd8bom+I
         mvyDvpHJxRFO71GbiwZOmerf/qFt4wJjVXL3X4G10l+hCmorGTWUvKtGh5hn1Opg/GvV
         wRoNzhQ+IatWtzyPu6ddNmfstpD0qK8sVTai4c30UUMr7TwpGfZAVJlpYPqn3ROVR9nC
         NE9mEQRIfl16oAWsfIWtzQUpTpa7owJQtaLNMuJGxZUcVSxal3xVS2kI1I7zuVJnL9lO
         ImOcrGQ6Y4nLHdE5GecnshEows7eMN3nOM9OrLEkWeiVrRh0dWiuFwPx509/YcGQa3by
         zXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JmDRDsaiTAvNz09zPKj9Qnqocr/diRUogR8+llXYcIo=;
        b=NG78Gucd8kNYeszvNb/VZSgsjh340Pk3dTWK+vfnABF6AYkUZJ4a1o4cMTAr/OBhQi
         vtaK4DvyUFAP9mf9JAlUrpQFCIH3+3+AEdDTGouCYdO80CFVkxfu2iTV8gt50UEMeub/
         nTACkXdLX7TjA5slEXiifbzZyR0+Q8FFKM0qOWTvI6Vloi10lz/oO1IxP5gjuJrLIK4a
         GUip888NMWDq1Pf1vi0qs5oEQU1b+JTM3Mmp6f9s7cG35LsprvCjyBktk7Ws6ImD2Jnl
         WbUDLGuarOPl4RQt3hzFxBO2GJHNs77FhHMxTV9GCPnkmVlqrWodw3hbI25iYihffynV
         nKdA==
X-Gm-Message-State: APjAAAUL2hENeYZB/xSSnTEYlyxt5SmAfGuPOez91QQJSOISoAu8LV1M
        ADQTauYMFEtGXYZltUZFwpY=
X-Google-Smtp-Source: APXvYqwKUceIM9ndg850YBBCZq7fP9nF23P00ngYa6QeSlBWeKPcEFhQCpCl+FgZYzDrTX+JxcFuFw==
X-Received: by 2002:ae9:eb96:: with SMTP id b144mr24769942qkg.321.1562083054478;
        Tue, 02 Jul 2019 08:57:34 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id g13sm6314594qkm.17.2019.07.02.08.57.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 08:57:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 88B3C41153; Tue,  2 Jul 2019 12:57:31 -0300 (-03)
Date:   Tue, 2 Jul 2019 12:57:31 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf tools: Fix typos / broken sentences
Message-ID: <20190702155731.GF15462@kernel.org>
References: <20190628220900.13741-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628220900.13741-1-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 28, 2019 at 03:09:00PM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> - Fix a typo in the man page
> - Fix a tip that doesn't make any sense.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-report.txt | 2 +-
>  tools/perf/Documentation/tips.txt        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 8c4372819e11..987261d158d4 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -89,7 +89,7 @@ OPTIONS
>  	- socket: processor socket number the task ran at the time of sample
>  	- srcline: filename and line number executed at the time of sample.  The
>  	DWARF debugging info must be provided.
> -	- srcfile: file name of the source file of the same. Requires dwarf
> +	- srcfile: file name of the source file of the samples. Requires dwarf
>  	information.
>  	- weight: Event specific weight, e.g. memory latency or transaction
>  	abort cost. This is the global weight.
> diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
> index 869965d629ce..825745a645c1 100644
> --- a/tools/perf/Documentation/tips.txt
> +++ b/tools/perf/Documentation/tips.txt
> @@ -38,6 +38,6 @@ To report cacheline events from previous recording: perf c2c report
>  To browse sample contexts use perf report --sample 10 and select in context menu
>  To separate samples by time use perf report --sort time,overhead,sym
>  To set sample time separation other than 100ms with --sort time use --time-quantum
> -Add -I to perf report to sample register values visible in perf report context.
> +Add -I to perf record to sample register values, which will be visible in perf report sample context.
>  To show IPC for sampling periods use perf record -e '{cycles,instructions}:S' and then browse context
>  To show context switches in perf report sample context add --switch-events to perf record.
> -- 
> 2.20.1

-- 

- Arnaldo
