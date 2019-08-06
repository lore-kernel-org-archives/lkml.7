Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C739C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA3220717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565126827;
	bh=Omab2aaLx1gzMfzJZgEqTd/OAd4bfJxT6vIOj463fSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=V4sKPmkDc1sOt9B0xBJUV7xwFAmvicBNLQRgnkeFrZgQquQqB1FrZ4sWj1lla0R4m
	 vcyFcFJKLjcd3uT19bC0h5gjX6yiLcYIuG8vjfVjbVYp0eb1uFdZ6xeNsoNC0tmbLx
	 1NEA26vXk6Qc07ilCkqlMir9zyqT1ktf7GGxF0F4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfHFV1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfHFV1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:27:06 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EA932075B;
        Tue,  6 Aug 2019 21:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565126825;
        bh=Omab2aaLx1gzMfzJZgEqTd/OAd4bfJxT6vIOj463fSQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cc+DOxbv7t+qm1HL+uMx6x/01ArqanOo9PuQKBfxQO2pLgdn7uPxoNkA9XUuRYsAU
         je8lX1mNVa8LqlhmF+5IukfgIN9lybKnIXRjaBFA4eGiLKF94DmZxTLgSaPXi6fUz4
         ZGdz6JBo6r3zWBuYVS9abYNCBEMySooilSH2UVXg=
Received: by mail-qk1-f178.google.com with SMTP id d15so64121561qkl.4;
        Tue, 06 Aug 2019 14:27:05 -0700 (PDT)
X-Gm-Message-State: APjAAAU7e5ehtgSYP4A3TvMIJHhtnE/tdHflGtWEz2S0auQpDnLS92b9
        VTjcZg8vJOR+PLBNsgoUwRVm1qqgpgAUuaMJAA==
X-Google-Smtp-Source: APXvYqz6MiK/9r6wnlSZQe3SUXiZOJhyEiFYrQoWgGX9vBTELl/dXmEjfCx6Pf8dwVZBOvzBv4MZdozaGg0tpmYHix4=
X-Received: by 2002:a37:6944:: with SMTP id e65mr4894358qkc.119.1565126824392;
 Tue, 06 Aug 2019 14:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190806192654.138605-1-saravanak@google.com> <20190806192654.138605-2-saravanak@google.com>
In-Reply-To: <20190806192654.138605-2-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Aug 2019 15:26:53 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+BwHSj1XUNp_eY362XnNoOqVTNHqAkvnbgece8ZQE3Qw@mail.gmail.com>
Message-ID: <CAL_Jsq+BwHSj1XUNp_eY362XnNoOqVTNHqAkvnbgece8ZQE3Qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] of/platform: Disable generic device linking code for PowerPC
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 1:27 PM Saravana Kannan <saravanak@google.com> wrote:
>
> PowerPC platforms don't use the generic of/platform code to populate the
> devices from DT.

Yes, they do.

> Therefore the generic device linking code is never used
> in PowerPC.  Compile it out to avoid warning about unused functions.

I'd prefer this get disabled on PPC using 'if (IS_ENABLED(CONFIG_PPC))
return' rather than #ifdefs.

>
> If a specific PowerPC platform wants to use this code in the future,
> bringing this back for PowerPC would be trivial. We'll just need to export
> of_link_to_suppliers() and then let the machine specific files do the
> linking as they populate the devices from DT.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index f68de5c4aeff..a2a4e4b79d43 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -506,6 +506,7 @@ int of_platform_default_populate(struct device_node *root,
>  }
>  EXPORT_SYMBOL_GPL(of_platform_default_populate);
>
> +#ifndef CONFIG_PPC
>  static bool of_link_is_valid(struct device_node *con, struct device_node *sup)
>  {
>         of_node_get(sup);
> @@ -683,7 +684,6 @@ static int of_link_to_suppliers(struct device *dev)
>         return __of_link_to_suppliers(dev, dev->of_node);
>  }
>
> -#ifndef CONFIG_PPC
>  static const struct of_device_id reserved_mem_matches[] = {
>         { .compatible = "qcom,rmtfs-mem" },
>         { .compatible = "qcom,cmd-db" },
> --
> 2.22.0.770.g0f2c4a37fd-goog
>
