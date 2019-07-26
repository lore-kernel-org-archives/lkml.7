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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610A0C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EE822BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUPSK9iA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfGZTfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:35:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45546 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfGZTfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:35:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so39931612qkj.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9rZxd8VlixOlt9zfomJK4+5/qXD8hXRfD7GJqGB6X9U=;
        b=ZUPSK9iAYNIhz/pAuQzPdbv97MxD6VdG+EGmXpFKU6hvFq5Rg6BUBfTHrYr61YsmJe
         RqdKZbg0FStQeo3I4qm6IDF21NSYAOZ/HdGjGFz17M+RngzYC140ASrBRHVtWU4ZrujI
         eZevzK5KR+6DlWv4t6aSsnqfrR1GfPVeNYJqTQ8ISXcVlekwzDe0yDXNa/QJRerBnmFX
         MhsiVNGwhRM2cULQ8te5NpkUpUizHYOJqNnnZBOGnD2yw1TP+EKnQLfBZFicfEtMDXHz
         fYx7lax0XlWYbcneW97TaK9nWY1o7d2N12D6oB2wyhyrSklCkOEESR4rdmm9gnsluQtz
         IisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9rZxd8VlixOlt9zfomJK4+5/qXD8hXRfD7GJqGB6X9U=;
        b=odPxtJYyfGSyJAHv7gUB3OBkcrIO5cxi+98EcvwsNVRfjY6GMkBNXJAdxX95cGUYZu
         c6T3N0DSL2asYmaxhBmazWEOPQoyyg3PnJz+h/gktDYJWB09qXVvTZij2MFYGxQVgOvN
         LWBE0oKbszKc4kRq+2GwfeSzF53R0adZR5RjoeHWI0GXJHauVolgQ6c7Gzj+QG4rY39I
         IWV8zs+M+h+x8pYpcTtB5LtAu2NNWJxABrO4Z4plgJV1JQau/rTzdaCP/XpUVAWC18Wl
         pG1Wg6n5MJfpkXCboi6VrBtr0ZaQy3mUgq1yfZpxUzRFPZBk7ix34GPVNh7XKt1QReAJ
         qOSw==
X-Gm-Message-State: APjAAAXtv8rwIJa38yHGVOplYVMRSaUfI2sifvEbQOmuV2K5YRG4QVOL
        P1Rb5jJG/shP2Bj9N1ASe0E=
X-Google-Smtp-Source: APXvYqz2Z7i28hZM+M4lbb8YD+uC39dWedzDQMekatgaWQtcfJU4UDdKKM/73crOYiB5vczjfwhUwg==
X-Received: by 2002:a37:815:: with SMTP id 21mr63769478qki.257.1564169730335;
        Fri, 26 Jul 2019 12:35:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id h18sm22574293qkk.93.2019.07.26.12.35.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:35:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1BFD940340; Fri, 26 Jul 2019 16:35:27 -0300 (-03)
Date:   Fri, 26 Jul 2019 16:35:27 -0300
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com,
        linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH 2/3] Fix ordered-events.c array-bounds error
Message-ID: <20190726193527.GA24867@kernel.org>
References: <20190724184512.162887-1-nums@google.com>
 <20190724184512.162887-3-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190724184512.162887-3-nums@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 24, 2019 at 11:45:11AM -0700, Numfor Mbiziwo-Tiapo escreveu:
> Perf does not build with the ubsan (undefined behavior sanitizer)
> and there is an error that says:
> 
> tools/perf/util/debug.h:38:2:
>  error: array subscript is above array bounds [-Werror=array-bounds]
>   eprintf_time(n, var, t, fmt, ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> tools/perf/util/debug.h:40:34:
>  note: in expansion of macro ‘pr_time_N’
>  #define pr_oe_time(t, fmt, ...)  pr_time_N(1, debug_ordered_events,
>  t, pr_fmt(fmt), ##__VA_ARGS__)
> 
> util/ordered-events.c:329:2: note: in expansion of macro ‘pr_oe_time’
>   pr_oe_time(oe->next_flush, "next_flush - ordered_events__flush
>   POST %s, nr_events %u\n",
> 
> This can be reproduced by running (from the tip directory):
> make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"
> 
> The error stems from the 'str' array in the __ordered_events__flush
> function in tools/perf/util/ordered-events.c. On line 319 of this
> file, they use values of the variable 'how' (which has the type enum
> oeflush - defined in ordered-events.h) as indices for the 'str' array.
> Since 'how' has 5 values and the 'str' array only has 3, when the 4th
> and 5th values of 'how' (OE_FLUSH__TOP and OE_FLUSH__TIME) are used as
> indices, this will go out of the bounds of the 'str' array.
> Adding the matching strings from the enum values into the 'str' array
> fixes this.
> 
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  tools/perf/util/ordered-events.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
> index 897589507d97..c092b0c39d2b 100644
> --- a/tools/perf/util/ordered-events.c
> +++ b/tools/perf/util/ordered-events.c
> @@ -270,6 +270,8 @@ static int __ordered_events__flush(struct ordered_events *oe, enum oe_flush how,
>  		"FINAL",
>  		"ROUND",
>  		"HALF ",
> +		"TOP",
> +		"TIME",
>  	};
>  	int err;
>  	bool show_progress = false;

Humm, this was fixed already by:

commit 1e5b0cf8672e622257df024074e6e09bfbcb7750
Author: Changbin Du <changbin.du@gmail.com>
Date:   Sat Mar 16 16:05:52 2019 +0800

    perf top: Fix global-buffer-overflow issue

    The array str[] should have six elements.

      =================================================================
      ==4322==ERROR: AddressSanitizer: global-buffer-overflow on address 0x56463844e300 at pc 0x564637e7ad0d bp 0x7f30c8c89d10 sp 0x7f30c8c89d00
      READ of size 8 at 0x56463844e300 thread T9
          #0 0x564637e7ad0c in __ordered_events__flush util/ordered-events.c:316
          #1 0x564637e7b0e4 in ordered_events__flush util/ordered-events.c:338
          #2 0x564637c6a57d in process_thread /home/changbin/work/linux/tools/perf/builtin-top.c:1073
          #3 0x7f30d173a163 in start_thread (/lib/x86_64-linux-gnu/libpthread.so.0+0x8163)
          #4 0x7f30cfffbdee in __clone (/lib/x86_64-linux-gnu/libc.so.6+0x11adee)
