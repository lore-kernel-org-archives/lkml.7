Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED880C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5200206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZalBINU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406629AbfFLIin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:38:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55473 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406333AbfFLIim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:38:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so5602022wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=73CrIHEXuQUZeET/GcqX8rdQIUtJYJb3U8bvrSHkrDM=;
        b=WZalBINUFcOHyDb0rkiVJFWzDPwAlgL2Jo5WhElcjlmQDC0vHEnxuxt96PkKdDBY/Q
         JYhCK/XtFB9voateeZrxvff7lNbZfEyER0VOXAlydwJNMWCC1XVsmPJtyXe+aw4JNQ/+
         0gceVjExu8mpLcXm12VADkkkM8V4MhStXgQ/28yNfjT/QK+CrxCHMYY7WtcSvcE8eE6J
         yHJoqEjzW/+MdPcuwRgWYNpvcP0Mp4fYnwst1SH+ElG6Ovxi3HiN7hAvLOQ1A4+DC1TP
         8BvO6lQ/awN9F3biFDxEKclA+qTEazW66Vzwr0Tx6K3lg6W9Q9tpiuIYGtIDrfh7VQuZ
         dpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=73CrIHEXuQUZeET/GcqX8rdQIUtJYJb3U8bvrSHkrDM=;
        b=aAqGiO/vLx3y7JFP5qVQVRpp1KvhfCM1TWA/RyAFbTc/8fEjUCScFI7Cb9/wn0AOms
         wywFaxeS8v+4dUi/ahiUfO7H/TFjd5Q7BBt79LKbn1/9M4NEdfAoBJubw1TLaBIlE7F1
         33EEZiD7aX8ZxKzXdeX076jLTMr3N10X7o+I49qgkRsL4Vncyx8u2mt8GRlGFUYe/qAq
         la9hc4d5TKmhX81ZFROpJNBQuhz1UMrCDLMI13IGp+DYfjS1xt1ToDauj6tLAxXRAH8T
         M8J+bJKX+8me4+VBMnLGcVjUWV6CJkNYPVeLTivRiDtX2KMHGN8ckXIdNNC2OFNKePE3
         pMnQ==
X-Gm-Message-State: APjAAAXdlcxj2PPA1m0f+bkVNJEZ1oQOXrwdF5Ezibirrjuv+TB0dRT+
        SYzBC+S23Ar3hTkiJm6e3Xrsng==
X-Google-Smtp-Source: APXvYqwZD2mzXxw9OeO4fKkiV9+G9jBZOreZ1wd7qKmlq2YewI+0UAZKMSryD2WK/JA+ZsZWGPtJAQ==
X-Received: by 2002:a1c:6154:: with SMTP id v81mr20631257wmb.92.1560328720395;
        Wed, 12 Jun 2019 01:38:40 -0700 (PDT)
Received: from dell ([2a01:4c8:f:9687:619a:bb91:d243:fc8b])
        by smtp.gmail.com with ESMTPSA id y6sm1520209wma.6.2019.06.12.01.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 01:38:39 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:38:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/3] mfd: madera: Add Madera core support for CS47L15
Message-ID: <20190612083835.GY4797@dell>
References: <20190530143953.25799-1-ckeepax@opensource.cirrus.com>
 <20190530143953.25799-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190530143953.25799-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019, Charles Keepax wrote:

> From: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> This patch adds all the core support and defines for the Cirrus
> Logic CS47L15 smart audio CODEC.
> 
> Registers or fields are named MADERA_* if it is part of the
> common hardware platform and does not conflict with any other
> Madera codecs. It is named CS47L15_* if it is unique to CS47L15
> and conflicts with definitions on other codecs.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/Kconfig                  |    7 +
>  drivers/mfd/Makefile                 |    3 +
>  drivers/mfd/cs47l15-tables.c         | 1301 ++++++++++++++++++++++++++++++++++
>  drivers/mfd/madera-core.c            |   44 ++
>  drivers/mfd/madera-i2c.c             |    7 +
>  drivers/mfd/madera-spi.c             |    7 +
>  drivers/mfd/madera.h                 |    6 +
>  include/linux/mfd/madera/core.h      |    2 +
>  include/linux/mfd/madera/registers.h |    5 +
>  9 files changed, 1382 insertions(+)
>  create mode 100644 drivers/mfd/cs47l15-tables.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
