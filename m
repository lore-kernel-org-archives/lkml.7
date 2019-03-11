Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C793C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD27206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub72mcrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfCKQ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:59:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42931 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:59:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id u7so5848091qtg.9;
        Mon, 11 Mar 2019 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KI+BNiyO0P4l5mn1tS7DhvkOTjvTUqUiUWapeOMdJOk=;
        b=Ub72mcrA/6SU7i5WA23qIwjUEL2XNjB6p/z6VsjO4FtWatd1QrgokNiFX1TO5NZ0tP
         sCL19UeKrR5q/YsovnCujc+8fIzQnYhNx6VBIilv9JpOJDvYnRnZuZofBLsGMeIC0aXK
         NVceYVKQWtE2LA46J1u2lfD2aX0l+MeXuqn9NSs224fURgJnA3fFSL0dQmprnRhqcOkZ
         T8BjaWLWKwRpP5UN5RP7flweE1EPZmkTu7ET+lQf4jyeXyXrPIzMeBPaR51LbUcrswOH
         Arc5yHtPMMJ2NehNw/PWbYzLQw6oOcl/s8qweOFO3HE55Yykq3IG3obk7ssz5KgAWeW9
         fVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KI+BNiyO0P4l5mn1tS7DhvkOTjvTUqUiUWapeOMdJOk=;
        b=lHHsvb/BcLMpKr3WmBpaWCtfk75Xsa5m8g/Iv7T54UH0KmD5cQrgoONMdFlkylCtkd
         87kNn4dkLGTWA00sGmPPQwCnsbsF0FZDv1p4IzkzVVsbSzJ1R5iWAZ2TmG1lETWkT/g7
         P2L6NjIEYzqAO4r6iywQOrULUGUtOiD3SGkEbHVhKwjoDBIoJRV402uGBAxvxka4TjMG
         +QIR/91xsfdh2ird02UWN4kz3EyOMytHlPcAZRp5ietPI5IxgPz0fTkvvC4LJGLflJPj
         DVzg0Q39ImNlrF2msT8MeTGQtaVD4aXlS5GTesologmdYmjqb86ahEAr8jDX+FMeE4E1
         MsHQ==
X-Gm-Message-State: APjAAAX7ux0ke53mRl6VMn633C2ktUx5XTKx4hdXkK/f7XBxS5ZxSd5R
        3HL20mEqQNlAoQkT221Ipi/gnfx5
X-Google-Smtp-Source: APXvYqwiPgC/ziSOVUrb5fp4I3rgFXBPAuLlfhwiAXkpbybWTuqmNxRWZfkegxtvsI21h3io2jLT3Q==
X-Received: by 2002:ac8:8d5:: with SMTP id y21mr27186795qth.67.1552323569427;
        Mon, 11 Mar 2019 09:59:29 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.162.132.204])
        by smtp.gmail.com with ESMTPSA id g123sm9333540qkg.0.2019.03.11.09.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 09:59:28 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 26A5E4039C; Mon, 11 Mar 2019 13:59:25 -0300 (-03)
Date:   Mon, 11 Mar 2019 13:59:25 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 02/11] perf tools report: Parse time quantum
Message-ID: <20190311165925.GO10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-3-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-3-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 07:44:53AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Many workloads change over time. perf report currently aggregates
> the whole time range reported in perf.data.
> 
> This patch adds an option for a time quantum to quantisize the
> perf.data over time.
> 
> This just adds the option, will be used in follow on patches
> for a time sort key.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ---
> v2:
> Move time_quantum to symbol_conf. check for zero time quantum
> v3:
> Document s unit
> v4:
> Use _NSEC defines

Humm? This just adds a header, but nevermind, I have the full patch in
my tree already :-)

- Arnaldo

> ---
>  tools/perf/util/symbol.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 6b73a0eeb6a1..967066d4d899 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -30,6 +30,7 @@
>  #include <elf.h>
>  #include <limits.h>
>  #include <symbol/kallsyms.h>
> +#include <linux/time64.h>
>  #include <sys/utsname.h>
>  
>  static int dso__load_kernel_sym(struct dso *dso, struct map *map);
> -- 
> 2.20.1

-- 

- Arnaldo
