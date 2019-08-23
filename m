Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A804CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721672089E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oghd8agl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfHWJT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:19:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46931 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfHWJTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:19:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id f9so8165972ljc.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+DA0AUrj8c0E7gzH9vsBYpt4Fmk9x7nsKTREy+4/ks=;
        b=Oghd8aglYHCh34au85+ry4tne+dtAEjBaom3pk8M+iAp54CYFO2abPgeB4U6gGQoFb
         GXq2rlRHqXupg0sssYrOWFmgHV9pZ628O7CVXoWMqtoJKF7y0c6OkAuaRAgGvID/hnie
         td1TOWlzu+vzgStPw7oHVBR3qrwozDq5AsQ2MV+x3hnNyLk8QwM/uhNh7csdnxs08q7p
         3kdx4TnXYbqkwxufvlLaPfqmh9AKDixX8dG2TXzvdy8JIjs2TM+R1WR7/mPoWU/keGPm
         P7VjGhBYL48nDEqaCWPhMu3j3+gyLaSTLX6iA4uhDaNzla+LKn/3WZjKESEYDKj2WXXz
         Z55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+DA0AUrj8c0E7gzH9vsBYpt4Fmk9x7nsKTREy+4/ks=;
        b=VKOuJfSEvotdSQbFTZjqAP641I8/3/SUcl/e3C87E4N8EcbTsnBBSKYWK5BwTOr4Zs
         EddUv+aG3HqzAAqMbOeuMhhil8drs1Mc+DnE8HEfW2G6JLOv/VYZBuxLKzicAKulRO0s
         L/pB6V3B+ezIdqt6x7EWyLNDvHZofj14vJ3kWTQ+U201vAKzvfEezw7PTYmXGE1CR2pg
         SkAlkUdsK0TXGbkK20Oz9NtiJheMLdmR9bd4o1NuhNT34CjlbMdLP/zNK89vK/ehobD4
         ls8yGmFXgxh7xHun59wgZqO4vKyazH60AFo0D8kgWhqelqdot4IIq7mWKHJkGd1CQrjr
         FwLg==
X-Gm-Message-State: APjAAAVWxfHOCzj37TxLOcYr+BdtDp9CNc+/RrFsszVf2rpUqH8dy+2t
        DIxKh43X3nA4ronVaETNsVgVZE0cbiXcTpqP/ho4GQ==
X-Google-Smtp-Source: APXvYqwK+gepCG0Ez2tTpjT/vmPLIiIHDlmYRRbhEPz9u24BZVmHTm4kFBeT7fwouJFEuhCJDdriYDbZdllA7ru0lvE=
X-Received: by 2002:a2e:b174:: with SMTP id a20mr2366638ljm.108.1566551993585;
 Fri, 23 Aug 2019 02:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190820145834.7301-1-dinguyen@kernel.org> <20190820145834.7301-2-dinguyen@kernel.org>
In-Reply-To: <20190820145834.7301-2-dinguyen@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 11:19:42 +0200
Message-ID: <CACRpkdasbXuqUkO3NjMGBU_ePEBT23BS1eP-bigB0_g494LgvQ@mail.gmail.com>
Subject: Re: [RESEND PATCHv4 1/1] drivers/amba: add reset control to amba bus probe
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 4:58 PM Dinh Nguyen <dinguyen@kernel.org> wrote:

> @@ -401,6 +402,26 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>         ret = amba_get_enable_pclk(dev);
>         if (ret == 0) {
>                 u32 pid, cid;
> +               int count;
> +               struct reset_control *rstc;
> +
> +               /*
> +                * Find reset control(s) of the amba bus and de-assert them.
> +                */
> +               count = reset_control_get_count(&dev->dev);
> +               while (count > 0) {
> +                       rstc = of_reset_control_get_shared_by_index(dev->dev.of_node, count - 1);
> +                       if (IS_ERR(rstc)) {
> +                               if (PTR_ERR(rstc) == -EPROBE_DEFER)
> +                                       ret = -EPROBE_DEFER;
> +                               else
> +                                       dev_err(&dev->dev, "Can't get amba reset!\n");
> +                               break;
> +                       }
> +                       reset_control_deassert(rstc);
> +                       reset_control_put(rstc);
> +                       count--;
> +               }

I'm not normally a footprint person, but the looks of the stubs in
<linux/reset.h> makes me suspicious whether this will have zero impact
in size on platforms without reset controllers.

Can you just ls -al on the kernel without CONFIG_RESET_CONTROLLER
before and after this patch and ascertain that it has zero footprint effect?

If it doesn't I'd sure like to break this into its own function and
stick a if (!IS_ENABLED(CONFIG_RESET_CONTROLLER)) return 0;
in there to make sure the compiler drops it.

Also it'd be nice to get Philipp's ACK on the semantics, though they
look correct to me.

Yours,
Linus Walleij
