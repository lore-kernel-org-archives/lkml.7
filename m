Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ABDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C2F2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/mo7T0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfCLSOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:14:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36266 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfCLRLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id t206so2740449oib.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/34JM6n4jbLorpMWeteTyQIhtscAMn+/Mff17ZFVkU8=;
        b=S/mo7T0XDqYtcBFjmUlbV/oyhvFiTCNm/epZWXkiPLvjtcsPHrYEEglAzU+RTSFght
         8zRaHlifKBynuBUhuvezFleWhnfuj/eWIj3+4OeBLYSuiVuDCr513q6qfse1Lf8nUwLU
         z08hOGUhGhVgwnlB40ptpXwoBhvfzoSaUHlsHHxkQcb/qcAlq8c0w010DQ5zs+uZthKW
         MG/0UKmBoecOdLkrxmhlLkgInZ0yRCsO+7xPkOm44GyzAs4Q05JO1s93EQX72QfcFA+I
         i8kNZq7wMB34N5MZE/nzJFGJ3xzbGUtxsdls80lSKuQnl8pxHgyT08r+0mBAPp+MW3X3
         2eKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/34JM6n4jbLorpMWeteTyQIhtscAMn+/Mff17ZFVkU8=;
        b=RLIIWUn/bXpWJC+6I09jyNAFuzDlzGZdmx2XzT371bugFvibAHXU3QEz90nqoB4wK7
         5abFWkb4Cm1vXlGFhDnrNMHxqvTtxpF6w859QOuIjDDb6r5Qp2FAy1RPVC6dyS6zqKxy
         8d7mRL8MftnWjQWZpQ7JvqK8LxlOTBWT6RFXF5aBktj9+gA1k7Fd/wi4pX1fbjvGOwL4
         YtYFvVCytnkhL1T9R0Vkm28wJJH50zeSZmU6wPay4vVai/kfPZE+KsCYrqCcd4VgaeV4
         rxasPQwIfxKFS2L3zUNSdeUagVARmcspPravyzfzMO+trPBe9so0gQywe4aNSypqbBfj
         JjaQ==
X-Gm-Message-State: APjAAAXrHkfLoPUXmju1bJGlcEb7LZpG6tftn1VU+f4M7MyBmTJ5OKiE
        zwLt0PGjZEa6eYiFzEVspfjrxDWOwFhX8OupqqE=
X-Google-Smtp-Source: APXvYqxV6uRSGhGzdtVh9u1BbIyZqPM8caDx+PHty/Pyl48dNS0u9ii/K0stY7FYyt+4FVfFo/fB0Yh6bddX0KSsk8g=
X-Received: by 2002:aca:e6d5:: with SMTP id d204mr2450438oih.77.1552410681983;
 Tue, 12 Mar 2019 10:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <CAGngYiWFU-VnG=ODLWaUf0yp69qaU2GSd9exdHvyi6Ko1ib9qw@mail.gmail.com>
 <20190208121916.GE23483@kroah.com> <CAGngYiVVNitd5SDLah-kxP69W6XHYHOQrOz=DnevuGnqoHD7HA@mail.gmail.com>
 <20190208141400.GA22162@kroah.com> <CAGngYiXZtNcqQ3JGgavBxypo75WtAT7T-X4DQFNWD8kQcifU8g@mail.gmail.com>
 <20190311191339.GA5628@kroah.com>
In-Reply-To: <20190311191339.GA5628@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 12 Mar 2019 13:11:11 -0400
Message-ID: <CAGngYiVB=6627d31ad5ajfrmBtV5_pDLudKkBuPNyNnqkssBAA@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] Add Fieldbus subsystem + support HMS Profinet card
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 3:13 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> That sounds like a good plan, I'll take that.  Want to respin the
> patches with the code in drivers/staging/ and I'll be glad to queue them
> up after 5.1-rc1 is out.

Andreas Farber suggested that the patchset may have more success reaching
its target audience by cross-posting in netdev, and maybe linux-serial +
linux-gpio. Does that sound ok? Any other group where the patchset might
be welcome?

Greg, are you ok with holding off taking the patch for a few days, to give
the netdev/serial/gpio people a chance to react?
