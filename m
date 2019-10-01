Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A712ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2061D2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u84I+mXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbfJAOns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:43:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43597 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfJAOns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:43:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so5580388plj.10;
        Tue, 01 Oct 2019 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AsHga82PnWYuVbnSetVb5rvuKk++G/LVwUkiOc7x9Ko=;
        b=u84I+mXDUJNJFNmk1TIPJpwMe7vN1r5I61l9e4kS996mXSBVvAuTWlEzBK/8qvyez2
         o3zPX2LGAE8vVW8Vyt7Wbqp2pNN4qGaOcvpDb/MtNRJRsVJd5DMUzjKjrQPOOlmZ0uni
         FLEy5W4d2iDmJ7dv/dPUC61fF+mW7wnaAHxNp7mr+DibWs7A1bikf4IsScDZ7U4fZeu2
         kybIhIaqo0xRWsRZaL/16ngUyXtdtanhI0H6aWOW28zzOWDhBckogSEXNX52+2sYmjjw
         aO+s59Inqpo7a6NJyDkVOtoOqqGYyAW/TB1GaIg9iuY+xG8m7Nocx84vk0l9JLZhUrM3
         RoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AsHga82PnWYuVbnSetVb5rvuKk++G/LVwUkiOc7x9Ko=;
        b=cr3W/MFg+NRoeWjLT3QwmCLzNNw3k6DZNeWxBxn3tV2QWT5h3Sd55TCpnixJmOTfKX
         cuEft1EM+5KSR102MZ0sXanaPlTwXPzwjGg3+1VYp283DIOmv1VelI16Kt+hKpHXhFM0
         h0IOY/w+Tq70W6Z3jiGL1XmdtgdKra6EAi4J+yFDA7tdjVUJj4actwWIP9VOi4qAoz07
         tmqPACo6pBuxq2WCvokZwkRS0cXUOLZmfyCUXNm2EhEdx8xhUW/WDWR9G1bbSZcNXOgV
         qZGRmaWMhZ/HS1T7M8wg5V/m2821HwgpVAhQDNhKj1bcJopZO/fJVutV1ARGownpxCuP
         6fcQ==
X-Gm-Message-State: APjAAAV7CM+Kh+Bkmnjuq33RfCeFvYP8WCSLYttf/klKAHr7ByEh705r
        Af+dH6YqPRhWuge/4YJlczLjwgLO9bUk8gmM5Dfz6M8PMqw=
X-Google-Smtp-Source: APXvYqyPCMmwTRrHGAD9Lp2vjSW0FnYKiS52oGLD8FlRCTw7lARfeHu5z0O4GLYxoQv2HdeeCWFHszlszUhDMDRyCQQ=
X-Received: by 2002:a17:902:bc48:: with SMTP id t8mr26083624plz.255.1569941026756;
 Tue, 01 Oct 2019 07:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191002003004.16e51eec@canb.auug.org.au>
In-Reply-To: <20191002003004.16e51eec@canb.auug.org.au>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Oct 2019 17:43:35 +0300
Message-ID: <CAHp75VcoTBLjad_8ZMObd0HhaqA_UATQHbBghSJJn2wK5yA9Dg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl-intel-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 5:32 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> In commit
>
>   d21556b6ff04 ("pinctrl: intel: Allocate IRQ chip dynamic")
>
> Fixes tag
>
>   Fixes: ee1a6ca43dba ("Add Intel Broxton pin controller support")
>
> has these problem(s):
>
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format='Fixes: %h ("%s")'

Thank you for pointing this out.
Nevertheless I have a question. Does prefix carry crucial information
for the commits which are already in the kernel? Can't we simple use
substring (or let's say most meaningful part of the commit subject)
instead?

-- 
With Best Regards,
Andy Shevchenko
