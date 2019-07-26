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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B63C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC1221880
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAP0uATW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfGZT3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:29:04 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39696 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGZT3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:29:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9so53687952qtu.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CbbN6OSlmg62A0iSdM9ofxr6K6tE4hYBWoGxx76PxCY=;
        b=qAP0uATWRONBq+5AyEm1POcvyogRmNLfvixwHbtDhUlMEPiW5HDlEjrhNhrbNDlU5a
         CvA88jcYqh1TXBcCmRYgAcKjMYPDNzCNl4WGTNiYzIfL4kUYceDoERjSPkGppta2Q7Aa
         bIhUUWd5IMhdPVTFpKulaqHQAG8l8mirKYL5xGWhqeXHW3q+3Fzqw1ushEjIcimhXR5T
         fXx/oGcqr21C54ZMxDpgyi8hnCPwZhU8Ois/pwXiYeAtbmYv0SfTy80O7RPTpKoiNPa5
         8d4eXPhLWiKcHm/TYBcNsPp9E4xJdW3KdXM4NtWp3BMhWB1yL8ukvzpkyP98SH3/Q45T
         OIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CbbN6OSlmg62A0iSdM9ofxr6K6tE4hYBWoGxx76PxCY=;
        b=paXF/ixXrS6eVLitmIcEA/nvCtxn5Cj0I+vzW6dV+XUGNw17xoF0aU8ghGR5L8i7D/
         d2DybjI+47eyT60A1x9kchJpLA1gAjNri0jPDLPDba0vFZLgZFwFYq0yQBo12yl1EPOA
         bioO4BA4Oyy2tVsYVSIkxvRzmkCOPplRk8Krks7De53eUqDyfM7cIJVLUPD/23KyGNgx
         1RsAlkB+IXM6jN9NRkc1rFNwX1T/K6cYawKsEBU6WNV4g30eR1+gPjZng8UHHBwVCtYL
         lEWr7He8I7OUJZJM48q+BmFnX/Qa/EXGRKqC+c5X78NvZkY8dDagW3P/7HK/pX/gT1Lm
         93jw==
X-Gm-Message-State: APjAAAVKCoQmwVUROOJfQ+qg2lAO7pe+PrpgjUiI17oTe4xvXBAEUDvN
        bryHuADnrSV1a9Etz3IT7Is=
X-Google-Smtp-Source: APXvYqxJ45o6qtOAbWtQF5MqYdWsD7IUTnVpZxf+EU7nYVbmwpUoJw50pCWVVs0F95NgSGb/I4st7w==
X-Received: by 2002:ac8:7383:: with SMTP id t3mr48039056qtp.156.1564169342612;
        Fri, 26 Jul 2019 12:29:02 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id j61sm23861187qte.47.2019.07.26.12.29.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:29:01 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6749840340; Fri, 26 Jul 2019 16:28:59 -0300 (-03)
Date:   Fri, 26 Jul 2019 16:28:59 -0300
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com,
        linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH 2/3] Fix annotate.c use of uninitialized value error
Message-ID: <20190726192859.GG20482@kernel.org>
References: <20190724234500.253358-1-nums@google.com>
 <20190724234500.253358-3-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724234500.253358-3-nums@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 24, 2019 at 04:44:59PM -0700, Numfor Mbiziwo-Tiapo escreveu:
> Our local MSAN (Memory Sanitizer) build of perf throws a warning
> that comes from the "dso__disassemble_filename" function in
> "tools/perf/util/annotate.c" when running perf record.
> 
> The warning stems from the call to readlink, in which "build_id_path"
> was being read into "linkname". Since readlink does not null terminate,
> an uninitialized memory access would later occur when "linkname" is
> passed into the strstr function. This is simply fixed by null-terminating
> "linkname" after the call to readlink.
> 
> To reproduce this warning, build perf by running:
> make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-fsanitize=memory\
>  -fsanitize-memory-track-origins"
> 
> (Additionally, llvm might have to be installed and clang might have to
> be specified as the compiler - export CC=/usr/bin/clang)
> 
> then running:
> tools/perf/perf record -o - ls / | tools/perf/perf --no-pager annotate\
>  -i - --stdio
> 
> Please see the cover letter for why false positive warnings may be
> generated.
> 
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  tools/perf/util/annotate.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 70de8f6b3aee..d8bfb561bc35 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1627,6 +1627,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  	char *build_id_filename;
>  	char *build_id_path = NULL;
>  	char *pos;
> +	int len;
>  
>  	if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
>  	    !dso__is_kcore(dso))
> @@ -1655,10 +1656,16 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  	if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
>  		dirname(build_id_path);
>  
> -	if (dso__is_kcore(dso) ||
> -	    readlink(build_id_path, linkname, sizeof(linkname)) < 0 ||
> -	    strstr(linkname, DSO__NAME_KALLSYMS) ||
> -	    access(filename, R_OK)) {
> +	if (dso__is_kcore(dso))
> +		goto fallback;
> +
> +	len = readlink(build_id_path, linkname, sizeof(linkname));
> +	if (len < 0)
> +		goto fallback;

If the buffer has N bytes and the linkname has more than that, then it
will truncate at N bytes and return N, then if we access linkname[N] we
will be accessing one byte after the end of the buffer, no?

> +
> +	linkname[len] = '\0';
> +	if (strstr(linkname, DSO__NAME_KALLSYMS) ||
> +		access(filename, R_OK)) {
>  fallback:
>  		/*
>  		 * If we don't have build-ids or the build-id file isn't in the
> -- 
> 2.22.0.657.g960e92d24f-goog

-- 

- Arnaldo
