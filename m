Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3666C46484
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C168A218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyl34Yv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfGDOMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:12:16 -0400
Received: from mail-vk1-f172.google.com ([209.85.221.172]:44394 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfGDOMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:12:16 -0400
Received: by mail-vk1-f172.google.com with SMTP id w186so646046vkd.11;
        Thu, 04 Jul 2019 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwjzuKWAb+6lrK93GKCiLTg/Hx2Y3ZoRRbWD2cO622U=;
        b=eyl34Yv8nX2KUyU4Fz2gdHGh6L+62UalJ2nIsVtaOpKgXSDHi7opEv3U5Yzg/59msm
         PnHxUWlp9USlqhzSE0E2TbyMn4cMd5mm/UQw5rbieQxZSfI2433j7KlaWK+95M95Xp/V
         Sv2VgS14C2Dsqipw12Cx/oR0vpLaEkN3TMsRE0PKTPmkYvmQvdOmE1mBFdWdj2fn1zfM
         3/BkK3rgoGe9bZSWtmpiuf5trPShc5Bw/yHu2vV+yDpreZba+MIZ/DdCCPCtGIg/O6WF
         LBPj2NIkS8S5aH7FT+S6HdQzPX+IGGjWN+GUa5jiH6/EHbXvFYkBBsTw9CKZ8/o3/vtQ
         YyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwjzuKWAb+6lrK93GKCiLTg/Hx2Y3ZoRRbWD2cO622U=;
        b=exlTx/douHJdzsQoFyaJZjUM3lDhx8SVzFaLHXBET7e2TBK55itd6N914VgfwixIrA
         RFQeoPYR1sNzesewJbOeOhEbykAoxIOCbtL0P6ptd4BiwL9Dji72CY6eNk+TzDfAkfOQ
         wQdpYOIaFspj1Cq7saA7YMlo7A2rHIKZBb1zjgCkG1/Jk9jCszLKrFXfSfW1yRl1bnce
         Ypx/utk3jU/TJig1CjDT0F5PwRUVAjntGFiE6pnRnUis9q1ujnmkC21BaHE+B+O6n8Nx
         lYAwq0UdWws0h37ZHbHygdePcigMzPaAmy1EGRleUTwzZwgABbw7m/laaF8ETvMHGAxf
         MWGw==
X-Gm-Message-State: APjAAAVPGx8PcIXY+XiCHiKDkBoRgk/nrC4A+pnoTMU1OducNQz0FReq
        MmaCrtrU2nkiMEdakAExsWvSnVWPz8m4t+v2s44=
X-Google-Smtp-Source: APXvYqy8X3yxVQW7mmHhj2pfnE6gtj/r+XF3IEI0IzGYwRt810JGgoyuihiWEQWD5b9s73RvwHLKrvZOx+G2cwyj0GA=
X-Received: by 2002:a1f:2242:: with SMTP id i63mr8314223vki.69.1562249535108;
 Thu, 04 Jul 2019 07:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190704023546.4503-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190704023546.4503-1-huangfq.daxian@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 4 Jul 2019 15:12:23 +0100
Message-ID: <CACvgo53Dgdx5NhMaOAc9AhfvvbjX17RfuT71bMLR6G4RKhY=AQ@mail.gmail.com>
Subject: Re: [Patch v2 02/10] drm/msm: using dev_get_drvdata directly
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 at 08:26, Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> Several drivers cast a struct device pointer to a struct
> platform_device pointer only to then call platform_get_drvdata().
> To improve readability, these constructs can be simplified
> by using dev_get_drvdata() directly.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

This patch is:
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

I think you want to add Jordan's ack-by from [1]

-Emil
[1] https://lists.freedesktop.org/archives/dri-devel/2019-July/224928.html
