Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768B3C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B1020B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdz1QcTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfGCDJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:09:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36630 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfGCDJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:09:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id p15so990786qtl.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 20:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xFqqC+Ngzt8dNCfl2mWlwTPcMXkNsrKFhzRFHu0uFBI=;
        b=Wdz1QcTOxjcvcY7Cu0BTjOWurKgeMYq+k1MnpKquUOr/lgtqvCLd2v5b/CzA05GNqP
         QyTzSI1UoczYPCLPSaEf4H8XkJOw+iYQSg7KJJMTMhS4Vmqf0yqWL282xPVwx9DGx16E
         MC/KsVPs6SiZm20tX62Wa4VlqRGDpXavIJhtWCkW9uhLPvG+64LF9P1BkUitnmicI/fV
         v+li4TUnKhToc4jYVAufvWKddkVVAvR2Ykg/q0jGWFD2My4hG7VGhuDkDYGt4pNOreFs
         OxWUrptAJL4m+JVh2w4OOe5sdI7P0STaaoJKXS0RpctYt/oX6Wge48i8eLXrjROuiM9k
         y3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xFqqC+Ngzt8dNCfl2mWlwTPcMXkNsrKFhzRFHu0uFBI=;
        b=KFVy4o7uz71oD8H1AnMoMrv/aGG1ZTdK76+W9vfm+IlCwEA/1oXtaStjmjkIZ0Wp7V
         XJVdSYqlDDQnuULNf3RHcn6xQ6GJQiKiVS5+bRxDNqzj6ZF3/G+4D7uGk3rRb3ndZXSr
         z1GhpIaarhU2+3sMDPM0Xbakgky3ExaAvCNGnCSPBYwPEJg/u94yJnRzI9P3/z8+bVaO
         gi5GeJfeiRev8IR9S0+rJs2VxEXHfdIGVD+e9iKJNQr5UVkh5PwQijkcC+KrXLkMUPgx
         TmQiUlqLJmch3qaw9IOFQXtjcKSWxvJrC3Z6A5tqFzN80bYejXdGDhTp3bjAmDqIGIYy
         taQQ==
X-Gm-Message-State: APjAAAW83nzTRJm6AeNlR5YAfoFi3veRxAPOjVK4aogmmTDfa2+9Cdyo
        1uiNUrVaX6wte+mFvECjF38=
X-Google-Smtp-Source: APXvYqwEwTIruK5S3TlMvHZUXUmTSyZCrYHiDqk7MObG3OG/uUTLaJnUrLr7HDsRsw5kGxY1Iex4jA==
X-Received: by 2002:ac8:47cd:: with SMTP id d13mr15361913qtr.156.1562123371103;
        Tue, 02 Jul 2019 20:09:31 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id k38sm521435qtk.10.2019.07.02.20.09.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 20:09:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0EF9741153; Wed,  3 Jul 2019 00:09:27 -0300 (-03)
Date:   Wed, 3 Jul 2019 00:09:26 -0300
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com,
        linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH 1/2] Fix mmap-thread-lookup.c unitialized memory usage
Message-ID: <20190703030926.GN15462@kernel.org>
References: <20190702173716.181223-1-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702173716.181223-1-nums@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 02, 2019 at 10:37:15AM -0700, Numfor Mbiziwo-Tiapo escreveu:
> Running the perf test command after building perf with a memory
> sanitizer causes a warning that says:
> WARNING: MemorySanitizer: use-of-uninitialized-value... in mmap-thread-lookup.c
> Initializing the go variable to 0 fixes this change.
> 
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  tools/perf/tests/mmap-thread-lookup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
> index 5ede9b561d32..b1abf4752f35 100644
> --- a/tools/perf/tests/mmap-thread-lookup.c
> +++ b/tools/perf/tests/mmap-thread-lookup.c
> @@ -52,7 +52,7 @@ static void *thread_fn(void *arg)
>  {
>  	struct thread_data *td = arg;
>  	ssize_t ret;
> -	int go;
> +	int go = 0;
>  
>  	if (thread_init(td))
>  		return NULL;

The test needs to write something to a file, whatever, so this doesn't
fix anything, just silences the compiler warning, which is a good thing.

I'll apply and adjust the cset commit log.

Thanks,

- Arnaldo
