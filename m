Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECADC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405D621019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANKFIAZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfEMTsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:48:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42025 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfEMTso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:48:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id d4so8809705qkc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sykOft9FFBUmilrQ1nPhLX+j0e/Ov648FW6a6gJmiZ0=;
        b=ANKFIAZHZJTQNHI4V+3mA/MdTS4Lkw2wuCQliRZFdRRr82PEs2HGiDGc6eGHXYpsen
         vtA/YPXT5267dGVX9yxPLnPQp6EeEZeXWdlAC+ceHONkJUnhURb5/P8yr2L/TtnvsyvV
         VY1quZTgRh6Tc6to3EUN2czorFAFikEhUCuEyZGhylLnQlwGcee8u6SYwAnsIwhJ7kv9
         qihHkx0InFQa4Ap2jW6pU0McOtpBPrjq/BNS3l3Pom8FrtrQRGNhH2jK0WfGU49O1pt/
         Je7jBaFxo2Fty029A5wBAAlK1AoeeMRNBKZplJGIW4LjtZoBu71DkOqY3kGg7mg/LX7B
         2NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sykOft9FFBUmilrQ1nPhLX+j0e/Ov648FW6a6gJmiZ0=;
        b=FAQtBNc202t6qyXwLWcifvoxkc/FTDGoksiubAUbDGtrF/ORj0hMi/WU66stJISwp6
         k6pEmCMWjUsQIN0ZIIHuZnhQm1IDnznrH+2JLeiIUd0rdFdIiLyz+uIf2pXUnDi0OGJx
         5hGAI1fAtQTY37/usfDIwRkWw/i8XWt3g6p4smaUdEFgRNHuvQEF99QkvPJRxIsFPajW
         taR9hG62hOWW+N1DRZXZGE916qS/deKb6QvuHkoNaNNs27JK0NHILgl/07nmHxE1C2dP
         2V1VFthNzH69Z03Paj6snYlA5MiDT7DKds9i8n/izAxODbZP5M1LhyrAgwkeprnaKkqr
         9ZYQ==
X-Gm-Message-State: APjAAAU1G2mwuCVoUcSxhctgeyert5wTmty6glfLwquh8LgEUMktbmBh
        fsmxO+G32hX8aZawJzXeYxi8JEty
X-Google-Smtp-Source: APXvYqxBh2CqtBfIbQFNCqjhxqAlnovZPyfABnkt9P+9cF2JrzssG2r24BoZHn0XvA7eIaCtQv2LEg==
X-Received: by 2002:a37:9ed8:: with SMTP id h207mr22961585qke.120.1557776923512;
        Mon, 13 May 2019 12:48:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id f7sm6862947qth.41.2019.05.13.12.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 12:48:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 682CF403AD; Mon, 13 May 2019 16:47:54 -0300 (-03)
Date:   Mon, 13 May 2019 16:47:54 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 01/12] perf tools: Separate generic code in
 dso__data_file_size
Message-ID: <20190513194754.GB3198@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190508132010.14512-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508132010.14512-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 08, 2019 at 03:19:59PM +0200, Jiri Olsa escreveu:
> Moving file specific code in dso__data_file_size function
> into separate file_size function. I'll add bpf specific
> code in following patches.

I'm applying this patch, as it just moves things around, no logic
change, but can you please clarify a question I have after looking at
this patch?
 
> Link: http://lkml.kernel.org/n/tip-rkcsft4a0f8sw33p67llxf0d@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/dso.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index e059976d9d93..cb6199c1390a 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -898,18 +898,12 @@ static ssize_t cached_read(struct dso *dso, struct machine *machine,
>  	return r;
>  }
>  
> -int dso__data_file_size(struct dso *dso, struct machine *machine)
> +static int file_size(struct dso *dso, struct machine *machine)
>  {
>  	int ret = 0;
>  	struct stat st;
>  	char sbuf[STRERR_BUFSIZE];
>  
> -	if (dso->data.file_size)
> -		return 0;
> -
> -	if (dso->data.status == DSO_DATA_STATUS_ERROR)
> -		return -1;
> -
>  	pthread_mutex_lock(&dso__data_open_lock);
>  
>  	/*
> @@ -938,6 +932,17 @@ int dso__data_file_size(struct dso *dso, struct machine *machine)
>  	return ret;
>  }
>  
> +int dso__data_file_size(struct dso *dso, struct machine *machine)
> +{
> +	if (dso->data.file_size)
> +		return 0;
> +
> +	if (dso->data.status == DSO_DATA_STATUS_ERROR)
> +		return -1;
> +
> +	return file_size(dso, machine);
> +}


So the name of the function suggests we want to know the
"data_file_size" of a dso, then the logic in it returns _zero_ if a
member named "dso->data.file_size" is _not_ zero, can you please
clarify?

I was expecting something like:

	if (dso->data.file_size)
		return dso->data.file_size;

I.e. if we had already read it, return the cached value, otherwise go
and call some other function to get that info somehow.

- Arnaldo

> +
>  /**
>   * dso__data_size - Return dso data size
>   * @dso: dso object
> -- 
> 2.20.1

-- 

- Arnaldo
