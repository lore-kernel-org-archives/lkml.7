Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE1AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9928B20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLcqbuVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCGFmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 00:42:46 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41296 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGFmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 00:42:45 -0500
Received: by mail-ua1-f68.google.com with SMTP id j7so9807179uak.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 21:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nig2vrbs6zKJ2eRQhqOhxS7/tBVdG0lBX9UTyMM/Vbw=;
        b=ZLcqbuVwhEI6gHPBW3CEDvEZKWtfWfW/IrU0g8zESgdebepePAm7HGeGEuUySvpQHB
         d28Z0q0+vvxP1yuzZh2Mpu1vLJjPIW6wvKnBU3zQ9x7gKP8TKV+rlzuCE5CEpBlYlWvz
         qlZaWBuvevusCiy+N9/252Q4L6XBELTn4fnxhVZeioN3NTS+Msa42HnlLZNYo/7pgTy3
         b+9itHncPWIxhBoc7/Tq6vsVLdf5zwTsFJVpFTeD1HXLnJv0432PYPrWGa5FySSVsB7e
         1Vr/wjaKs9Kub+QblyWMuhOz7HtUNN6OcDDbhwyPXoehMxRwS2iumlU7/si6IUOoTggE
         n1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nig2vrbs6zKJ2eRQhqOhxS7/tBVdG0lBX9UTyMM/Vbw=;
        b=rHevbsH6P5wNbMEIg1BhVd0SUFaO51Sy16NMUOJXKpwXL2aWZa6aK5awOBbsoUFCSJ
         jH6PQx2hp6GLNmaLDoNjCsHHfzJrDUCJJW5xQidJEwAlND2ZlLnK9/GA3g++9tXm3fTC
         lzDlBRE3qXsHe+5HinHQsT/ix5mlT9C8PpxJFYBpEVFmHORNHPdk+nalojmTmdMB4d5s
         Ib1lYbzlYPVwpv7VuKsvqpsVEspReS9slv/31qgdzN8+ukz0apKQ9+gpLpvUpQzWm3rV
         hbm1Ccwq7wfcz29O1oc2xRri2IIW2tgQhKjPJeO6K0d82G1l3hTa8N/NV9t5DoPn9iJT
         D7XQ==
X-Gm-Message-State: APjAAAXbW9GkaKU3gt57J+b5J4Ale+YSo5GXfZecWmXgLgaVG6EpqTyD
        xJCe+VnY4C6UchQp5p1yW+VfMu6JasOIao/JRCc=
X-Google-Smtp-Source: APXvYqw1RXeiDN6i534t+tr6wPUEO6ZNp27c9MRVYRdaBWfaoM2sHzX+rGM/p0bsXayR/xc+95hNKe0IHjUpS45YNxw=
X-Received: by 2002:ab0:69d9:: with SMTP id u25mr6071910uaq.8.1551937364152;
 Wed, 06 Mar 2019 21:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20190302094312.13363-1-oded.gabbay@gmail.com> <CAGXu5jLGCfP8Wv58swP_=w6-xNSOvOqZW9WUjSMaJQAXbYHnSQ@mail.gmail.com>
In-Reply-To: <CAGXu5jLGCfP8Wv58swP_=w6-xNSOvOqZW9WUjSMaJQAXbYHnSQ@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 7 Mar 2019 07:42:18 +0200
Message-ID: <CAFCwf10bKhXsmmoQG4FP9FT6jq2dJYrMZOzk424HGbwLCp9MjA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: use %px instead of %p in error print
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 5:46 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Mar 2, 2019 at 1:43 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > When parsing the address of an internal command buffer, the driver prints
> > an error if the buffer's address is not in the range of the device's DRAM
> > or SRAM memory address space.
> >
> > Use %px to print the real address that the user gave the driver and not a
> > hashed value, so the user will get a clue regarding the origin of his
> > error.
> >
> > Note that if the print occurs, the pointer that is printed is a
> > user's virtual address and not some kind of physical address.
>
> Err, which virtual address space is this? If this is mapped into the
> kernel's virtual address space, this should not be %px...
No, it's not mapped to kernel in any way.
It's supposed to be an address in the device's address space.
As this is an error message, it's either a wrong address in the
device's address space, or it's a user-space virtual address.
Oded


>
> -Kees
>
> >
> > Suggested-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> >  drivers/misc/habanalabs/goya/goya.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> > index c4f3ec1e9d8b..238dd57c541b 100644
> > --- a/drivers/misc/habanalabs/goya/goya.c
> > +++ b/drivers/misc/habanalabs/goya/goya.c
> > @@ -4293,7 +4293,7 @@ static int goya_parse_cb_no_ext_quque(struct hl_device *hdev,
> >                         return 0;
> >
> >                 dev_err(hdev->dev,
> > -                       "Internal CB address %p + 0x%x is not in SRAM nor in DRAM\n",
> > +                       "Internal CB address %px + 0x%x is not in SRAM nor in DRAM\n",
> >                         parser->user_cb, parser->user_cb_size);
> >
> >                 return -EFAULT;
> > --
> > 2.18.0
> >
>
>
> --
> Kees Cook
