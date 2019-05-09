Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83051C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A132173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AauaUrfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEIJdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 05:33:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37350 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEIJdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:33:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id y5so2272751wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SyRgRxtjdMJpbsjK9vjm2B3TwSm8QJJ2pjmdSOpbmps=;
        b=AauaUrfm2cnOW6SNDfuMRv0+hlgU2BgvMMo5qTYqMWmgv0tM2Y605oJ9MDb6GCKkyr
         xxLZDhgFvVAUlAqzhZZgGwA2pJ050Cg3c+g34asToSOFZ08TE2qbNZLS3DeuykRS59oz
         8+wg3JumczxfcDO7Pl6qu7oRNbTm/41lIdyzvY1NkLggKzIkIhVByv0CcEtkutzoETEX
         NxstvI4XTnL3mAERfoDswn2CPdQJx+hVe0gJm0AM6FQHrltYCRVbW5fJLJS4w4cxHgzg
         ACVVbtk5SuzhgRFF6Z67DPh3S/iQNyWj0leAwGWeu9gnUt6RivRWexcjB7HEr88L+o0d
         BWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SyRgRxtjdMJpbsjK9vjm2B3TwSm8QJJ2pjmdSOpbmps=;
        b=r/BOkP9pKCQNbJ8M/lYpyr0jpBLOV08NPZ4I9P0ub7bZVNZO+SnxWyNKCplT82pgAa
         4GsGu3PquwVdtmItKtMpibd8WWcGd/kplP0w0qOT50xupup7w639R/85yHwZ9mz9k4op
         ieuEAevQVzgbtkyDUFm4hIkHNN5av1QAY/36GpXJHUe123XpbMK1NGWqGORFppTD9cXY
         ZVrJUExH047/12PLGPxP6UZ4Zu1wwC5imE7ss8xGJvCOvu133szjukkBJyfxZ7tufomv
         UYK/DBkflENqsrgWzdIewZfslrkD+x26hZTS9V5XXmzgPypIU7AAWX7J3SHxUAXauyk/
         vrhw==
X-Gm-Message-State: APjAAAXi2o7j+WUyjPKUGb7YbvSEKR+qFSkG29uJ4cbmdMx/X4BpGY58
        h2dYfvI7dkyt+uvRQEiX+yDigQ==
X-Google-Smtp-Source: APXvYqzWxiSGBE8sUUva3+DpZ/awGVFeFFPJtZu5iHJoO63RJCNa28okuodpAuszCvvYsv8zSHsUTA==
X-Received: by 2002:a1c:f111:: with SMTP id p17mr1919584wmh.62.1557394409462;
        Thu, 09 May 2019 02:33:29 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id j131sm4430911wmb.9.2019.05.09.02.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 02:33:28 -0700 (PDT)
Date:   Thu, 9 May 2019 10:33:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v6 1/9] dt-bindings: mfd: Add ST Multi-Function eXpander
 (STMFX) core bindings
Message-ID: <20190509093326.GV31645@dell>
References: <1557392336-28239-1-git-send-email-amelie.delaunay@st.com>
 <1557392336-28239-2-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1557392336-28239-2-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 May 2019, Amelie Delaunay wrote:

> This patch adds documentation of device tree bindings for the
> STMicroelectronics Multi-Function eXpander (STMFX) MFD core.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/stmfx.txt | 28 +++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
