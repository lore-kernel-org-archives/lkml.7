Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484B6C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120D02075B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXozv7o6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfE2WJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 18:09:24 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43533 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfE2WJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:09:23 -0400
Received: by mail-oi1-f193.google.com with SMTP id t187so3371740oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 15:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtBd0igQNAxdQAvDkTKzFaKKKxYH7TTNb8Emm7WFbQE=;
        b=PXozv7o68bfCUq0r+Erfvc1dZo7UWlAVyBTOedz9ikaeFw07hwAiM5rs4CIKNt5WHa
         wivuhgusMAxHlziT0bbZDYOYPirYWq6UhwvLmtzzjAEcnJs1YJo0xs6vsrDuOQvdAxqC
         ZR9iVaCMj0ck/tcGikxIn8tQdeUuSrZzZzFngH8l1huBKjx4fSBlDueH3rzzhRCW3XOf
         5UPTqqo/rSz/y1lm1e9veDp9ChVoAE4E2OoZmEsqzrTXF7/Mcmh8hv6AZHATwg4B/oGZ
         ml39zfV1Zhl9BSIV4ppRGjdq9VCRb8iLoQTWgvtg3XSCXL/KtHxC87ITOGZcs2FrhY2D
         VPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtBd0igQNAxdQAvDkTKzFaKKKxYH7TTNb8Emm7WFbQE=;
        b=Fi9UImmcm5dIYn22Ee6KLlDfY+bgB50AeWZP4baA8KRMmArILMpZQLvhPZHzF1ii/G
         jZ8gID1HIfz5n/w6RwH1Yb+WrCUYsW5lDbbm//bXVhoyabcDtc08MUcHaUlIvf4iQuTt
         a4qM5e+8Qd63Zhiq9TngYYdIMeh72xdhJc1kQW/Fi8lgtFj+FLacx2w/RHf08KN9NL7I
         T5TCxD5JqIJH/LCMbifaAMsPS7UWUApgVZymIf0aJMviRSWMRaCOu/HVpwdwaI2M70/g
         B3h9x4CDWUurobWe3DCoOHxsfudBzEFuyGdUz21DMAhbt7z6q7RQ2pPyT0YNgHfYzt2i
         3s2A==
X-Gm-Message-State: APjAAAW7WzMqOd4FoLh7LHdHbjW7x6as2xAz3gkqtL3R5ZvyvJb/72Cq
        Faccp/XMFgx6Qfe4TitVY1JnURP9/N1CtOHo4hooC2+u
X-Google-Smtp-Source: APXvYqwTqdwJ0JoKkftSDj5qIPj+WtB0r5SxluHWi/TiA3Au7JVtxIAOfUmpnc08w/KlBRo4CfJfUS0kItBStcaTtoI=
X-Received: by 2002:a05:6808:642:: with SMTP id z2mr382112oih.83.1559167762998;
 Wed, 29 May 2019 15:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190528043117.169987-1-tgb.kernel@gmail.com> <b52aaaed-5efb-ae1f-68c0-80b150388219@suse.cz>
In-Reply-To: <b52aaaed-5efb-ae1f-68c0-80b150388219@suse.cz>
From:   Trevor Bourget <tgb.kernel@gmail.com>
Date:   Wed, 29 May 2019 15:09:11 -0700
Message-ID: <CAG0f_nYQSn8eFHH3EcV4zxia0C6v7PfCvXybx40em9KgtzMGqQ@mail.gmail.com>
Subject: Re: [PATCH] vt: configurable number of console devices
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I hadn't registered that was uapi. You are right, as a
configuration setting it's an odd thing to expose there.
That define won't really be any use to user space except for type
range validation, and as such it would actually be unhelpful for it to
be other than 63.

I will add if defined(__KERNEL__) to improve that, so that it will be
constant for uapi.

btw The idea is obviously not new. I can give credit to James Cox who
posted an actual patch 15 years ago that never merged.
https://lore.kernel.org/lkml/E1BFhPh-00027s-IL@smtp.gentoo.org/

-- Trevor

On Wed, May 29, 2019 at 4:03 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 28. 05. 19, 6:31, Trevor Bourget wrote:
> > --- a/include/uapi/linux/vt.h
> > +++ b/include/uapi/linux/vt.h
> > @@ -8,9 +8,13 @@
> >   * resizing).
> >   */
> >  #define MIN_NR_CONSOLES 1       /* must be at least 1 */
> > +#ifdef CONFIG_MAX_NR_CONSOLES
> > +#define MAX_NR_CONSOLES CONFIG_MAX_NR_CONSOLES
>
> This is an uapi header. Will the #ifdef work there? As I don't think
> CONFIG_* (i.e. autoconf.h) is available in userspace...
>
> Also, I am not sure if there is any consumer of this macro in userspace
> at all -- so what are the possible effects of this being "incorrect"?
>
> BTW having headers from one kernel and booting another with different
> settings makes this definition also incorrect. The same as for e.g. the
> HZ constant. Again, not sure if this is a problem at all.
>
> thanks,
> --
> js
> suse labs
