Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5562C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8272086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyJZW7fZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfHEKIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:08:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36363 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfHEKIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:08:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id j17so3437427lfp.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmJocWvsymOdQ7NU7/6yMlP4/6K5DwEx+usK89GVi9s=;
        b=kyJZW7fZfdLgtDs2aKngH2TyuWTJjTeVTLZyRgxZRY9MQ56FWUw3A52lCdt4c4YJ+1
         3TgWOde1fzdSqgTWIgbjzvsDeaFtKgXf6SuYKrrM9YK82qK7s6dWcsjao4CGSwv8Ahlt
         Crwmv8+ySmVuExNcK9irfRd7xd4YEh9epWXPM2OVxpgaQ8bRFBbu/lNMcWXb245BCABI
         /yNpf25WGiE15uDcA+a++0LXluCfysTo88g0q7Hcvunkj67HSTRYbpqtQilt8t8aWCuR
         NoBItyc2gaayKuIzBJdFKFHEpFkdC+iXQWdc8it3UQcFXi36FqTMsdYN8t8x8xKnWrM8
         44vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmJocWvsymOdQ7NU7/6yMlP4/6K5DwEx+usK89GVi9s=;
        b=ATVM/z27YSsa2EASBRTLXLPNvcg501OiYk6SO3HwMOHTi7jung6vA+2nRdH83YVi51
         yasXDSOAkXdKP50jWHq/Sn8WDL8s1fgQSYADPpzlhQazLguFGBFDbXZEMhC04ok/s93o
         SpnVTDrxxnfTVBLuYrdTy3CG0fcfbb4m2h/Ahi3zHi9pyizoPOGFnvUzFHZ1oo2/zIKk
         G8ZWTmQopvqAoP6M2lJaoFFsljwSi8/yFmIuqP9gV/SB4logN/UeKuPi+lbP5lx5jt82
         4RyR2TzCVbr4fzIGpLDKRbqY3deHf6I3L7NIPQ1omzxTRSkFKYFSSjbbttm/DYhF+hdW
         MRfw==
X-Gm-Message-State: APjAAAV9HV3uj4M28odSb/xxN3h7j6iGyaWxnlA4z3zOW1MrIthUFFPu
        oWqdWgKv9o8ICcJmhQOqZSOu7D9i4M+OkLjmNYDrdh8g
X-Google-Smtp-Source: APXvYqxpqm0yndDdT3beIa5MGWi8lTPoZhzSa/lWFiqq6Dn3b88/pHlyJgXWVtBOlC/fjyLdOtrrqUOtG4JGHdovYiM=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr60787048lfp.61.1564999694066;
 Mon, 05 Aug 2019 03:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <1563958245-6321-1-git-send-email-chunfeng.yun@mediatek.com> <1563958245-6321-4-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1563958245-6321-4-git-send-email-chunfeng.yun@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 12:08:02 +0200
Message-ID: <CACRpkda5OUEfZRSMA-8H5jnhSan+VJ_3KB5CvOaRdZP1NeJQ+w@mail.gmail.com>
Subject: Re: [PATCH v8 03/11] dt-bindings: usb: add binding for USB GPIO based
 connection detection driver
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:51 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:

> It's used to support dual role switch via GPIO when use Type-B
> receptacle, typically the USB ID pin is connected to an input
> GPIO, and also used to enable/disable device when the USB Vbus
> pin is connected to an input GPIO.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v8 changes:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
