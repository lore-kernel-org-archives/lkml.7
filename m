Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC52DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3A72080C
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irN3quJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfHYOYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 10:24:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41956 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfHYOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 10:24:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id i4so15560966qtj.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 07:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0/698qMfdEW9koWLq2lHp7mNDwMKHG7rPseKGAxbKRE=;
        b=irN3quJ/UkrnKWfz67pEVnxx1EliVG+79zp9b7UWOs6zFVP8SuhfgHSWa6Szc5HlY7
         QG6pZ0vfUsf9nCyae+UP/znjIV6AiEBorbJAxhI6J0y89SMDtev6Be9x2wmSrCMeU0ZE
         nqSae7lOHeUnoRNhx8ECWVBFTE6ntu2d5WYoqMkemHiwM1ahTj5xtVEtMnlIkDuWgB3t
         YIk+g3MqUcAQrSA9cQ5Fm1UXnPETX8qUK822ChpGl+x/2PiRsAMRj0cgNr5n5JwMHWds
         CAfTFktx0/yUSno0fh2TEQ2p9PqL7T8I2UqD82TOA6FI7A1+OC+IuGKya3jQQMpUM1hP
         5xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0/698qMfdEW9koWLq2lHp7mNDwMKHG7rPseKGAxbKRE=;
        b=DgF7rI7kgK7SSnj8PRyUdiBhlFW+rZhgu1nBXoQMxB83Y5cufrWyng0fxSjq3IUv5l
         ycJ6l+P6GXJhZK/IHeJL3a5WXqZhMb1WalECMXKlQG0r0RuHdrHx+cxJWPwOg2EbVHKw
         +lopSx35+j3hPK1eKeOaI/DsInyWd1hQbbABKW/HNvmz2le7d/J5akNvJ1rTJbwSG5+O
         hqAjhr/uflsOvwDyCjncI3AZU12RT1nObqVidEOE4B6qwNv49JSxze8YyhL5xRXLiCca
         y/YXon2uWjCebuYElBNUsT2eFhBhM7O+LaBmHrtW3zAhzqAIVNWTZhA+TLQM3PWgu7aU
         bfiw==
X-Gm-Message-State: APjAAAVZOZTKFTCcNVC7W6jJI4fkp01epXq6jr67FIx9NUFlMs/U8mY0
        JO8TNn0MrUO12X1lvG34L2XVuRFq
X-Google-Smtp-Source: APXvYqya3vuy7tITa9807mhEsPyxVzyElTTYzaqYbStQdMzbdke2dDCjic+TW671F1XF69NhtHPF6Q==
X-Received: by 2002:ac8:5458:: with SMTP id d24mr13402151qtq.14.1566743055893;
        Sun, 25 Aug 2019 07:24:15 -0700 (PDT)
Received: from quaco.ghostprotocols.net (user.186-235-140-211.acesso10.net.br. [186.235.140.211])
        by smtp.gmail.com with ESMTPSA id t5sm4998025qkt.93.2019.08.25.07.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 07:24:15 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7DF8640340; Sun, 25 Aug 2019 11:24:12 -0300 (-03)
Date:   Sun, 25 Aug 2019 11:24:12 -0300
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tools/perf: pmu-events: Fix reproducibility
Message-ID: <20190825142412.GC26569@kernel.org>
References: <20190825131329.naqzd5kwg7mw5d3f@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825131329.naqzd5kwg7mw5d3f@decadent.org.uk>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Aug 25, 2019 at 02:13:29PM +0100, Ben Hutchings escreveu:
> jevents.c uses nftw() to enumerate files and outputs the corresponding
> C structs in the order they are found.  This makes it sensitive to
> directory ordering, so that the perf executable is not reproducible.
> 
> To avoid this, store all the files and directories found and then sort
> them by their (relative) path.  (This maintains the parent-first
> ordering that nftw() promises.)  Then apply the existing callbacks to
> them in the sorted order.
> 
> Don't both storing the stat buffers as we don't need them.
> 
> References: https://tests.reproducible-builds.org/debian/dbdtxt/bullseye/i386/linux_4.19.37-6.diffoscope.txt.gz

Thanks for working on making the building of perf reproducible! Some
comments below.

> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -50,6 +50,12 @@
>  #include "json.h"
>  #include "jevents.h"
>  
> +struct found_file {
> +	const char	*fpath;
> +	int		typeflag;
> +	struct FTW	ftwbuf;
> +};
> +
>  int verbose;
>  char *prog;
>  
> @@ -865,6 +871,44 @@ static int get_maxfds(void)
>   * nftw() doesn't let us pass an argument to the processing function,
>   * so use a global variables.
>   */
> +static struct found_file *found_files;
> +static size_t n_found_files;
> +static size_t max_found_files;

