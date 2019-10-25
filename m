Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82BBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C58621D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4k77EVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504159AbfJYMCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:02:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43646 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502539AbfJYMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:02:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id t20so2766368qtr.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U3muYkVb3sn/zD3GnI85KoquW1PDnagsDLGnaKlzxUg=;
        b=f4k77EVP3oB4TFXVyejNteYMnBZxJxaPv8yN3YKZaUih/akVpJpz0PNswqsYe66tUn
         N0ITsPRgnY4LreqhjwD5DBfzXKkKzwt1St7lMeCB0Yp8v2NQDZgGjx+M08dNoog9n7ZI
         mewMpnX+8qU3u0sHTOjU7bPeMnjmGHRoDoOV8EFtaaaH/XqVYF0VmiVm9R36gf+bh0bq
         65NWOFmTuUdi0Oe8GkOHKJOA94GrI7mONOr1/x4ChNNx+VnxHLPCTEjhVURKm3OeLg2K
         +13SambnQ31yajHSVkLMYDmQ6jrTVqGB0z4jtVAkFbYGxThNppfkbg7ZfNKkOV3645qt
         uWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U3muYkVb3sn/zD3GnI85KoquW1PDnagsDLGnaKlzxUg=;
        b=jueQwO7mho7iEp2P6s77sTqKlDmIxEF0Y2kgxUL7UA/oFcqILDAMu7eohVuM2H1fOX
         nAYU/oj//J6kM9wrbH/qBRFPQO9VcK66okwXtn4+acjsoe7iFaYH2h+IBiD6tfldRtJ+
         77sEV8WDMRgsR3wAdyUEU2pmrNAa/bWygMDRhlJqAlhO0Rt9x9gRzJAqYu6t1mwEDjV6
         pkZslgrHdI5q0S5XFqd2R3BMf79H5SVNijwfdTLC09rLhvaDuH+YQrRw3zysBxYeBP0f
         ut2NbpwbDbIJstozeSGzQprlrDwdFxQNYCBON7UAzuxcbjOWA/DNyUxHPUigIQiHt93A
         LYfA==
X-Gm-Message-State: APjAAAUQZF8VndASpE39ncg7PDOotIu/mVpTvan6iphN+WV7N+pR2cWo
        u+Q4YT/LvTRk0B+y+uuc9OE=
X-Google-Smtp-Source: APXvYqxyathMCAeGIRon/l7dS54Jlq7okRabEc4gt560TDidgz/g1QfGAoadWP2Sp4XPsfqiMddMXw==
X-Received: by 2002:ac8:2a31:: with SMTP id k46mr2663074qtk.392.1572004971789;
        Fri, 25 Oct 2019 05:02:51 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.179.80.16])
        by smtp.gmail.com with ESMTPSA id 144sm1083827qkj.5.2019.10.25.05.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:02:50 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5894041199; Fri, 25 Oct 2019 09:02:48 -0300 (-03)
Date:   Fri, 25 Oct 2019 09:02:48 -0300
To:     Hewenliang <hewenliang4@huawei.com>
Cc:     peterz@infradead.org, jolsa@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ilubashe@akamai.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, hushiyuan@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] perf tools: Call closedir to release the resource before
 we return
Message-ID: <20191025120248.GA23511@kernel.org>
References: <20191025031605.23658-1-hewenliang4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025031605.23658-1-hewenliang4@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 24, 2019 at 11:16:05PM -0400, Hewenliang escreveu:
> We should close the directory on pattern failure before the return
> of rm_rf_depth_pat.
> 
> Fixes: cdb6b0235f170 ("perf tools: Add pattern name checking to rm_rf")
> Signed-off-by: Hewenliang <hewenliang4@huawei.com>

I've already applied:

commit 6080728ff8e9c9116e52e6f840152356ac2fea56
Author: Yunfeng Ye <yeyunfeng@huawei.com>
Date:   Tue Oct 15 16:30:08 2019 +0800

    perf tools: Fix resource leak of closedir() on the error paths
    
    Both build_mem_topology() and rm_rf_depth_pat() have resource leaks of
    closedir() on the error paths.
    
    Fix this by calling closedir() before function returns.
    
    Fixes: e2091cedd51b ("perf tools: Add MEM_TOPOLOGY feature to perf data file")
    Fixes: cdb6b0235f17 ("perf tools: Add pattern name checking to rm_rf")
    Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
    Acked-by: Jiri Olsa <jolsa@kernel.org>

[acme@quaco perf]$ git tag --contains 6080728ff8e9c9116e52e6f840152356ac2fea56
perf-urgent-for-mingo-5.4-20191017
[acme@quaco perf]$ 

It is already in tip/perf/urgent, should get to Linus soon.

- Arnaldo

> ---
>  tools/perf/util/util.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 5eda6e19c947..1aadca8c43f3 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -154,8 +154,10 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
>  		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
>  			continue;
>  
> -		if (!match_pat(d->d_name, pat))
> +		if (!match_pat(d->d_name, pat)) {
> +			closedir(dir);
>  			return -2;
> +		}
>  
>  		scnprintf(namebuf, sizeof(namebuf), "%s/%s",
>  			  path, d->d_name);
> -- 
> 2.19.1

-- 

- Arnaldo
