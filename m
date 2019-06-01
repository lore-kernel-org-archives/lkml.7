Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8105C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E78027747
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdXIboJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfFARWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 13:22:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45354 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfFARWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 13:22:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so3389961lfm.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yD3/2nMu40iWkCJApa1un3cbczzFbKdO9B0J2VVf/BQ=;
        b=fdXIboJGEs9ESGymq78yu8qUEGAMvfm1YFl7lJvcJq74hnBGstgi3nh1Ht7YV0Ckm4
         XZ8/FKCIUqFbF3v+mtlW8LWp3BuPT8bjmcahkROSYSZ+unuhb8849YDQDon13YS/gZfp
         uqWhz3jP9iZ+94jHeB0wTBPQfgfM6Pu0642rIFbomK/rrAllD8V5JoaaDMLqZQR/p5uT
         +XXXicxvkrcPkwk79q4OPIxeqDLvbxQrMBWbUjjiOHV7zOwrgtn0YYyGP5/11yMmrN3N
         bKZby/3X/rUyhnTaBnkGhFORTADk5zbD/ISe7q3l0wAQJGUCu8b5HZys81i0NHgpcqJB
         l7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yD3/2nMu40iWkCJApa1un3cbczzFbKdO9B0J2VVf/BQ=;
        b=lKAVR8tdJO27wf6x87YHaYAyXgCbS60nJ9R29T3wmUaZw1pYlP6YSW9F4fOKj8ysWM
         Wh0K9sbTBwAs5R+Ld0MO8o+eAqFksFkNknR8dum5jopIz4eU4M5/6shnChDiiSN/E+ZA
         n6lYnRQOkM+nDERPhx7M6lZkQyNzRqilwrbTCu0U3N8Sto8Y7a2U/PMdSZGAODQ14aHn
         NiCXHA2FNBI+B8y02UtO2J+1srNWr38+Jsnm73M0bpx8eXUyxtOY4+JdL514enq5YzxG
         EIZPx6i8Fq0HPfxTc5mtBLxd1KLYmrFsIyEbqfc+Dlobv2o2H4BQgCGOYcWEoaFv1H5c
         BNtw==
X-Gm-Message-State: APjAAAXOaCGICuqkvUmadxqN976CmSES3Ytd1WF6JMe16m2BG7H0NVhL
        yftwSLTub2PRu0aely/NElx/uE3YkSz/jZi8eYj2fA==
X-Google-Smtp-Source: APXvYqw55gN5VS0X6O9i9hhjw+uvDGiRLwxkuM3dwGJ0LgEBcvGtcO3QnqZCk2Lc0KpmVCUEwbZz3DIJZLpEdAK2dJQ=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr7439447lfu.141.1559409763924;
 Sat, 01 Jun 2019 10:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <1558007594-14824-1-git-send-email-kyarlagadda@nvidia.com> <1558007594-14824-2-git-send-email-kyarlagadda@nvidia.com>
In-Reply-To: <1558007594-14824-2-git-send-email-kyarlagadda@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 Jun 2019 19:22:32 +0200
Message-ID: <CACRpkdb9swUxO9GBvZQMVu0t0-77Pr9W5RivuiVhgrM1eBGtdA@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] pinctrl: tegra: Support 32 bit register access
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>, vidyas@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 1:53 PM Krishna Yarlagadda
<kyarlagadda@nvidia.com> wrote:

> Tegra194 chip has 32 bit pinctrl registers. Existing register defines in
> header are only 16 bit.
> Modified common pinctrl-tegra driver to support 32 bit registers of
> Tegra 194 and later chips.
>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>

Patch applied.

Yours,
Linus Walleij