Would be nice to avoid adding more static variables, what about having
it in a struct, declare it on the calling function and then pass it as
context?

> +
> +static int add_one_file(const char *fpath, const struct stat *sb,
> +			int typeflag, struct FTW *ftwbuf)
> +{
> +	struct found_file *file;
> +
> +	if (ftwbuf->level == 0 || ftwbuf->level > 3)
> +		return 0;
> +
> +	/* Grow array if necessary */
> +	if (n_found_files >= max_found_files) {
> +		if (max_found_files == 0)
> +			max_found_files = 16;
> +		else
> +			max_found_files *= 2;
> +		found_files = realloc(found_files,
> +				      max_found_files * sizeof(*found_files));

What if realloc() fails?

> +	}
> +
> +	file = &found_files[n_found_files++];
> +	file->fpath = strdup(fpath);
> +	file->typeflag = typeflag;
> +	file->ftwbuf = *ftwbuf;
> +
> +	return 0;
> +}
> +
> +static int compare_files(const void *left, const void *right)
> +{
> +	const struct found_file *left_file = left;
> +	const struct found_file *right_file = right;
> +
> +	return strcmp(left_file->fpath, right_file->fpath);
> +}
> +
>  static FILE *eventsfp;
>  static char *mapfile;
>  
> @@ -919,19 +963,19 @@ static int is_json_file(const char *name
>  	return 0;
>  }
>  
> -static int preprocess_arch_std_files(const char *fpath, const struct stat *sb,
> +static int preprocess_arch_std_files(const char *fpath,
>  				int typeflag, struct FTW *ftwbuf)
>  {
>  	int level = ftwbuf->level;
>  	int is_file = typeflag == FTW_F;
>  
>  	if (level == 1 && is_file && is_json_file(fpath))
> -		return json_events(fpath, save_arch_std_events, (void *)sb);
> +		return json_events(fpath, save_arch_std_events, NULL);
>  
>  	return 0;
>  }
>  
> -static int process_one_file(const char *fpath, const struct stat *sb,
> +static int process_one_file(const char *fpath,
>  			    int typeflag, struct FTW *ftwbuf)
>  {
>  	char *tblname, *bname;
> @@ -956,9 +1000,9 @@ static int process_one_file(const char *
>  	} else
>  		bname = (char *) fpath + ftwbuf->base;
>  
> -	pr_debug("%s %d %7jd %-20s %s\n",
> +	pr_debug("%s %d %-20s %s\n",
>  		 is_file ? "f" : is_dir ? "d" : "x",
> -		 level, sb->st_size, bname, fpath);
> +		 level, bname, fpath);
>  
>  	/* base dir or too deep */
>  	if (level == 0 || level > 3)
> @@ -1070,6 +1114,7 @@ int main(int argc, char *argv[])
>  	const char *output_file;
>  	const char *start_dirname;
>  	struct stat stbuf;
> +	size_t i;
>  
>  	prog = basename(argv[0]);
>  	if (argc < 4) {
> @@ -1113,8 +1158,26 @@ int main(int argc, char *argv[])
>  	 */
>  
>  	maxfds = get_maxfds();
> +	rc = nftw(ldirname, add_one_file, maxfds, 0);
> +	if (rc < 0) {
> +		/* Make build fail */
> +		free_arch_std_events();
> +		return 1;
> +	} else if (rc) {
> +		goto empty_map;
> +	}
> +
> +	/* Sort file names to ensure reproduciblity */
> +	qsort(found_files, n_found_files, sizeof(*found_files), compare_files);
> +
>  	mapfile = NULL;
> -	rc = nftw(ldirname, preprocess_arch_std_files, maxfds, 0);
> +	for (i = 0; i < n_found_files; i++) {
> +		rc = preprocess_arch_std_files(found_files[i].fpath,
> +					       found_files[i].typeflag,
> +					       &found_files[i].ftwbuf);
> +		if (rc)
> +			break;
> +	}
>  	if (rc && verbose) {
>  		pr_info("%s: Error preprocessing arch standard files %s\n",
>  			prog, ldirname);
> @@ -1127,7 +1190,13 @@ int main(int argc, char *argv[])
>  		goto empty_map;
>  	}
>  
> -	rc = nftw(ldirname, process_one_file, maxfds, 0);
> +	for (i = 0; i < n_found_files; i++) {
> +		rc = process_one_file(found_files[i].fpath,
> +				      found_files[i].typeflag,
> +				      &found_files[i].ftwbuf);
> +		if (rc)
> +			break;
> +	}
>  	if (rc && verbose) {
>  		pr_info("%s: Error walking file tree %s\n", prog, ldirname);
>  		goto empty_map;



-- 

- Arnaldo
