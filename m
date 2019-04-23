Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD754C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCC1214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bei/Bz11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfDWOND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:13:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46111 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfDWOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:13:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id k18so11861604lfj.13;
        Tue, 23 Apr 2019 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YcKL/V/Lsj3dfCPjoyLCaFyNvA/eBm6FKQwBRxx79w=;
        b=Bei/Bz11G+p4daWEZlXbaIlI0l6LwJWq99Ci+4kjAxIBR7AIUWvSlbfpc+XGseujPX
         8M31G/l9MXJvK7tIQJe6L8F8w9mKzIixdkHkqrecysDJNERyBV7Sr+zR0UQyPYBZ14Un
         pgs+qTH0zJ6TwpCLdJTLgKxCGdVni7t9StTJsn/dmli9xLHPsj0CO/zxSPkFMCNpw2T3
         OToT7GQWG5eHIWhRxtvjUgyrcdB6pOi0Nb6/+XufzhWBkfdGK11JM3brsQeJV9NbrYpo
         jSef+7IhudQSwheCdLK582O61ZOKBONx5EYz1i2DudxirqbEjojfhKoMVmpVw6EnrLVo
         QT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YcKL/V/Lsj3dfCPjoyLCaFyNvA/eBm6FKQwBRxx79w=;
        b=VdiQfRg2bfIaAk+LUlTeoHNngUc2JPyy16W/ud940v83AQK0hterYidohQAkY4nSyO
         2+24DOKEmH4Qbo6JYMzBhdbJT3VduPKh2IA/aJEbmbWl3YKMUWSPN2KJHlJ9GOk+2xPE
         6m3T19TRteeF+sGexf+jDlrxEydyZFSyVp/UZ+gJ41fJ5v50raNRxPaEU1KGu6idUsyl
         JZ3MGz+U0R2d/WsHWcrmfnvRU9llwrvmS2BpIkr78De0AjHZ3P4Ij9TMP+P1idNcXFla
         DPGyr8NqKSy54S+4SdazyzCusMaBHWc6FAMXu+ahvGNAyM4nH2Iz5USrXZh5BaAcaaqE
         iO1A==
X-Gm-Message-State: APjAAAXKA7Zm87PB87HpeoDZ00chAS8ozSEZqcc4W3pZ+G/tNtsyJjXF
        3H40SQ6cXUae04p1z9ac5PxZFrKgEz3/blZxFf8=
X-Google-Smtp-Source: APXvYqwz/ecJZGfljAiXhGLGwNMcxrEWdVeJOltcQgEa/cDfS/+I/EAYVYRqEQZZzGo0hZI/N3roHeWhS4eo1gLTmRw=
X-Received: by 2002:a19:f60f:: with SMTP id x15mr14036494lfe.95.1556028780653;
 Tue, 23 Apr 2019 07:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com> <1556027045-5269-10-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556027045-5269-10-git-send-email-yibin.gong@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 23 Apr 2019 11:12:58 -0300
Message-ID: <CAOMZO5AT2dPJwQefKwFsfp8XqodL4k7bhKcmXQskHbc9aQ6n8A@mail.gmail.com>
Subject: Re: [PATCH v1 09/15] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 10:51 AM Robin Gong <yibin.gong@nxp.com> wrote:
>
> ECSPI issue fixed from i.mx6ul at hardware level, no need
> ERR009165 anymore on those chips such as i.mx8mq. Add i.mx6sx
> from where i.mx6ul source.
>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 1e20470..99c44a5 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -419,6 +419,7 @@ struct sdma_driver_data {
>         int num_events;
>         struct sdma_script_start_addrs  *script_addrs;
>         bool check_ratio;
> +       bool ecspi_fixed;

Please state the erratum number in the variable name, such as
has_err009165_fixed
