Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828C1C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555F7208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="CtuzE3Xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfFTI3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:29:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33932 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTI3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:29:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so2413951qtu.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 01:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+LDECNzk7Ax81lY+NTXinI2CggAW7FJancdnXbish8=;
        b=CtuzE3XrAV1rVmsdqj11M6pmKHISAnlRUomi1TlE3HzkVaVNorKLX2wW/stFBg1Bv6
         DyIHp3jITT2jE0rKVoCLPQ360+74LzXT6mmKu2+NrX5JQsoKH9lgwciuIWycQoNxySYe
         E/CSxBpptpTlZ//LZbwz0Wkz4IVdBnFrG+bkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+LDECNzk7Ax81lY+NTXinI2CggAW7FJancdnXbish8=;
        b=Q2Vvdg/l/bzMj7brRfaDSY7kUF5iAJpL8ugM2yuW8Fwlzmss6MoMN0San7eM4qWBPx
         5ik1FfVClBGIVwnt5JMImnH0yadwAl1kPUsYrpgsjjq6URf3gJKq5ERU1wczjh+jq+lT
         1OwlEV8yNkl/JnUVHqg7yndAWQ5Pat4lELf5Z+ou8bgt+aGSw01XHpLI9HIIvr9Xrrp/
         1id9EVdpLcqWiyT8ZMVbkSpxGGu0aJGAi07RNf8Sfg32f4cSfVzgM/Nv/oLfkfU4YOUO
         UU38g5SgO5XhnRpC9oaqFJXZOwEd1Zo4krYAursrNe9dtiJJHRjfSkXBRxAU/jAmXLxa
         jBjQ==
X-Gm-Message-State: APjAAAXP7dD6dUSreXieFW/Y0VA89yCpi4cUUb2hLsnyEFE29sZbCpGQ
        +c/a/9aEpXaf/IDw9O0swuWrxngtHu+9owOWDROmpCjU7lM=
X-Google-Smtp-Source: APXvYqz9ktCSXKcc8gJFwqeG+AN29q9x2gYJJMH1Lf+t9yZGIz77JKqmMdeqFF/zzNE+Y8nQBNbxTH4cVcRoubKl5l0=
X-Received: by 2002:a0c:afd5:: with SMTP id t21mr38274708qvc.105.1561019389077;
 Thu, 20 Jun 2019 01:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190619125636.1109665-1-arnd@arndb.de>
In-Reply-To: <20190619125636.1109665-1-arnd@arndb.de>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 20 Jun 2019 08:29:36 +0000
Message-ID: <CACPK8Xe0Ppr8QjPSTPyNSHEbSXvuZLjC04hqP6ATTSystY888w@mail.gmail.com>
Subject: Re: [PATCH] soc: aspeed: fix probe error handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Patrick Venture <venture@google.com>,
        Vijay Khemka <vijaykhemka@fb.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 at 12:56, Arnd Bergmann <arnd@arndb.de> wrote:
>
> gcc warns that a mising "flash" phandle node leads to undefined
> behavior later:
>
> drivers/soc/aspeed/aspeed-lpc-ctrl.c: In function 'aspeed_lpc_ctrl_probe':
> drivers/soc/aspeed/aspeed-lpc-ctrl.c:201:18: error: '*((void *)&resm+8)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>
> The device cannot work without this node, so just error out here.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd. This looks like it applies on top of Vijay's recent patch?

The intent of that change was to make the driver usable for systems
that do not want to depend on the flash phandle. I think the fix we
want looks like this:

--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -224,10 +224,11 @@ static int aspeed_lpc_ctrl_probe(struct
platform_device *pdev)
                        dev_err(dev, "Couldn't address to resource for
flash\n");
                        return rc;
                }
+
+               lpc_ctrl->pnor_size = resource_size(&resm);
+               lpc_ctrl->pnor_base = resm.start;
        }

-       lpc_ctrl->pnor_size = resource_size(&resm);
-       lpc_ctrl->pnor_base = resm.start;


Vijay, do you agree?

Cheers,

Joel

> ---
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> index 239520bb207e..81109d22af6a 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> @@ -212,6 +212,7 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>         node = of_parse_phandle(dev->of_node, "flash", 0);
>         if (!node) {
>                 dev_dbg(dev, "Didn't find host pnor flash node\n");
> +               return -ENXIO;
>         } else {
>                 rc = of_address_to_resource(node, 1, &resm);
>                 of_node_put(node);
> --
> 2.20.0
>
