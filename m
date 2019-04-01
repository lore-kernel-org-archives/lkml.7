Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823C12070D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXf8nhkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfDAMtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:49:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32995 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAMtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:49:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id v14so6202185lfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6mrsn2zQtd1vReW3beHG4bHiss+raJ7XDvPsLbPmTGM=;
        b=gXf8nhkA1IewYnxXvPXDJ4q0HxcZB+wXn9TYo4fPA4qeyVoTl9sA379tiVJTHHnLio
         TjxDRheer57NbwMnXJ/W/fykp8z67dGplzKejD+z9FPCzW9s4sJvA+JoZX29Mty+fxaC
         MfsUhSt8nnWFXPrwq+gpjDq/kRQ8SINr69uYxv7ayQhWsZlDY1e7Rifso76oxFx4VgY/
         l87RJgKCM0qpnTUzgPiVMTc6kcIJwupJC41Gtw0syJbiJI3fArAWKYAueQ5G7hjqSBht
         JKzDu5qMiEIPDn1bfZ7q8dHGvNOcZz5fzFdevIWs2Vk7qyW+ASQLzd9/Yl4ySmRbsd/8
         p5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6mrsn2zQtd1vReW3beHG4bHiss+raJ7XDvPsLbPmTGM=;
        b=kNUC/dgp211C57sBzXFrHi1djnpavnvjkqlNNRIpdsGyn/7hhXDd3ilpDQ9zHkBoqF
         C3qsBXPZrrNpOHQyHiYO5evDnw3INBTM/5uCj8Jbkjyh6UmINsXOkZv+ti3EmZl5wJji
         TGct3/WO8F+l4AYNbUJXhcW8fcRNJN6CDPypbV1+NXvGkJaOKm2S7GuhKtFPucFz/1OG
         aHWgCRcfsjHwSeCBytwbnytKWfY/TC0P/KSCLyUerFgn7z6Uq7+Kp7XDe5VLNmKTVr21
         DODNXHolmZmKaRnFXZnrQ+SGsDIh5/s4TnIBram41oqAzgjgkpIZ6uxGnKeKcns/wzSH
         evKg==
X-Gm-Message-State: APjAAAVIPTAMD0PQYPVv48S2m2yJgiLKDX7nCWagPgo35Jxy+ikgjSIt
        wbJKqNztMSdtMD+lq0ib+6QG5zCR8vPMeYQTxYc=
X-Google-Smtp-Source: APXvYqxVQdRruUlUIQolVek9vsBMiQ5jbPuNOLtM6MOfPBQMMiUAu3iB6SPwa1KK3nzz0wHtTeObp0IjrzgLXVLJdU8=
X-Received: by 2002:ac2:52a6:: with SMTP id r6mr34230379lfm.27.1554122946318;
 Mon, 01 Apr 2019 05:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190330155051.9855-1-festevam@gmail.com> <VI1PR10MB2352F3C08CADD6029FF77FF3FE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VI1PR10MB2352F3C08CADD6029FF77FF3FE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 1 Apr 2019 09:48:59 -0300
Message-ID: <CAOMZO5DMCSf+UKHOW7AJJhj9QVht5+dwZqR7wystDaKSz4R9YQ@mail.gmail.com>
Subject: Re: [RFC] ARM: dts: imx: Fix the AR803X phy-mode
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        PENGUTRONIX <kernel@pengutronix.de>, IMXNXP <linux-imx@nxp.com>,
        "smoch@web.de" <smoch@web.de>, ARMLINUX <linux@armlinux.org.uk>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, Apr 1, 2019 at 5:38 AM Steve Twiss
<stwiss.opensource@diasemi.com> wrote:

> This patch looks surprisingly similar to this one ;)
> https://lore.kernel.org/patchwork/patch/1052588/
>
> Link: https://lkml.kernel.org/r/1397569821-5530-4-git-send-email-thomas.petazzoni@free-electrons.com
> Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Tested-by: Adam Thomson <Adam.Thomson@diasemi.com>
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

I put your attributions in the formal patch that I have just submitted.

Thanks
