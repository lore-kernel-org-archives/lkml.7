Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8452BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533EA2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffz1d7Kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfCEU5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:57:15 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:46602 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfCEU5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:57:15 -0500
Received: by mail-qt1-f174.google.com with SMTP id z25so10436229qti.13;
        Tue, 05 Mar 2019 12:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pywPfCLG8SiW/sHFe7irf0pLLBM1icy57+JFvSZCGVM=;
        b=ffz1d7KgT9iP2OViA7sHfqmzsKNKt5JotViRbynckIyJ2j69x/yuqXN8Br/2O8RvPe
         13jCsvB5FUujG/MUWAnO6kOqdJMzK7DGt1wVt6PdHsY61Aep6UJMCreoQGXKAoOrc7gL
         0ed4/NysybThn9wRBp0ehQrA6VsndvE8xEoPf2U8pevWK4fU7H2ezKRu/PqMnKCkHPOW
         6ow84CXcGF4r7w94BnQFTwBD8k8Ljm7+dHOLRJ4WTwtKHa0KbP/L+D537NZaEDY6yzFN
         WPxiF//icl0b7ZzOcgAfzXe6fTtQBPzgIxUqUeJwB9HtGIVXyTL2ZjrKs/gleEIWy9lg
         6lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pywPfCLG8SiW/sHFe7irf0pLLBM1icy57+JFvSZCGVM=;
        b=hmdTUrGdqXUJj1MIQdZSbwHWhZZGQzkFAN4IECkf40WPGNPBGTeAXxLH9USobp/9mo
         zzyNAwFPDIMIdFkMqDoNNBxnEu8yAlml24qXAPdaVhXIrL9iwAipMawAeTcFvElpea6T
         R6y5ApQEPdn23iwrLlF17L1xkxhEjIRU3RP2PDA6yp3Mn2Tg7pdMJo6pAPo5MxJRSXfO
         kURUh8yCEvSmgH9iWYbXICiGkWgKVu56SR77ASYZWCUvJ5cBJsmS7kXP6i6fajGs7VHV
         yU0FHzj+6m3aBN2wucn86bgO4x2b3TYSsA7fUd7xtLTVrAVq2uA4r663MRnvpfKxoHsI
         JPNg==
X-Gm-Message-State: APjAAAXD/bplqIYSqsC191r7XFthMFkRKdyDJMLkLYKC5iPYYE5PkRSB
        jirX+qhpGxgV2uYfJFsXjNraDVim6UbrMNaDUK0=
X-Google-Smtp-Source: APXvYqwfNzsnSUMD5rNWn40e9/qpjgysMxjKuZLdCTNJB4KYI5lFiniYp9yN8FaROmOeleq11djCdCKTY2XmMHDiD0Q=
X-Received: by 2002:a0c:b0cb:: with SMTP id p11mr3661553qvc.239.1551819433742;
 Tue, 05 Mar 2019 12:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20190305173113.26119-1-colin.king@canonical.com>
In-Reply-To: <20190305173113.26119-1-colin.king@canonical.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 5 Mar 2019 12:57:02 -0800
Message-ID: <CAPhsuW4BATiS5btfY1SSOUgMscRemGfj56rUHNzX9NGdt7wqag@mail.gmail.com>
Subject: Re: [PATCH][bpf-next] bpf: hbm: fix spelling mistake "deault" -> "default"
To:     Colin King <colin.king@canonical.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 9:41 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are a couple of typos, fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I guess this could go to bpf tree.

Acked-by: Song Liu <songliubraving@fb.com>


> ---
>  samples/bpf/hbm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
> index 8408ccb7409f..a79828ab273f 100644
> --- a/samples/bpf/hbm.c
> +++ b/samples/bpf/hbm.c
> @@ -18,7 +18,7 @@
>   *             Default is /hbm1
>   *    -r <rate>        Rate limit in Mbps
>   *    -s       Get HBM stats (marked, dropped, etc.)
> - *    -t <time>        Exit after specified seconds (deault is 0)
> + *    -t <time>        Exit after specified seconds (default is 0)
>   *    -w       Work conserving flag. cgroup can increase its bandwidth
>   *             beyond the rate limit specified while there is available
>   *             bandwidth. Current implementation assumes there is only
> @@ -376,7 +376,7 @@ static void Usage(void)
>                "               Default is /hbm1\n"
>                "    -r <rate>  Rate in Mbps\n"
>                "    -s         Update HBM stats\n"
> -              "    -t <time>  Exit after specified seconds (deault is 0)\n"
> +              "    -t <time>  Exit after specified seconds (default is 0)\n"
>                "    -w         Work conserving flag. cgroup can increase\n"
>                "               bandwidth beyond the rate limit specified\n"
>                "               while there is available bandwidth. Current\n"
> --
> 2.20.1
>
