Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B211DC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861A1208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN35w7qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfE0Wqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:46:39 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34529 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfE0Wqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:46:38 -0400
Received: by mail-vs1-f67.google.com with SMTP id q64so11545404vsd.1;
        Mon, 27 May 2019 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nAxSDUpSTB5+2VyJk52eb0oMfVsMIDwOuaLx4OXvgqo=;
        b=IN35w7qpwmeOxb+sdX1U1YcdeXwoF1d6+JfPNgnMiww/n1QPCFZ+t2eLoHY9ltlPDy
         Mes886ny68/uHEh2S+VBmh2XCnSjZQvgWhwEd09tf69uhYu7tS7OO1APux8RNGxFcqi2
         7etk6pOUdSnu1cOTo1abqt7ySrKByczlRr7FqW4Ti3Ut3YiTgE9z6jB70JA47qGVaQFy
         UVbiqA6bfbIoYQgJXmDGwO8TIiwaP8YIiabSpLNt7awortVIF33ofiWxbCfURNeZmr8m
         jyiTSNOrUUKkidr1BhVWRYSUxuELjCNCuZhQYSm215ICRGD1fTH48TF6atD5dW23Jsjg
         iyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nAxSDUpSTB5+2VyJk52eb0oMfVsMIDwOuaLx4OXvgqo=;
        b=OTsfoZoEo1fdZMfpBhvbJpRd6W8KLIrH8L7ns5f/R11JwLcYCcqC8XBLfepsk2wwbg
         Mvocakg/938oQxV7Vx2kh0aSmtWyPhvprB+Dz8bhoXzJ+MbbDmUwlllyRYfuKHxlGwMB
         rhv2x4b9JXa0GeDY5aBZpw9OuhjIQma0ZCq8gVqNkTRkfbYVEcrxunJjFbZx1N5InMMC
         YlrYEfbimH9uTAru/VwEnCEGNKkEXW/letTVBQRO5Exne+xnPmGW2H5wT2cApXl3ztcl
         B2g2nDj2WbhB9x1BHDWHjamGh6a9FpRRGk+p9g1CzCbodvbGQBPxSJCq1BDgK6f0eNFn
         jxUg==
X-Gm-Message-State: APjAAAUrO3x9szZm4NJUGJPQ2o0CBDp82odEGwUbL9g5pycFM5k1ElKj
        KufSlsmY6G5jmjvouD2uShRhLwoI9gttXcFirPQ=
X-Google-Smtp-Source: APXvYqxsYi6DfDX048rPZgbDcdGYbIOH9u6yIRypUQzUmRpQfD2MPA55IEOwCXhRbAIN4lSNxquBgYv2/HDWj2xt33o=
X-Received: by 2002:a67:c78a:: with SMTP id t10mr37521604vsk.91.1558997197762;
 Mon, 27 May 2019 15:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190527223730.11474-1-acme@kernel.org> <20190527223730.11474-6-acme@kernel.org>
In-Reply-To: <20190527223730.11474-6-acme@kernel.org>
From:   Shawn Landden <slandden@gmail.com>
Date:   Mon, 27 May 2019 17:46:26 -0500
Message-ID: <CA+49okqviNfP087Z34-P4mJuMYc8_PiNJgTPz0xSAxqtp4iM0A@mail.gmail.com>
Subject: Re: [PATCH 05/44] perf data: Fix 'strncat may truncate' build failure
 with recent gcc
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 5:38 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Shawn Landden <shawn@git.icu>
>
> This strncat() is safe because the buffer was allocated with zalloc(),
> however gcc doesn't know that. Since the string always has 4 non-null
> bytes, just use memcpy() here.
>
>     CC       /home/shawn/linux/tools/perf/util/data-convert-bt.o
>   In file included from /usr/include/string.h:494,
>                    from /home/shawn/linux/tools/lib/traceevent/event-pars=
e.h:27,
>                    from util/data-convert-bt.c:22:
>   In function =E2=80=98strncat=E2=80=99,
>       inlined from =E2=80=98string_set_value=E2=80=99 at util/data-conver=
t-bt.c:274:4:
>   /usr/include/powerpc64le-linux-gnu/bits/string_fortified.h:136:10: erro=
r: =E2=80=98__builtin_strncat=E2=80=99 output may be truncated copying 4 by=
tes from a string of length 4 [-Werror=3Dstringop-truncation]
>     136 |   return __builtin___strncat_chk (__dest, __src, __len, __bos (=
__dest));
>         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
>
> Signed-off-by: Shawn Landden <shawn@git.icu>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> LPU-Reference: 20190518183238.10954-1-shawn@git.icu
> Link: https://lkml.kernel.org/n/tip-289f1jice17ta7tr3tstm9jm@git.kernel.o=
rg
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/data-convert-bt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-con=
vert-bt.c
> index e0311c9750ad..9097543a818b 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -271,7 +271,7 @@ static int string_set_value(struct bt_ctf_field *fiel=
d, const char *string)
>                                 if (i > 0)
>                                         strncpy(buffer, string, i);
>                         }
> -                       strncat(buffer + p, numstr, 4);
> +                       memcpy(buffer + p, numstr, 4);
I took care to have enough context in my patch that you could see what
was going on. I wonder if there is a way to make that care
propate when people add Signed-off-by: lines.
>                         p +=3D 3;
>                 }
>         }
> --
> 2.20.1
>
