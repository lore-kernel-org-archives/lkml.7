Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D62CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDE920684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMiwS5zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405013AbfJXBk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 21:40:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41188 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJXBk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:40:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id f5so23159952ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 18:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOCBNMFhsUwuaWySwxiGRZhWupa8CafL3k0FP31MP/Q=;
        b=ZMiwS5zrfJyYariAhNC1SpAi0ujVKhx1509aJ9n6WNfikliQqfcT/zQuWbz5uFjzfV
         S00s1C7j4vZLN962DkZSiW4Erwj4t4/twZVDCBR5aWVWr0OF93eGvWdHkWptpG6epFNH
         mjMB78Q44BNgGJ7LjpNLsvaOB8eyrvM2YMGQk7V0fbumYIJ666fy9Fiik4uVGEv5PvC1
         aBNkLKyZASWlNxoEy4vU+QBvRFsviUf67oygzHknmJ2mhxjswP9dVI/fBG1wmXGaBuPr
         mv9WKRyJyUlR++4tZDqDld0U/XsqGKe96uBSz9oKj0Y0O9yjaHOVYdEq3dKuYzr/fhmD
         J+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOCBNMFhsUwuaWySwxiGRZhWupa8CafL3k0FP31MP/Q=;
        b=MyJ3n8P5ja7D61s1Zua9L9wd4odb3qkUJDidQDLEfGWPICwX/KPl6E7wFx3xpztTH3
         olGIv4gSMfNniin0YNPUx8vvnYgGGJpE2GdqbzseUrtqwmcCtokoGmrqUETmvJC2yHo6
         Ee4FZ47Q/XCtgHU0s+ZXkNNAghR6l/jDDeMP/vU2WoO2QYsf6dUn74LjE99s0I4mfSz5
         HGKqLOIHZNipUj+Q/ZE7ad4qQyaDGdxVw3r65bthlVTG1W4zF94Qh9gElPbs7YV6YT4r
         E/H38cZcF6q7XRUPshK8gpTUhDb8qW9Q9MFba1gSAay7o8ja9eDmfYzNiH6NdhnL5oWG
         UEEw==
X-Gm-Message-State: APjAAAX2OizdUnzEnjBrnjMe3gLKHZAbmFjJWguj0oOSPliORMo6w6qV
        VR1eV8BP6ziccXaBKBK97xiINo8onWUKuy9sPs+PcQ==
X-Google-Smtp-Source: APXvYqxGLbN1RIPFksaMgjLVXnRobxv32AuLFuk74an6GGmU02IXj731v3vVwQHrAHz7MkHmxSbqCpHm+AYCQkYMSTA=
X-Received: by 2002:a2e:8e35:: with SMTP id r21mr7711485ljk.36.1571881257797;
 Wed, 23 Oct 2019 18:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <2e3d8287d05ce2d642c0445fbef6f1960124c557.1571828539.git.baolin.wang@linaro.org>
 <CAK8P3a0i_xvSzeRxfT-5LLpaAfGx3USsuXX1dv1x6Bg87jeopg@mail.gmail.com>
In-Reply-To: <CAK8P3a0i_xvSzeRxfT-5LLpaAfGx3USsuXX1dv1x6Bg87jeopg@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 24 Oct 2019 09:40:45 +0800
Message-ID: <CAMz4kuLOWq7TT-iho5URZXbN_pGc9uEW8TH+WJ2YGat16a1yiQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update the Spreadtrum SoC maintainer
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>, baolin.wang7@gmail.com,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 at 20:17, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Oct 23, 2019 at 1:06 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > +F:     drivers/power/reset/sc27xx-poweroff.c
> > +F:     drivers/leds/leds-sc27xx-bltc.c
> > +F:     drivers/input/misc/sc27xx-vibra.c
> > +F:     drivers/power/supply/sc27xx_fuel_gauge.c
> > +F:     drivers/power/supply/sc2731_charger.c
> > +F:     drivers/rtc/rtc-sc27xx.c
> > +F:     drivers/regulator/sc2731-regulator.c
> > +F:     drivers/nvmem/sc27xx-efuse.c
> > +F:     drivers/iio/adc/sc27xx_adc.c
> >  N:     sprd
>
> Maybe add a regex pattern for "sc27xx" instead of listing each file
> individually?
> That would simplify it when files move around or you add more drivers that
> follow the same naming.

Sure, will do. Thanks.

-- 
Baolin Wang
Best Regards
