Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85E8C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD371206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWdxRA3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfK0PSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:18:12 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43758 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfK0PSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:18:12 -0500
Received: by mail-qv1-f68.google.com with SMTP id cg2so9019123qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 07:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vNfHT06AlidhzMdeMZBKrDSV+OxXpZG1zDvb/7idp3o=;
        b=jWdxRA3cRUpaMwYfLAYsFxVHsT3d0ArqIknF+qIyFO78fbo2Ol6MFp3I52ne5IJvkE
         ZvPfYbsAHvj1hq7XwJQN1l/zPS4UQ2ncRT/bUPiSv4FR/HtPSE+o1XQr14SSgBF0B0v8
         LPvja7Zq7VFF6GkXg1gmC7JTY2QnSC3dp5bJyXeMHDYuD1jLv2d8bJ0iVOmLC/bl9/zP
         ZyObttTdLUlEdiQ3zcYG+FgXTPkdsrsyeQBjzALuFr3mQwJerqMeTTO8QoT9QjhsnsRI
         hO4pJAdFfsEa4fSTTq1axiQ9drbuB2qNoW8ib4HqThqkoO10vJ2dZAJJQHkbVFTcu/aO
         RuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vNfHT06AlidhzMdeMZBKrDSV+OxXpZG1zDvb/7idp3o=;
        b=F0c9gR/jKbvkySL+8lpqIKfJBZmLYuKSsO3lXrw+0dvG7VVeaMCEIA5HVaP6mU2NB2
         uJUCJ5JVrj5A+NYdq21FcRRqYnHJcziRaCBJFmAS/C8ByxJn1b6UfCq0CG93gU84+40o
         fCg85uqIbxLKzFjTZH3bzeusxM5kY5CkV6bZJ5iiWVnqsJxizTfQ9nCENuGCFn/g+MKR
         I8i95DyIYq9Xe2dwYlEVCIVOLwRbkfwKuxSG9i9TpMopa+lkmJcK9MMNafHRRMJ7HNAE
         kNpSjjBM8dGLTn//47Qn9VeegDajypC2KYEbDX4us1G15DHCOJd/rJpxMlKGKxBUg39l
         AyBw==
X-Gm-Message-State: APjAAAWAeA9+rhfdDk8Rmt6CUqOjv7VIK7B3rnsq68eJj7ad3TgmU+Sm
        YaIEJ836jm7vldUNrgopf1/ngpCANxE=
X-Google-Smtp-Source: APXvYqxTF9JLxJOdh8W+1UnD7xOMgHQtNmgZrbcJwwMla8YUWOMI7pyF4bzPQfzvXXwW5LhM2kG3ew==
X-Received: by 2002:a0c:ee91:: with SMTP id u17mr3982227qvr.245.1574867890891;
        Wed, 27 Nov 2019 07:18:10 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id n19sm6972872qkn.52.2019.11.27.07.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 07:18:10 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DA25940D3E; Wed, 27 Nov 2019 12:18:07 -0300 (-03)
Date:   Wed, 27 Nov 2019 12:18:07 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] perf script: Fix brstackinsn for AUXTRACE
Message-ID: <20191127151807.GF22719@kernel.org>
References: <20191127095322.15417-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127095322.15417-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 27, 2019 at 11:53:21AM +0200, Adrian Hunter escreveu:
> brstackinsn must be allowed to be set by the user when AUX area data has
> been captured because, in that case, the branch stack might be
> synthesized on the fly. This fixes the following error:
> 
> Before:
> 
>   $ perf record -e '{intel_pt//,cpu/mem_inst_retired.all_loads,aux-sample-size=8192/pp}:u' grep -rqs jhgjhg /boot
>   [ perf record: Woken up 19 times to write data ]
>   [ perf record: Captured and wrote 2.274 MB perf.data ]
>   $ perf script -F +brstackinsn --xed --itrace=i1usl100 | head
>   Display of branch stack assembler requested, but non all-branch filter set
>   Hint: run 'perf record -b ...'
> 
> After:
> 
>   $ perf record -e '{intel_pt//,cpu/mem_inst_retired.all_loads,aux-sample-size=8192/pp}:u' grep -rqs jhgjhg /boot
>   [ perf record: Woken up 19 times to write data ]
>   [ perf record: Captured and wrote 2.274 MB perf.data ]
>   $ perf script -F +brstackinsn --xed --itrace=i1usl100 | head
>             grep 13759 [002]  8091.310257:       1862                                        instructions:uH:      5641d58069eb bmexec+0x86b (/bin/grep)
>         bmexec+2485:
>         00005641d5806b35                        jnz 0x5641d5806bd0              # MISPRED
>         00005641d5806bd0                        movzxb  (%r13,%rdx,1), %eax
>         00005641d5806bd6                        add %rdi, %rax
>         00005641d5806bd9                        movzxb  -0x1(%rax), %edx
>         00005641d5806bdd                        cmp %rax, %r14
>         00005641d5806be0                        jnb 0x5641d58069c0              # MISPRED
>         mismatch of LBR data and executable
>         00005641d58069c0                        movzxb  (%r13,%rdx,1), %edi

Thanks, applied.

- Arnaldo
 
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Fixes: 48d02a1d5c13 ("perf script: Add 'brstackinsn' for branch stacks")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 7b2f0922050c..e8db26b9b29e 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -448,7 +448,7 @@ static int perf_evsel__check_attr(struct evsel *evsel,
>  		       "selected. Hence, no address to lookup the source line number.\n");
>  		return -EINVAL;
>  	}
> -	if (PRINT_FIELD(BRSTACKINSN) &&
> +	if (PRINT_FIELD(BRSTACKINSN) && !allow_user_set &&
>  	    !(perf_evlist__combined_branch_type(session->evlist) &
>  	      PERF_SAMPLE_BRANCH_ANY)) {
>  		pr_err("Display of branch stack assembler requested, but non all-branch filter set\n"
> -- 
> 2.17.1

-- 

- Arnaldo
