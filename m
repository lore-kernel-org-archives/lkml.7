Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A2BC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6559B218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4AxvAwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfGYTcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:32:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35613 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfGYTcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:32:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so49175225ljh.2;
        Thu, 25 Jul 2019 12:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kp0EWNt1hJYOLXDTYlF7zykP3Zq2TsBvXEhXEloAP6c=;
        b=C4AxvAwobnSSddWK24zoACbWa2WjxylpFNge6tKlmOW+LLRo+AXD/ZpOa2ItZLWQ0V
         rca8/YgVzcRihbJdusIc8NP6R3JF6C/L5frSIAc/ApkYxB0wzAc/FRwDJCtahPQgb0Hs
         n6AYQKp2AyOCm6dUCMFiWExIrr7KlAr2OSGThds/zl6FzBQwutPcxhg8gmCHra/5nXrQ
         IFypJzMVv81BoUmg/179zDv95k+wq9BmQCIE/v38M6QgpT2vp1mZDuyRiUPuPDsu6wJo
         ThpgtWT10jqE3omLZRtngj0C7o/10Ew8qAXeJP224fMyanvN2BdJ790hY3vFN7KL3lgf
         A13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kp0EWNt1hJYOLXDTYlF7zykP3Zq2TsBvXEhXEloAP6c=;
        b=koKc9XOcM/qE/rJBKkRGiU665hLLAf/2m4JxY+Qr22IMgHnZATzEh2bsWuD7K+aRvP
         qzAx3zOx5ElDLPrfDCUUk7Bz9so2Pd7xMuGNVWCcKUqf+FSRRcZFJ3dc71lIAiXJEgtS
         ASZxGOG/Ldvi3wPGWAhsBXSKm4+M2+pFPTNokPole8o4dkRxibndTpMJOKbi3tLdJnm4
         TGIkOMkDhDjXxMJ7suqKuyAKdned6S4RVl/R0lgih14AIWmRpiIVW+tI+WmAEg49Y2pz
         Nc3V+WrIG4e6My7Aw4h7psslC3U64B0QyqFzKaNk7FQ2iTRqvvtfGAXEe7itjTRF7L+o
         sPWQ==
X-Gm-Message-State: APjAAAVNCyA40QDw9r/LX/hfFJt1B2KDszVt9geKBCYr68gT/SNOq6qf
        CNCZssJHH/cUVtWFkgoTPLDuNnn5Wxwl6z1Px0s=
X-Google-Smtp-Source: APXvYqyDf3rdKYXqiXUlgdRjLq+Vaz3jmCLYtBCYErQSevesbRjPKuJmugaeK1C2zffMG++H1hJFxitGJxEZjTaH6lU=
X-Received: by 2002:a2e:5dc6:: with SMTP id v67mr47345282lje.240.1564083149838;
 Thu, 25 Jul 2019 12:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190712204316.16783-1-TheSven73@gmail.com> <CAGngYiVb_-A4Au749GD6SKi=UqKKBm4yxim8YOCbgVjfz7xtvg@mail.gmail.com>
In-Reply-To: <CAGngYiVb_-A4Au749GD6SKi=UqKKBm4yxim8YOCbgVjfz7xtvg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 25 Jul 2019 16:32:31 -0300
Message-ID: <CAOMZO5CrUZ1C0i8ofuiG8thsPgfxPiY5XOnvUsmnkYYSKJBMNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bus: imx-weim: optionally enable burst clock mode
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Thu, Jul 25, 2019 at 11:30 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> On Fri, Jul 12, 2019 at 4:43 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> >
> > To enable burst clock mode, add the fsl,burst-clk-enable
> > property to the weim bus's devicetree node.
> >
>
> Any feedback on this patch, positive or negative?

Looks good to me:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
