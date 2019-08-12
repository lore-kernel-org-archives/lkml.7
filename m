Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D1C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B112087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lglejf56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfHLHq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:46:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55763 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfHLHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:46:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so11205916wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I1bA5jORkWQ9x0UxkfmMQZ+aUJyRV+I6opQ4+8D4ims=;
        b=lglejf56tBgWWaA7k3eSdwo3OsbCb6f9LcRJm4ksycSN9PTqOJu5CyHXQ+7IqzJxvo
         7eoPc02Kq96MebG5zgVDaK6GL3PqYP3oPbqMVA3xL/sJN5YXNK7ppv2ebdgtMdQUeXOg
         lyPkt2oTPPFItUVxs+qZJNq7Nyh+Jlxtr64y6cNWYF/I+BjMKGquSdbPcI6xdM2SfDvX
         NDNwh2DfSdbxJaVON1KhDpb8+QCLjUtAdXFkqh4Msi8u7LNBS0j3sm3LntBLcKI5OReY
         9USSjYB+1Taq8TMsf80a6IKlcJP2QosDu6bV/kKpNJPpS33yRsvVHmsL1rY8Nr/h3ZCc
         fzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I1bA5jORkWQ9x0UxkfmMQZ+aUJyRV+I6opQ4+8D4ims=;
        b=U7UwuGTkQ21O22JPuYtwbbqiVpH8KgBrJblJqXyRkQRMUTDQJ/uznmf0/AI01b8boG
         nReyVyjKZngEU3Blv1E9ofL9lnJTs9++aePd/w61AijiukW015mmOp9PR23X8v3M38ve
         Xxvn0/bUWVfp5pofH8yrtBoOYECSAGADqzQUiSh6zvV61FQZdR0jDnXC9vGBylZORDoJ
         zjRg3NaEEfLAqTuriMXFgjmMke9aLwWTkQf3rygK5QS7JBPnIXC8H3XZ15gJ1bd6KEe3
         oNsDXbvPjs6M+l6vH0mCWPlk7oj+SiZkNjbtBPc+bfkXvm8jPBCyLlUOhFE/bVkBmNnj
         BEjQ==
X-Gm-Message-State: APjAAAV2j54uO/ggFrzyw7/2GD27bz5ZrI5stVTs1hzzAUcyl/m30AS8
        g/e92OcY1lR43tf52qVRCiHOXiknC10=
X-Google-Smtp-Source: APXvYqwQUWwJahjPXQuRPdhuH8iNxALXWjWb/36HKamnbs66r/hrIHkKFrKzeZUKDpJJ1IQoeq2kng==
X-Received: by 2002:a1c:f913:: with SMTP id x19mr26141015wmh.139.1565596015652;
        Mon, 12 Aug 2019 00:46:55 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id f197sm13829394wme.22.2019.08.12.00.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:46:55 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:46:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/14] mfd: ab3100-core: convert to i2c_new_dummy_device
Message-ID: <20190812074653.GU4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-4-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Wolfram Sang wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/mfd/ab3100-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
