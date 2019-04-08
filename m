Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05760C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C528921473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yN0X4Uin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfDHMI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:08:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46401 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfDHMI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:08:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so10960020ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3lArc2n9tzWucn1nLjpFa+ISpKY+1Yj+dyKF8hBOx9s=;
        b=yN0X4Uina7MNY2edTgfIEtLJR33qIeGrHh7QunafOLJ1HUpiEkTDzbVBpERkgGJ4F5
         FP3b45kgUwIMQs63HPwaMsrA9LkB/PNftgXXupNWDO4BdLWuMpwAlZE6talWajmck0tV
         ByVanSg5lm695axVfWaMJVpAkCMZGLt0zNrpkgeKI7CAH5e16HUGH1WzaoUfyNhQXxj8
         NC5AEjjj0Omw+LZcrrPBtMPrIoH18jqAZ8Op7agQfyOKKmos3QYwacUOk47JjfxmPPtj
         yDVVoG16Vl7UWFKN3l0YXZiRpyg3zjh0S5ec03WfDlQ0W00bvJUYfpV0mbcEir/hQ8nh
         b/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lArc2n9tzWucn1nLjpFa+ISpKY+1Yj+dyKF8hBOx9s=;
        b=F9Pg9lZkoN5hjIYPb9OaYZSm3qkmKNSd3fKeFZ2TLGoStm/f09eO2AMku2jviWvKtE
         /tsPWpcymAUuPl48XNXU5yiaprKRxjm8iO9Y1zqgXnLL8q1xtO5+Hj8QYY/c2pmjyXqe
         +aPrUMxSTfQCWJZi60HvSRFy009WxfzfIW9Myk8fNLiJ2hSy5V/+wxktUr4XlQODRUqP
         VULlMkfppkIp8A8FbGpOpgn1RYvXt9LcR7c7XiPMw2oz2zfgyWvgcCSw1PKiNsf6wolk
         kOh70bqHuxnf7Dha72qoYBUYRHqoAwnaIxkhEpCSpjWSrpVrY8Hs3jH/QnvaErz6GYTe
         KFVA==
X-Gm-Message-State: APjAAAXADj/i2KVOw+d6l/8ch31vKMRTO9Fy3c2LfV5eXrcXvawrOfyx
        OtismxEi0DWueclAt9orbR7DfR6yHIjUogDYhycCcw==
X-Google-Smtp-Source: APXvYqwwrkzLNLsjheg5tYQt9GrUlrmKvR4Wd1BVaiGu2bG+ePPMhmJePOpCOuA8UdnWlSS3st0UboCVwTX/6K6qHxA=
X-Received: by 2002:a2e:9a46:: with SMTP id k6mr15487200ljj.119.1554725335288;
 Mon, 08 Apr 2019 05:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190313142040.26694-1-cquast@hanoverdisplays.com>
In-Reply-To: <20190313142040.26694-1-cquast@hanoverdisplays.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 14:08:43 +0200
Message-ID: <CACRpkdYqJxeFLJw+eG4YoA-MPrYFSwxkgPuq-3AAXiVRaiUsQg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: imx7d: Fix PAD_CTL_DSE_X*
To:     VI1PR04MB42227AA158BA1FCBF314AA27807B0@vi1pr04mb4222.eurprd04.prod.outlook.com
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
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

On Wed, Mar 13, 2019 at 3:20 PM Christina Quast
<cquast@hanoverdisplays.com> wrote:

> In the iMX7d datasheet, the PAD_CTL_DSE_X* values are different from
> the documentation.
>
> Changes since v2:
> * Changed patch title to 'dt-bindings: pinctrl: imx7d:'
>
> Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>

Patch applied with the ACKs.

Yours,
Linus Walleij
