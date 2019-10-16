Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E2EFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B431E2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392374AbfJPKlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:41:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43388 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfJPKlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:41:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 332E06C094A5466FB9A7;
        Wed, 16 Oct 2019 18:41:15 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 18:41:05 +0800
Subject: Re: [PATCH] perf jevents: Fix resource leak in process_mapfile()
To:     Yunfeng Ye <yeyunfeng@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <lukemujica@google.com>, <kan.liang@linux.intel.com>,
        <yuzenghui@huawei.com>
References: <bf113089-e3cd-50f9-f7ed-17d07512a702@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <linfeilong@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <87e66585-1564-3523-59f6-cab15b7e1717@huawei.com>
Date:   Wed, 16 Oct 2019 11:40:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <bf113089-e3cd-50f9-f7ed-17d07512a702@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2019 08:47, Yunfeng Ye wrote:
> There are memory leaks and file descriptor resource leaks in
> process_mapfile().
>
> Fix this by adding free() and fclose() on the error paths.
>
> Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
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

There's a subtle change of behaviour here, i.e. now calling 
print_mapping_table_suffix(), but I don't think that it makes any 
difference.

However, does outfp remain open also in this case:

main(int argc, char *argv[])
{
...

if (process_mapfile(eventsfp, mapfile)) {
	pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
	/* Make build fail */
	return 1;
}

return 0;

empty_map:
	fclose(eventsfp);
	...
}

I think that this code works on the basis that the program exits on any 
sort of error and releases resources automatically. Having said that, it 
is a good practice to tidy up.

John

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
>


