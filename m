Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6188C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37F027752
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srpi2hBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFAR0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 13:26:30 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37504 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfFAR03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 13:26:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id m15so10426305lfh.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHptL7zfnF1m2FdPFd/6eUaxLNWNAM6Dt9dgYrixSuY=;
        b=srpi2hByezotfENbCGCrv66us8KaJ0u5/OqAcyBrE8JY3f6mzgbaNyXt89Qk5LxC2x
         T6Ga3UJnGO59zM8eJnwagM+ps6GSFmwWvaJ13ddUMZMeMR38asYpJpSlQ55B7to2hdYo
         +ucWGoRE7IVaSa3DnQQ1dmeBpFb4UE04Z2+cJC6l3Rai4Xrk3WW6CkHZM6LKg/0w05Ph
         EMmv7g1BM25I2scEK8ENa3b0ekGqHp3g+w3PunUQocOsC26KC51o3Rj7J5CHkDrYDkD5
         JItRaQrsS08gZH+kRGoQAMtNPjxWqoPz4qFaWqoNdEPTnzUczks2ViGb1iW7t1ILRnZV
         lneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHptL7zfnF1m2FdPFd/6eUaxLNWNAM6Dt9dgYrixSuY=;
        b=q5Uc9C810FaZ2EwTWkjdkKVCMtXZpFnKcqKtxUIW5ZTzDfIRpF1bP5OBc6QplAYxXi
         hLQ83p+v2339GO2dIGA4+hqijnraUhJGVFSBoxorgcsmYywuLAjJYwZcwhov4sY7AZRc
         ybwZWG3VOIsWzSd8yzZ6Kak1OFPbABOC1pTwk0ZfNhYL2DmVG2yeiMRSF3uZMqhyPmEB
         ehBWrzY+6wpR5RkbcseZ+8zq6BIzdyMKn7X4bgVcSA3fA+VACjUxXf6tMdplTKshCxH8
         upFKfZRAZsWUV0V6rV8bT7fsgK0Dx4CX7JV3DOkjt05Nm74jcTeAlQtA/VW33HZegT8e
         bXDA==
X-Gm-Message-State: APjAAAXvFJGt/RFDiU1NZoc84x6bDR8zidbbbPEcR6enw6ccs25NSoDI
        Pd1L277y/hbLxwJrzBIvwQnB24GOTjIeNY/I8N4Skw==
X-Google-Smtp-Source: APXvYqxyDcM5T7cPR2O1upgFuOVBtRLY7i9cZ8Wfnrcs3leDvRcsQxnLNvhpVp5c1+nqaJ8cr9vMq8JGhhfgUpW6r74=
X-Received: by 2002:ac2:598d:: with SMTP id w13mr8883951lfn.165.1559409987952;
 Sat, 01 Jun 2019 10:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <1558007594-14824-1-git-send-email-kyarlagadda@nvidia.com> <1558007594-14824-4-git-send-email-kyarlagadda@nvidia.com>
In-Reply-To: <1558007594-14824-4-git-send-email-kyarlagadda@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 Jun 2019 19:26:16 +0200
Message-ID: <CACRpkdYOJydUhSOh7Pn47x0xjYP1HbfNA-2+8O48AA6PnTMNoQ@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] soc/tegra: select pinctrl for Tegra194
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

> Select PINCTRL_TEGRA194 by default for Tegra194 SOC needed
> for dynamically controlling PCIe pins
>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I guess this needs to be applied by the Tegra SoC maintainers and
go upstream through the ARM SoC tree.

If nothing happens and you lose patience, do not hesitate to poke
me back and I might just apply it to the pinctrl tree.

Yours,
Linus Walleij
