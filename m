Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D322BC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E55921901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKteIHvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbfGYOa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:30:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43201 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfGYOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:30:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id w79so37828422oif.10;
        Thu, 25 Jul 2019 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHJuI0wfvLr45CJw/k6BParVKLuhWxWvzs6WoKiu60g=;
        b=NKteIHvNZvctxJ61hGchvTbcOO2iicgFxCeETIGC78Gt9DZ4G+UeyNfAmQjFvlaTtc
         ClUT0btd2oT9sGhYe6mql72tZYnzXwOcOzO0d8X7nf+c1aTE3/expGEGovRbPVfCFEDd
         DBBOYo/WpMnrov5HRjPXZN7DwHQuGlg6MCaA51vbG0vGFBSj9FXbMnLXLIQ/txUgrKle
         UUNkgKuUQDEqB9jiQNLnCz9XR3JLjPhGGeBHEYhBszrmSbzV3fpQmkoh2Lb+f5CLw8Z/
         56zvYIXUf5X6YofoUl2sQkyrkeZhJFtMUgLgrKyvh/hnQBzMxg8iWqCzoBYfVY8toY5R
         8ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHJuI0wfvLr45CJw/k6BParVKLuhWxWvzs6WoKiu60g=;
        b=m11S31jn9jvVKuq/r6sqHukCM2QjXySmnms2iqoLQpr61MG1MwleRI4ORCK/Ak6gXh
         ivgHnUuIythEfyZH5WLbt7qM31xeMqrOrFvgGGLTcQS//CH5ggi6c6z8JpYShzzyuXjf
         AkJ3JGymF93taLNc0TINkk5/Zoq+Evrp7iYaitUTKs2QPPMHr15CxaSwV5/yE/XqSYz+
         WvRwre8lY5A3DEWtDfEhCFNKih+N4o/L0Xz/2IcEKZYwoOBtwV0uSpImXblSFg/lxrVB
         AAUL1fuCaFP+kG705RaFNaXlueRqC7VuC0vf3ZtnAX6NVfsH0KdAurSQ4hl8Q7GdLa55
         +XXA==
X-Gm-Message-State: APjAAAWPF9xrESznqFR5yjcHulT291z/GZk6OLneeAFQEvdXCB0aIg2k
        gLSTRQz/bbErxTKh3aGjeCXpT5CKl2JxDAxUhGU=
X-Google-Smtp-Source: APXvYqwX23r4z7p2EwocpDavX+sBENQpUDF1tiS32O0SWRa7BbF96aycupZRCgHisT2KjQOuzYQoCmQ+TX2ScLUPPjc=
X-Received: by 2002:aca:bb08:: with SMTP id l8mr7381468oif.92.1564065026058;
 Thu, 25 Jul 2019 07:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190712204316.16783-1-TheSven73@gmail.com>
In-Reply-To: <20190712204316.16783-1-TheSven73@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 25 Jul 2019 10:30:14 -0400
Message-ID: <CAGngYiVb_-A4Au749GD6SKi=UqKKBm4yxim8YOCbgVjfz7xtvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bus: imx-weim: optionally enable burst clock mode
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 4:43 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> To enable burst clock mode, add the fsl,burst-clk-enable
> property to the weim bus's devicetree node.
>

Any feedback on this patch, positive or negative?
