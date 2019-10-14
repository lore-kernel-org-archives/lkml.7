Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A299ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7175F21A49
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APROephV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbfJNO1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:27:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46331 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbfJNO1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:27:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so16019411qkd.13;
        Mon, 14 Oct 2019 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3V+PGu2Pyj0zf4ZH2iF3KZ1fNITKR1WxcgLIFZ54C7g=;
        b=APROephVsfFNzX2RVV5DyBkL9ZJGsxrkxzBGUtyFJ7I8pBb4A8Sh6bJetLf6WyV2AN
         Eee4AwmioqqgfSgaXepYXZhtPufDugC6Fa85A4h0lPF7uSUibJ6EOwPnSRpTQ0ymL1o5
         S3MUd0aFrt4Vjc3NFteCHGzmcyUzce2BQMFhBjNX74sNh6ryu6RJxKjN6V7UKvXnhmM3
         yvI20uJs3FXq3VWDq5h5H2SQ2iW933iJoxuPep3vGhJIRf0DcGqw/fDafVBX2zV7C5JQ
         hWUSRDXLcIQmmgQxjl/Q5mnlY++YLMqZNSLBfzaR01qNnFdgWS8qFXH5PzDiIbcauk2s
         Uu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3V+PGu2Pyj0zf4ZH2iF3KZ1fNITKR1WxcgLIFZ54C7g=;
        b=C53EmAr+yssfYx/Ksh/00FYI3GjpbDr6NsJkLy2pZMBiKMsULxQAbuBHRU0Dqd2fQw
         uAzuwXaXUJNz7+MSE1VVDdVcMMyqTRYdCRYSf84rxaXNhICf4gHQCzD7iqW1ISf2uZwE
         Hc/xp1uldmZosdhflGo8rYHttQGWA+dihurDvj2adc68QW6NKTSJ5JtLTN/hXSUIubt5
         kxc9Zl8Yai138y775me0WGktDrhsTZgEjD7ChC1S3O56DYAMJ+gn330Q8DBSVbDtTIVT
         0qM8VpcX5V43Mlxxrdz97RBaA8ct1dVJmBUE4XN/2y/+NGLO0aQI/1/PhByb5onzxhxb
         KSmg==
X-Gm-Message-State: APjAAAXljaet7oJXnnjmkRbZwlSFJhSIT8JYwi11/sUscRl1CstLrARh
        EwIjBDMpPNKDuJkgD5u6KcBv13R1
X-Google-Smtp-Source: APXvYqxtbBj724cxF+nTluv34uda4ZWEiUHW17e92CGKh33IW7olw+eu5Sy9x+hAjyZTIsHt0V7kIQ==
X-Received: by 2002:ae9:e84e:: with SMTP id a75mr30732432qkg.2.1571063242380;
        Mon, 14 Oct 2019 07:27:22 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id d134sm8102386qkg.133.2019.10.14.07.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:27:21 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B39B54DD66; Mon, 14 Oct 2019 11:27:19 -0300 (-03)
Date:   Mon, 14 Oct 2019 11:27:19 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf jvmti: Link against tools/lib/ctype.h to have weak
 strlcpy()
Message-ID: <20191014142719.GK19627@kernel.org>
References: <20191008093841.59387-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008093841.59387-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 08, 2019 at 11:38:41AM +0200, Thomas Richter escreveu:
> The build of file libperf-jvmti.so succeeds but the resulting
> object fails to load:
> 
>  # ~/linux/tools/perf/perf record -k mono -- java  \
>       -XX:+PreserveFramePointer \
>       -agentpath:/root/linux/tools/perf/libperf-jvmti.so \
>        hog 100000 123450
>   Error occurred during initialization of VM
>   Could not find agent library /root/linux/tools/perf/libperf-jvmti.so
>       in absolute path, with error:
>       /root/linux/tools/perf/libperf-jvmti.so: undefined symbol: _ctype
> 
> Add the missing _ctype symbol into the build script.
> 
> Fixes: c5d048240e49 ("perf jvmti: Link against tools/lib/string.h to have weak strlcpy()")

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/jvmti/Build | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/jvmti/Build b/tools/perf/jvmti/Build
> index 1e148bbdf820..202cadaaf097 100644
> --- a/tools/perf/jvmti/Build
> +++ b/tools/perf/jvmti/Build
> @@ -2,7 +2,7 @@ jvmti-y += libjvmti.o
>  jvmti-y += jvmti_agent.o
>  
>  # For strlcpy
> -jvmti-y += libstring.o
> +jvmti-y += libstring.o libctype.o
>  
>  CFLAGS_jvmti         = -fPIC -DPIC -I$(JDIR)/include -I$(JDIR)/include/linux
>  CFLAGS_REMOVE_jvmti  = -Wmissing-declarations
> @@ -15,3 +15,7 @@ CFLAGS_libstring.o += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PE
>  $(OUTPUT)jvmti/libstring.o: ../lib/string.c FORCE
>  	$(call rule_mkdir)
>  	$(call if_changed_dep,cc_o_c)
> +
> +$(OUTPUT)jvmti/libctype.o: ../lib/ctype.c FORCE
> +	$(call rule_mkdir)
> +	$(call if_changed_dep,cc_o_c)
> -- 
> 2.21.0

-- 

- Arnaldo
