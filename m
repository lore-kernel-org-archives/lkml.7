Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A24C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51882073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdRvCks/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLWQnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 11:43:05 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43064 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfLWQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:43:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so18325138ljm.10;
        Mon, 23 Dec 2019 08:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifd1wnOruXsNwGxgtVXfg7wrVzRZczBNll4oBe85Rx0=;
        b=VdRvCks/jfwxO4dWau5qXjKg7Czet2xK/6zBWvd+csldlQEbIfTF+8Lzc3holb75U5
         cnp5E18ddrQ1CaJhOKKO2zTXn+h1jIXGk/cn3/on25hcPnsI5uox+BvRCmOywT1VK21l
         2iKgm7Ajn807bXuiwOnVZ5NYQ0FBHLiXlC11yTk+tgSKy/NJ1wohhmSpm5I5HAEUOavT
         Q1+KSqC9zlF/F+LayoP2kWgAfAUPLuVPw/dOFTZsYkjff+jsV7msqbhA1g4o6AjAvPt6
         RgwUGWSUpcfuEt1j7aKP6m4yYrTb1P0Cdm0p4cHUkUfh1Cm1GumSdPkAmAAjgl3JH5/i
         o4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifd1wnOruXsNwGxgtVXfg7wrVzRZczBNll4oBe85Rx0=;
        b=LuakQGnr8udAEAgui+E9DjrtP5O3EB6rV1ekDVy9L5CxTmWE9VmqBUOBGsh62kL2ag
         gTgwBVA473uJfjrq+h/oPbrTeWFvZu5+WiGTN2Iu8+3UChonW3wTmxJ960AvUOenvlVf
         fEkwWIilsL6kM4Pn/hi2a2g7IEH4erDAwz4fDkqaGMfaONT2OKM23WWecUn8mCewNT1I
         kw1S9tcw/Rxnnecghwj+iuEFycprS5UuJgkTS8QqJjgIZgHaHNckgJiwkehRKWkeJYOI
         j131ZXoXU5CFhOinryPmTyIJNNE/xkBl7EbafSQbtVM2b60xbY8IWgcTiUWtKRcfv6X2
         8KUg==
X-Gm-Message-State: APjAAAUanndEO3TJZu9WkyA4wKhNRXkAZ0s4w0+nU/K70tgE3eo54OGr
        78CK1savKvE0ayXrCVUWD/IIBEznM6S+ZUmMuLQ=
X-Google-Smtp-Source: APXvYqxiDj8lIaZAB1jqC0aYJ4gqv06ifcJTyVxtncJI7fCxlQvV/RvTs4NldhRGJ9shbRDE2tRI2uNEWq4Ysl8deoU=
X-Received: by 2002:a2e:814e:: with SMTP id t14mr17964339ljg.149.1577119382325;
 Mon, 23 Dec 2019 08:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20191223163546.29637-1-michael@amarulasolutions.com> <20191223163546.29637-2-michael@amarulasolutions.com>
In-Reply-To: <20191223163546.29637-2-michael@amarulasolutions.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 23 Dec 2019 13:42:49 -0300
Message-ID: <CAOMZO5CzZvDSEkYcz3LzMCnLp8ZW7zNBd18LkKZWtbh0PMQvdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6dl: Fix typo in i.CoreM6 1.5 Dual MIPI
 starter kit
To:     Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Mon, Dec 23, 2019 at 1:35 PM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Fix the file to be included in dual mipi starter kit. This
> fix ethernet probing
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  arch/arm/boot/dts/imx6dl-icore-mipi.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6dl-icore-mipi.dts b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
> index e43bccb78ab2..d8f3821a0ffd 100644
> --- a/arch/arm/boot/dts/imx6dl-icore-mipi.dts
> +++ b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
> @@ -8,7 +8,7 @@
>  /dts-v1/;
>
>  #include "imx6dl.dtsi"
> -#include "imx6qdl-icore.dtsi"
> +#include "imx6qdl-icore-1.5.dtsi"

Jagan submitted the same fix today:
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-December/701895.html
