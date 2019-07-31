Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9860BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B17520659
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="iLKtDYhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfGaNVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:21:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37514 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfGaNVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:21:47 -0400
Received: by mail-io1-f67.google.com with SMTP id q22so16376539iog.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEmtqV6jxIm1Hf7XCoFWbgfozoS82kQ9/Zb5qc7DFzQ=;
        b=iLKtDYhQ1/laEfKGBtuXbMfooXiyjZ2AmkBlkslHGjFZItiG4iB2z0M9LzNcR7awVf
         9ik3RbeyAKgBKGiDRVsmk4WWMlNOzJcOSY2VbRleml4zG9+0sCTCeoWJQGKFCOQ3qytm
         d0Kil5SswxA4ZMoBjhJpnI0igtkGv1aCEns0ueRxAMmhGlFNDOZrRRIg+e71N153QivE
         3Vxp8UR8I2IM/2cinG7q6TgyuG6e3qwhmvoBhAL5BYgkj6fwkHOFEdqitUzOqfPq2xaV
         4VCZiI1aosV9SKIiWWLwn3A05GqHn3MByxVWAIJqRor+QNYZylU8JC191piLfQFLLEtH
         fp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEmtqV6jxIm1Hf7XCoFWbgfozoS82kQ9/Zb5qc7DFzQ=;
        b=CrmMrChOUM/ziA1YHEG1/wxRO0gE1uEDDXu9RbPeTJkyJsfUt/NcBNmKyeuLLpvixP
         rGPCf8m02Z4bAEqVUlljLung6v+WAeTUfopCpwrz7DacVfe5zmU858YdhgNRJTSNBIV9
         IDbxZ8plRZfHCP22bk6d5SP6PzrpW+cOPkCklBvcn5pkXzvrmm1CH3hwp99bxSmBSIkP
         /z9ypFWM1Rw9Et/FdRwrhGr+oaQwgMvBmL9Tmv6EeAihp2OPBwM/+6OoCQ3gRgaNASsC
         cyiOJCn9vngQj8oJ4ZIIti0w1QrkWBHqkuwPQyWEfCOxmhSG5pB0xV64GoZb0bUYWw2i
         c3Yw==
X-Gm-Message-State: APjAAAWXKYSv5H6Z6zLtbpufWdu4Cerq9oUmFfNcJNom8WPUUa2PI+1U
        JJfhdeVYt+/vVYCGfq3gQ0MMf1+HCS+fg8Uy1Ug=
X-Google-Smtp-Source: APXvYqzPVMAFcVhfX7nef6PXLS/pYiwVYlTrHmhyyV8Mlbt2TQ+kXJroNOKFGdZUkM4UDziKIKKtIjxDZXRuH16p/bU=
X-Received: by 2002:a02:16c5:: with SMTP id a188mr128658135jaa.86.1564579306847;
 Wed, 31 Jul 2019 06:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190729135505.15394-1-patrice.chotard@st.com>
 <CAOesGMg-3xt2qjjZ569pUE+d6tn7nz264AN9ARkBT_Ej4TFC2A@mail.gmail.com>
 <de6ab910-380e-6271-88d8-6fe670525e60@st.com> <CAOesGMgi2cLUZGZnzKY+4i2tZSFyLe2TEK5SPY5yu0qSh_BRxg@mail.gmail.com>
In-Reply-To: <CAOesGMgi2cLUZGZnzKY+4i2tZSFyLe2TEK5SPY5yu0qSh_BRxg@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 31 Jul 2019 15:21:35 +0200
Message-ID: <CAOesGMirq=42Cj4kT=dLSqUiG-yee5zuqFhg5t=ud5KPmQJYBw@mail.gmail.com>
Subject: Re: ARM: multi_v7_defconfig: Enable SPI_STM32_QSPI support
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Patrice CHOTARD <patrice.chotard@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 3:20 PM Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> On Wed, Jul 31, 2019 at 8:48 AM Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
> >
> > Hi Olof
> >
> > On 7/30/19 7:36 PM, Olof Johansson wrote:
> > > Hi Patrice,
> > >
> > > If you cc soc@kernel.org on patches you want us to apply, you'll get
> > > them automatically tracked by patchwork.
> > >
> >
> > Does it means that you will take it directly in arm-soc tree ?
> > I mean, I used to take this kind of patch (multi-v7_defconfig patch
> > linked to STM32 driver) in my stm32 branch and to send PR for them.
>
> You can do that too -- it was unclear to me whether you posted the
> patch with us in the To: line because you wanted it applied or not.

Also, we request that platform maintainers keep the defconfig updates
in a separate branch, since we normally track them in a separate
branch on our side. So if you do it in the future, please send
separate PR.

For single patches, it's just as easy to send us the patch as a pull request.


Thanks,

-Olof
