Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C957DC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B09121019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEUjAMlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbfEMSCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:02:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35421 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbfEMSCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:02:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id c17so2439465lfi.2;
        Mon, 13 May 2019 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zS+LwfVg2khkqAlhoTFFFjzuYkUPD/9SFICbNmLG588=;
        b=KEUjAMlD5dMDa5GsmmdEz9cu4OvVATgBkCtl8zN7eoWUPbfAm/fbVtk1/9P3YfYxy+
         jspK9o5+/1xMzYH65R6IId2SUlES9m1jbc3Is8zAv6X5+2ZI2Hcd+9N+Yjesu/KY1Pu7
         x0Cvjft8i84sk2dRI2xXG4Nj/p3ktsQgJRdE84jZ+yWhcI0wo7lMgAB3VocCK32DD8Co
         lAFiLIEnEDqJ6IgzxaZNa/UR3lEvwTJu1IsfMGzri9TyuQtLbnadnKb2IRWOchLrN3UA
         LmoykvWsYcDjVG6/v4GFN5ZStsFoXIqaXbF6NRtM57f/PDuzKDeGB4khUPompmbF8t7H
         DqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zS+LwfVg2khkqAlhoTFFFjzuYkUPD/9SFICbNmLG588=;
        b=VjLbAtWWvKerILHuk2+dhMci0+pzZEsQhUV5ggOMmBTtVLpW0lbxjFdBJzM0NB9Not
         B50bDtiKIERFbdwAhgNtl0sjZS0XYHXvV9dTXmLJfwZ5QtJCkygV0jIO3wPe2JrYqf7V
         +9GDpBwH0ICHQ+1bj3lWf8oX5xwycupBF8zpNwfB98i9Bmd+BN/qyfjJDJRqCofO5al8
         +CjOiejLJLKbx3kDKquVhJmpXiYMp0jy/6NZw/jiOM+/N6cnc3pa7j9Zbg7taukyXFBa
         wiFRh/LPnLy5qNmGVMk4GScOU7iXR9gHWvWHLPtU1nshNizQ3OY+NI/G82G4+QA3Suiu
         CrbA==
X-Gm-Message-State: APjAAAVNMaiLLz0HSR/Dap5htsfyOiqG3PD28os3q8cVBBWOVj7iX4wi
        KeuPcwTivpHT03KeniYY3Z8pXbSPdEPgGnAZclU=
X-Google-Smtp-Source: APXvYqxzUj2G1F5MbdNS+8N+ZQleOQ69VpT3QcJdiUuVmAPVlLl9yxOSYTE/aAbCQWlLPSAc4J8eKgxHnKsBGlVG0i4=
X-Received: by 2002:ac2:5621:: with SMTP id b1mr15038258lff.27.1557770521961;
 Mon, 13 May 2019 11:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190513174057.4410-1-angus@akkea.ca> <20190513174057.4410-2-angus@akkea.ca>
In-Reply-To: <20190513174057.4410-2-angus@akkea.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 13 May 2019 15:01:56 -0300
Message-ID: <CAOMZO5BaQnrDOYogzgpmCExjB+uhYQ8SsxBiMWrSB-1KRtgeVQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] MAINTAINERS: add an entry for for arm64 imx devicetrees
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 2:41 PM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> Add an explicit reference to imx* devicetrees
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7707c28628b9..0871a21a5bbb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1648,6 +1648,7 @@ T:        git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
>  F:     arch/arm/boot/dts/ls1021a*
>  F:     arch/arm64/boot/dts/freescale/fsl-*
>  F:     arch/arm64/boot/dts/freescale/qoriq-*
> +F:     arch/arm64/boot/dts/freescale/imx*

No, please put this entry under ARM/FREESCALE IMX / MXC ARM ARCHITECTURE

Thanks
