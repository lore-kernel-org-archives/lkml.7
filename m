Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB41C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8792054F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfHEDfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 23:35:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39781 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfHEDfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 23:35:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so77307013edv.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 20:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqhoil23mCCoSHv8fSgyN9BpiBD51hIbu//YpD4kADg=;
        b=S1bI9qB0fGedlo/Nd86xBi012egUIqk1nHseETNSHt+L90ADgs2kVSlQrDuWimZ2by
         ySVYh6l8nsHF3A7C9VDUDzmXXre4NVbZxrdU4reG747YM0KvErnPnXxBhGNyJPWSBy7w
         oWNG1JoZn7qSSmEMhEb4wP9W6qEHAgaIPAMoGmd+5KTDBYvfjDV+Cy+m2AvZrtctN83t
         orFAmdaG1J8q1f1wj/SC4QtlGZAjWHbRqExa71viXVcByMyIYfGWMifZAVYfRkg0n8Ba
         7F/ct8HcZXTp9Be126afbd6cY8q55nfcanFiOjP18EuxBGCfTI6MrcIKxseDjXX7XV6e
         HnlA==
X-Gm-Message-State: APjAAAWM2ztKIB+DECdOYn54wP0X4WMcI1uLUtZ9ZiDuEpk9rgQEWj0w
        p50bJyp/A3ifRRyCNQOUiKJOA43PAkQ=
X-Google-Smtp-Source: APXvYqzsOa9+Lpu29rJFeqataghFtEubUKFWu/7aXO5Btgj6isNEwmsallDXNU/sx3bpZ04np4QQhw==
X-Received: by 2002:a17:906:a394:: with SMTP id k20mr20417256ejz.46.1564976119087;
        Sun, 04 Aug 2019 20:35:19 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id oh24sm13966324ejb.35.2019.08.04.20.35.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 20:35:18 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id r1so82801330wrl.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 20:35:18 -0700 (PDT)
X-Received: by 2002:adf:c613:: with SMTP id n19mr102352520wrg.109.1564976118031;
 Sun, 04 Aug 2019 20:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-3-swboyd@chromium.org>
In-Reply-To: <20190730181557.90391-3-swboyd@chromium.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 5 Aug 2019 11:35:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v65njFXzLM_BvkDsZEzxEfkp_FFmFrS+1Ww9ZVen3iwy9g@mail.gmail.com>
Message-ID: <CAGb2v65njFXzLM_BvkDsZEzxEfkp_FFmFrS+1Ww9ZVen3iwy9g@mail.gmail.com>
Subject: Re: [PATCH v6 02/57] bus: sunxi-rsb: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 31, 2019 at 2:16 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
>
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
>
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
>
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
>
> While we're here, remove braces on if statements that only have one
> statement (manually).
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Please apply directly to subsystem trees

I didn't follow this series. Is this for -fixes or -next?

Thanks.

>  drivers/bus/sunxi-rsb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index 1b76d9585902..be79d6c6a4e4 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -651,10 +651,8 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
>                 return PTR_ERR(rsb->regs);
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               dev_err(dev, "failed to retrieve irq: %d\n", irq);
> +       if (irq < 0)
>                 return irq;
> -       }
>
>         rsb->clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(rsb->clk)) {
> --
> Sent by a computer through tubes
>
