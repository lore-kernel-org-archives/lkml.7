Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524F6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C71420850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aORwKUHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfHYOU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 10:20:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47049 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbfHYOU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 10:20:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id j15so15526659qtl.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l2Yitugva1EUrPKohaqSUfkaCQgBIwseyIUlvSFrx60=;
        b=aORwKUHkRaLp6biqe5xo7zK98/V/8HFX7+3DdUGeR6dF42xSfoAkPnptnjZxRZAZFD
         cqhXDZ4LianEjQYtOxALA5x/QVE/jmj1iwiY6bMlHtZ8Z4HarVT9TQVRLssr/ylSSSkX
         kEXdx4Z2VQOTXQc9rx/lSw3DGDxUKnvyHbEZ1G9wApeEN0mJlaubsACiC/OMIAgHiZc6
         WIHGQXLlL48xVe22jqYf7UBhDpymivUhTOUnCbPidVQFpQEh8YecaO8Whz/LaF3c5/KP
         Q0qdn3v6cIL473IvSBaya3b2Dgu3lxlcCuezssR94wBIsxkD8iaF/3diNjNYCOD66E+s
         Qljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l2Yitugva1EUrPKohaqSUfkaCQgBIwseyIUlvSFrx60=;
        b=Vvs6Qnz0UBzY0w5eSKbc+H4LdXXp6no+ZlfA2xkJB4EsnfM0hxwl8DMP3tIbBR/zzG
         j145N2j4YRmhUJ2pMgja926DrsyOTqShk6cozN4wQEQ+dRJrmbvFqMKIXD+yVWqYqX5I
         M+2QFeyyVB2GceEdgZW4nyzLO+XuBCC6uaXM7SdoYQ5W7OdLKNCdgos7ZMKdk1vloxMA
         MQANuPu2gFRtMhhJUXAT7dHR4R9B4vJHDTPKLO7OlxceTGPm88F9/dsjTwCiWiFqduk9
         GqJ/KCPymfxx4doFrv5CpggRA7tJsWKHz85yzHrf/UDHm5uLUXQPl+8OuAsAQLnoFgtA
         5iOQ==
X-Gm-Message-State: APjAAAWsKeCi4rHeMvH6yQsDgxvwo3oZWHletuY/uYV/Txbdw0dEBI/w
        Na0cFJms3A//NUb3hYiZhuM=
X-Google-Smtp-Source: APXvYqybk9lR9+PLsEp0NFwz0pAugZxYHe7k/dxd4jis6A6iK5ugmKvCDObmZ5ikuXV1A9MnGTKQOw==
X-Received: by 2002:ac8:794f:: with SMTP id r15mr13645313qtt.130.1566742826641;
        Sun, 25 Aug 2019 07:20:26 -0700 (PDT)
Received: from quaco.ghostprotocols.net (user.186-235-140-211.acesso10.net.br. [186.235.140.211])
        by smtp.gmail.com with ESMTPSA id t26sm5549585qtc.95.2019.08.25.07.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 07:20:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7386C40340; Sun, 25 Aug 2019 11:20:23 -0300 (-03)
Date:   Sun, 25 Aug 2019 11:20:23 -0300
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] perf: Remove duplicate headers
Message-ID: <20190825142023.GB26569@kernel.org>
References: <1566663319-4283-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566663319-4283-1-git-send-email-jrdr.linux@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 24, 2019 at 09:45:19PM +0530, Souptick Joarder escreveu:
> Removed duplicate headers which are included twice.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/util/data.c                 | 1 -
>  tools/perf/util/get_current_dir_name.c | 1 -
>  tools/perf/util/stat-display.c         | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 6a64f71..509a41e 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -8,7 +8,6 @@
>  #include <unistd.h>
>  #include <string.h>
>  #include <asm/bug.h>
> -#include <sys/types.h>
>  #include <dirent.h>
>  
>  #include "data.h"
> diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
> index 267aa60..ebb80cd 100644
> --- a/tools/perf/util/get_current_dir_name.c
> +++ b/tools/perf/util/get_current_dir_name.c
> @@ -5,7 +5,6 @@
>  #include "util.h"
>  #include <unistd.h>
>  #include <stdlib.h>
> -#include <stdlib.h>
>  
>  /* Android's 'bionic' library, for one, doesn't have this */
>  
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 6d043c7..7b3a16c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -12,7 +12,6 @@
>  #include "string2.h"
>  #include "sane_ctype.h"
>  #include "cgroup.h"
> -#include <math.h>
>  #include <api/fs/fs.h>
>  
>  #define CNTR_NOT_SUPPORTED	"<not supported>"
> -- 
> 1.9.1

-- 

- Arnaldo
