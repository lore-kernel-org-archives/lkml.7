Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A1AC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A8E224FE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="zDPsmRIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfI3Ug5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:36:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43228 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbfI3Ug5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:36:57 -0400
Received: by mail-io1-f65.google.com with SMTP id v2so41811504iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 13:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUaOjIAAKAGaG+nfGl63t9Ipyj1FhR6XnUA53rZZ53s=;
        b=zDPsmRIwr8UIFX7VPiwHVeFhbT9W6MjyM0cDosaTz6Rj3zolIxdtsVVOrY9z7FM7XG
         uAU1mKI9zyzUMMFkGYEdYKvs95ONx+ggQ3z4YWqT57peTmyX6l5T0UAPu64/Ap15zr5L
         RA79HvMK4wUKRBh7sh0vJFG9xuDD0oBULcut5P/nId/bamWyDBfHP5/BaMkAPmcWsbrK
         +punAMByTro8mAK6qQVtmf/sNn61rZ89cXtgTkj8atxCDXheMXds+FSHGJQZYl93Tnu5
         GSMApqoi55lWrKNOCG5yhIXhbnj3Owa/bd5XjwGPVK33WbZP59K1UlWpDncsZUyRoWoB
         gNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUaOjIAAKAGaG+nfGl63t9Ipyj1FhR6XnUA53rZZ53s=;
        b=l6RDXjp5kl/YSiS13z9pon7vU87xuca9Kyu2mXxi1EufluGX38AN5rqMPbJV5xDoVL
         CTtaljGuEONnLvBc+mVgJhrOYReYWVL7F6MzZXjziR6DEbqefgCpm5KUOy3P7a9WLLcY
         oPR0aaU8g03aX6pN/zM3LNF+HhdaE9JfPhbv1ZW+1oob+eqDXXRNcaJzFaU5yZU9gg8p
         aIHjQOOy0pOc7qiR3hzsgVx6JXCOyXwQCeQU2Q/Evdw4vBlz5KxO1OQ/XITA15QSXf0o
         he/q8yF7c16LIF2h2PhAyj6Jt4CKCHW4HezE5c0vl4jt8P6+jp4M6l8VQBtEOUcY5lEb
         SvGQ==
X-Gm-Message-State: APjAAAW/BOyKuKx5cAqWHEOUh0FSkOCOfdscd/xxW/fITHoKUFDwodoH
        TcTadqDN+N00qQRlpDlnqbvFE/hHOfIoQBeetxLL2sMUUmg=
X-Google-Smtp-Source: APXvYqx2QQxA7WYK1gg5Log0L74tzLz+6chp+ZbkA5mlSoinDE3QaD6dO1s0HBeusM7BqhVSnDyqgXQvtPF3K4YXyUw=
X-Received: by 2002:a92:4799:: with SMTP id e25mr22486585ilk.72.1569869194482;
 Mon, 30 Sep 2019 11:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190920075946.13282-1-j-keerthy@ti.com> <20190920075946.13282-5-j-keerthy@ti.com>
 <20190930134856.umdoeq7k6ukmajij@willie-the-truck>
In-Reply-To: <20190930134856.umdoeq7k6ukmajij@willie-the-truck>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 30 Sep 2019 11:46:23 -0700
Message-ID: <CAOesGMgs7rKOVnimDwSpeGTAf93Er+Ymzy9-R-mKkQK6MQcF3Q@mail.gmail.com>
Subject: Re: [PATCH v2 linux-next 4/4] arm64: configs: defconfig: Change
 CONFIG_REMOTEPROC from m to y
To:     Will Deacon <will@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>,
        hch@lst.de, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 6:49 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Sep 20, 2019 at 01:29:46PM +0530, Keerthy wrote:
> > Commit 6334150e9a36 ("remoteproc: don't allow modular build")
> > changes CONFIG_REMOTEPROC to a boolean from a tristate config
> > option which inhibits all defconfigs marking CONFIG_REMOTEPROC as
> > a module in compiling the remoteproc and dependent config options.
> >
> > So fix the defconfig to have CONFIG_REMOTEPROC built in.
> >
> > Fixes: 6334150e9a36 ("remoteproc: don't allow modular build")
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > ---
> >  arch/arm64/configs/defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 8e05c39eab08..c9a867ac32d4 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -723,7 +723,7 @@ CONFIG_TEGRA_IOMMU_SMMU=y
> >  CONFIG_ARM_SMMU=y
> >  CONFIG_ARM_SMMU_V3=y
> >  CONFIG_QCOM_IOMMU=y
> > -CONFIG_REMOTEPROC=m
> > +CONFIG_REMOTEPROC=y
> >  CONFIG_QCOM_Q6V5_MSS=m
> >  CONFIG_QCOM_Q6V5_PAS=m
> >  CONFIG_QCOM_SYSMON=m
>
> Acked-by: Will Deacon <will@kernel.org>
>
> This fixes the following annoying warning from "make defconfig" on arm64:
>
>   arch/arm64/configs/defconfig:726:warning: symbol value 'm' invalid for REMOTEPROC
>
> I'm assuming the fix will go via arm-soc, but I can take it otherwise
> (please just let me know).

Thanks, I'll pick this up, but I'll squash the 4 one-line changes into
one commit instead of separate patches.


-Olof
