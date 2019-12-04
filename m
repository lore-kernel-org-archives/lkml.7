Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B97C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1213020661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575484398;
	bh=br61MmbqNzyL0zQQ9ZbnyNvUPNjXO7jzCtUUCCg/cZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MdYAhQJCeSaUSwaQTYdOFYTOLohl/LyXRXG7Cn6i+O6Ow2xMWn/Bl0MWu1Xm9xazU
	 bgExan2QWHULx+p1QZk1MAUYY6FdpwBSTZwDUIpvWf3M7Trro73ZULI6Z/ns+PZQmc
	 +SMC0x+aoovf1kJdXeQAeKc22+GbKgLIQgo1Lsgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfLDSdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:33:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46854 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbfLDSdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:33:16 -0500
Received: by mail-lf1-f66.google.com with SMTP id a17so317272lfi.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 10:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FPiBy3e3zUg0m4K/nRiHT6Vw6UdUbtEDAqlj3R5valo=;
        b=Djtns5IVsjsKkjqXlXecLgmq7TLzrMkrPSgPEVr/ZvwmJI4iaDca3o5iA6ZgsfgxEU
         Hpfx40UcKXq7pbBcMond4TGqgXSpVLfIVObpgFXwaKdlBXgs60PfyOM2EclUBrVxZy+I
         VKVVd/1vx0Caofr6kXg8TOm9f33WEMkE4r42w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FPiBy3e3zUg0m4K/nRiHT6Vw6UdUbtEDAqlj3R5valo=;
        b=OFPe8nXhcY+p0Blgwy3zwS86/eWT7mY3ThgRfz9PmsbS72Up8bxiENX/TrLMmBA3GX
         qg8I7RR8yLRreBKbaAlYVejLS1YDBXHl+Ci1L+34Uj2I4JZQUX3TiIiH4va7ZL6uuHGJ
         7+vO7Hi0TQ1NKfjrR2yAJ3piKA2onMU1E3vvkpmwxBopaPjgHTVby1f4y6lwgu3133QF
         SUnPYy0XYcFl6lkpkuEBCPDRk8pts0oFuy1JLG5itfwO0VWur+J9ZO6Yb/5Vy4OpEcTJ
         bBryKHgKJisbnvYRmtNT/AeI0W5hlVi6uygeDFDA+xOmlcGj85pS88vgIX7KcGqHMW8I
         R6HQ==
X-Gm-Message-State: APjAAAXyKk2f6As8pUkh/PCKrA+V6KijuyS4yKFjZPuCdslzJxlh6miN
        IaqMFLrMbdnwv/Wa61aSEqvD7vuJMB8=
X-Google-Smtp-Source: APXvYqxouT5tmRrnaUixeMIu03inSa3eCDamlFpbmmTVOVZCiKy5cS2Gxwa0L/2qVTEF2x5pe0phZw==
X-Received: by 2002:ac2:5ec3:: with SMTP id d3mr2946745lfq.176.1575484394290;
        Wed, 04 Dec 2019 10:33:14 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id f7sm3589090ljp.62.2019.12.04.10.33.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 10:33:13 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id a17so317210lfi.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 10:33:13 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr2926109lfk.52.1575484392762;
 Wed, 04 Dec 2019 10:33:12 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a33oETbN-60VjpNNeuW1U1Wzb4juVzdiw1ESdses6m3bw@mail.gmail.com>
 <20191204140812.2761761-1-arnd@arndb.de>
In-Reply-To: <20191204140812.2761761-1-arnd@arndb.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Dec 2019 10:32:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjBbi2xJZw+7Wqtt3W_mOUSPU2N4w-OES9WUUyXt-DnCg@mail.gmail.com>
Message-ID: <CAHk-=wjBbi2xJZw+7Wqtt3W_mOUSPU2N4w-OES9WUUyXt-DnCg@mail.gmail.com>
Subject: Re: [PATCH] scsi: sg: fix v3 compat read/write interface
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Gilbert <dgilbert@interlog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 6:08 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> To address both of these, move the definition of compat_sg_io_hdr
> into a scsi/sg.h to make it visible to sg.c and rewrite the logic
> for reading req_pack_id as well as the size check to a simpler
> version that gets the expected results.

I think the patch is a good thing, except for this part:

> @@ -575,6 +561,14 @@ sg_new_read(Sg_fd * sfp, char __user *buf, size_t count, Sg_request * srp)
>         int err = 0, err2;
>         int len;
>
> +#ifdef CONFIG_COMPAT
> +       if (in_compat_syscall()) {
> +               if (count < sizeof(struct compat_sg_io_hdr)) {
> +                       err = -EINVAL;
> +                       goto err_out;
> +               }
> +       } else
> +#endif
>         if (count < SZ_SG_IO_HDR) {
>                 err = -EINVAL;
>                 goto err_out;

Yes, yes, I know we do things like that in some other places too, but
I really detest this kind of ifdeffery.

That

         } else
  #endif
         if (count < SZ_SG_IO_HDR) {

is just evil. Please don't add things like this where the #ifdef
section has subtle semantic continuations outside of it. If somebody
adds a statement in between there, it now acts completely wrong.

I think you can remove the #ifdef entirely. If CONFIG_COMPAT isn't
set, I think in_compat_syscall() just turns to 0, and the code gets
optimized away.

Hmm?

               Linus
