Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7972BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A0220883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+f6N01w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDHMK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:10:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40260 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfDHMK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:10:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so11005555ljq.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6EXHZyfcUgwoJekW9Rx00B3qsHIPo//6ifXS/WXfEXU=;
        b=q+f6N01wGhOLW1LMDGyb2g8uymGzOjiv0UPQNfMAuhCNtnP4Y1W4822KmJktDWDxig
         2xeRwQ4y2xbb/RG5lZjgBB+c7l87URe+t0dxMJXQN0H1IuUYbb7tAf+i+fx1RcivKb3B
         rYnRa6+mLmHcNa2WaxFkubU5LfPl/pH1EYnLgpj4bE5snNcrKqi+XUi+rx/JQF+fto70
         /DrTpETYIXsBMXBqzGgAM/WlSacNUe5F7SxdpXEsB63NNZnALpu7DC9W+2B34x8vc8wY
         HALVulgDf4Mll1BhSYPYLYsHzFFKiYs1uvDoC8/oVbQw/GiR47nZRv/XpEmZxPgrbKs1
         97IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6EXHZyfcUgwoJekW9Rx00B3qsHIPo//6ifXS/WXfEXU=;
        b=XFADdWARq4OJbVMrKqgzlhydQ/xuOVQTJdMMVYBDUWpMDIaLAVioRMzGWtK/4awAYh
         F93V+ZcZv8bwLg3yEpJ0iLQ6e5Jmu4WpWgpTM64LQZecLp68bme4lEXrndpnwiqW40sH
         26yxotX555yRROjxOgFc2dLGM1dXNo0LURcLQJmzHC47tnAFWMyoUkoEkaOFt1BQNQ0j
         vJEKsDzYJqr5uahEm5N+Gid2d+cjMV/j0tiZHv91uUwHXI7o3GTTGh2zgrNFic0fr4jM
         /Ar92C1KH1wQmrbE6Lj/IGIBGaBl0JIYUOLBVihBFYWx7HI5W+KKiSmoWJlCS0K0gYr0
         3Pfw==
X-Gm-Message-State: APjAAAUXlY70FcIt8Xeuwbv3nO2UbBM/jEnW1C6Mc6eku5QqkwFknCRA
        z9FYWsUaztJAy8+49+LBm+bFxxBKQirMpNCBZsiWzw==
X-Google-Smtp-Source: APXvYqznUDGF3kOuCqUQ9c66RYhp5LsQ1GJ1Tk720gTRvYRTb55+NaE0IDBIRSFfwdzTkMJE09eUKaCHuNGBAYsdqMw=
X-Received: by 2002:a2e:9d12:: with SMTP id t18mr15527930lji.163.1554725426679;
 Mon, 08 Apr 2019 05:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190313142040.26694-1-cquast@hanoverdisplays.com> <20190403084341.GA4636@X250>
In-Reply-To: <20190403084341.GA4636@X250>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 14:10:14 +0200
Message-ID: <CACRpkdbfSp0xANWU9Jc0=qrFUN9fJntADxH1J4jZpP=e0NbXaQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: imx7d: Fix PAD_CTL_DSE_X*
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     VI1PR04MB42227AA158BA1FCBF314AA27807B0@vi1pr04mb4222.eurprd04.prod.outlook.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christina Quast <cquast@hanoverdisplays.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 10:43 AM Shawn Guo <shawnguo@kernel.org> wrote:

> I assume this will go via your tree.  Let me know if you think
> differently.

OK I applied it, if you're not merging any device trees using
these defines this cycle it's fine I suppose.

Yours,
Linus Walleij
