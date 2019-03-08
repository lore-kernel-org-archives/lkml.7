Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0EAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4CC20868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqMNhRtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfCHRdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:33:13 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39299 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHRdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:33:13 -0500
Received: by mail-qt1-f193.google.com with SMTP id o6so22076202qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 09:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pa3zynBilQ2pYo/NBQ9cRSVT4c4yJIGrC1V57I3Z8Cw=;
        b=cqMNhRtcQc5j0o9Jxp/yYYPz+0ZXMna0eW96+T/FOMyAbYztmVAygSnofiMq+Y8d7k
         /5gbIH0r4XMMhM+jDgJeOuRlechNA0HCJJnPS70Hevvr0OHB/PAVIkaX3tH0TwCr+h9Q
         FN1dPtxepnGCvW4ImMNhmlU6nnFA7/XNiH4c5gE6179cdqkiGPXXWscyXbNrwlFJsFIZ
         TNC4DQ5raDRCyhvengrwlJl9DYKsULatzi9FbHtSpm7gfFpEiG1tuDmVc8cBul54Reb0
         8nYMk7v+nfFoyzblf1JMU4d94l+1wpuw/rK+X8VlwNH9OzJRqhLHrEVDwBtnfjIFPohj
         IhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pa3zynBilQ2pYo/NBQ9cRSVT4c4yJIGrC1V57I3Z8Cw=;
        b=lNxz60Zk4EJfz3TVZgz+m2RskONFY9yRjCbJnn4DJLjPdsTSOPDowyWUt/lTuMHrTh
         2leGF1T528JVCESAtnlXPZXArpdb16T2qZ17WYRdANx1gEMy6Y9/0T6/s5niQNEidY37
         LX5G5sjmPzi/4vfOPacgR24ob0TDRJy0ePhZGPh5jXG8XGzlCaSqmvdpRd5KB+1nujcf
         f09ExObW2HJoRpSKLjyxx3jp9GgklosM5yYmn89wcb582p4L6MfgoYiwrxlX8qEyh2iN
         BTkSCOcb1lxi5Owr+71gywsTzDQA44z8dVDjzhjBevgmBn9OQQkyLqXhkXH1ms+uASzq
         fP/A==
X-Gm-Message-State: APjAAAX1Zo8xtDB4R+G2eMWBDS96I/ywhlgtIop9DxIr9Pd8tC2Brv3f
        AirmrUYZemcMQA5pc4cghIQ=
X-Google-Smtp-Source: APXvYqwkzRKlrP6jtKprTraVl4hZnVzhHbTtwxqZxXWBAyX77xoBDHVS/vEnfgNA7HS6sJ/qQhqjGw==
X-Received: by 2002:ac8:1851:: with SMTP id n17mr15291052qtk.42.1552066392399;
        Fri, 08 Mar 2019 09:33:12 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id s41sm4899254qtc.38.2019.03.08.09.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 09:33:11 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 75D8D4039C; Fri,  8 Mar 2019 14:33:05 -0300 (-03)
Date:   Fri, 8 Mar 2019 14:33:05 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 04/11] perf data: Make perf_data__size to work over
 directory
Message-ID: <20190308173305.GE10690@kernel.org>
References: <20190308134745.5057-1-jolsa@kernel.org>
 <20190308134745.5057-5-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308134745.5057-5-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 08, 2019 at 02:47:38PM +0100, Jiri Olsa escreveu:
> Making perf_data__size to return proper size
> for directory data.
> 
> Link: http://lkml.kernel.org/n/tip-t4dm8cctat2ginmy2bb08xe8@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/data.c | 17 +++++++++++++++++
>  tools/perf/util/data.h |  6 +-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index d568975c5ee3..498c531e2cb9 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -393,3 +393,20 @@ int perf_data__switch(struct perf_data *data,
>  	free(new_filepath);
>  	return ret;
>  }
> +
> +unsigned long perf_data__size(struct perf_data *data)
> +{
> +	u64 size = data->file.size;
> +	int i;
> +
> +	if (!data->is_dir)
> +		return size;

So you do the sum over dir.files[i] _plus_ what is in data->file.size,
what is in data->file.size? Zero for the dir case? Or some non-per-cpu
metadata?

- Arnaldo

> +
> +	for (i = 0; i < data->dir.nr; i++) {
> +		struct perf_data_file *file = &data->dir.files[i];
> +
> +		size += file->size;
> +	}
> +
> +	return size;
> +}
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index 0deeb1af9f54..d342469bdfda 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -54,11 +54,6 @@ static inline int perf_data__fd(struct perf_data *data)
>  	return data->file.fd;
>  }
>  
> -static inline unsigned long perf_data__size(struct perf_data *data)
> -{
> -	return data->file.size;
> -}
> -
>  int perf_data__open(struct perf_data *data);
>  void perf_data__close(struct perf_data *data);
>  ssize_t perf_data__write(struct perf_data *data,
> @@ -80,4 +75,5 @@ int perf_data__create_dir(struct perf_data *data, int nr);
>  int perf_data__open_dir(struct perf_data *data);
>  void perf_data__close_dir(struct perf_data *data);
>  int perf_data__update_dir(struct perf_data *data);
> +unsigned long perf_data__size(struct perf_data *data);
>  #endif /* __PERF_DATA_H */
> -- 
> 2.17.2

-- 

- Arnaldo
