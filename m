Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F91C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD662075C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tkDWR58v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfIKJ6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:58:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33846 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfIKJ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:58:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id h2so12873782ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 02:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4dGhcxp6T6gSoKIxWokryHsNaeknVwfT4UnRhjgn/A=;
        b=tkDWR58vwuKS0da2FWu9u/M/Xn/DyAr+ZUrx/+cJp27zqKvp/xBOMk/VGYXwWTSTla
         RUGyo5mKpJkCSH4kikwfH+5eo9+R6rZIayBLRSf+XRHifxKTcmqIQ4gwFxUtB1L1mNNv
         C+y6q8VDxxIv11W0mSPewJcrRxVLCXfhy/zrVENzffiPUZWT19SmmXpXLxeHXmrBsWUW
         Z+acs/RypO6knajkSEc5Qz/wJsF/2ZvG/Tnm6Rf1dhTLkszi/Ebc+DrhWG1iSvuJcAmU
         OvMWljKcMJ9mFuT5LckIuewLzRHNMNjiVhbyaXyBbavOplfSxkteHCHD9wi0oaIvuhN+
         RE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4dGhcxp6T6gSoKIxWokryHsNaeknVwfT4UnRhjgn/A=;
        b=rfSaQls45BITatH8PLMR0MS3uNj3pW5KEjLOSP2mv/8TYCDDoie2LUCAjx3MVWIfZj
         khFcDeMsAzbPlDOFU6QUpj0Wp4dBCRg+kKOGe0HBeK63ang67K8WTPCAs/8WW4wXCXVH
         QyY0Txue03sRWK5Fc21BlVBpPGUT5h/tcicZby9c5vUepPPhYNlWZvaWQQKB+KNF+Qxd
         7HoyAwyjvInFiXwuIGU/co1JyrFo/2uW/Rwn6B0D2dgCaZ/Dj95cYVQQ4UmfoA48/6CJ
         8zxngjpT0NsY/aYMvRZ0RbHE4oUkerBN7NlFYFl1BKVh4OIbOmTdZBBSZ95WU31oH1Ru
         FPHQ==
X-Gm-Message-State: APjAAAWt9+F0DBFd7KOmwwFe3DT2mtLz0s5Kb/21zMxdfvDdCNCCjUu1
        VbJVNG+qp8VHRyZ31/EI+C13Y3Chpow3+SXGKavwVwQfxyVOIQ==
X-Google-Smtp-Source: APXvYqwbLg5jGI86j9e4EMl792llsAjTOPkGlSGFa4C8Xlkdq8JvUyl4zObZNLLqt7Sar4h37ifM08D33QB5mKjQPek=
X-Received: by 2002:a2e:8056:: with SMTP id p22mr17584388ljg.69.1568195890794;
 Wed, 11 Sep 2019 02:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190905140919.29283-1-colin.king@canonical.com>
In-Reply-To: <20190905140919.29283-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 10:57:59 +0100
Message-ID: <CACRpkdbYKjKPAT=V8K_JtP49teq5q9GELkK-vc+mQEdwcU781w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm: remove redundant assignment to pointer log
To:     Colin King <colin.king@canonical.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 3:09 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer log is being initialized with a value that is never read
> and is being re-assigned a little later on. The assignment is
> redundant and hence can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.

Yours,
Linus Walleij
