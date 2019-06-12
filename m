Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10200C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E522063F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AV7toiB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437161AbfFLIbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:31:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55672 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfFLIbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:31:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so5579763wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=r3SzJwXrLD2vEcjZT750WK8cKLEa+W6WNKJTcM8KNjU=;
        b=AV7toiB2kM1Sr4N+o3ge48VkF43YiDVmDUu7Ys8JDTPCam5aohC0dr02fDL0SOEVPM
         LLEnggLz23ta0tKDH3Fp+7VYrGcCz73Lr9Tk0xNwjYNVGrSIj6SMvyn5/S5vJuorig3W
         cyDw6Q49330DAu75YGVDw+q25aMAqbmjCTF30GzanQwNNKLDq3QtGMs2HBLiLz4qrHMh
         Kc/cyeP6e1p2aUqCQKaEUjdSBLhuc1dB4ot3ufw5d7FHby1/2Veo+ZN6MoQhg6qjPUNc
         ITClCkeJ0Y3XW8LB4WzVYddGcP1Jh/DsXAoisV6AFv/WjoHeCcEwewFxodHUufY9NtWF
         6PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r3SzJwXrLD2vEcjZT750WK8cKLEa+W6WNKJTcM8KNjU=;
        b=PhaxyVP/ZaIPPwOq6CtfMaMtdgP2uyC4m0hiFsaZd7Cd1V/MPoZurVz4eN6Y+lKI8/
         +tjSCt4ugu1lwuX5udlkCarsow0+LY7NEGDuMpXm1Di42U5rTkIxzbMs4vuuNG+krt3z
         mGptiSzStPt2spgxx10fG8G5g9OkrkxObjg6pyWOc0cve/jGz0V3LTU5AHFZ76X4WsHy
         +H/vr5uyKwDrH3Re+3Y4i+ovPXoPPtFIjxi38coHQrFziZfUpoT2TBxdVbe9RaadV731
         PKtTntFWPZN3QK6Ka2fRAgXfb5JmK5/vonvHku4aFIXZCWD4V+JuSaaDwY/oI8MTiV2n
         piGg==
X-Gm-Message-State: APjAAAX4bNq///ys33u90EBcKeELbq2bF0nN5MPdJbThFodq/OmsW6D/
        BBy128SdefYPkCdm4K4XCLJBlg==
X-Google-Smtp-Source: APXvYqyEqDOjstCdNORzQasGt3uussUd0WQUbPDIZzUATkA/HKYfDj0wN8eFJhwXEO8M66PIhVT/Yw==
X-Received: by 2002:a1c:1bc1:: with SMTP id b184mr22630124wmb.42.1560328301436;
        Wed, 12 Jun 2019 01:31:41 -0700 (PDT)
Received: from dell ([2a01:4c8:f:9687:619a:bb91:d243:fc8b])
        by smtp.gmail.com with ESMTPSA id t140sm1662995wmt.0.2019.06.12.01.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 01:31:40 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:31:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     arnd@arndb.de, natechancellor@gmail.com, ottosabart@seberm.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/4 RESEND] mfd: arizona: fix undefined behavior
Message-ID: <20190612083138.GT4797@dell>
References: <20190520090628.29061-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520090628.29061-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019, Charles Keepax wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> When the driver is used with a subdevice that is disabled in the
> kernel configuration, clang gets a little confused about the
> control flow and fails to notice that n_subdevs is only
> uninitialized when subdevs is NULL, and we check for that,
> leading to a false-positive warning:
> 
> drivers/mfd/arizona-core.c:1423:19: error: variable 'n_subdevs' is uninitialized when used here
>       [-Werror,-Wuninitialized]
>                               subdevs, n_subdevs, NULL, 0, NULL);
>                                        ^~~~~~~~~
> drivers/mfd/arizona-core.c:999:15: note: initialize the variable 'n_subdevs' to silence this warning
>         int n_subdevs, ret, i;
>                      ^
>                       = 0
> 
> Ideally, we would rearrange the code to avoid all those early
> initializations and have an explicit exit in each disabled case,
> but it's much easier to chicken out and add one more initialization
> here to shut up the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/arizona-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
