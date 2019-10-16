Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EA0FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F96218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtzSFNoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393973AbfJPOZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:25:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34810 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfJPOZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:25:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id 3so36434566qta.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y4EQYL75ejH4E6buXrBDGLhTfNE3a0xcUuB5fdXMSbo=;
        b=rtzSFNoFtdbPX0n8kfiZENC2xSjazQH8VXjl9lodLsafn/bABXG9TXSs0/kdUUx49A
         gNRnTmxQDl5DnoqzJqNKjWxGYsTf69VTnLEEIElF0SWvSQMRXcMa2EC6AeT7iQG6hnio
         GYrSQXmF43e2/8JQ/5Zspa043MM34PVWSLfg2BlolIhRENpR04W2mgjKM5X3zld8l6Z9
         4nLiL5fZ6CmzKmatDtB/QRcSi3HcW5owvdGVfm1uDdTz+x4S3/loVNC27Y5rTX0KMYMm
         mO8f2Z7Rx4xoMttbjtqI6Uk5XPLVc3IGIJTDf7IRoBc02J7/IpLRQYAwGDZOiGRW/7vP
         jjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y4EQYL75ejH4E6buXrBDGLhTfNE3a0xcUuB5fdXMSbo=;
        b=lR76+F5blb4eroMoFROG3aY8JTesz4jhLpKCl64JgGGUODGJK3+IfxM850lkQAXvqZ
         Wa5MfDjdITLy2XL2NFjPTz9+hsbLIBpJZG9eooRY3+sNmOc+2rLMn/eRSZFQmO6v48Vy
         U/pkzafgQQKd9NKj6G3xoPgf5Mj2VkcRcI+0br7DLdfH+7bzDcGkfXdeyR7TpbomuFjU
         Mku25/rOTHnW+sf0iM3AL3ZWdXHGWj2oadZHQoyLtjtrOfqnOCs24kisdRCglb46Sl5V
         mtwQ751E/sgpyL1AP5gZaxuH1T7Uq8c0RPBRVl06T15waHP5aExobagF/XMGC5xJKd7m
         TqgQ==
X-Gm-Message-State: APjAAAUSKJlq+ddXvk7f7Dd96otojqeMh1e96Ewv7Y4ZrjrMi7u7L1HA
        AiSiKpZqeODNyoiTctdVUWE=
X-Google-Smtp-Source: APXvYqzD1v6TJW8bih7yFjzHROo8CWUW8NXrkF/wDyyIyq5kgr0wRo7Dk7CzVMWeZevM2jxfVnOOrQ==
X-Received: by 2002:a0c:bf45:: with SMTP id b5mr41462664qvj.150.1571235938895;
        Wed, 16 Oct 2019 07:25:38 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id r55sm13644479qtj.86.2019.10.16.07.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:25:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3C2554DD66; Wed, 16 Oct 2019 11:25:36 -0300 (-03)
Date:   Wed, 16 Oct 2019 11:25:36 -0300
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, john.garry@huawei.com, ak@linux.intel.com,
        lukemujica@google.com, kan.liang@linux.intel.com,
        yuzenghui@huawei.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hushiyuan@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH v2] perf jevents: Fix resource leak in process_mapfile()
 and main()
Message-ID: <20191016142536.GH22835@kernel.org>
References: <d7907042-ec9c-2bef-25b4-810e14602f89@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7907042-ec9c-2bef-25b4-810e14602f89@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 16, 2019 at 09:50:17PM +0800, Yunfeng Ye escreveu:
> There are memory leaks and file descriptor resource leaks in
> process_mapfile() and main().
> 
> Fix this by adding free(), fclose() and free_arch_std_events()
> on the error paths.
> 
> Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
> Fixes: 3f056b66647b ("perf jevents: Make build fail on JSON parse error")
> Fixes: e9d32c1bf0cd ("perf vendor events: Add support for arch standard events")

Nice, thanks for adding the fixes line, I looked at those three patches
and indeed they were leaky, thanks for the fixes, we shouldn't have
those leaks even if that, for now, makes the tool to end anyway.

- Arnaldo

> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
> v1 -> v2:
>  - add free(eventsfp) to fix eventsfp resource leaks
>  - add free_arch_std_events() on the error path
> 
>  tools/perf/pmu-events/jevents.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index e2837260ca4d..99e3fd04a5cb 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -758,6 +758,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
>  	char *line, *p;
>  	int line_num;
>  	char *tblname;
> +	int ret = 0;
> 
>  	pr_info("%s: Processing mapfile %s\n", prog, fpath);
> 
> @@ -769,6 +770,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
>  	if (!mapfp) {
>  		pr_info("%s: Error %s opening %s\n", prog, strerror(errno),
>  				fpath);
> +		free(line);
>  		return -1;
>  	}
> 
> @@ -795,7 +797,8 @@ static int process_mapfile(FILE *outfp, char *fpath)
>  			/* TODO Deal with lines longer than 16K */
>  			pr_info("%s: Mapfile %s: line %d too long, aborting\n",
>  					prog, fpath, line_num);
> -			return -1;
> +			ret = -1;
> +			goto out;
>  		}
>  		line[strlen(line)-1] = '\0';
> 
> @@ -825,7 +828,9 @@ static int process_mapfile(FILE *outfp, char *fpath)
> 
>  out:
>  	print_mapping_table_suffix(outfp);
> -	return 0;
> +	fclose(mapfp);
> +	free(line);
> +	return ret;
>  }
> 
>  /*
> @@ -1122,6 +1127,7 @@ int main(int argc, char *argv[])
>  		goto empty_map;
>  	} else if (rc < 0) {
>  		/* Make build fail */
> +		fclose(eventsfp);
>  		free_arch_std_events();
>  		return 1;
>  	} else if (rc) {
> @@ -1134,6 +1140,7 @@ int main(int argc, char *argv[])
>  		goto empty_map;
>  	} else if (rc < 0) {
>  		/* Make build fail */
> +		fclose(eventsfp);
>  		free_arch_std_events();
>  		return 1;
>  	} else if (rc) {
> @@ -1151,6 +1158,8 @@ int main(int argc, char *argv[])
>  	if (process_mapfile(eventsfp, mapfile)) {
>  		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
>  		/* Make build fail */
> +		fclose(eventsfp);
> +		free_arch_std_events();
>  		return 1;
>  	}
> 
> -- 
> 2.7.4.3

-- 

- Arnaldo
