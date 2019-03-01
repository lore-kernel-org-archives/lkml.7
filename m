Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D3FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF962084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDOKuiSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbfCANaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:30:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40074 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfCANaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:30:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id w6so20372243ljd.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 05:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/XJDPgZr92xbE7yFFhPob5maKvzEO0Ch9NxM0VD/tA=;
        b=DDOKuiSAybrLJ9HTTyxnqDUYKXjm/K4uQyuMsw6fxtSlsimcQPnh5ydyQ3xHrqNBtj
         Myl/3Ef6pxTs3apyhr0wqKC1c97E93vv1JJ1SvB5LnW2ph+Tyc6uw6+231N51HjXY7/8
         FuJbDswOwSPQo/JCFei/uxNAwLpXvrdQJQehhNcL6KzEzP/6OZcxpMsxQ6CXg6I5PHNa
         PUdyPg0Oe3Khbdo68+M7g7W5M75WXSDzighDnyuCURZwjo/QpQHbgb8vcy34GCcLVO9v
         sgnh76Y8n9Pav3vNyMPBSoAVX7yoV77yW3TjE6PdjBn/ORpP8c5UiUIL/9ceMgW1UYSf
         KFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/XJDPgZr92xbE7yFFhPob5maKvzEO0Ch9NxM0VD/tA=;
        b=HVpJfaNgMw1V5YqAKhKz7oaspGQAC92ykrSV3VExXY50I7cVLKoTqYnabk412CsNoZ
         fQ2v5WQoPWkqmVHCCZI57LuC0DERSC4Q4TvIg0jhlsX10xgHCwEFY8fEtX3zGgyy2S63
         N1X/JSCODpVMy5FXZ84KjYexUk28UJCUTgy3E7ilN0x2Vc3pmaqibsIwMJvDjaHS/JQ3
         7alRgjZozQ5rlhBHlWGcQ6+UuhAkd14GEvR2MlRnQy1B7zCJSOtz+jfiIUqevg7sjMkQ
         LJf1Aab7EsOgwy1X4nChcNu2FK9EQK71FlNNINu6TnUymoE0grQSrtPHGmZ5MjMGF7I9
         ggsA==
X-Gm-Message-State: APjAAAVRgj7nkE+z3vOldJaCq4L80j0Fv2XCvhxCGbFKu88H0AcVf2qM
        5+SnbfKkKxfzWI0LJD7HPRC7a8FZCa3lkM7Lbz/ZQA==
X-Google-Smtp-Source: APXvYqzQBL4m/JhwTqQVZZDw5PN823UelfkF5SqwestEOA1FGFQe7QDjXsZTb/laUfbMj1HJu1EZEe6HumI04LW7sZU=
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr2839458ljc.97.1551447019150;
 Fri, 01 Mar 2019 05:30:19 -0800 (PST)
MIME-Version: 1.0
References: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn> <1551430616-42014-11-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1551430616-42014-11-git-send-email-wen.yang99@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Mar 2019 14:30:07 +0100
Message-ID: <CACRpkdbRfagzAr6zRBtEJ0Z2fvLhiMsy8CPsuiFswf0NjzvCRw@mail.gmail.com>
Subject: Re: [PATCH 11/15] ARM: versatile: fix a leaked reference by
 addingmissing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        avifishman70@gmail.com, Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Xu Wei <xuwei5@hisilicon.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>, wang.yi59@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 9:57 AM Wen Yang <wen.yang99@zte.com.cn> wrote:

> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-versatile/versatile_dt.c:315:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 302, but without a corresponding object release within this function.
> ./arch/arm/mach-versatile/versatile_dt.c:320:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 302, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Patch applied. Will send upstream next kernel cycle or so.

Yours,
Linus Walleij
