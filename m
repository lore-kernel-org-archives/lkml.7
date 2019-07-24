Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91823C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A1C2189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpjg1Mqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfGXI7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:59:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36670 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfGXI7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:59:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so46123747wrs.3;
        Wed, 24 Jul 2019 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLD0FIohOIaMjbj7E0OOl2DyS6RV1bLULju5D5/jTY0=;
        b=lpjg1MqhUsOo7tkaEJrwfY2Sbjfd+C+NxcHvLoN+uP+ea1X5D/LzA8U9UqfIOf+jtp
         HP37lrCo8XZL9ygrn8K2ciiMXnWIdLfPTCvPTXysPyIzQak6nDvRBsRE5MXh317hrMDp
         7HE5zV5/sw1DszulN9iEs9PO51bVTkmTqzJ1Kv1mUKVnjvSCGP2PzruV5Z2QRaC0Y5yE
         gg0ArZ1AmS/yBrz8Yd4t5IH8FE4s5dQQY5AmJkR0mkYc+7LsCI3n50WdVLdpmaoGNPkj
         7cOk1aBDmK3pohX8ukFNVvHeH3iXs4Iho0dBAesi+OE9/Xe8k1W9RUwyOXknVD6Gz6Mu
         GlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLD0FIohOIaMjbj7E0OOl2DyS6RV1bLULju5D5/jTY0=;
        b=ul+1msj1SyRvMw6U+JnApLGXAwnkCfDjJ+Wg9ceKKqQWxJ2rhOyvr7u5bqE5QH0aE3
         Qjk/BaB+pkqjcaFKXQHr9Mz+Dn7TQ7XntsCtd2rYj/tfm3NNpUzepHvE6tIerrOnTxUF
         IJuaZO++fcmao2BFRPjYH6oN4fY67kJDGUCXl56tT7sV06QQ1gT08W+58OMkPVTDXnk2
         AlkKDVG6I/MZ5C5iwjSAkrQZappuGukhYo3Kv8HCkWcmFEQsSAPX4lDPzkrq7u428rTS
         cLwLrPC2a1tJqZDR/d3UCVjTDXp1wyhsn2cw1QhZW4uxMN/3HWZzj8mW/NlvmgCsc9iR
         s0Vw==
X-Gm-Message-State: APjAAAXc+dLzhBaE9wpmZOXmOyVT4eSL+i0mkTxRD7gQFpHoTE7PGrC3
        Ph5bWRBLJCm+/XuHvl4zA+OZg449KTz8IUPoq70=
X-Google-Smtp-Source: APXvYqzDa65ZZuqbBz0Y9LKy5ttZgCPxfD6HONFDo1ej5tX89DOctwjYr4B8EOdL7v6XaKJGVXfdSB6Urjocukqv+IY=
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr12742240wrx.196.1563958750049;
 Wed, 24 Jul 2019 01:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190723084104.12639-1-daniel.baluta@nxp.com> <20190723084104.12639-2-daniel.baluta@nxp.com>
 <a5d44d96-4d50-ee46-a6bf-3ce108b1994a@linux.intel.com> <CAEnQRZCuB2QKzz-08K0z+x+p0qCpqR_wDc=q2GChvJiw4E9hBA@mail.gmail.com>
 <1563957164.2311.28.camel@pengutronix.de>
In-Reply-To: <1563957164.2311.28.camel@pengutronix.de>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 24 Jul 2019 11:58:58 +0300
Message-ID: <CAEnQRZAEsPFp36hD7XiWihTe2KQOJV6Eq9C8hjn0Z1kiUZjzyQ@mail.gmail.com>
Subject: Re: [Sound-open-firmware] [PATCH v2 1/5] ASoC: SOF: imx: Add i.MX8 HW support
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Olaru <paul.olaru@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 11:32 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Daniel,
>
> Am Mittwoch, den 24.07.2019, 09:54 +0300 schrieb Daniel Baluta:
> > On Tue, Jul 23, 2019 at 6:18 PM Pierre-Louis Bossart
> [...]
> >
> > > Also are all the resources device-managed, I don't see a remove()?
> >
> > Good catch for pm stuff. We mostly didn't care about remove because
> > drivers are always Y in our distribution.
>
> Linux drivers need to be hotplug aware, even if they are not built as a
> module. You can test things by manually unbinding the driver from the
> device via sysfs.

Agree. Will take this into consideration when sending next version!
