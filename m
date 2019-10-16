Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B0C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB6620650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404502AbfJPKL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:11:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730479AbfJPKL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:11:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0EFA315C036;
        Wed, 16 Oct 2019 10:11:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 35CD75D6B2;
        Wed, 16 Oct 2019 10:11:23 +0000 (UTC)
Date:   Wed, 16 Oct 2019 12:11:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, john.garry@huawei.com, ak@linux.intel.com,
        lukemujica@google.com, kan.liang@linux.intel.com,
        yuzenghui@huawei.com, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] perf jevents: Fix resource leak in process_mapfile()
Message-ID: <20191016101122.GB15580@krava>
References: <bf113089-e3cd-50f9-f7ed-17d07512a702@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf113089-e3cd-50f9-f7ed-17d07512a702@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 16 Oct 2019 10:11:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:47:23PM +0800, Yunfeng Ye wrote:
> There are memory leaks and file descriptor resource leaks in
> process_mapfile().
> 
> Fix this by adding free() and fclose() on the error paths.
> 
> Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/pmu-events/jevents.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index e2837260ca4d..6e60d4cff592 100644
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
> -- 
> 2.7.4.3
> 
