Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECE5C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6932064A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWAjpLiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfGaUW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:22:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42854 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbfGaUWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:22:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id s19so48387089lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0SpmVhieaSp1M/Y3YqpENmZuxtfqWEgb2ZzBcoQ3X0I=;
        b=LWAjpLiybWndbpqvSdgC0ZNVG3eJ/FDLgFPRE39//+I4dk/MsAtj+ieFxB9Hs2cwHQ
         oY2l9jwMPeSNwgmgqTsA7iSTuBKhTQZGKCfU0RbTM86pn4D5v+lrLJf3EQsyq3p6Iz/0
         q0kyq7nEqWOvEYdsRx2VVAYAOG4ck69HCAa6EDEDEEJoDH22wO8bzmsr3TQ05a4E/2e1
         ODRI678yagekALfr4cBmh88QfX+hhk3Qe1VzHoiQdIWQ4SzjgXounkQY1fao2yLewMyc
         KjXDaZtoOnZu2ZuHqpkJLVVM01pvBQZIuQO98ZLyGkv7wslm8+/X17AH7bMoLhLDMJyC
         WkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SpmVhieaSp1M/Y3YqpENmZuxtfqWEgb2ZzBcoQ3X0I=;
        b=rB3oLEh5Iyyg6djXOuM0OimtVgRrDxwToSzPx+V8VDRBCUp0FweiSIhO6HJaO3Fuko
         lUzYuhciAduw45Sp5jv2lCa+rrz8kpVGkAqS1Ta8uMT3Kbs8vtrcVYrbRLvt4skiKQuk
         LDx/SNFRrspgNryJdSpTPqv5YVUv6EC/eVrhjIqlj85pNlH35TvaY4O5mCKtqVGgePBQ
         LDo6VxMk84RcjB/sqdskBGOi0K0DnVjLVNjg+3j5DnjGmzAsOk3TdF1DB0x8W9lz1pp5
         RuODhku8FkUem/srm5SOY6DMlO1iDhVDB+PAOU3X1B1j4+hzsC/mN7zAF420fnqTyHhT
         G5eA==
X-Gm-Message-State: APjAAAXVzEQfdv5zVoQF0uXzlIvUHHWLeHSO4urESh4CuN4vUqFka3iy
        vds5iaJ2jz7YhUPXld901d5pVJNNye/WO8Ni1H7rEQdM
X-Google-Smtp-Source: APXvYqxeyi7F/o8AJ7WWDg5VWXCfCMw/eTyZi57avRvhkoBN7e7jtZLbC39zRmkyQb8O5+pm6aN7oPac1yNmmebqoVk=
X-Received: by 2002:a05:6512:21e:: with SMTP id a30mr39464898lfo.107.1564604542373;
 Wed, 31 Jul 2019 13:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190731180131.8597-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190731180131.8597-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 31 Jul 2019 17:22:34 -0300
Message-ID: <CAOMZO5BSsPx-iFtuHap-kSSqYYCEMH4A=wsOp61oJvGRUe1O6g@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Drop imx_anatop_init()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Chris Healy <cphealy@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Wed, Jul 31, 2019 at 3:01 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> With commit b5bbe2235361 ("usb: phy: mxs: Disable external charger
> detect in mxs_phy_hw_init()") in tree all of the necessary charger
> setup is done by the USB PHY driver which covers all of the affected
> i.MX6 SoCs.
>
> NOTE: Imx_anatop_init() was also called for i.MX7D, but looking at its
> datasheet it appears to have a different USB PHY IP block, so
> executing i.MX6 charger disable configuration seems unnecessary.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Fabio Estevam <festevam@gmail.com>
