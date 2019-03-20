Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D126C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F1D2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfCTKqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:46:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36749 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTKqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:46:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id t206so1404752oib.3;
        Wed, 20 Mar 2019 03:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1N0WovuFJcK1Y3w5s7NmQZB+eZFDUE7KETPZdg9U0gA=;
        b=ZJwBuOvsW4a8lfaiVm69K/PKae0H9qgGZLjZpFLkckd/V1R87BhIyY+mKyH5yRld3y
         xr5PJQ2jRjhvtwGl3FjzVsMEMP6+EofEe/Vd8aSo897Uc0BaW6m9C0dK46k7uimLjNhq
         P8R+BzdStgHpV1u2A/SSAk25lbPu0/QnEUafd2rg+A2yOAGjN90SLUW4sc8N2VzfafPQ
         4SKVx1sFqLENBXmvWzwq3b4NUTcv26ear0ww3unL4JDAY2g7kqxPDL7J/EnW4q+xH+OQ
         pxiy/8paZF7NJv0uP7pzXMuOb/Se6uZwmWVT+sMIlUpWgmL3r2hPsT6KNdIjDbUIKVun
         +AIQ==
X-Gm-Message-State: APjAAAVawwxOZ34db9BSBcd7uY5MpYDBY//S223u/4ewpDxwQ6Zk6Trk
        dG17ygUCcfDgEavnWy+QtTD0Rro+x/uTCl2iQsQ=
X-Google-Smtp-Source: APXvYqzQqweK7jcXzAI8LE3xGKHBu6b/9Vqxcgnb3Fb8HTIuCJKUUZg68WQMs4lTyrp+/bVWq9+R/NdBFcaB8Ry718U=
X-Received: by 2002:aca:304e:: with SMTP id w75mr4725561oiw.176.1553078792888;
 Wed, 20 Mar 2019 03:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <1552974845-1590-1-git-send-email-harini.katakam@xilinx.com> <74d29e0e-d55e-e983-add1-361f7c4af948@microchip.com>
In-Reply-To: <74d29e0e-d55e-e983-add1-361f7c4af948@microchip.com>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Wed, 20 Mar 2019 16:16:22 +0530
Message-ID: <CAFcVECKqatju7P7WAR0cLGePkAvDcJ8Sb-KKxvjpvtNuEtWSWw@mail.gmail.com>
Subject: Re: [RFC PATCH] net: macb: Add null check for PCLK and HCLK
To:     Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Tue, Mar 19, 2019 at 9:51 PM <Claudiu.Beznea@microchip.com> wrote:
>
>
>
> On 19.03.2019 07:54, Harini Katakam wrote:
<snip>
> > -     if (IS_ERR(*pclk)) {
> > +     if (IS_ERR(*pclk) || (*pclk == NULL)) {
>
> You can use IS_ERR_OR_NULL() macro.
>
Yes will fix, thanks.
Also the error code from this function will end up being 0 below
even if pointer is NULL. Will fix that.

Regards,
Harini

> >               err = PTR_ERR(*pclk);
> >               dev_err(&pdev->dev, "failed to get macb_clk (%u)\n", err);
> >               return err;
> >       }
