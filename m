Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD79C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A16A2465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ge7vJSYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLTEJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:09:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40675 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfLTEJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:09:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id c17so6572476qkg.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 20:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWH2rtI+yo+f6Uui9r4utAB0db9s0smuFWVbuUxv/60=;
        b=Ge7vJSYdnt7deD6kR9fLEvZNkE16NR9RLAQVmVdh5o+lyvc2n4VcUt3iIWoIebvnaQ
         4qovegTLVPk4Tdp3Bw65X6UM1HludsBNsvoxkk5P6L1rTqJRQ2Z1QHXr2KxV7RjHYpS7
         aIIno4goROur4619EjBV4jXY5IGKj7lq66+NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWH2rtI+yo+f6Uui9r4utAB0db9s0smuFWVbuUxv/60=;
        b=clIuYF/VpRi5LCQ1euQlPDKJAAJ0X6Efdw6fkRF0ViltnWEmAdY1Leh3PdRXBW6P/b
         Hsf7XL+4ZcPfiAHID7ocPzp74JbvRrAkbmONakgX1Kh+4FruKuh5bnJOg7K/IUQ1ykMV
         RBayYOrjtlAd8UYEQgY4Dni/bJIFybJz6nSL32Y+rEtJosF9RB6sJ3kNAVcP+F77lEyW
         FBOqDx7VLANuvfp9E5HeFrCzTQLYm+pQWHgHRKYOuDsszEdclEMvQtRUoA/b8Jy3oNiN
         wIVtyaF/zWtxewuWDkh+byBg1cZomRj9R+ZhHGrX9jXXuWoYWNRntm0Xi1/C257j7NTW
         YpGQ==
X-Gm-Message-State: APjAAAX1F5gjjOi9ZPBoHlH1ntZnFyh0lrEIVwIj7mY4IaOBgm03ibM9
        2HEPVHdNqs7SSI20jGyTzgIwdAj6hK0jWMt/VjLDcQ==
X-Google-Smtp-Source: APXvYqyKlFLkKf97nbSI3FdciNJl4vfBubiJ5SkVtcJcYc3HIVAvB6w/kPk0zMeJU+zuW03LhaGoMPxI3g4/KGpiJKk=
X-Received: by 2002:ae9:e103:: with SMTP id g3mr4794526qkm.353.1576814959140;
 Thu, 19 Dec 2019 20:09:19 -0800 (PST)
MIME-Version: 1.0
References: <1576813564-23927-1-git-send-email-weiyi.lu@mediatek.com> <1576813564-23927-5-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1576813564-23927-5-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 20 Dec 2019 12:09:08 +0800
Message-ID: <CANMq1KBk179u67S0VKHr_Ymh3mcd6yddJKNhvChjW7=QMe0xMQ@mail.gmail.com>
Subject: Re: [PATCH v11 04/10] soc: mediatek: Add multiple step bus protection control
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 11:46 AM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Both MT8183 & MT6765 have more control steps of bus protection
> than previous project. And there add more bus protection registers
> reside at infracfg & smi-common. Also add new APIs for multiple
> step bus protection control with more customized arguments.
> And then use bp_table for bus protection of all compatibles,
> instead of mixing bus_prot_mask and bus_prot_reg_update.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

I think this looks much better, thanks!

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/soc/mediatek/Makefile         |   2 +-
>  drivers/soc/mediatek/mtk-scpsys-ext.c | 101 +++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-scpsys.c     | 117 +++++++++++++++++++++-------------
>  drivers/soc/mediatek/scpsys-ext.h     |  67 +++++++++++++++++++
>  4 files changed, 240 insertions(+), 47 deletions(-)
>  create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
>  create mode 100644 drivers/soc/mediatek/scpsys-ext.h
