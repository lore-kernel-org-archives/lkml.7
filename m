Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B25C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14AC2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkvzVl52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbfJNQTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:19:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45409 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbfJNQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:19:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id c21so26144345qtj.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sz7Iyq3k0PImjaLJATlB1W9ASE/exdNG56wszXOZTI4=;
        b=nkvzVl52YqUGqmQDzwWeWb4IScwuxt5XdDJojwBsycr5o2MlmX30+d4lVaam0Byupy
         Dc+8c0JjJbinwZPE9F7PVVoJRcsQrz5k37ZWVmCMicCcxcMiMmvATF4somVTOPXg0mXJ
         66Ja3r21I78/5Xo7Jv2qQOj6sR/Y8vL2CzwhHV582OUljbDFcMTKRQS/FERCvz31Vw6B
         1KMFSuhjMrLesDpD+dVooVoYxZkqVTguh+PCCP8FbnbEph/BvDwML/CIqm3j7Z60J+q/
         p26Tj6lQtholZFPL/zUZ2Btp8FzoEoAPTYVhlRd836/vJ6mqoAQG5qJq5ijXvLVQzZXu
         L76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sz7Iyq3k0PImjaLJATlB1W9ASE/exdNG56wszXOZTI4=;
        b=bL6gxDnepic3/N/EKfYs88yqT0I4M0FlCmutMnxXwpF5LmmEHsyk1g471/m2sXdO+G
         2Rz/YKKOxennR+5sax2qtFvkEXSGaaHVa16K0R0HSYW1LeNMwSJvSW/OVvyw6BAnMlLk
         JcxjfqD1LZH1t4gdhRZ925AfP+uylDwAkT4vRRPAvt/SNcApU+7It9U3quvu1iwutYRE
         8bGuPDgzO1g2y0BTXWOD9bpv9XtP2oYBQXJXvBU9hd5XBQezFWe0n/DqiCShEqrtGo/r
         DCHEVnzjoczv+jvDzls8ySzqf0fzbJNoHoJXePn1jv+Kdhv37Yh9iuYgvnWrPj7w4QUp
         ICxA==
X-Gm-Message-State: APjAAAV9gH+vgfm7LaZqtrLxq7bf8JfCknnVcM+9drx22sWKvUmMj3vK
        DfH2Qkta7WsCyZTwgwK22Kw=
X-Google-Smtp-Source: APXvYqyyUudhktAqlP6yDREPhQVZ6oR/GKkA9zxOlBEX0+qZqbzEwVRs/HfELF3VOt0TJbLtDdZ68Q==
X-Received: by 2002:ad4:408c:: with SMTP id l12mr30518648qvp.210.1571069981201;
        Mon, 14 Oct 2019 09:19:41 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id v13sm7939222qtp.61.2019.10.14.09.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 09:19:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 312444DD66; Mon, 14 Oct 2019 13:19:38 -0300 (-03)
Date:   Mon, 14 Oct 2019 13:19:38 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf jvmti: Link in tools/lib/ctype.o
Message-ID: <20191014161938.GM19627@kernel.org>
References: <20191014154856.25306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014154856.25306-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 14, 2019 at 05:48:56PM +0200, Jiri Olsa escreveu:
> The libperf-jvmti.so links already with tools/lib/string.o
> to use strlcpy. However the string.o depends on ctype.o
> so we need to link it in as well.
> 
> Fixes: 79743bc927f6 ("perf jvmti: Link against tools/lib/string.o to have weak strlcpy()")
> Link: http://lkml.kernel.org/n/tip-zitavtnkcu2guqwfgtp7n7bg@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

I applied one already for this, contributed by Thomas.

Thanks,

- Arnaldo
> ---
>  tools/perf/jvmti/Build | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/jvmti/Build b/tools/perf/jvmti/Build
> index 1e148bbdf820..7de7f90bf3fb 100644
> --- a/tools/perf/jvmti/Build
> +++ b/tools/perf/jvmti/Build
> @@ -3,6 +3,7 @@ jvmti-y += jvmti_agent.o
>  
>  # For strlcpy
>  jvmti-y += libstring.o
> +jvmti-y += libctype.o
>  
>  CFLAGS_jvmti         = -fPIC -DPIC -I$(JDIR)/include -I$(JDIR)/include/linux
>  CFLAGS_REMOVE_jvmti  = -Wmissing-declarations
> @@ -15,3 +16,7 @@ CFLAGS_libstring.o += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PE
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
