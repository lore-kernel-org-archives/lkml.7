Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF049C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB72121D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ZSyrvWFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbfJDULn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:11:43 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39461 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731160AbfJDULm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:11:42 -0400
Received: by mail-io1-f65.google.com with SMTP id a1so16229550ioc.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+gSdG7Prkk7Cp8mQY9HaZirRwIllCjsMp9BMJvUxrk=;
        b=ZSyrvWFeV/vh62RWW9BJlK1/b3jPCygzz85/0IwOL2MzWF2ErbrXK6d6LLO3DT1w7M
         tTzG4A+wWRStYJB9lmHyo/ND5e+tPKnLsSWfVGqX2PTyd83EKyJ9gLVo7YD4ZRRLXVvA
         u+YFOOsDVJF/Tt6K1cit9W+BpFxgaVaMID2R8z9h+WO31LJKARx+2KAU8lezejqryyRU
         NDa8k78Ue9/HTUCJAweCKptnGwn1UA2cUL3fOz9WsGSJDvMGeOpumca6hj6KLo3Eh2/i
         FMSd9CQiqYxLLAzuWfoZo8wbKGVbqooDkKvvAoqxJlgVTh9FIFKrd8tNT00tVxE7W4CS
         rfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+gSdG7Prkk7Cp8mQY9HaZirRwIllCjsMp9BMJvUxrk=;
        b=aO57yFwiolK5OTcJGMzeJBob/3omD494ihlGHxtdEBpyr6+l8x7sgRgzrT5b4w0Z9V
         P96WckCOywGly754vnIvos6xeJi1qosN4IUXTfbVLAF3q6gbujRGu0fxyfO5HIgGnp2Q
         CHuLOexYOt5xuka9OxsRv9GY4VV3CDBN2a9iUi4v71zuJTDrEn8Yl2GSlAF5avv4Y7d2
         f+g0SA+PWZHnsUJjS9EjxinvKskwReOz/2/4/pYeo1e5449554Lju1r/brJMnBwp/CrT
         f05/riLNFV7yBmbY12ACqDamJvBaio2HFHlAbYWY15c7FS5RQXflLcXdGkRwsULCSAam
         TIRQ==
X-Gm-Message-State: APjAAAWeNiMfomBfBvmUEmRqaQ8qW1p478cT/w/t8uZ0OAVE5V+OsWzC
        i+oHEbj/1plasYZuSdzCUVPV6PXyDJIArDbHkomDtQ==
X-Google-Smtp-Source: APXvYqxlEQ0p5dqdnleWWojSrwkdgmBEUkurQtZ1WZv+uCyU//AQSI8hbw9SjVK2dBtB2MjbTcY6tyfd+ZHXEi17F2s=
X-Received: by 2002:a5d:81cc:: with SMTP id t12mr8160598iol.207.1570219901601;
 Fri, 04 Oct 2019 13:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191004124025.17394-1-patrice.chotard@st.com>
In-Reply-To: <20191004124025.17394-1-patrice.chotard@st.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 4 Oct 2019 13:11:30 -0700
Message-ID: <CAOesGMgF2m_MUqHy9_aabMxMZ4rd1=qL0VGr+avPNn=GgsLJCg@mail.gmail.com>
Subject: Re: ARM: multi_v7_defconfig: Fix SPI_STM32_QSPI support
To:     Patrice CHOTARD <patrice.chotard@st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com, SoC Team <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 5:40 AM <patrice.chotard@st.com> wrote:
>
> From: Patrice Chotard <patrice.chotard@st.com>
>
> SPI_STM32_QSPI must be set in buildin as rootfs can be
> located on QSPI memory device.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to arm/fixes. Thanks!


-Olof
