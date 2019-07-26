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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D26C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C2721994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD4ybSsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfGZTTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:19:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37621 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388725AbfGZTTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:19:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so53701068qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CpzhLAZ1Tk4+tthXloHBt+h7BDefmj32MyAj8d7cP00=;
        b=hD4ybSskoIGalzStkMeB6+dJbqT7rQTjanyfSGyC+e8zMs/ABTUbK7BYNFhKcBsTu1
         ylNJbMNwDrp1GNmsiA0jPYz1YrznyQSEcZOkShW4VS64PsxxlpFtqUFIggXUMA9ffVGo
         wnD2s0SltJBohMsea5oCh2VZiC1RngoYisr7OYlyjhFyG4zobn9II5gXzhCpKrs7g2Th
         XlLKlK5ezdJcAmvi2HxN7zawqLnKDw9IqaqS61tVo28qIXm71kDM0528k+B69824IsS5
         MYrMoKeU769YWAiSPf06ViNx7D1VPP/hWZM4urL9mcFxuG9TrMYCSCsMOXcULNA/zJit
         rmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CpzhLAZ1Tk4+tthXloHBt+h7BDefmj32MyAj8d7cP00=;
        b=hV3vT3jA9R7aq07kbHgoas2FFbVDnxAUb/PRPs1qNZIRcvX4DhTyRO95uyj3iV0hUC
         Rqj/lKQ1eQD7rmG4wKGQJn1w2npHbTnV/crLJgM12bVVRWN52BCRcmGjaEPzK64vLSrB
         B5EGX4t6wMUtzWjOg0LIfN8Hdxfy6BYebVzVtkYMaLb8iRu9lQEOu39SKqizwjyg8w51
         0PX88HrYQy6jX4C7J3AFrTLm3XmJlwHb8rRMhlHb8jhTIJnvS8XEY66/q9XtNO9bZVma
         gCTKL7T2zltV0R34i37KuPHaYxIqcIdm+cVZdV9+zOU7iRLU0Zd2+H0hJ4+eoNW9TfwC
         EZXg==
X-Gm-Message-State: APjAAAWnez54Z9OIWqUDLKMuVb0B6Zn9m1R49goloWroMJZTBrlUjrD4
        9xaD2s2LunVbHC6BaRccF308pnA5
X-Google-Smtp-Source: APXvYqzKR3eGhxXf87Si1dP47Im21BEcKMrs9qSrPVdY7/NXt6MkP4KFatqqIYErzXQDF/2Ec8z3LQ==
X-Received: by 2002:a0c:b012:: with SMTP id k18mr70182318qvc.74.1564168771302;
        Fri, 26 Jul 2019 12:19:31 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id j61sm23852056qte.47.2019.07.26.12.19.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:19:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 49A1F40340; Fri, 26 Jul 2019 16:19:28 -0300 (-03)
Date:   Fri, 26 Jul 2019 16:19:28 -0300
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com,
        linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH 1/3] Fix util.c use of unitialized value warning
Message-ID: <20190726191928.GF20482@kernel.org>
References: <20190724234500.253358-1-nums@google.com>
 <20190724234500.253358-2-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724234500.253358-2-nums@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 24, 2019 at 04:44:58PM -0700, Numfor Mbiziwo-Tiapo escreveu:
> When building our local version of perf with MSAN (Memory Sanitizer)
> and running the perf record command, MSAN throws a use of uninitialized
> value warning in "tools/perf/util/util.c:333:6".
> 
> This warning stems from the "buf" variable being passed into "write".
> It originated as the variable "ev" with the type union perf_event*
> defined in the "perf_event__synthesize_attr" function in
> "tools/perf/util/header.c".
> 
> In the "perf_event__synthesize_attr" function they allocate space with
> a malloc call using ev, then go on to only assign some of the member
> variables before passing "ev" on as a parameter to the "process" function
> therefore "ev" contains uninitialized memory. Changing the malloc call
> to calloc initializes all the members of "ev" which gets rid of the
> warning.

I'm applying, but changing the calloc call to zalloc() that is just a
shorter wrapper to calloc(1, size).

Thanks,

- Arnaldo
 
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
>  tools/perf/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index dec6d218c31c..b9c71fc45ac1 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3427,7 +3427,7 @@ int perf_event__synthesize_attr(struct perf_tool *tool,
>  	size += sizeof(struct perf_event_header);
>  	size += ids * sizeof(u64);
>  
> -	ev = malloc(size);
> +	ev = calloc(1, size);
>  
>  	if (ev == NULL)
>  		return -ENOMEM;
> -- 
> 2.22.0.657.g960e92d24f-goog

-- 

- Arnaldo
