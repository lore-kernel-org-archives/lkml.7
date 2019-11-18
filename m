Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9DDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA768222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euXZ0k0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKRWBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:01:51 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37381 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRWBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:01:51 -0500
Received: by mail-qk1-f194.google.com with SMTP id e187so15959424qkf.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 14:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bd0rusYl5yZEO/vYsRZfpOV3cgBDpXyCK6zFjVeNYEg=;
        b=euXZ0k0L1UVJoY+d1LWqxLDI3vYxY19jStFaZtYQ7m4urPFI/DIYYvRnbUcD9U8O61
         lOo4/PVn5iwaVwcMhPnZKiGBX5UuXAB35/tFFaCbw/0MjNGam9gwaAQMl8s64uYW337J
         md7iK6xwo+N3wvYBsoHzH40iXic3XpyJCkukyhlTEMGnGgA2Wc15KhufE8C3OcyjBofq
         E52ZP2Oeo3L6eXrB0evf06rtx56xs2G6GZa8NTYk3nuST+vFCd/a5r+Rxkrht+coX88i
         fxUzmtoTvUCV9z5t30ypRys8SWy7E54LcEGFlm3y4q3RMnDsKDb9GGCKEnUNPm00pVvh
         bYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bd0rusYl5yZEO/vYsRZfpOV3cgBDpXyCK6zFjVeNYEg=;
        b=o+GjnUk0ljJ46IrKid6+2s0q239DJSdhBA6KRw91YzgIAjtxJ4EYNN/c/nHRocwSV4
         D2nWaQ3pXbZ/PIrGP/CZO+a2fDJMAJU0uc+RGNaI7TlecoqAnlJuSMV1whDCkGQhST8k
         RUhu/bstkoufCm1/Gjy4od8hBrzub1N/03cbvNVxo6COb53Tfpm7ccBPpeSZ6v72Pp4i
         P3zyWwhfvco9pXt6nN31wZ4SVa3Aqg6KXFqE12rv4ignHZAUGDerjfJrhzuDhjvJCOYh
         Ja3GixnRfdET+reRWAErYTCv2YsVzeZ+1NXwWlvrZmRSPVxMXjxk5uNKnsZ/sl3DG27Z
         3g7Q==
X-Gm-Message-State: APjAAAUR9bqcH4vBA1vzHgG73rrXr2Rsh8SmDy0BQj47XpMKo45gRIR3
        rlpdfO/QYRmMt8FGo4nqjbm2abXErFQ=
X-Google-Smtp-Source: APXvYqy6dUNg6wxLRydDMXsh9WSGkYV1ruT4CaFkDDbJ2fcBvv3gL6vUC+g+yfGwILVUCDv29KNzGg==
X-Received: by 2002:a37:4884:: with SMTP id v126mr27195390qka.45.1574114510166;
        Mon, 18 Nov 2019 14:01:50 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id s63sm9202333qkf.129.2019.11.18.14.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 14:01:49 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9BECA40D3E; Mon, 18 Nov 2019 19:01:47 -0300 (-03)
Date:   Mon, 18 Nov 2019 19:01:47 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 3/7] perf probe: Do not show non representive lines by
 perf-probe -L
Message-ID: <20191118220147.GD20465@kernel.org>
References: <157406469983.24476.13195800716161845227.stgit@devnote2>
 <157406473064.24476.2913278267727587314.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157406473064.24476.2913278267727587314.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 18, 2019 at 05:12:10PM +0900, Masami Hiramatsu escreveu:
> Since perf probe -L shows non representive lines, it can be
> mislead users where user can put probes.
> This prevents to show such non representive lines so that user
> can understand which lines user can probe.
> 
>   # perf probe -L kernel_read
>   <kernel_read@/build/linux-pvZVvI/linux-5.0.0/fs/read_write.c:0>
>         0  ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
>            {
>         2         mm_segment_t old_fs;
>                   ssize_t result;
> 
>                   old_fs = get_fs();
>         6         set_fs(get_ds());
>                   /* The cast to a user pointer is valid due to the set_fs() */
>         8         result = vfs_read(file, (void __user *)buf, count, pos);
>         9         set_fs(old_fs);
>        10         return result;
>            }
>            EXPORT_SYMBOL(kernel_read);

Thanks, this fixes the problem I reported, applied.

- Arnaldo
 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-finder.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index ef1b320cedf8..f12ad507a822 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1734,12 +1734,19 @@ static int line_range_walk_cb(const char *fname, int lineno,
>  			      void *data)
>  {
>  	struct line_finder *lf = data;
> +	const char *__fname;
> +	int __lineno;
>  	int err;
>  
>  	if ((strtailcmp(fname, lf->fname) != 0) ||
>  	    (lf->lno_s > lineno || lf->lno_e < lineno))
>  		return 0;
>  
> +	/* Make sure this line can be reversable */
> +	if (cu_find_lineinfo(&lf->cu_die, addr, &__fname, &__lineno) > 0
> +	    && (lineno != __lineno || strcmp(fname, __fname)))
> +		return 0;
> +
>  	err = line_range_add_line(fname, lineno, lf->lr);
>  	if (err < 0 && err != -EEXIST)
>  		return err;

-- 

- Arnaldo
