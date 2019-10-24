Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27336CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AAB20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHPx8HzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408695AbfJXHpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:45:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53462 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408683AbfJXHpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:45:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id n7so761642wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 00:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8oUqiQ0qhLfajr7lFRroQcRmM7Bml9GJfZWFzXhl9Dw=;
        b=KHPx8HzIc7W2+mSPj0KG1m583K/Fr5km1YWWRTp9TaZytqbYp8Goy2/toHgd11CfT0
         CHONg31WaPitlnvai2KYsapP6PAqF7hLrL8rRXGesZMDAIW+97u8ENdF6rxrAN5B9zQ4
         s0WvsCBsOEG56xLOMeiNaM6vjmXD42EqgTbtJFiK1R7Ey4c6fmcpKchmVfRz1gpC/lRH
         OseU/u6THa4P0mJ0YJC3+GckUxEupyZH+prs+CBSZvB04QakwwmzBgUvc8EJSLK7ATBW
         MzBBMYRuB8oM7hFhFh0sn663aPvUPP4IwSnGLDK80I2zDcJL1G7ywKkYzXif4UvBiKAP
         s7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8oUqiQ0qhLfajr7lFRroQcRmM7Bml9GJfZWFzXhl9Dw=;
        b=jzpQrQVKrvnQAIk1Eecsbslwkgt1+ajd2Ig9Kohy96zjcAV8m1BxYSeNpKfOiYBim4
         C2/Ca78qO7ZnEYWEte3vzz3KO3gjOC2S/mVN7ifMKoKm7P2qKdgy2/6ZeOuW3rT2nqt9
         nkUbv+NZ41Yg6vZYlxoZV6D0CY2ikLUR//e4iRj4WxFvSA8TqIP32k9H7y09kMbTtO4+
         hLK4x8HBO3rjGcRvDtg3to53vW4oCcRjzpw6Fi4CGbQKOfjlw44eZf41rRpIwrvDVxqB
         nL/MuCn4LCK018bO8+MRxRduuAHMgWRUnPL30r4Huh4ZVejwdWIEvkpHyrDuVE1angTe
         grQA==
X-Gm-Message-State: APjAAAU7WfIlHUljOAGzKKFH3Hl1fsgeYMTo91pqqv4X6zqtrABP2iRg
        Cwwf3vOzqmrXLe9vi1soGiMTj0XTj7U=
X-Google-Smtp-Source: APXvYqzSTT5aGQ7uezaXEWwZWnTNeODxOXNl46D2JyS3Ed3nnQMSSWsIv5FpBbwpBm1OG1SzMTMK2w==
X-Received: by 2002:a1c:f718:: with SMTP id v24mr3399066wmh.82.1571903118832;
        Thu, 24 Oct 2019 00:45:18 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id l7sm14647621wro.17.2019.10.24.00.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 00:45:18 -0700 (PDT)
Date:   Thu, 24 Oct 2019 08:45:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND v4 2/3] mfd: madera: Update DT binding document to
 support clock supplies
Message-ID: <20191024074516.GF15843@dell>
References: <20191021135813.13571-1-ckeepax@opensource.cirrus.com>
 <20191021135813.13571-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021135813.13571-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Charles Keepax wrote:

> Add the 3 input clock sources for the chip into the device tree binding
> document.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  Documentation/devicetree/bindings/mfd/madera.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
