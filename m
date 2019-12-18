Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCAFC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3659218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk9ZmoqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfLRMoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:44:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45418 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfLRMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:44:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id j26so1955530ljc.12;
        Wed, 18 Dec 2019 04:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuNJY1Eqkdr1yzpz8WFLWL68ldC+kkUguGLPAWGyiKg=;
        b=Uk9ZmoqCJrTgBGsW7QgSAo1GJ0/FOCOTb+LmR7/Tli2IwqMf/QhDVrVRYg2WsC9EgT
         KNW72dnQE5tUAyzvk+4Gbh/AFXqhROHqgGML3xtdEKeS2nMacSpCV6/AjKpByY8qxxND
         SYsF9Qm4t50Lm6trf+CmkjR1ZgAdKQApUP4fcnjkFfhvJytNr7e9xlZKpp2MPCI/3GZh
         a4Yg0rVe5zEUH7w993qA5GmD4EksreE0IWif7g1fEnaj8d/Ct9DKidnpsIrHITliOEQl
         QNZq/G9y8pYI5k0YkKkDiaCoLU/SQqKFnhSviRdbBv8Zl5R0GRLkkRgQc+WjsrPFN1Xi
         89IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuNJY1Eqkdr1yzpz8WFLWL68ldC+kkUguGLPAWGyiKg=;
        b=tafs74cgqhoQoz+x1gyp93PulvXWx4Qn3sjS5YCfsFp/aRQfxae9k5W2r2GJWZumPY
         swMhmVjLB3tuCRFGfmlaIJMu+jnWufMAzkKxTds28g7SaVbLEnnSyHd0EtwFc9406XRx
         QHy2taPG+XtCEVoYq7wdAZVhcLZ9HNGFweZjdP40rNowx3Cr+USCr42Ir/tPqPy31tQg
         6ei4IpZdz+99jJCrJV3iY3jdBTSG7JWHTK+J7Xhz2vW1j7KxonSVmMAgPcuzUxPIMBXK
         jtMxe5NGGbEYPJCmdAd/Fc9lNwkh5Di7g9vgtw0WiBqvSocbNizoQl01sfJxHOWO7XWJ
         U3Rw==
X-Gm-Message-State: APjAAAWBnW7JJkd+J/na+ebhNW239N85X/ybvAYy+Dx2KXE0Y13PlRSw
        XGTUndAJVcZip/KzN99HJIzTKxHHMgC4GrPIyJYtcOlN
X-Google-Smtp-Source: APXvYqxLHrBjXy5iF2n5zmXApo8E8VCToPLW9VCn5+hUXoH6t4y2DqL90iI7/3WHJVVYZQeBdsPWYXGBxdQBioaBcD0=
X-Received: by 2002:a2e:6e10:: with SMTP id j16mr1623824ljc.202.1576673049367;
 Wed, 18 Dec 2019 04:44:09 -0800 (PST)
MIME-Version: 1.0
References: <1576671574-14319-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1576671574-14319-1-git-send-email-peng.fan@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Dec 2019 09:44:04 -0300
Message-ID: <CAOMZO5DEDN7bNhqgyh-Qa41MJ2LAatfG_4=VvywCk53pK4e2vQ@mail.gmail.com>
Subject: Re: [PATCH V2] arm: dts: imx7ulp: fix reg of cpu node
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 9:22 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> According to arm cpus binding doc,
> "
>       On 32-bit ARM v7 or later systems this property is
>         required and matches the CPU MPIDR[23:0] register
>         bits.
>
>         Bits [23:0] in the reg cell must be set to
>         bits [23:0] in MPIDR.
>
>         All other bits in the reg cell must be set to 0.
> "
>
> In i.MX7ULP, the MPIDR[23:0] is 0xf00, not 0, so fix it.
> Otherwise there will be warning:
> "DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map"
>
> Fixes: 20434dc92c05 ("ARM: dts: imx: add common imx7ulp dtsi support")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
