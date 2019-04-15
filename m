Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B07C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E92320848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gd7sR54F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDOJxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:53:00 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36779 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfDOJw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:52:59 -0400
Received: by mail-vk1-f196.google.com with SMTP id w140so3493374vkd.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dE8oThaoQA9m3plqdG3WIPqIKM1d2jkt8oFQ26liqRY=;
        b=gd7sR54FQTjclKZU/Kih/BTRkrELqURoL+6f7b3GXmlcMb+k3ZJzjaypcIV1CMKa8d
         joTk9D6moFNLcrtGW2KMANZGc5kqPrubs9SK71Z/cTDBQhQtl80MFAUIqLZA+jO8hWne
         GDFxnuMJbCFyNewwhVlpnfMBPFs3+mW6S5MOmOp2q+y959RD8gXpWy89oCe16GEGUfrE
         n09vZ2jPFIcjCCJ46qhSiewLhvRK1D5kJ0R7nO7lgqxzcEsX2t+5DqG4wV2N7DUGqKFB
         VgGnlW3myCF4jVIMPZODC6pv54u4USFeLHNUdsa2DrYeSNvdQNo7ehaF2wRX9Sj2QgLW
         EiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dE8oThaoQA9m3plqdG3WIPqIKM1d2jkt8oFQ26liqRY=;
        b=RZZlT4f3DFkgdqQOrEpw68f97b6VMbX/7pk11rXONy93W2zETT90Zi4Kn6ylQAb9NU
         CVzljLwM6Be652ihmdPPv1x5HK/x6dbit0lXV1bIXggiLQuNpxlovv+ua0sQW93PJM3n
         9rNOlcNRQMwlpb307o0U56W6m0hoBHqmzB1ZCmoK3Axs0ql7RFaMZy+1vA58TAu7dPiK
         jYrEgkQjayu8FmL1yeZooZClf0zj/5XnkyPswT0vhhSMQpSN7PXFM9Toy8uYBlsWkEjX
         tPU5b4SuJ1LggGl3OdHOD9s4IaOFV88cXHgQZHxSFEEFmegiCMHipcLAI2YU6M0rf5Tc
         OP+Q==
X-Gm-Message-State: APjAAAUiMBwl7w6sVwLtLlz/m3FStTQmDTv7fUyOnyXvu9xW6ipr8dte
        4MreO9CTAWpgYZ9gI6o6uvPq9dq98N14syhA9LIu3A==
X-Google-Smtp-Source: APXvYqyo8XOegxXlrYzTMUm04C937tM2W61ZtmLW5qJ2m1lxHPqyJKHt4EwZW3Fo+8L8Uy6yynewORwaL263Ml9ODUg=
X-Received: by 2002:a1f:2c8:: with SMTP id 191mr39174140vkc.29.1555321978094;
 Mon, 15 Apr 2019 02:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <1555139666-948-1-git-send-email-hofrat@osadl.org> <1555139666-948-10-git-send-email-hofrat@osadl.org>
In-Reply-To: <1555139666-948-10-git-send-email-hofrat@osadl.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Apr 2019 11:52:20 +0200
Message-ID: <CAPDyKFrdCPJRWEa37fWLMxJHzoSB_W-WrDahfz3AF=SvfCU4GA@mail.gmail.com>
Subject: Re: [PATCH] ARM: ux500: add missing of_node_put()
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2019 at 09:20, Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
>  of_find_compatible_node() returns a pointer with refcount incremented
> so both in the error path as well as after usage in soc_info_populate()
> respectively actually b8500_read_soc_id() an explicit of_node_put is
> needed to release backupram.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit 18a992787896 ("ARM: ux500: move soc_id driver to drivers/soc")

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>
> Problem located with experimental cocinelle script
>
> get_maintainer.pl only returns linux-kernel@vger.kernel.org for
> this file ? Is MAINTAINERS entry missing ?

drivers/soc/ux500 should be added to the ARM/NOMADIK/U300/Ux500
ARCHITECTURES section, which is maintained by Linus Walleij.

If you send a patch, I am sure Linus will ack it.

>
> Not really sure about the referenced fixes commit 18a992787896
> ("ARM: ux500: move soc_id driver to drivers/soc") the commit log notes
> only that the driver is being moved and not expected to change (v4.8)
> but looking at the previous version in v4.7 it does seem that while
> moving the driver there was also a relevant change to the driver code
> including the switch to using of_find_compatible_node().
>
> Patch was compiletested with: u8500_defconfig (implies
> ONFIG_UX500_SOC_ID=y)
>
> Patch is against 4.18-rc3 (localversion-next is next-20180706)
>
>  drivers/soc/ux500/ux500-soc-id.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/ux500/ux500-soc-id.c b/drivers/soc/ux500/ux500-soc-id.c
> index 6c1be74..e22597d 100644
> --- a/drivers/soc/ux500/ux500-soc-id.c
> +++ b/drivers/soc/ux500/ux500-soc-id.c
> @@ -203,10 +203,13 @@ static int __init ux500_soc_device_init(void)
>         ux500_setup_id();
>
>         soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> -       if (!soc_dev_attr)
> +       if (!soc_dev_attr) {
> +               of_node_put(backupram);
>                 return -ENOMEM;
> +       }
>
>         soc_info_populate(soc_dev_attr, backupram);
> +       of_node_put(backupram);
>
>         soc_dev = soc_device_register(soc_dev_attr);
>         if (IS_ERR(soc_dev)) {
> --
> 2.1.4
>
