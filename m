Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAA9C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D11C2465E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RbQpLY0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgAFIfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:35:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35777 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgAFIfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:35:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so48664294wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 00:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e0KhA/fnqWm6T6Fd1y/ycOP88g1CHs2BTbMCEvSy12Q=;
        b=RbQpLY0JPaeobLbCh36bLbDuItz1p7hIAmNT2oGDYKGS1mgu5Kj3oPlu4mgWSw9v3V
         RRnqMhQkSAZP8VJnl+HJQ2j/nICCe/2u6Jr9uMeBWnZHi0CKpHrVnJH3X1AieSxarvfY
         RMfKwTlVQBKqPcnTAAPuR32zi4ywOv2KxET3xVXJreV42QVohvmVFFev/y7javZBTZyT
         6e7rf8ctUiAhzrJjeFAycyuba+GTeIXAcc8poGc+sxGZq0JGpeHMzvjAD0UcAdgMsbvL
         dk/9SaRwbZjFAIoiFJKp/voDRjXhW2OCJlDenxb0AT1RW+hmZFk7a8vUi4GZNQubEfVq
         iCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e0KhA/fnqWm6T6Fd1y/ycOP88g1CHs2BTbMCEvSy12Q=;
        b=kIdQnE5XEELhME+ttMquiXjGYce6CLuUJnWpL55VVMy0CAMAHJcUrr3PJ/3zrRf1Kq
         MQLnwkUlmvkbeVZsGpJ9FiqOylgIb9FXtQb08qNDuZAWrkg9NniGcLABKHOmrH+zSCu6
         1fK+UrHR4AHSRpf2+MxsuDxhwQSHxgScHUzjVD205ID+ijDScg0be8rZHUdpJPr1PLfl
         WzHatSClFIYU5TjknbPmhxBptkVEgk0pDrZqoDW3mJXo7cLboRp4B83GtGUQeiDOGIMn
         30STFvm/IKtd8Bo4E42hpVncjOBM/JYoW9eF0vBagOfsCI2wP93mDMGKKU1rbvM6sjKY
         e0pA==
X-Gm-Message-State: APjAAAUcW/C2rqW77wn9w1d32Owfc9LdzbCkO1mL6qeWUimWFWJFHE03
        /c+BdxcRspzkVdtqxmGtqKH7+w==
X-Google-Smtp-Source: APXvYqyIiOs7jWQLCFZMnVa3AtUvwaffIrFpTMgoZ+P25QYJI9FKcD+DBcRlTB3YcQs0DsS/7Kd9WQ==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr67762298wrs.303.1578299749170;
        Mon, 06 Jan 2020 00:35:49 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id m3sm70800908wrs.53.2020.01.06.00.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 00:35:48 -0800 (PST)
Date:   Mon, 6 Jan 2020 08:36:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/9] mfd: axp20x: Mark AXP20X_VBUS_IPSOUT_MGMT as
 volatile
Message-ID: <20200106083603.GK22390@dell>
References: <20200105012416.23296-1-samuel@sholland.org>
 <20200105012416.23296-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200105012416.23296-2-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Jan 2020, Samuel Holland wrote:

> On AXP288 and newer PMICs, bit 7 of AXP20X_VBUS_IPSOUT_MGMT can be set
> to prevent using the VBUS input. However, when the VBUS unplugged and
> plugged back in, the bit automatically resets to zero.
> 
> We need to set the register as volatile to prevent regmap from caching
> that bit. Otherwise, regcache will think the bit is already set and not
> write the register.
> 
> Fixes: cd53216625a0 ("mfd: axp20x: Fix axp288 volatile ranges")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/mfd/axp20x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
