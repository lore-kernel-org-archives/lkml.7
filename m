Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB645C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8644206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFFfO9Yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfLLR5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:57:23 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38183 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbfLLR5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:57:22 -0500
Received: by mail-vs1-f68.google.com with SMTP id y195so2211147vsy.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K7vOpUXob2e3Hdh+2YsZBG6Im8Xv28LTEisQhfwz8SM=;
        b=tFFfO9Ynl5cCgc0gho5rF165zWHsyFo+ddFAi/FdNodQxWgpDZZYcDe39igBpa+TQp
         fafCDGIhF/eFyrPTSQMJ9Q2/Fc7ZhrcFXETxf1oJBbaaHHpw4q21v0guglH2Eq4yUwin
         yEJ1l/jbLEYi1GA1DZr4OgPA2HbV+QFo9c8pY8GDoVOwfd7qhdQMG6yYF4kff+81wrAm
         sqLY+cb2Ncj0lSIYGpYXYCrjkvqvA0g1HaieDNnGRLIAWr14VYxiDfEwk788qaiLqwQ/
         Agiajn68NWHyNx8t9YOIBkujVBclLDQ+jiMl8oUGsgh7YaCHRsBN/591T3/7g7V2V7Xf
         25wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K7vOpUXob2e3Hdh+2YsZBG6Im8Xv28LTEisQhfwz8SM=;
        b=d04pjdXcf0UVFSV1FML5sYw5y3vXbjiB0l1uhS+hkADXh13xRUMtQlnei6B3mgVHV8
         cbAT5eOKfylCOSQbH0SFpl7QYJQKDuGujHzhpdlzAjCKXy1W9esc7+ln9xGrj2PMdPCz
         g/kTu6Uepl3ZZS4g+i4HeAQdZUuEzYk1zBRPGrR44c4LVHsD5pQpnhSP4OwWfe6brU1U
         bh76iRW/XU7hnz2AfSyED9WoH0bJnwP8YAbwAzpRgRBmRGwVTTaAZjQUaICPk/sQewD9
         lHKQdb7H+uLfBxUxIpZeyb67j1fuY4MC57znYuHgw01KfhX3oORF5206WfRgSJnou6KR
         +6DQ==
X-Gm-Message-State: APjAAAXmnx4kCf9MNAft/MIkdNZYY8d73Rok4Uu39kWaZboqhx4SsOll
        ithIgxrOFsNJXtVuyX2jcgc=
X-Google-Smtp-Source: APXvYqzS4JKSwQu7+tpjuaBYUnCX6B+Vwsq5a/HDs+EgEzUUnLf/AMCGJsk7qGTQz6MPXj6mf5thmw==
X-Received: by 2002:a05:6102:405:: with SMTP id d5mr7952349vsq.94.1576173441258;
        Thu, 12 Dec 2019 09:57:21 -0800 (PST)
Received: from quaco.ghostprotocols.net ([177.195.210.207])
        by smtp.gmail.com with ESMTPSA id j24sm4165791vki.37.2019.12.12.09.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 09:57:20 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DC43240352; Thu, 12 Dec 2019 14:57:16 -0300 (-03)
Date:   Thu, 12 Dec 2019 14:57:16 -0300
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
Subject: Re: [PATCH] perf list: Fix s390 counter long description for
 DTLB1_GPAGE_WRITES
Message-ID: <20191212175716.GH13965@kernel.org>
References: <20191212143446.88582-1-emaste@freefall.freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212143446.88582-1-emaste@freefall.freebsd.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 12, 2019 at 02:34:46PM +0000, Ed Maste escreveu:
> From: Ed Maste <emaste@freebsd.org>
> 
> cf_z13 counter DTLB1_GPAGE_WRITES included a prefix 'Counter:132\tName:'.
> This is incorrect; remove the prefix as with 7fcfa9a2d9 for cf_z14.

Looks obviously right, applying.

- Arnaldo
 
> Signed-off-by: Ed Maste <emaste@freebsd.org>
> ---
>  tools/perf/pmu-events/arch/s390/cf_z13/extended.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
> index 62e6bdf750dd..1a5e4f89c57e 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
> @@ -32,7 +32,7 @@
>  		"EventCode": "132",
>  		"EventName": "DTLB1_GPAGE_WRITES",
>  		"BriefDescription": "DTLB1 Two-Gigabyte Page Writes",
> -		"PublicDescription": "Counter:132	Name:DTLB1_GPAGE_WRITES A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a two-gigabyte page."
> +		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a two-gigabyte page."
>  	},
>  	{
>  		"Unit": "CPU-M-CF",
> -- 
> 2.24.0

-- 

- Arnaldo
