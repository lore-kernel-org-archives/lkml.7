Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90E4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4D721841
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBjDx0q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfCULRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:17:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40909 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbfCULRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:17:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id u68so4283317lff.7;
        Thu, 21 Mar 2019 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJ/MSJisOrVQgxOdnH7RszxW2FyDvD/479s88cZ5GsY=;
        b=WBjDx0q0zDpRyMrMOhi35fmCsoFYOuIJgBFOCrH096P1jWHwz81BjGqzltJ9XNw/zq
         pkZb4Lp6QhSdkqNMkkQW+Ahj622adOggM8yOkQPti4MxvavXRdaAA/F5VXoBdBvnpmSe
         OoaUz56OzJXdf6oYKxdpUU0Rkno/pzL4tHC5EzBVjpfaEN1y4D4VxWB5/UcGZKOo6eEn
         /a1S/uUuZ/TXAmc7v9EVKdH5aPHejwMU899CVC3/blEBTUZUPwaf9YSXeGVj5C+yPYFE
         PXPIrVL8ZVAR3VHbol/1TcGHR0LYZiaAW9c1ALjQ5TEpSz0eGCtRqgzllPj9jOclzV/c
         Xc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJ/MSJisOrVQgxOdnH7RszxW2FyDvD/479s88cZ5GsY=;
        b=FyC3ECu/mRyKsRQEkig50MJvwsrlpVht8SZxCUzSDdBQUEeAvq7OMZ36WxKsknA4w1
         M32u0CXdS7WOMRiJ1k/F+24YfOOEicsUxjyAFydgwVnZOPyvva4pSHkGAHwtOOXCxg54
         NeYhIuFIXyRlVpwZBLXddzm74Xg/t21HJpo59tYg0L2VlbqvgUHOMKAGj1KHuPylIhTt
         tHmog7sFTMZsuymMv7mX1kPhDOKUVico4WUsdELHfzagyTMM1QNf4N3QMLS9V40APdj5
         u1AJQN5RytpMrG8dgZrud95Efiw+3dG24D80SezzlrOp4X2U0/XBc2lLyObMBAs1E5ar
         hRSA==
X-Gm-Message-State: APjAAAXRDwg+YaG5KRrgG/4gYmdU8ntWLVyrnVlvZmGnvtZyo3UijoFP
        X4Mx18hpgKzAxrxqbSCppIcCfEnPBo4eQ+HlfsY=
X-Google-Smtp-Source: APXvYqySgZWjMiqyMwlyKbmViYHzYT2NeoQPgh4lYh2Mas98Jkv6Kp6vccT/Kn4GcD+jI4szuhEn1eW0B1CKRoWMfqA=
X-Received: by 2002:a19:920a:: with SMTP id u10mr1808864lfd.122.1553167025425;
 Thu, 21 Mar 2019 04:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
 <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
 <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com> <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175>
In-Reply-To: <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 Mar 2019 08:17:01 -0300
Message-ID: <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use rgmii-id
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Thu, Mar 21, 2019 at 5:42 AM Abel Vesa <abel.vesa@nxp.com> wrote:

> > It seems we have other boards that need to be fixed and we can not
> > have an old dtb with functional Ethernet with a new kernel.
> >
> > Does anyone know if this issue is AR8031 specific?
>
> I can confirm the same fix is works on imx6sx too.

imx6sx-sabresd also uses an AR8031 Ethernet PHY.

I also tested that changing the phy-mode to "rgmii-id" fixes Ethernet
on pico-imx7d with AR8035.

So yes, we currently have lots of broken dtb's in mainline and I am
wondering what is the proper fix here.

Does anyone know what was the kernel commit that introduced such regressions?
