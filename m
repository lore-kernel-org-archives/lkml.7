Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61499C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E85D22BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFp5IHLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbfGZTAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:00:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42146 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbfGZTAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:00:22 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so39805046qkm.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pl5ZN1tIu5/f+o27SPQ4FfIyyDR7u8qs0vTKkb7CN1M=;
        b=pFp5IHLHW8CTyLie7a8MsAEoDNc93Am5xK3dtCwExeles2LhWiQW8xrxwrHSEFqJWG
         ecSJFgJttfSutkNyJDbDf9QTbwlbabzeO15afanO6IoLbA4opfIQxeEKTofX+oP7qF0H
         42P0u4FcWU0TtHauixXj+EefF04hTppV525N7MIUjXrRw2T+m5LQmsBHUpfmdU43OOSX
         3ZdWytU14AaIuX3WNP8kQzyIfPm7UV9UwZsu6xIhUSOU7gwR1xDg3+lwLJNvvoNOhiw8
         P1tlWEwYzjBG9stoHsjsoibXlap8iuhmDrpqDEtUS8rekUXQn6Pgg8hKTkOT+vOtLyWg
         PsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pl5ZN1tIu5/f+o27SPQ4FfIyyDR7u8qs0vTKkb7CN1M=;
        b=Z6/Qrd69jpeBjOhzdG2BzBGTtjWDvbuyBrhLHSTtQ7HjVQe6u9tf/vFCwHefzEdVlR
         r4ng8Q3x3rDqtZHjY7M5PtY2NM8VXVAxw+H96OP7tbYC4qsouUYepOnoxFqhVCM6df9G
         tBvyJkBvROCjWb7+0FKwbfkhDlhGh9AU4b10h27Oqr8tCAShGaLwzQ1wPdweJvksm/uM
         rXMdw1Bq1dXx10Z2QXPsUUXzRv4DZ9mbTD8BXGtiUEiFmAHnWOiiulYDNcl4oLqb4j7W
         XDzeS9E8eyHA5mBT+i2vmSs1AsHuVzZ5DagEdh6ul3AZ0oXYclTXRZKfbZ/QOXpK9Zcc
         xTIQ==
X-Gm-Message-State: APjAAAWcROcUAc9lvikojKo1eq11yIDqnNvhIKGILnS5PctINCvt70Jf
        bkzIQRbO7gsdFCXCKJ3u9B4=
X-Google-Smtp-Source: APXvYqw5uq0WY9ULjYNMUZ+VcJFBLA1vnIakQwp1uJE1Gj+J65gwfgHG79KWhQDXjDVWjAGfatMG+A==
X-Received: by 2002:a37:648:: with SMTP id 69mr64381529qkg.248.1564167621387;
        Fri, 26 Jul 2019 12:00:21 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id o10sm27071131qti.62.2019.07.26.12.00.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:00:19 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8561F40340; Fri, 26 Jul 2019 16:00:16 -0300 (-03)
Date:   Fri, 26 Jul 2019 16:00:16 -0300
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [patch] perf tool divide by zero error if f_header.attr_size==0
Message-ID: <20190726190016.GB20482@kernel.org>
References: <alpine.DEB.2.21.1907231100440.14532@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907231100440.14532@macbook-air>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 23, 2019 at 11:06:01AM -0400, Vince Weaver escreveu:
> Hello
> 
> so I have been having lots of trouble with hand-crafted perf.data files 
> causing segfaults and the like, so I have started fuzzing the perf tool.
> 
> First issue found:
> 
> If f_header.attr_size is 0 in the perf.data file, then perf will crash
> with a divide-by-zero error.
> 
> Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>


I added this on top:

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 25f89d0790fe..47877f0f6667 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3560,6 +3560,9 @@ int perf_session__read_header(struct perf_session *session)
        }

        if (f_header.attr_size == 0) {
+               pr_err("ERROR: The %s file's attr size field is 0 which is unexpected.\n"
+                      "Was the 'perf record' command properly terminated?\n",
+                      data->file.path);
                return -EINVAL;
        }

[acme@quaco perf]$

Thanks, applied.

- Arnaldo

> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index c24db7f4909c..26df60ee9460 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3559,6 +3559,10 @@ int perf_session__read_header(struct perf_session *session)
>  			   data->file.path);
>  	}
>  
> +	if (f_header.attr_size == 0) {
> +		return -EINVAL;
> +	}
> +
>  	nr_attrs = f_header.attrs.size / f_header.attr_size;
>  	lseek(fd, f_header.attrs.offset, SEEK_SET);
>  

-- 

- Arnaldo
