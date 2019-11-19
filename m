Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904FFC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6829A22311
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqsn2nAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfKSChg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 21:37:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35151 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfKSChf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:37:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id r7so21451214ljg.2;
        Mon, 18 Nov 2019 18:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lucCyifi+cNj2bBusqodMTZdSBO5qj6Vap0H2hhae+0=;
        b=tqsn2nAG3Br2u59mKUWyfMiYlANBBlYkBAAROl0eTj43D008vybSBfn1aIqPwaNqlX
         3Y0h7JDlKZMw7N2123tGDAgEJM75Gen8sa7qSYPFy/AexfYc+F42R+2KiCCdNvivjqlX
         kgIZOVur45nzTlfz3sktrN2FV5dMhiNXB8Ok6GX1Q7nJqoCNKlZEdTQhcYMAuvlM78PP
         5sJP6aItkPYw9Fcvb/1Ckjal1CK3LD8+gSrj2xvxuMJZEUMDXkls9kXKyqLotxjQOhD0
         xALPcyCNlCVW69l6Ar3OkXmqGwb02AjyXEwlzlaUR+AzHlgStF3nKz/09xU4Nq4hK/jg
         oZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lucCyifi+cNj2bBusqodMTZdSBO5qj6Vap0H2hhae+0=;
        b=UtpEeC8DUOger/mvCzzIOdC5X80wnUj3Q0OGSjHSfIPEalQt4+IGbQdYzS7fawMQxz
         GqONpyKNk8TChJo8rxamU1INBLrALwCkq1RhdVTyJMWgvzI//ldoxsbKbspV+1l97Aok
         /n/z47BiSEIsE8O2qPDjL6+p8PnwuXwvWza4GACBMqFMLk2uOrN0B64yDHUSw9G5GuQP
         ObCu+TIFOBss08zNZFtNGE62D7WXI4WgfENbbqPciPpA5sRGVEZW2QBdkdckbzUJ+cab
         4aB+CytE3fwaahI9rHgKhcmVz+kGoW0EnuH0APUGcM3//r+Xg6Hl/xOu+l3fe8LrHNjM
         qD8g==
X-Gm-Message-State: APjAAAUmw3cvpIWpG1dJKFP4UOGwYvfj+zWQ0rSb7jlWQtPLG5Sy+Rg9
        CSBStAFsoW7TReH3bAzPP/jIXjuxrJ3y4fTxtXA=
X-Google-Smtp-Source: APXvYqzQsuRSn+l9haQPfvyu4GjnZzDuxDevPw00bbnzXD6rqv6dBa3+zSNGIlk9xkmiUOFa7FXZtrGL7aXiC7nXYD4=
X-Received: by 2002:a05:651c:387:: with SMTP id e7mr1844421ljp.0.1574131053718;
 Mon, 18 Nov 2019 18:37:33 -0800 (PST)
MIME-Version: 1.0
References: <1573586526-15007-4-git-send-email-oliver.graute@gmail.com>
 <1573593892-25693-1-git-send-email-oliver.graute@gmail.com>
 <CAOMZO5DYssbnVsemV+U24wbVoYM3LM3ZZtFwWHonXLHKF0Y+kg@mail.gmail.com> <20191118212912.GA16329@bogus>
In-Reply-To: <20191118212912.GA16329@bogus>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 18 Nov 2019 23:37:27 -0300
Message-ID: <CAOMZO5ALK+YJDQZ3ma6qc2WNnayapVQde3R9MA3sEGnSFBGnxA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: fsl: Add Variscite i.MX6UL compatibles
To:     Rob Herring <robh@kernel.org>
Cc:     Oliver Graute <oliver.graute@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 6:29 PM Rob Herring <robh@kernel.org> wrote:

> > I guess what you mean is:
> >
> > variscite,imx6ul-var-6ulcustomboard # i.MX6 UltraLite Carrier-board
>
> It matched the .dts file. However the '"' in there is an error. Make
> sure 'make dt_binding_check' passes.

The dts is called imx6ul-var-6ulcustomboard.dts, so it is not matching
the dts name.
