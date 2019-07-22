Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF285C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9885E2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="df+2EoaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfGVRkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:40:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43184 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbfGVRkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:40:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so12505861pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYfzslaWulTFr0xM3TKG5/yZQnVIHkJch0xVtez9k0w=;
        b=df+2EoaAYbHuE4qZhyMXCJ2/XHW6oy3ksUiV7wnxQ+uTiRGCoE6EgC0RxbUzaksfBw
         tNmx6nleN7Ts6xN7Q6rgK1qye5hmLp+tWni+mbXYj5CQAPkmj7QwstOaVlJd8miVKKC6
         cVws66RR3SHBzqNrVU3D4Kc4ORYNtsj7mnzgnH/f9xFDhWmR//tWcPuJjezt9VJfUMrI
         clsGcfozCH6hPB+GwSo4o7Wy6GM7j2GehRUxV6lEoWngxLuMQt3KgeaXSd9IT/1or6c9
         yC+tpAmREowCZVsbTh8Eky2NOCWSd0jgynSVfZWEfRmdRqCp79lNhsit44PCE1zXFxYd
         PHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYfzslaWulTFr0xM3TKG5/yZQnVIHkJch0xVtez9k0w=;
        b=OU0dk5NI3aa3CGy0Zv0ibWKn6mXakNXcaeT/2rtkIgZDy8WrRT/Iy6qWfTbZwgZMQG
         e9aKmJrLWsOY5FUGTOQ+XobT2W1t+Oe5XS/IPYyJRxYdWiugtaHbKp5SCz5Fc78y+rS/
         rQP4BLHX3R0Ijl0r9WSM+V9DLh779NyYEA+jflfU744giO9uTcn/8iA3Jd7uV2Rk8SXS
         sqkXqW0IKGaRs9ixHJeM/3zj/AixitUGAPVQizfuPwEpv5S4kmz4dxzZD+zn6tewcNoY
         1CRTeog+3qTymKtvSi0O5jjUEb3/LMeDzMpE60Vq/KBlXV+kRV1xAKu/D4uLWVO+tgmh
         s0GQ==
X-Gm-Message-State: APjAAAUC4o1OdP+TvgvMvU3KHqJK7yo6YuTLwWmJELaHG0rtzHZ4O+dO
        2xat0JbPnAqrceyXqZ6Dx0BFfPhQ1qiJhU7PIwfY8lgPrROrpQ==
X-Google-Smtp-Source: APXvYqx4+xtrOszTxdbwMjjZxdFHkrqWHgPpK/6/Qd315mVt5H5fxqHOXY82vPusbgwgagNfayPARa52vgkOLZSaxA4=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr75631504plq.223.1563817251308;
 Mon, 22 Jul 2019 10:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <201907192038.AEF9B52@keescook>
In-Reply-To: <201907192038.AEF9B52@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jul 2019 10:40:40 -0700
Message-ID: <CAKwvOdkkqhwHz_yLN5VjAdENj3qtwdJ080QKpQ9vr--F1xQPhA@mail.gmail.com>
Subject: Re: [PATCH] libata: zpodd: Fix small read overflow in zpodd_get_mech_type()
To:     Kees Cook <keescook@chromium.org>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 8:41 PM Kees Cook <keescook@chromium.org> wrote:
>
> Much like commit 18c9a99bce2a ("libata: zpodd: small read overflow in
> eject_tray()"), this fixes a cdb[] buffer length, this time in
> zpodd_get_mech_type():
>
> We read from the cdb[] buffer in ata_exec_internal_sg(). It has to be
> ATAPI_CDB_LEN (16) bytes long, but this buffer is only 12 bytes.
>
> The KASAN report was:
>
> BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
> Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149
> ...
> The buggy address belongs to the variable:
>  cdb.48319+0x0/0x40
>
> Reported-by: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
> Fixes: afe759511808c ("libata: identify and init ZPODD devices")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Interesting, both initializer lists are less than ATAPI_CDB_LEN (16)
elements, yet ata_exec_internal_sg() in drivers/ata/libata-core.c very
clearly has a ATAPI_CDB_LEN byte memcpy on that element.  Probably
both initializer lists should just lead off the trailing zero's or
provide the entire 16 elements.  For now, thank you for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/ata/libata-zpodd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
> index 173e6f2dd9af..eefda51f97d3 100644
> --- a/drivers/ata/libata-zpodd.c
> +++ b/drivers/ata/libata-zpodd.c
> @@ -56,7 +56,7 @@ static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
>         unsigned int ret;
>         struct rm_feature_desc *desc;
>         struct ata_taskfile tf;
> -       static const char cdb[] = {  GPCMD_GET_CONFIGURATION,
> +       static const char cdb[ATAPI_CDB_LEN] = {  GPCMD_GET_CONFIGURATION,
>                         2,      /* only 1 feature descriptor requested */
>                         0, 3,   /* 3, removable medium feature */
>                         0, 0, 0,/* reserved */
> --
> 2.17.1
>
>
> --
> Kees Cook



-- 
Thanks,
~Nick Desaulniers
