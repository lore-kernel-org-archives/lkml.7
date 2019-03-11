Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611D0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEC62075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfCKOzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:55:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41263 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfCKOzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:55:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id v10so5337568qtp.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AebQmIMK8lzGgezuA2w2mUrodEUsYs59QWYsQaJJEuA=;
        b=F/Bkt9IN6By2/WuMqsc7fZgLq35TjLbaP2K6rxXdrx4mIEND61A8GcaBN58+4Y7ZNA
         7X4ah0HmOq69Nt1AB3iqX7CFxfBAiJmt+KRg0D1laUGnvYs/6V2diP+Uyenpmqf19tvK
         +THJ8edRhJGjJznHpDKSYZN4j2Akm+VU49ixZsVvKkqxwTkOlpCwpDIU61VmrUMKFe+A
         6TpuXYFgd6XTTzXVezV4tvWDw7/ZA7LLmGGKIa4bB/uqB1lIhynyuKZXxT5MOY/h1vf9
         eNgrAv3OmxAU49lrVbHGmTgBSwgTJYJI3kw9WXw0UYmgwrt+p+zFf0mb2S8Mzanzk15W
         F4lA==
X-Gm-Message-State: APjAAAUFyblnVpPv5kAtABA0QH/OGjd4Rs6q9+MFljsIwGbT2mi1yRdm
        Khy8KXikQI0aQoCoWNYe5GjEvzhs/7bTZTrc30H3aw==
X-Google-Smtp-Source: APXvYqybFKoYtimWvcJeDFm8//cGF5ptvZkYk5jQ9zfifTYwB4h+se5w0DVgVfSuaNFsjZCSphHLp1eTmm/6jnJFSYQ=
X-Received: by 2002:ac8:2eb8:: with SMTP id h53mr10098479qta.188.1552316150956;
 Mon, 11 Mar 2019 07:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190302222338.8023-1-colin.king@canonical.com>
In-Reply-To: <20190302222338.8023-1-colin.king@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 11 Mar 2019 15:55:39 +0100
Message-ID: <CAO-hwJJXgiLqLCQ+8Cw7Z1=yba0pVkLCkGH8R8HZjNQj=Vg4GA@mail.gmail.com>
Subject: Re: [PATCH][next] HID: uclogic: remove redudant duplicated null check
 on ver_ptr
To:     Colin King <colin.king@canonical.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 11:23 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently ver_ptr is being null checked twice, once before calling
> usb_string and once afterwards.  The second null check is redundant
> and can be removed, remove it.
>
> Detected by CoverityScan, CID#1477308 ("Logically dead code")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to for-5.1/upstream-fixes

Cheers,
Benjamin

>  drivers/hid/hid-uclogic-params.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
> index 7710d9f957da..0187c9f8fc22 100644
> --- a/drivers/hid/hid-uclogic-params.c
> +++ b/drivers/hid/hid-uclogic-params.c
> @@ -735,10 +735,6 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
>                 goto cleanup;
>         }
>         rc = usb_string(udev, 201, ver_ptr, ver_len);
> -       if (ver_ptr == NULL) {
> -               rc = -ENOMEM;
> -               goto cleanup;
> -       }
>         if (rc == -EPIPE) {
>                 *ver_ptr = '\0';
>         } else if (rc < 0) {
> --
> 2.20.1
>
