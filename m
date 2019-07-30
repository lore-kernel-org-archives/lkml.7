Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00191C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA77920659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="SxaVkioT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfG3ORv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:17:51 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38867 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfG3ORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:17:51 -0400
Received: by mail-vs1-f66.google.com with SMTP id k9so43548985vso.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RK299o1I9nQNlsSGV+4buZQzWUsPGHe+LviTSNSniew=;
        b=SxaVkioTG0t2pjLf5OyxRf9JMawK69C8+zJxxRkOddWQ67OVwOAduPXdi5/peQBnKk
         lxi9e/T1J1zIv9jw/oMZp6JAuybJF9n7nnxAPDDqYruh+tZLoXZKJ/Q4A3AT5yM3UpDd
         xwPcHIMWGUZGuT5Psh9H+Jxgn1UEA1p7tgXfDI0/kw+RynaQ8a6IsxMh9b2huMgPjP3o
         mwBg41OPB8I5f2RDxKql10x6ujzkOMge/X4MS/u5FTbnMA54GyC8MC3VQhza3klGnXYI
         k019OGWuAeXXutGGH3OceFAdoSGs9lXpunq0Ya6qlRFlWPZiHKR4GNpyV6lXlQkxRe3o
         NBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RK299o1I9nQNlsSGV+4buZQzWUsPGHe+LviTSNSniew=;
        b=UriARElLx7qHnih3PRnzhqGTsYDeslOirNe3sQuTD92IxVyO+kG7uAJXnqZ+NJMdi0
         Zso4xoSju/vlAGbEw0Zi6DOfdRMgn7uQFukax+37tKIUKEUzysycNH7ZMnWAhAs7wyUa
         3iN467sbynqmtFiqQMkKAt3axy/g/sYfo1Uymj5xaf9ZxBRCfy7Vo7zWGTMly3AkAhsz
         0vQiFZy7fvHAfqb9NZ3wQU9JJsdANuYYc3vO5TkGXVwgXrT6Tl2tumy1Ja1dEgBGHJVR
         pBfMCPM6vq3OXnmEYhPd8LuVon7fL6w7dvB13+8amV1qr8m36FjpIrpRi6pBiLrjuEge
         Oenw==
X-Gm-Message-State: APjAAAVZQirfoJUF37og8aix9nK93MwpquRAwU93xa9vNTv1k+/WMyTY
        hPh6U+bEv/vQhMa/r1fQCPOmJWIEM/fYcwVaNEA=
X-Google-Smtp-Source: APXvYqzOWV7w5UY6HfuniMmOZbt2GqzgJCloyN6OJVs76PDRwHfZfJxx5YKZtGvjUeFd4Nxu5FnCxu0Lhw8PkE14veU=
X-Received: by 2002:a67:e9ca:: with SMTP id q10mr41517640vso.105.1564496270292;
 Tue, 30 Jul 2019 07:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <3601e3ae4357d48b3294f42781d0f19095d1b00e.1564479382.git.joabreu@synopsys.com>
In-Reply-To: <3601e3ae4357d48b3294f42781d0f19095d1b00e.1564479382.git.joabreu@synopsys.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 30 Jul 2019 11:17:39 -0300
Message-ID: <CAAEAJfDU23Q2G+qXW+BubX3FM3MwSGhJ15NrmDuzoM6UFfFLmw@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: Sync RX Buffer upon allocation
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 at 10:57, Jose Abreu <Jose.Abreu@synopsys.com> wrote:
>
> With recent changes that introduced support for Page Pool in stmmac, Jon
> reported that NFS boot was no longer working on an ARM64 based platform
> that had the IP behind an IOMMU.
>
> As Page Pool API does not guarantee DMA syncing because of the use of
> DMA_ATTR_SKIP_CPU_SYNC flag, we have to explicit sync the whole buffer upon
> re-allocation because we are always re-using same pages.
>
> In fact, ARM64 code invalidates the DMA area upon two situations [1]:
>         - sync_single_for_cpu(): Invalidates if direction != DMA_TO_DEVICE
>         - sync_single_for_device(): Invalidates if direction == DMA_FROM_DEVICE
>
> So, as we must invalidate both the current RX buffer and the newly allocated
> buffer we propose this fix.
>
> [1] arch/arm64/mm/cache.S
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 2af6106ae949 ("net: stmmac: Introducing support for Page Pool")
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>

Thanks a lot for the bug hunt and the fix. This fixes NFS mounting
on my RK3288 and RK3399 boards.

Tested-by: Ezequiel Garcia <ezequiel@collabora.com>
