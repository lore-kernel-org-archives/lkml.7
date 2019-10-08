Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC009C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA10820873
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SJySUhGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfJHWUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:20:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34534 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:20:45 -0400
Received: by mail-io1-f66.google.com with SMTP id q1so590016ion.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVXX+jePG0dCtUJvg0DDOB9y84J6FIyWcr2vDL3JBhU=;
        b=SJySUhGxbmn/z4rxv9EcvoyuY58UMbJjjlI5IXJep3N8nUl1az6BoWji8k9FAnv7zJ
         +OaYKJbhRu6oKs8uY3BrrxiBNL7ZdmsvdsbnsL1LdCYyjv+Dsxe9dQOFGjA7RXWsNFv9
         bKVRXreg1AVstVtJPPVC5ZYOuFp6Z7eQ6C6cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVXX+jePG0dCtUJvg0DDOB9y84J6FIyWcr2vDL3JBhU=;
        b=gCv9ABWSi1iNMonH2VqqELD+ZD8cpKXnUewI8O4Z4VJTLGFD7qjV9Zk3W1dKYorKfD
         2GjGulWvOPSu9Pww7AOz4/lsv5oo3krYkNA2jMtPQ3yd1e7676JxQqnPlWCuq6m0ZYsy
         7Mnu3pa8dR/LCfOF0oJAdqrw3s/caQdbaQgAfTM0dv5yInpXKDJDVPgvzeXikMyAcl9T
         Wn1vN0+sLIpWbVsMXKAvPIxv2KmkE1Ch9ZFhkVLD7foZ0IMdicyT29FKHi5kSA0jPkb4
         Y40f83LmwLUDLu1cZmmwSEFGDghKKczZ2KR7awNv2OVnSXdMeGS2VDCa/4li6qwAhiVT
         fGFw==
X-Gm-Message-State: APjAAAU46X7GNx8i/LVLqHezuD0h+aYX4wXUxSvBQeiGCRW6uU+aVjbL
        ZeqRP0qNWRyc4y/xXwD4boQS/8RQ8mo=
X-Google-Smtp-Source: APXvYqyGMKU6vuCr4UxBC3NqUgjh0d3N3Rt/hG/zmETFdsje/OUbOT1Fgg6VUgqQxBnWoG2nLZLeLg==
X-Received: by 2002:a02:ac8e:: with SMTP id x14mr280405jan.11.1570573244204;
        Tue, 08 Oct 2019 15:20:44 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id d26sm151203ioc.16.2019.10.08.15.20.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 15:20:43 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id h144so508355iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:20:43 -0700 (PDT)
X-Received: by 2002:a92:dcc1:: with SMTP id b1mr733444ilr.168.1570573242957;
 Tue, 08 Oct 2019 15:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191008132043.7966-1-daniel.thompson@linaro.org> <20191008132043.7966-2-daniel.thompson@linaro.org>
In-Reply-To: <20191008132043.7966-2-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Oct 2019 15:20:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WE1Ys4t5Xxic2vSn0zrvJ38fvkQuU5Nws6WXHXo3bQNw@mail.gmail.com>
Message-ID: <CAD=FV=WE1Ys4t5Xxic2vSn0zrvJ38fvkQuU5Nws6WXHXo3bQNw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] kdb: Tidy up code to handle escape sequences
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 8, 2019 at 6:21 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> kdb_read_get_key() has extremely complex break/continue control flow
> managed by state variables and is very hard to review or modify. In
> particular the way the escape sequence handling interacts with the
> general control flow is hard to follow. Separate out the escape key
> handling, without changing the control flow. This makes the main body of
> the code easier to review.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 127 ++++++++++++++++++++------------------
>  1 file changed, 66 insertions(+), 61 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 3a5184eb6977..68e2c29f14f5 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -49,6 +49,63 @@ static int kgdb_transition_check(char *buffer)
>         return 0;
>  }
>
> +/*
> + * kdb_read_handle_escape
> + *
> + * Run a validity check on an accumulated escape sequence.
> + *
> + * Returns -1 if the escape sequence is unwanted, 0 if it is incomplete,
> + * otherwise it returns a mapped key value to pass to the upper layers.
> + */
> +static int kdb_read_handle_escape(char *buf, size_t sz)
> +{
> +       char *lastkey = buf + sz - 1;
> +
> +       switch (sz) {
> +       case 1:
> +               if (*lastkey == '\e')
> +                       return 0;

Technically the "if" here isn't needed, at least not until a later
patch in the series.  The only way we could get here is if *lastkey ==
'\e'...

...but I suppose it's fine to keep it here in preparation for the last patch.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
