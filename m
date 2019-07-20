Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FB9C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 00:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B35720880
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 00:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1zBRrhsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbfGTAHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 20:07:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42749 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfGTAHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 20:07:03 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so31628430iob.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 17:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsLcrqMAUu4AoH66JxPCMj3rYWjxDVrsa6sAl26Keow=;
        b=1zBRrhsD6b4kEV5d0rGARv+pFRVIq7kjHd6qwcrFrCbayb36xIA9fxsHqe1zH3iIhT
         hRlMYekXOKtCfN7c6ck3opKS5NycMeay+Hm2dssqX1tt54eu5Ik+R4TrZgdcm0izqt2Z
         LM9V56b+/cUJOxSGr7ll+Tom5poJxME3GGq2Zv8PGNDomEtuNMbTOfmzsmQEgKIYtMk7
         OwnblDGQoMl22Qtf+9Pb86xtpbFiwh73fIqasXNX1EO1YReL5BKkrNAz4Ou0wtKvOw30
         lafDN6ukV1LplTTuaYxY62Ul2W5rGJKRu2rkM0etgEowaaWWhEmMWNHJ/6MeUq/VaOjn
         7Tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsLcrqMAUu4AoH66JxPCMj3rYWjxDVrsa6sAl26Keow=;
        b=TgwnZ49yw7ZuoAoHV6yAD4/LYtmgZXqt397tNbxo3OcKgWdKzwmD2+bSmglTmqgH9X
         vDNtx0uPPb09ACUaVMLT0dfojI4ehOlGhrdF2C2q/55WwzJg7z/cOFZ9wznz13NQjRoG
         zzsctFuSOvp2wfck5hTxWtWsLCe6dDJYRRi5WbbmeFY7u2U+l8s9GPxedJwyxvldqStL
         3FdoZUzZ96h8DRwOu31jFcxuk04c8AlkAF9h1YWtq8MtCsHlDJAANW62t3AeK3vxO52z
         6DODDhX6fgtWdVti9eyAqVJtfj3OImMgs/z9CmCSiaakP/h1Tm+OF7Hf9XRWPvE4V1q0
         veow==
X-Gm-Message-State: APjAAAWhOQBkCOrD0KmLdk2a6y6jpRZYjAKhzrY16W0eZrxTpUMvjhVA
        TJ+LrLERkMEY4zo1pJR3iO/YrkQBGrGqQ85avPEcsCasN7A=
X-Google-Smtp-Source: APXvYqwdO98htBh+kZg9SXpHOHDdDKKpp1f6rO+ypEHc/scl3AdWwHpvw/lNhiCk+YJ0BdP+5c8Jr9HmNOpJZD3ycXQ=
X-Received: by 2002:a5d:9642:: with SMTP id d2mr29714178ios.278.1563581223042;
 Fri, 19 Jul 2019 17:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190719235434.13214-1-olof@lixom.net> <20190719235434.13214-3-olof@lixom.net>
In-Reply-To: <20190719235434.13214-3-olof@lixom.net>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 19 Jul 2019 17:06:52 -0700
Message-ID: <CAOesGMjW0fX4QidH2xhQf0nxbhRHWXDFg5KUR6a5AWsucCNyoA@mail.gmail.com>
Subject: Re: [GIT PULL 2/4] ARM: SoC-related driver updates
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        soc@kernel.org, ARM-SoC Maintainers <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 4:54 PM Olof Johansson <olof@lixom.net> wrote:
>
> Various driver updates for platforms and a couple of the small driver
> subsystems we merge through our tree:
>
> - A driver for SCU (system control) on NXP i.MX8QXP
> - Qualcomm Always-on Subsystem messaging driver (AOSS QMP)
> - Qualcomm PM support for MSM8998
> - Support for a newer version of DRAM PHY driver for Broadcom (DPFE)
> - Reset controller support for Bitmain BM1880
> - TI SCI (System Control Interface) support for CPU control on AM654
> processors
> - More TI sysc refactoring and rework

Of course, _after_ I send the pull request, I double-check my due
diligence on new drivers, and notice that "DPAA2_CONSOLE" is "default
y".

We'll get it fixed in one of the post-rc1 fix batches.


-Olof
