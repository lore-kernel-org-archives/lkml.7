Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC59C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E0B2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvCXwtyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfLAQzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 11:55:09 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37741 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfLAQzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 11:55:09 -0500
Received: by mail-vk1-f193.google.com with SMTP id l5so8483098vkb.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=viArvFx6bwriRqbVKzxWIMI2mYJJQWXa9W1jvneUNgg=;
        b=KvCXwtyApb1BFJ+f/GXpVJfqasT3tb0yp/VkqEXhiUxH89753Jw6IPwdTv6PG9wlsj
         eF6zhDU4T3XmtolPVITQgiP7Q7oVvGe8cSzDaF1zFoEjGeuHhJ0Giy0J+ftlrV7Y2ffy
         ePgzwoytEibf7jIdudIHiXTOPoM/CDs7SQTE6ZeRbSq+/8bu9PkYgIVENh+gi1skwsgB
         WZrTxzx3xSDIUFHcclFwWwhLbfTdBR2TSP9r0/0TTE45YZPRzObu8tVFZMKkVZqy3Eyr
         LEIFq4U1RE2g3TztrqRcapa8Vz/0TpI7dR3DbFHC6DigqLnEdSJD9JdmkHDoWgiOO8qL
         VH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=viArvFx6bwriRqbVKzxWIMI2mYJJQWXa9W1jvneUNgg=;
        b=brfngedN8gJRTr17+ZUxXhxW1KR6h1OXGUTSGo5dDS9TmKPoCtFdUSpbP1f3cv0GP3
         VL4HXLjzYFiN1i62ylvHA4QakmT308q8CQPfevDWyalGUSGQ6oThIuEQueYv+XqdgF9K
         7qWiUBAZB4t+/u4iYmERlrTpszIc8+hth57oQdH9nlo2F5R51HmTJ0flWflSZm4RPjmE
         FQA6IzKZXZuvzgpU91GitT0F10IsMcNdmJj7DDcOLA9e20XK2AWsX6GbROK+UfGeQmep
         8HRZA/PTilrjdAvXis2X/Z98IM/yo12se+R8XNn/gw46cgZK2IttNXi8dBEd1JQ7jFEB
         ePvw==
X-Gm-Message-State: APjAAAXgjnXDwB54cK2EydlQCMS5lo65yd6vlxfY583ZmqTVhwxcveKP
        962xAU0iQy/xz4URafNsqq/y1dL0wauFIL4rXA9XVA==
X-Google-Smtp-Source: APXvYqxQKtkUk1bCB9U2E9yGqBp+kvryIfipQmxAxRtvyRcLSfilQRKWzVod6eoX+fvNXBWy1t14R9zzUwiHNOj+kqo=
X-Received: by 2002:a1f:c1c4:: with SMTP id r187mr14072991vkf.73.1575219306734;
 Sun, 01 Dec 2019 08:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20191201161542.69535-1-dwlsalmeida@gmail.com> <20191201161542.69535-5-dwlsalmeida@gmail.com>
 <CAFzckaFfmVYV_baqV9bHrnguXfOKs42DJ2VgA4C1y2Ey-+99xQ@mail.gmail.com> <CAFzckaGYZUac5JkwXtcdbZHtUgQyv_7oiHivi32ggYLR=9oT_w@mail.gmail.com>
In-Reply-To: <CAFzckaGYZUac5JkwXtcdbZHtUgQyv_7oiHivi32ggYLR=9oT_w@mail.gmail.com>
From:   Amit Choudhary <amitchoudhary2305@gmail.com>
Date:   Sun, 1 Dec 2019 22:24:30 +0530
Message-ID: <CAFzckaHALf8zEEWryTLq4Y5TfbfW_8Kh3_X=L-Jk1fEtCE7y1g@mail.gmail.com>
Subject: Re: [PATCH 4/6] media: dvb_dummy_fe: Fix long lines
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow reply got messed up.

On Sun, Dec 1, 2019 at 10:22 PM Amit Choudhary
<amitchoudhary2305@gmail.com> wrote:
>
> +static int dvb_dummy_fe_read_signal_strength(struct dvb_frontend *fe,
> >
> > +                                            u16 *strength)
>
>
> In my opinion, the arguments on new line should be just below the
> start of arguments on top line. Like this:
> +static int dvb_dummy_fe_read_signal_strength(struct dvb_frontend *fe,
> +
> u16 *strength)
>
>
>
> > +               .caps = FE_CAN_FEC_1_2 |
> > +                       FE_CAN_FEC_2_3 |
>
>
> Similarly, here too and other places too:
> +               .caps = FE_CAN_FEC_1_2 |
> +                           FE_CAN_FEC_2_3 |
>
> Regards,
> Amit
