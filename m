Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F688C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBECD2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YbIku5D+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfCKSLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:11:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43512 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfCKSLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:11:09 -0400
Received: by mail-io1-f65.google.com with SMTP id y6so4884963ioq.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sb5O4oqOVT5kioG6KfJRBjNCLqUcdsbfFHu02YhEyBk=;
        b=YbIku5D+X2dRadJgHsWQSNSntzS02JqniMAPVsl5j0sTOAJHjjXMJaoIepUVh9QeFm
         u5IFJKPW5uG7VhEKxO2f2seOsgK/cWLKbO4h0EopS511vm3m5Fe//CedX7G3bfuQk4TA
         GrqSBPE6phjeDuKoCt1thIF3pEuusSuXfFWas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sb5O4oqOVT5kioG6KfJRBjNCLqUcdsbfFHu02YhEyBk=;
        b=iuGZqnjqt1YR6c0MouhSijg7KBae7PGqXdVR9F0k+zSY0CBFGqc7qE5+a6vV4Pu+dl
         BpeXh8p3cjOA/g+lSLWN/u6buD+RDVpoCB5YeZ7Ab3sJGKtfOE592CO7EdoPhGjkrEQg
         fZfwkHbtgGAJ08bjn4BCcQ9UtjTymyKfN6nOxUABZNOW4MS2gCntzz1f4T0ZjFomSFff
         UE5Db2H/5XNXSHuVmLXh27MOeJmeYkHCk2SMbHLkQCaHPaUZNAZYRcyGN+2wmqAidEdK
         GyxrtisK7xxorYc3MSOO3zFPVAf9nbuA5Jlr4Qz8iYb/AenAVx96+744R1T3O0rplTAA
         GE1Q==
X-Gm-Message-State: APjAAAUsqLQXP9XGsQND6DJD2Uf0Vs6osryXbiG/OKoGA2CenyFI4qmE
        XfE3dlIRWCiEQGR+rkCymd6STT7IL4ukm4Ct7+4atQ==
X-Google-Smtp-Source: APXvYqy93y4F5t44M7iA5rnGywMf431A9jV1zNgVRDpeVsTuxmvXcTm5xNS9r2YIX5GaFlmE5Dp+TZBJcnTxqTZ8iJo=
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr18565090ios.267.1552327868530;
 Mon, 11 Mar 2019 11:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190311150332.19492-1-jagan@amarulasolutions.com> <20190311150332.19492-3-jagan@amarulasolutions.com>
In-Reply-To: <20190311150332.19492-3-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 11 Mar 2019 23:40:57 +0530
Message-ID: <CAMty3ZCS8G+dT4bHihovrug-2CCncA+BMg=Q2YYcsyjonSQPiQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: rk3399: rock960: Add missing
 GPIO for vcc5v0_host
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com,
        Akash Gajjar <akash@openedev.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 8:33 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> vcc5v0_host on rock960 is bound to have GPIO4_PD1.
>
> Add support for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Signed-off-by: Akash Gajjar <akash@openedev.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> index 68ca3bf9ea2f..c3d3343d6dde 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> @@ -68,6 +68,7 @@
>         vcc5v0_host: vcc5v0-host-regulator {
>                 compatible = "regulator-fixed";
>                 enable-active-high;
> +               gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;

This is already present in dts file, sorry for the noise. please ignore.
