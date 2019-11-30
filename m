Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D9BC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FD22084D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPNc87T/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfK3WZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:25:19 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43440 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfK3WZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 17:25:18 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so12458650ljm.10;
        Sat, 30 Nov 2019 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZLHndLy8wicZRQ8gUFmArG9klydMdpl0N2wfSSNkifI=;
        b=pPNc87T/eg772s4w4CQ6sQaiOlN4v6fqemZr2tF99Xi5ajTigA9GFKGKmxPwo3+vay
         ck0rnzF2b3gOq9ZeuKOZyCnrTSUqrxq3MyxthN6f0wBhcbCr+vwbVsuY8WQIqkbhul2a
         WYm48k+Z7jcM+j+CsP/CPx+Ag1CxGfRBLU7g1PuCSexVqsHbqutElazUGJZqodWj96pz
         ZwY27aZwdBcxI7jHvc8e8btd7tYjvCoaIiq61uko8UWCrmbpSsu6XLsFvogh+byPR+/B
         pGgFWkZyWtuguvY5AaQmkESVl5tX2rLskekG7pUXWhcVk56p/BkZefMdQkoFSQi3WXvL
         shjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLHndLy8wicZRQ8gUFmArG9klydMdpl0N2wfSSNkifI=;
        b=XsQbq56evCdwiEYYAtMLJNqR+W8uso1JpXURbsoB3oL0GmGokuaNBInLYNVciGZ+GU
         u4Ce0A3cYQItO02j9OsVU0+W0WaFjq/g85Km9dTvxSrNzkC6b4ngBvkZUgxdlAcFHXZm
         fBsa0dvhAQ52t2xL8f6l2ojb2HEYU0o8cAeLiU82+ZzEOpHe7U85Pn5+xIFkpyrdeYLC
         gkIuax4dVUPdDupeedhb3U2DJcccRDDe2WMyl5Z/83LRDLrs/Ij5I0x2CJPqeKuK5t7j
         mnUvlOKZ6Zq7X+LOkimWdTlsA+r+etBYbUzsGMvcnx9iUT7VARI7E8fJuc/upQkdgTku
         Z95g==
X-Gm-Message-State: APjAAAVlmThi4upsr2wGrfyr+W6R24FoyFsAzMlpnh6VKTW8OMNcskir
        bbCpuBaQkDuvpIg5aJVOZAiKLgG7DcasLoRo0r/UdyaX
X-Google-Smtp-Source: APXvYqw/vYVdKA0yQ23MEFQIuSuq0NyhafkG56sLhiNAnO62bt8QuHvZWQmIrvBfMTlVNGvFENOY82wRB8C1TAvf03s=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr28323396ljh.17.1575152716281;
 Sat, 30 Nov 2019 14:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20191129234108.12732-1-aford173@gmail.com> <20191129234108.12732-2-aford173@gmail.com>
In-Reply-To: <20191129234108.12732-2-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 30 Nov 2019 19:25:31 -0300
Message-ID: <CAOMZO5AyLBrsxr5rqkWgf44X0CQdqHcdaCLRaWLC25b18bF+xw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: Add GPC Support
To:     Adam Ford <aford173@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Fri, Nov 29, 2019 at 8:41 PM Adam Ford <aford173@gmail.com> wrote:

> +
> +                       gpc: gpc@303a0000 {
> +                               compatible = "fsl,imx8mm-gpc";

You could do like this instead:

compatible = "fsl,imx8mm-gpc", "fsl,imx8mq-gpc";

and then you don't need patch 1/2.

Also, "fsl,imx8mm-gpc" needs to be documented.
