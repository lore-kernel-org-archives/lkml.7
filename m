Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E731C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 05:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA6220879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 05:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rmpzcg2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfENF5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 01:57:55 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45450 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfENF5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 01:57:54 -0400
Received: by mail-ua1-f66.google.com with SMTP id n7so5740724uap.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 22:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zx9aUYVTZ/Q7QmtL7E4nK+XknXpd1NX7Wy7ZAb5BKRs=;
        b=Rmpzcg2mJ8O3AQjylXPCeevcKoYMTVT3NRT2gIZbq/u4Q+f3PbK73vlsx89hTtjXJ6
         fOFXv2CyYetApLHi6mZbCiMrOmqmf7KJfhbMt2AHIhEvfzDkRk210yZCkOvVpi9rtkA7
         7UsUT6wDPxQdeCCLcsksxuaEZQHTveMdg8Ckzzns0DB65/rBBB2TB5DIRGTmQ09DM9tZ
         cor08RYzCUZQd2kviJTzdEnoaN+q67ubA5vSq4l6wD2GEtqcOoU0YbPTv6ENKEThJ5Oq
         QYN0T97KEoi14HoeGfDBZ+AjEr3OuwKINurzcLzYOaZDqUmUjT+dKb0oJm01W3f4CmG4
         4pJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zx9aUYVTZ/Q7QmtL7E4nK+XknXpd1NX7Wy7ZAb5BKRs=;
        b=U+uPJIgaXGfazSE8jgfx7QkZKY126Ts+qeE4PKyPrWPxb+ITg8A062lyrxbpPYIkB3
         yIxLx+9eHOF4prL6f8jgz8+IVrLYe1hg9pC9WM5TBWKuDhY1gQPfB+40ps4cD21UPgTR
         YFLcINqieG4PbsjQX6cS/DqSJxYq7XNNraf7XrgnZiKlkums+k63gZoPp13H2WBOjtE/
         bKvZKye2FYyO64bvb7E9egCz7aAgttsWbcG+LrPnLny6l+sdUFvL4UgO16EdRKHEBxAE
         MqLCpHUoelJ/+7HTdY4AMhRrqeXUZIh7FSyR0qWDHOD3lSQLlkSG9I1DptoZpSNNxmGS
         qTqg==
X-Gm-Message-State: APjAAAVGy3kTpUGDnlI+PQDk6W6z3nF6c2Uxi/QhnfuuQRlnTByr9DVQ
        0SPi5cNYsYInoUYjlThZhEAa/Jw+ERSaJSd9nvL0hI0lL0+FZg==
X-Google-Smtp-Source: APXvYqy5FnXMGsyfpUpPnivkU4JXOBXavnwReh+VH/AtXAs26EZEl4e75tBaEA6Nt+8bGsliB11cYvQPf8v/6wCw/n4=
X-Received: by 2002:ab0:23cd:: with SMTP id c13mr13461223uan.77.1557813473337;
 Mon, 13 May 2019 22:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557486950.git.amit.kucheria@linaro.org>
 <ab5bad0258e455ef84059b749ca9e79f311b5e3c.1557486950.git.amit.kucheria@linaro.org>
 <20190513183947.GJ2085@tuxbook-pro>
In-Reply-To: <20190513183947.GJ2085@tuxbook-pro>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 14 May 2019 11:27:42 +0530
Message-ID: <CAHLCerMx8MqMJYO4K6eNB6zOr01FwjP_JRWwz3=nM6dz4+KnSw@mail.gmail.com>
Subject: Re: [PATCHv1 1/8] arm64: dts: Fix various entry-method properties to
 reflect documentation
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 12:09 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 10 May 04:29 PDT 2019, Amit Kucheria wrote:
>
> Subject indicates pluralism, but this fixes a specific platform
> (board?). I think you should update that.

Copy paste from the previous cleanup commit :-) Will fix.

> > The idle-states binding documentation[1] mentions that the
> > 'entry-method' property is required on 64-bit platforms and must be set
> > to "psci".
> >
> > We fixed up all uses of the entry-method property in
> > commit e9880240e4f4 ("arm64: dts: Fix various entry-method properties to
> > reflect documentation"). But a new one has appeared. Fix it up.
> >
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
>
> The message looks good though, so with a new subject you have my:
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks

>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index 2896bbcfa3bb..42e7822a0227 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -51,7 +51,7 @@
> >                * PSCI node is not added default, U-boot will add missing
> >                * parts if it determines to use PSCI.
> >                */
> > -             entry-method = "arm,psci";
> > +             entry-method = "psci";
> >
> >               CPU_PH20: cpu-ph20 {
> >                       compatible = "arm,idle-state";
> > --
> > 2.17.1
> >
