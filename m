Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BE2FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E9A205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdEFBc1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393200AbfJPMou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:44:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41957 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfJPMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:44:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id p10so22560818qkg.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4K7B+uLfKEBGyGYLI2L9ifLhMu932uDK9Ftu5vsTLNM=;
        b=TdEFBc1a1GhmOYAW2VtSm1o1gnQZkZwCc844SMM9XvDj5O96l/doIHiYscKqhjxk8c
         uunW6zvZyzSv90+FN0ByJ81MsiIQ+EdX1idYLnIEfIH29ecKHXYSLlWeO0rSBlRw30zJ
         xk43RxIDcXygry3uhKq1xbOt6FK7sHVII7pGy//MlKP4rMGy9xMxxjEdj/9VUV4RZPZx
         Yr/uPni/tyEG2zRjgof177N3oFQ4bX8meJn/QWXrdELUf0J8ypfwOa3ne05f1/BWGGMg
         WgQHfe13moWhf+DxVSs2o4pqtcK49LvS5YhXM0ILQv39atV1VQ088PQtUKIm821tofwL
         yYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4K7B+uLfKEBGyGYLI2L9ifLhMu932uDK9Ftu5vsTLNM=;
        b=haG3WGR3yhO+xyVqvGLO0blwlRUIyOvAXnWf1YkGFh6sDjNSY7BfXWN8WPBCG41hnu
         57IgN/bTLi/YSJpZPPDy9/YzgJqJj8ebZdcvOFUnfHCnVgUwMGiekb1eQoibV861VEFd
         Omn2D8d47HBd9Oy3jJn/MjtaPlZ/031vFwMUDnOMzdea4Wm2J0+bZEnwGYIHFAGnVHmI
         3+9D3qlofC45OP9LI2vUS6p9rfe9w5ZLCXR7W8GZPYi/f30r+v/aQX8NCJz05mao4Jix
         L/wpvsKHChy4jCLkLwZFKsM5hk6VJAyvRElQGXWrTXC4bMXLZuR16HEfWalcZXYiGJjS
         dqWg==
X-Gm-Message-State: APjAAAWbxNGEv9/7VBC/1wwTrsLs7bkDf1Xfv55s8Y6ZpJHcsW/HfBAv
        jdAleBwAblOiCIA8G4KqW094E79FPGahMzE0zTAGaj+2
X-Google-Smtp-Source: APXvYqwTM8BkVjUwYymUoCEI4D83P7/A66wqA+dK+mNJipK7M/FV7PxzP6J1Gjw69MjqnyvjKRuCo11TD2KiTz+ravM=
X-Received: by 2002:a37:bf02:: with SMTP id p2mr41057686qkf.42.1571229889157;
 Wed, 16 Oct 2019 05:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191015091708.7934-1-jay.xu@rock-chips.com> <20191015091708.7934-2-jay.xu@rock-chips.com>
In-Reply-To: <20191015091708.7934-2-jay.xu@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 14:44:37 +0200
Message-ID: <CACRpkda+gVxBHU=UZTqfgasOYKpGJ4QSp07-TH-QrTQ7Urm5DA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: rockchip: add rk3308 SoC support
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:17 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:

> Add rk3308 SoC support to rockchip pinctrl.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>

Patch applied.

Yours,
Linus Walleij
