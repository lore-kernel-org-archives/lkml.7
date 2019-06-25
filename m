Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA33C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C269021655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="lmRjWvzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfFYNDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:03:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36067 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbfFYNDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:03:37 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so1255074ioh.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AaAux+mpjiFWEqJlAiGOu1BVPLgrTOOP018VAUoSN3o=;
        b=lmRjWvzcBFajWRoBK3znbG6i3978d6nBbrRGi3suA6cnsxIj5JI2hVj20FLTyh+0yt
         zV7i5MYXlc52IXaOeYNjzP8Km02CfCbdrpobiwqLnmNIoJC484FCh1NAiy9uJzZ2p/ak
         mMguigzQ63Q61fPmyPDQzSrl6/Lar+u1ARJamNP1zlq85bKWUns0qMJT7D9GKH4/ZlQT
         MhwVKWJ4ICSk3sn5QpF8a4LT8tnmv8P23HsxXWL/TyRkmjtwMKIuQpXXavC4cWN0plke
         Vsdh3Ar8TJ70vtpE0ohBaHT9Xa2HP7pLyJMMHPfKOWuHJNMvCFUGK8z9SL/OONjvSnzz
         TTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaAux+mpjiFWEqJlAiGOu1BVPLgrTOOP018VAUoSN3o=;
        b=XCclaE+8MQYgk+MrJgOiIgjiRVMMF0EN7/OB7QXAZA3HXuEy3Wepooqp8VUU8eAOeq
         /I/epKgm6W54WEsAr5/TB9kvigtLxa909YiwiIqxgyGfOTO8o58UFEhVElHu8nUSqxpW
         RVVlwa1Br/hUv3BH7OBpEsb98ZXUAUwfRPHQnJ7HujiPHEwh2m4zAQKv0fo9QKuiCK3m
         V3quC3HrIFGPxZHtQAO4c+X6EIs0ASH2zCGmy8PL0TGYgjFvlv7WY4BmY9sP6TTJaiVf
         bSPRyQhqJRiTv7AtMkRFdcXMOgH+JceXtSFDPdiKygfwJNSh5VfL+KNDtzLITKyyNsBV
         /EvA==
X-Gm-Message-State: APjAAAWV/qBOoP48z2NbL2J1XIkkx6iLB7JgWYeFvyaaIrEtH1R/tvwD
        i0j1mB7Zq/7dat+FsSxBcCIMAnB6J2m+3FndHgoQ1w==
X-Google-Smtp-Source: APXvYqy4zCAKoPaPG2k29F7XqifxmNDOdW2j4TDAW8nqSYe5f3mVIHS3sMFRvz8ca5dxqSPtvcR/IL7ykacX2H/I+K4=
X-Received: by 2002:a02:54c1:: with SMTP id t184mr10221497jaa.10.1561467816781;
 Tue, 25 Jun 2019 06:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <b89ef8f0-d102-7f78-f373-cbcc7faddee3@hisilicon.com> <20190625112148.ckj7sgdgvyeel7vy@localhost>
In-Reply-To: <20190625112148.ckj7sgdgvyeel7vy@localhost>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 25 Jun 2019 15:03:25 +0200
Message-ID: <CAOesGMj+aNkOT1YVHTSBLkOfEujk7uer3R1AmE-sa1TwCijbBg@mail.gmail.com>
Subject: Re: [GIT PULL] Hisilicon fixes for v5.2
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     ARM-SoC Maintainers <arm@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Linuxarm <linuxarm@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        jinying@hisilicon.com, huangdaode <huangdaode@hisilicon.com>,
        Tangkunshan <tangkunshan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 25, 2019 at 2:04 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Tue, Jun 25, 2019 at 11:23:21AM +0100, Wei Xu wrote:
> > Hi ARM-SoC team,
> >
> > Please consider to pull the following changes.
> > Thanks!
> >
> > Best Regards,
> > Wei
> >
> > ---
> >
> > The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> >
> >   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/hisilicon/linux-hisi.git tags/hisi-fixes-for-5.2
> >
> > for you to fetch changes up to 07c811af1c00d7b4212eac86900b023b6405a954:
> >
> >   lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration (2019-06-25 09:40:42 +0100)
> >
> > ----------------------------------------------------------------
> > Hisilicon fixes for v5.2-rc
> >
> > - fixed RCU usage in logical PIO
> > - Added a function to unregister a logical PIO range in logical PIO
> >   to support the fixes in the hisi-lpc driver
> > - fixed and optimized hisi-lpc driver to avoid potential use-after-free
> >   and driver unbind crash
>
> Merged to fixes, thanks.


This broke arm64 allmodconfig:

       arm64.allmodconfig:
drivers/bus/hisi_lpc.c:656:3: error: implicit declaration of function
'hisi_lpc_acpi_remove'; did you mean 'hisi_lpc_acpi_probe'?
[-Werror=implicit-function-declaration]



Please build and test your branches before you send pull requests, Wei.

I've dropped the branch again; please re-submit when fixed. I think
it's probably 5.3 material now.


-Olof
