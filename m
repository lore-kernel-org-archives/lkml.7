Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB448C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9B520830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fwQKUaUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfJCLms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:42:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34330 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbfJCLms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:42:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so2604979wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jT+9een9mM2KMQc2NI2nr4Y5VakV7H0J0wclQgkUils=;
        b=fwQKUaUFQ6a/78eZtJv4rTrh8NiDMuR7wU5XIhUa32e5TXH0+uEfqBrFFkdozLykq1
         GQSrne3+R37jhPKfIGFJf311r73w02PYfez7FjwTcAvND4U6++vYOlaw9c7WX4E2oyY2
         nikycED8a/vkMoQonBwpaQpGZVVqHZtSoxd6HWOawqobtNEPaBTphaIe8FghuMyKs8M7
         Si1Ey/dynw5twF+TVb6+G/a0w5QVMtNTUe+ZkLXqRKR5eM/AqOW7nzpR5fVSezqZ8q7p
         32T39Ez4eEhSJ4vkH30VuovExTH5yDqeqWSaWP4tiMu+75u2sBIPXVp+uzQum8/3hiUN
         VJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jT+9een9mM2KMQc2NI2nr4Y5VakV7H0J0wclQgkUils=;
        b=jzmHcgliOnRyepkFtF2ArO8KfZGE8/dH9SZNU5Zu81skCQF/SirMvl/6ZyN9sMVIwg
         s7dWa+k3YNY+/xqBECjrd1I9bOGO05Nw3F7AANyyzAjN/O8594bHaEJO1FxhrrfjPrBo
         QnzThCYJqUXFJNhQb98ZzmN/n3tI2fM3IhcF0OhISx9NhAP9SN0BdhMyWV/hAzewF9yl
         MX9MbCizGBD/KB4yGQ3eve604h9fpXcLUK/Z3mTKeATu2Ptvqi6HrZRyr+1M4//pY1LG
         spQUQw0IvM24JJCYHCqy9dakEbiHDfb671dfUuDqK9LHsxvwFhpgMar5OVM4pZqvC0MF
         oinw==
X-Gm-Message-State: APjAAAXLhTsRINVXy9fU8yvY0MFAfbfVnVlMh+hVgWQ4chDjacNTTho0
        FC15+/AKhsO77PsUMBHjIXoTLg==
X-Google-Smtp-Source: APXvYqz82V76dcSOpmIIaTo777Rc74WPo1TLzktFeak8EAx8pWm//EW5b77wEGmszSGc+Q2Gg+GDIw==
X-Received: by 2002:a5d:6704:: with SMTP id o4mr6839593wru.365.1570102966533;
        Thu, 03 Oct 2019 04:42:46 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id 36sm3014735wrp.30.2019.10.03.04.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 04:42:46 -0700 (PDT)
Date:   Thu, 3 Oct 2019 12:42:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 2/2] backlight: lm3630a: Add an enable gpio for the
 HWEN pin
Message-ID: <20191003114242.GE21172@dell>
References: <20190912213257.24147-1-andreas@kemnade.info>
 <20190912213257.24147-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190912213257.24147-3-andreas@kemnade.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2019, Andreas Kemnade wrote:

> For now just enable it in the probe function to allow I2C
> access. Disabling also means resetting the register values
> to default and according to the datasheet does not give
> power savings.
> 
> Tested on Kobo Clara HD.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Dan Murphy <dmurphy@ti.com>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> changes in v2:
> - simplification
> - correct gpio direction initialisation
> 
> changes in v3:
> - removed legacy include
> 
>  drivers/video/backlight/lm3630a_bl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
