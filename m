Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEE3C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0492173E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abNCfJ5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfEWA2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:28:05 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34547 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfEWA2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:28:04 -0400
Received: by mail-it1-f194.google.com with SMTP id g23so6839780iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1ZKdXuHqQDX9bAfT1YFTd2QvlxFeCH9fgwUX8yc9KE=;
        b=abNCfJ5VHKIVCXewFBfsLMOhLJw+NeIEx6g1zIy0zQq4pU3pfHm+uAwUrMQ4Y1holN
         4B4S+0LtuU2Y4LIlU1q9v3q1nBMV5/xXP1i6xsv3RFge/01IBQJWGlvLbwyiWqa5dSHM
         82p30p9s+sb4aXo2iOOQh5X6wrkiWfDaqG3W8Npn9xZUWzPErAzeW99rQr0i7uRIBVhi
         mSpoPE61GpleFymru+vgmUbuZZP7CwxW/d/E2ygV1i7oBaTgdupTbYIcOR9NO9TvgdVa
         GdiLatiRnuxXb8dAaseGckhljv/JDFONnL1fN/wcaqbYvjUJsyJKqthrtYQYHE6MgoL7
         qyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1ZKdXuHqQDX9bAfT1YFTd2QvlxFeCH9fgwUX8yc9KE=;
        b=iiQ0LVBJqJAx4netoM2K0ZY0xE63UNJdFsL6SYfGnlKeUpvMF9cAswxTkGevBTyE6K
         iNElZ/X/NQcpQFndS8Rz622NXrPbl+mpU7mcN5XGUODCzN7dwrsk5t+mZEJgRKl+4+RH
         hIWZDPeecWjyl93zI0eFEsPSyf39WzVPJOHGhcdvYeMlqzRjicZa/8rVJwH6QxYlxUzd
         EH2i5PHali7jQ7xWX3eL4NNfwusUqZjA5HiL0zaGWzdKE3bpgqkg2Zsx4s5Obi+9rRyP
         7gcY2iqII56XN72PRx5rw6LsACot2ZsCy/ReXeqeAARDrDej7WDgMpwQ4y+6ztNENCLj
         ESEg==
X-Gm-Message-State: APjAAAXJmINhNA2I2wiZGCHkssKcqum1q2zc4lKAvjMCtuUklS4yaxCV
        LGdEZFbmnmI3oXu7DaKxEYTesf/Lzm3npb9F1J8=
X-Google-Smtp-Source: APXvYqziPV25rCpVRTxdK1Y4p/vM1Z13HbG9u+Sjr7o6eJ5LIyO6+zdwbF3RcHc6GzncGF+K2vLYN2OZ1ltss7e7QDA=
X-Received: by 2002:a02:ccea:: with SMTP id l10mr27164995jaq.111.1558571284154;
 Wed, 22 May 2019 17:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190522071227.31488-1-andrew.smirnov@gmail.com> <20190522071227.31488-2-andrew.smirnov@gmail.com>
In-Reply-To: <20190522071227.31488-2-andrew.smirnov@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Wed, 22 May 2019 17:27:53 -0700
Message-ID: <CAFXsbZrRpOK6SyRzwjNwrE8qnH1uQEO19hiJHxicNZ4pU6c9Bw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: imx6: rdu2: Disable WP for USDHC2 and USDHC3
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> RDU2 production units come with resistor connecting WP pin to
> correpsonding GPIO DNPed for both SD card slots. Drop any WP related
> configuration and mark both slots with "disable-wp".
>
> Reported-by: Chris Healy <cphealy@gmail.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 977d923e35df..5484e4b87975 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -625,7 +625,7 @@
>         pinctrl-0 = <&pinctrl_usdhc2>;


Reviewed-by: Chris Healy <cphealy@gmail.com>
