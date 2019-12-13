Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83B1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6F5206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ozjhT9Lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfLMKhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:37:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55524 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfLMKhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:37:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so5779702wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 02:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q5ocr36Lob8hEeIWs3h/05wUQjQ+K9T4cwQK/71/Rho=;
        b=ozjhT9LxrWoNn5+kruUUFRJPWCwFQD0DkqHF6Ig4DOJUCO4vI+jtZUQZFLC2js49Sj
         NuIOBOuolNM2SxE5kENSvIQHZVZRPnvKRv3Hx/vkcThIr+nL7ktfGwQ7jJwPTo2unwfB
         OQUfDXRNh0Ag9DDGGB2CsSkLxrYZE77mzjH5UrY3CfvD7oEkKgJ87NTH6Nx8n06x93Sk
         UZw1bAbky2AcB8TR3mH6K2fC7FZnS1vzNig4nsvlpaEXlqhf0kuVgWg7qghUcYdupMbU
         v4EWB4P/w6SgSSSdN+d/U/bWZJfcB50ezKAIXZkFvJ/3Rr6L5ZKWYal2yyIa/FozQmex
         z+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q5ocr36Lob8hEeIWs3h/05wUQjQ+K9T4cwQK/71/Rho=;
        b=nxRSRxuGNPbtfC6b87EfS0KXq1Ac97eneFTgm6SCbVE0FyyrA2PhBhW1NR988PKoEp
         1PK9Jw+exd/HDo76JbFODS3NJohq5djVg4iV/9DLREc2Kr/1bvsZPDeYfKzgXJD3asEQ
         HAG4EPpurq3Bw3GzhgK/+CyWYarjMI1dCdxtIsrhenHhu1DxM6uzPL7Qurzf1x+PSXxa
         RIOIo0lkSJ3sPrVbVG87t+E4NMDCXpUgC8cot5NMbgCKIFIoRhRUtvMwPEoAxMTzB4f2
         qHq7dd6w99p1eGflTc+mHgG7qTYn7ITP15ucxyhqxRDrIHGG5mhmFJQkSSyjh9WRMrp+
         iSVw==
X-Gm-Message-State: APjAAAWgeGumWAN+1Vtfwh1Nz3fUSnVqYhNbYdqN5q5u/sBY6UTdcimL
        5+AjceqxumFmqsXglqhzIzyNcg==
X-Google-Smtp-Source: APXvYqxnyCKPIUq28BfNLWLn/OmW1/9wwqrfPkgBDBgdwgpsg60dQCt7fUIEYsF/ccJNzGARb9NYQA==
X-Received: by 2002:a05:600c:2488:: with SMTP id 8mr12247781wms.152.1576233457453;
        Fri, 13 Dec 2019 02:37:37 -0800 (PST)
Received: from dell ([95.149.164.71])
        by smtp.gmail.com with ESMTPSA id y22sm3999712wma.35.2019.12.13.02.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 02:37:36 -0800 (PST)
Date:   Fri, 13 Dec 2019 10:37:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     support.opensource@diasemi.com, robh+dt@kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [RESEND PATCH v3 2/3] mfd: da9062: add support for the DA9062
 GPIOs in the core
Message-ID: <20191213103733.GB3648@dell>
References: <20191212160413.15232-1-m.felsch@pengutronix.de>
 <20191212160413.15232-3-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191212160413.15232-3-m.felsch@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019, Marco Felsch wrote:

> Currently the da9062 GPIO's aren't available. The patch adds the support
> to make these available by adding a gpio device with the corresponding
> irq resources. Furthermore the patch fixes a minor style issue for the
> onkey device.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/da9062-core.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
