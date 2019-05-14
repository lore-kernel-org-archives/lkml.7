Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BB3C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882312084F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEbB3ROM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfENSTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:19:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44851 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfENSTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:19:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id f24so96675qtk.11;
        Tue, 14 May 2019 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7HlgN9zidZAa5daMbOEFTbNZTexGARFlx0lJpt/7sB4=;
        b=WEbB3ROMtPkwXwvEg0jzPK3kWiQQXeT2Ss/RKPqO3M95KTz09lh7Bq1AxTxpZ1Scua
         iYXMz+A+nWNErPhVhcSmFL1XQ1Opb/oU4CCap94mlLo9s3XzMAw1gJn7cftDYJaXh7/Y
         R20i78VVuDEPpTBejkzEnrlfTWWtrBIu3vbEO+JPcV7PoLOX5lxrRa+lDXo2F09SFU+7
         jOBmKsa8rFJlzl9q8G/kDIgCVM0V10m0kMyDkI6rkb9HSFEf8IKHaC27n/w6Xb86KVMa
         z95R4ypwMFoQ0ttDqvza+7j/Y0Wqm2jzibEMMRNL0e0EkYXgz7CCNV7935XCsUkELJYc
         wvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7HlgN9zidZAa5daMbOEFTbNZTexGARFlx0lJpt/7sB4=;
        b=KT86YUXhJUG/rS2wAJvVEw4zvPlHP0hxUSCkEVkcSt6/bDo1QlWjlr2BDe12VqUxjd
         gtcx2+lCtOFpajyJpBdQz3pC8pcmAgPucvJzjELMf/1kA6/huQ6wf8OXrw0ZQqZMUV5l
         rRpLocttwYJweA8sRBg5jkXmFrUPR50eCetTpZCWDyh+ptKKsRkQk8LxDh4rgU9agpJb
         +4GD2TcSqwCAaY06yJFws7CoGoaldsHxLu5x/AhTHdkMPFypBcGxaA5uNTSGqzGEh0q4
         hzMz9iZnJff6VlgxaMeyn82/JzId11AKCDZXxfhiCTOx+CrP8RklM56d6a571iNt2QHo
         lstA==
X-Gm-Message-State: APjAAAVRt3ZKiloWe4PEx42MXpGbv5hNloTjF/b2JTxLFDNWIuMs0zzh
        XmiR73LGFXbcwWX1/qL0+p22S52TnQo=
X-Google-Smtp-Source: APXvYqyaiRg0n4UYd66i87qfgRr4kGpJcutrTeClZG43OrwZDeZhZEtVVnCjZawt/RDo8/YjQB7dDA==
X-Received: by 2002:ac8:28c2:: with SMTP id j2mr9427349qtj.103.1557857946315;
        Tue, 14 May 2019 11:19:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id x30sm3608274qtx.35.2019.05.14.11.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 11:19:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3E4F4403AD; Tue, 14 May 2019 15:19:02 -0300 (-03)
Date:   Tue, 14 May 2019 15:19:02 -0300
To:     kan.liang@linux.intel.com
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/3] perf parse-regs: Add generic support for non-gprs
Message-ID: <20190514181902.GB1756@kernel.org>
References: <1557844753-58223-1-git-send-email-kan.liang@linux.intel.com>
 <1557844753-58223-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557844753-58223-2-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 14, 2019 at 07:39:12AM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Some non general purpose registers, e.g. XMM, can be collected on some
> platforms, e.g. X86 Icelake.
> 
> Add a weak function has_non_gprs_support() to check if the
> kernel/hardware support non-gprs collection.
> Add a weak function non_gprs_mask() to return non-gprs mask.
> 
> By default, the non-gprs collection is not support. Specific platforms
> should implement their own non-gprs functions if they can collect
> non-gprs.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/parse-regs-options.c | 10 +++++++++-
>  tools/perf/util/perf_regs.c          | 10 ++++++++++
>  tools/perf/util/perf_regs.h          |  2 ++
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
> index b21617f..2f90f31 100644
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
> @@ -12,6 +12,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  	const struct sample_reg *r;
>  	char *s, *os = NULL, *p;
>  	int ret = -1;
> +	bool has_non_gprs = has_non_gprs_support(intr);

This is generic code, what does "non gprs" means for !Intel? Can we come
up with a better, not architecture specific jargon? Or you mean "general
purpose registers"?

Perhaps we can ask for a register mask for use with intr? I.e.:

For the -I/--intr-regs

        uint64_t mask = arch__intr_reg_mask();

And for --user-regs

        uint64_t mask = arch__user_reg_mask();

And then on that loop do:

  	for (r = sample_reg_masks; r->name; r++) {
		if (r->mask & mask))
  			fprintf(stderr, "%s ", r->name);
  	}

?
  
>  	if (unset)
>  		return 0;
> @@ -37,6 +38,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  			if (!strcmp(s, "?")) {
>  				fprintf(stderr, "available registers: ");
>  				for (r = sample_reg_masks; r->name; r++) {
> +					if (!has_non_gprs && (r->mask & ~PERF_REGS_MASK))
> +						break;
>  					fprintf(stderr, "%s ", r->name);
>  				}
>  				fputc('\n', stderr);
> @@ -44,6 +47,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  				return -1;
>  			}
>  			for (r = sample_reg_masks; r->name; r++) {
> +				if (!has_non_gprs && (r->mask & ~PERF_REGS_MASK))
> +					continue;
>  				if (!strcasecmp(s, r->name))
>  					break;
>  			}
> @@ -64,8 +69,11 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  	ret = 0;
>  
>  	/* default to all possible regs */
> -	if (*mode == 0)
> +	if (*mode == 0) {
>  		*mode = PERF_REGS_MASK;
> +		if (has_non_gprs)
> +			*mode |= non_gprs_mask(intr);
> +	}
>  error:
>  	free(os);
>  	return ret;
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 2acfcc5..0d278b6 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -13,6 +13,16 @@ int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
>  	return SDT_ARG_SKIP;
>  }
>  
> +bool __weak has_non_gprs_support(bool intr __maybe_unused)
> +{
> +	return false;
> +}
> +
> +u64 __weak non_gprs_mask(bool intr __maybe_unused)
> +{
> +	return 0;
> +}
> +
>  #ifdef HAVE_PERF_REGS_SUPPORT
>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
>  {
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 1a15a4b..983b4e6 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -23,6 +23,8 @@ enum {
>  };
>  
>  int arch_sdt_arg_parse_op(char *old_op, char **new_op);
> +bool has_non_gprs_support(bool intr);
> +u64 non_gprs_mask(bool intr);
>  
>  #ifdef HAVE_PERF_REGS_SUPPORT
>  #include <perf_regs.h>
> -- 
> 2.7.4

-- 

- Arnaldo
