Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9403C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9356205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBubT+aS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEFIuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:50:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41633 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfEFIuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:50:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so2423061pgp.8;
        Mon, 06 May 2019 01:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5UrX+OKB1Qk90azGE0Sbmu/dZQhz6aRGSvU+CcR6II=;
        b=JBubT+aStrvOdmYGy3+U/RHPuwrfslnYHztfCXODd/806YqBZY47ajlr8a3NJz9DbF
         YUXnp/Ik8eg6Gz0XWbzByOEXfoikxDFcfqEYrQU4bUH3aQhlaUD4O9H17Pl+KdxR/zZS
         Htwqb4xMYF6lVuftPbXfloSULGPfMzXgvSA/oXNY5AHSEF6kwozNj0Ev9MGljvD5lYER
         uUYpC2cWgyNQ9aaPQSwX1tVQjl/uN8TQ5Px237Er/Tn8POiNo5rDGkUWKWm1sUGY91vv
         Y645Ziu242QSgr/cN2bgr7eShoRi7e9j13BfgesPzBPFEYFACSl2Kn/IvwWLWqHpWvJq
         7edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5UrX+OKB1Qk90azGE0Sbmu/dZQhz6aRGSvU+CcR6II=;
        b=hIXWNs6bkwqeKPOUBrLTwDOK+H1eoswd2WMOF7QYxiX9z6TkQpSpciVaFwBqFRJKvW
         DLmAkZc6mqoTF0ikY+RAGECTX68agar2sU+bPRPOknIP8GLPDnBByHrbEJu9KDpX4EJ9
         D3JP8MqfrdotRxTS7oCibwn/W4oGsriRlJ0/XEPaUbggdDcp8vOVLs77uGCySl5rjljj
         VL9VC35XXRG+7F7no8Lqu5Wnew4PhUDRqdrw6a8Lc+1LIflxDiToBBKjZNS8tRLwCSJN
         XIONKqLsTzBjyJDM5ojTWJPIrXJtRwOa9YX6whVTstpcj1a+XfumuN2/3wANsD0BoX/W
         qj4A==
X-Gm-Message-State: APjAAAWfyKBPFr0Wgn8PCAS5n9zS0G49Hc5hk4GXc6BdUYrf9+nkXLzF
        saERQYB/cGx58w56U66mv5NlNzSWg7OVc9Wh+J4=
X-Google-Smtp-Source: APXvYqwk4wRA4+aEmV822/Cbz6TpwqrbFU6onaXz2mR5pnZhdArGowee1G1v/w1vdUrQ3WrK3YRO9NKQZVPJ+1OerEE=
X-Received: by 2002:a62:30c2:: with SMTP id w185mr32048057pfw.175.1557132599170;
 Mon, 06 May 2019 01:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190415125204.7386-1-colin.king@canonical.com> <520f6626-246b-005f-53ef-df2f75a89cd9@codeaurora.org>
In-Reply-To: <520f6626-246b-005f-53ef-df2f75a89cd9@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 May 2019 11:49:48 +0300
Message-ID: <CAHp75VcXGyEGYXrswuLHecpvqqR1dfi94Nhu3dhhkex9OVJCfw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: fix spelling mistake
 "capabilites" -> "capabilities"
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Colin King <colin.king@canonical.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 9:58 AM Mukesh Ojha <mojha@codeaurora.org> wrote:
>
>
> On 4/15/2019 6:22 PM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a spelling mistake in a module parameter description. Fix it.
> >

Pushed to my review and testing queue, thanks!

> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>
> Cheers,
> -Mukesh
>
> > ---
> >   drivers/platform/x86/thinkpad_acpi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > index 57d9ae9d8e56..9192b686e9a6 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -10269,7 +10269,7 @@ MODULE_PARM_DESC(volume_mode,
> >
> >   module_param_named(volume_capabilities, volume_capabilities, uint, 0444);
> >   MODULE_PARM_DESC(volume_capabilities,
> > -              "Selects the mixer capabilites: 0=auto, 1=volume and mute, 2=mute only");
> > +              "Selects the mixer capabilities: 0=auto, 1=volume and mute, 2=mute only");
> >
> >   module_param_named(volume_control, volume_control_allowed, bool, 0444);
> >   MODULE_PARM_DESC(volume_control,



-- 
With Best Regards,
Andy Shevchenko
