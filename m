Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D999ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6272089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfJOIr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:47:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfJOIr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:47:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 259FB7F746;
        Tue, 15 Oct 2019 08:47:56 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3608C19C68;
        Tue, 15 Oct 2019 08:47:54 +0000 (UTC)
Date:   Tue, 15 Oct 2019 10:47:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] perf c2c: fix memory leak in build_cl_output()
Message-ID: <20191015084753.GD10951@krava>
References: <4d3c0178-5482-c313-98e1-f82090d2d456@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3c0178-5482-c313-98e1-f82090d2d456@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 15 Oct 2019 08:47:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:54:14AM +0800, Yunfeng Ye wrote:
> There is a memory leak problem in the failure paths of
> build_cl_output(), so fix it.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-c2c.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 3542b6a..e69f449 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2635,6 +2635,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
>  	bool add_sym   = false;
>  	bool add_dso   = false;
>  	bool add_src   = false;
> +	int ret = 0;
> 
>  	if (!buf)
>  		return -ENOMEM;
> @@ -2653,7 +2654,8 @@ static int build_cl_output(char *cl_sort, bool no_source)
>  			add_dso = true;
>  		} else if (strcmp(tok, "offset")) {
>  			pr_err("unrecognized sort token: %s\n", tok);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto err;
>  		}
>  	}
> 
> @@ -2676,13 +2678,15 @@ static int build_cl_output(char *cl_sort, bool no_source)
>  		add_sym ? "symbol," : "",
>  		add_dso ? "dso," : "",
>  		add_src ? "cl_srcline," : "",
> -		"node") < 0)
> -		return -ENOMEM;
> +		"node") < 0) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> 
>  	c2c.show_src = add_src;
> -
> +err:
>  	free(buf);
> -	return 0;
> +	return ret;
>  }
> 
>  static int setup_coalesce(const char *coalesce, bool no_source)
> -- 
> 2.7.4.3
> 
