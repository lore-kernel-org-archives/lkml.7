Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2639C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2AF21670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrlGXo+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfGEQk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:40:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36444 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfGEQk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:40:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so8319715qkl.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t/6ftpa8KEJE9o6IFoYpCHZyzY+Y35BOpCfDAYSShIo=;
        b=QrlGXo+n9D7RfqENzPoBWhYPPJo4DOGzNfXDJ6gek3sJJ2nxqhKaIOYO3QcD00I6iW
         AcbDZR3FiGlgKdKa1Ilj3Rwz7SWTdeopaYRNAia4DCf+BlX/KTkKjUnaJj8I66UScgRJ
         +/ulSBJrmCi3DYYoWFjrmPPrKe+wPX9PTI24cS3yrYpbbF4Fyqm6CD2FH06nRJczSz04
         gi31/VBd0Kfg0r3RRFpNAaGIRu251/LtkLga/NkTnT3/fhf2hFDiQ0YmfmXp14Pr40wj
         cTzB9FPH362gM4F7YqAU4BFjh95pp6b2wuV7iyOy/AcPql7m2NxcBfqbsM7mjk5o/zDn
         loNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t/6ftpa8KEJE9o6IFoYpCHZyzY+Y35BOpCfDAYSShIo=;
        b=lRZ2dSFCHFNG7K176CUhMgTp5iIJIGkDR8OCyImg+usngIkQAX4aEEPvYeLkbgUj4/
         d6OAag8hNbj7gGm1qxpg0OOJdjJROhRbD2fUeY0q3FOjiaYuxJsDCEP512uNyl6GfjbY
         zpyjdhhYGmcIDt85qgwLWV+1hE4f//dwd0oblmMUMRAyNoQhavaMJ6t0G3e9Zb2APt9Y
         YEEiFc81Adue8RHVXN4e0287v5PQOq+qHpdrYpeu4FzQNeK3uqRtqDWpsUM/0HLI6/zv
         SRxvqcAiRmeS5Wj0q6szNBzoL399pyEnWj5mFLHMc5eOK8Lj4JBwAZuoGjeb+2QoRfds
         GJQg==
X-Gm-Message-State: APjAAAUjmdedPgOl6lLEAL7QZ4auXtj8U6qUm/jdvpNDFOZAhzx4wWtu
        xwgpx4F+I/UwiwilcxxBZvw=
X-Google-Smtp-Source: APXvYqwvMysi2jFsaYfZhHAVRTT5IFmPQJA3YpSu2oYgAes+UNdrnvAxUAEVk+7N6i0rwop/DBdHEw==
X-Received: by 2002:a37:4bc5:: with SMTP id y188mr3548298qka.13.1562344827870;
        Fri, 05 Jul 2019 09:40:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id r26sm3950383qkm.57.2019.07.05.09.40.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:40:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 675D740495; Fri,  5 Jul 2019 13:40:25 -0300 (-03)
Date:   Fri, 5 Jul 2019 13:40:25 -0300
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com,
        linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH 2/2] Fix perf-hooks test
Message-ID: <20190705164025.GB8600@kernel.org>
References: <20190702173716.181223-1-nums@google.com>
 <20190702173716.181223-2-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702173716.181223-2-nums@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 02, 2019 at 10:37:16AM -0700, Numfor Mbiziwo-Tiapo escreveu:
> The perf-hooks test fails with Address Sanitizer and Memory
> Sanitizer builds because it purposefully generates a segfault.
> Checking if these sanitizers are active when running this test
> will allow the perf-hooks test to pass.

Can you please add to the commit log message, here, the sequence of
steps needed to build with these sanitizers, so that one can replicate
the steps and reproduce the results?

- Arnaldo
 
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  tools/perf/tests/perf-hooks.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/tests/perf-hooks.c b/tools/perf/tests/perf-hooks.c
> index a693bcf017ea..524ecba63615 100644
> --- a/tools/perf/tests/perf-hooks.c
> +++ b/tools/perf/tests/perf-hooks.c
> @@ -25,7 +25,12 @@ static void the_hook(void *_hook_flags)
>  	*hook_flags = 1234;
>  
>  	/* Generate a segfault, test perf_hooks__recover */
> +#if defined(ADDRESS_SANITIZER) || defined(MEMORY_SANITIZER) || \
> +defined(THREAD_SANITIZER) || defined(SAFESTACK_SANITIZER)
> +	raise(SIGSEGV);
> +#else
>  	*p = 0;
> +#endif
>  }
>  
>  int test__perf_hooks(struct test *test __maybe_unused, int subtest __maybe_unused)
> -- 
> 2.22.0.410.gd8fdbe21b5-goog

-- 

- Arnaldo
