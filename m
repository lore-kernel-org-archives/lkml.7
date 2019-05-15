Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106FFC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D555D20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L44WaYKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbfEOLx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:53:56 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37617 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731120AbfEOLxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:53:53 -0400
Received: by mail-vk1-f195.google.com with SMTP id o187so674594vkg.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 04:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqTiQWMIUKTMvV3HGe2FXr2QXLkNPTKOj2lPv0DODS0=;
        b=L44WaYKFencKFL0aLRS4NaNaiepcTeSneyqE/eagATEjv28G/XY8rdrsINJYIQTZ92
         +PAtHPEVh8jR6qiTWKFFfSP1YkX7lU1GpVic60govDCk0GD9r4cJ91O5J6R1ASoGkJiU
         pwD0pXq8TRFRlQS5+wFTsIeGJMUFygr0Z/efTjq8sjfpv/HlMMDxuYSkqsFMm5CRpwm1
         HLqUJbTGo7MXb67aLZ0NYqUVwWM/iGnfiWnM954ZKFJk9wjWdFEtfhfXNzRPB2YT4cX3
         77AwPyaxeHAs+IgiexzVRguxuEPOP+ojlb2p4XdTHLUFutHRjAJsb04tpSMsrNmvvuQP
         EpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqTiQWMIUKTMvV3HGe2FXr2QXLkNPTKOj2lPv0DODS0=;
        b=QVe4XGQfiv/yidd/Ndx/QOC6ePbY5vlpgSYtsn5L5+ghmYk6i83IwS/tlBjqdmmpqC
         MkqHrQKrEYzLGOWWAfcjSN0/cwy3KRcTcRiIx7XAXbz0FSRFyKGZK+I6RnmylpqbErfq
         rwug7JAIAdFw6VfBQ6iVZNKHAt1C+FpXTxCOTnfJwYtKj/393iW2uQa5txuqIfb1vaID
         tV0jr+9Y+bOKcQk6qfquXWYozRWxHnoZ1E0vrSS3K0vicwE7nwYyh1CAwIi6R9zHpFTR
         rAB4ra0R+/qPi8Y4lImchxW3MZ8TS2WjC7Xf44LcA8iINJ4UGceNvEEfGCywbDoVTYYm
         RBMA==
X-Gm-Message-State: APjAAAX9ra9pR4PiSBPLguoKNH1/g8j/YhCoYKotLQ6kQF7fvn+PI/Jp
        gFhfDLhJqCsIvWU09Z8FfFmRG/W724578g6wqGUPtg==
X-Google-Smtp-Source: APXvYqxLLXp4CbKZ5K2cHxrvSLCedDsciD24l4vc3t7NCOi6h5PckPFbTpLuj6YsLGx3RyREW/4BoB33n9It563S1oQ=
X-Received: by 2002:a1f:6e4d:: with SMTP id j74mr888394vkc.36.1557921232169;
 Wed, 15 May 2019 04:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190509172427.17835-1-scott.branden@broadcom.com>
In-Reply-To: <20190509172427.17835-1-scott.branden@broadcom.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 May 2019 13:53:16 +0200
Message-ID: <CAPDyKFrmTEkknnmU22xuKaoG1=SbU2MfQANPmtV0wcF1xKaguA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: sdhci-iproc: fixes for HS50 data hold time
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 at 19:24, Scott Branden <scott.branden@broadcom.com> wrote:
>
> This patch series fixes data hold timing issues for various sdhci-iproc
> ip blocks that do not meet the HS50 data hold time.  NO_HISPD bit is set
> in quirks.
>
> Changes from v2:
>  - Added info to commit message as to stable tag selection decision
>    as per Adrian Hunter
>
> Changes from v1:
>  - Change fixes tag to Cc: stable@vger.kernel.org to specify version
>    to backport to
>
> Trac Hoang (2):
>   mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time
>     problem
>   mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem
>
>  drivers/mmc/host/sdhci-iproc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> --
> 2.17.1
>

Applied for fixes, thanks!

Kind regards
Uffe
