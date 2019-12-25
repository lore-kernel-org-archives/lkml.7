Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570F4C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 03:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1649F2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 03:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577242962;
	bh=TmX6g8ShDdQRr0f01ZX9dg2x7Z+X3Sh/DiayNwiGtK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fg7Ix5pJegfYQbnSMslz7P9xc+WSblowAefPHi1lEludqOKKuO25YoD01bubpzWCp
	 dcLxX+gBeMlEI6kgrAJg5PJidyY3MsekvyfWVAjsc/bI3bt/9ZVcl+/Nb87Muh05TE
	 dN2kSEMy3VctmrKu+5pZJqnyq/aInlAXP30IdxFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLYDCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 22:02:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfLYDCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 22:02:40 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D0AD2053B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 03:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577242960;
        bh=TmX6g8ShDdQRr0f01ZX9dg2x7Z+X3Sh/DiayNwiGtK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xirEjZHyFUs73Sf8Wkt63+Q6xEwi2tRuAYmiryq6ZcURBSZX1/XT1yukjYReC1Eo9
         pCAF+E2WU+zDtDWTgo9nuJhKVvI9URHyrQBP+a3mVZIMfXGTe2sVbtJwm4U8FBiGjl
         ASUPbDGumfhcCctSl0dFOO4dE8TgjDWCHvoSCV9s=
Received: by mail-wm1-f49.google.com with SMTP id t14so3624388wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 19:02:40 -0800 (PST)
X-Gm-Message-State: APjAAAXVaf5vbOUlyhfxx2WY16Rpok8D1EmuBWjPfYFiAyem/U8G+Qil
        5MigqDRCMJ9SEMrGE7pHdD+nMhzCO6CogliqdCw=
X-Google-Smtp-Source: APXvYqxiUBJp0ZgqJ7mIBfvqEQUSXXh4FQA2JBOW1lsIiDEPzF9WNsmvrbwAnTF/RjSk5AUT80qYpMeE31ykN8KQaTA=
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr6738854wmh.94.1577242958681;
 Tue, 24 Dec 2019 19:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20191225025908.25305-1-kever.yang@rock-chips.com>
In-Reply-To: <20191225025908.25305-1-kever.yang@rock-chips.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Wed, 25 Dec 2019 11:02:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v675A0fG9wHiJj_pkVQBmBFDf_u1L_dxiD9pT_8VBjujzw@mail.gmail.com>
Message-ID: <CAGb2v675A0fG9wHiJj_pkVQBmBFDf_u1L_dxiD9pT_8VBjujzw@mail.gmail.com>
Subject: Re: [PATCH] Revert "rockchip: make sure timer7 is enabled on rk3288 platforms"
To:     Kever Yang <kever.yang@rock-chips.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 25, 2019 at 10:59 AM Kever Yang <kever.yang@rock-chips.com> wrote:
>
> This reverts commit 2a9fe3ca84afff6259820c4f62e579f41476becc.
> All the U-Boot version for rk3288 including mainline, rockchip
> legacy/next-dev, have init the timer7, so no need to init it in kernel
> again.

What about the ChromeOS bootloader?

> One more reason is that if  we enable the trust for rk3288, then timer7 is
> not able to be accessed in kernel.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
