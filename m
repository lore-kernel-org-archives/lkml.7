Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29CEC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E242465B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI+boveA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfLKSMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:12:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37362 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKSMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:12:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so2193631pfn.4;
        Wed, 11 Dec 2019 10:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mQeGFHveTHebaelml1aHZBuXXsokPzTEQ06fsvkfyC8=;
        b=mI+boveAcYhI2Ifbt6cDI58x0/eSNDwiYFM++fDlHxEWTBAdMsjmWrJGrAR/186zn7
         LEt+5DfFz2F3MwfN7LAx6cQZ62sV3l4N/Dmc3ZxWP/+jJoDljMf9RKdOWgu5TrVTeMzw
         eoV/BJBpdhvZWMvU83GlS7R4jKvXnW/QoHm4CnDuLgYD6voisRFge+Bn5HUchhQALLJg
         8FlUJ7GRrKhmb2Xwc6tQtYddHWT5j46KhIAIKM/7q1fvCrmz+y5Ypuqn+ex8z7cvOQ3L
         U/qm6W/6RU5jjWYe6qLfEeVyP/dtYbC43h7Vk2rNqFMBR/sAF3D+Euwbsg7FHzSovBzo
         t0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mQeGFHveTHebaelml1aHZBuXXsokPzTEQ06fsvkfyC8=;
        b=UtG9lP5VFvuhqPQlki71V59Dat9iXa4GUPWtLR/uLFhcBeUSKCHuOBucVEGbmhiKX2
         DJ+1ptOYkALXkTd5TXYqXC+KX9q9hJZx+i8PPQsuEo2K1bHvxCr1sQ5f3OPdz/muZFpG
         I67GBz8OgQAz/W7098W5C5b+g4k/lXuzTxuUFKQEVcURdt1kCrRLHa5GMKW6+oR/Gfam
         dkMWXH5DSliuC7oR58mRkb8X8kZ59FTurf4h9JZsccW1TULFnTzXxG6dwdikx2eHRqcN
         +BsW2zs+jhI/U/X6ojFJ7mfD72SWFtBCpEfI78BXLlZSGTV73M3+krK2F6gFg6b5xKWJ
         kPzw==
X-Gm-Message-State: APjAAAVZo7bVaoTWJmeXcxI3ixraSd8rYgsOvHZ+qxt9578/pnXazwg7
        uSzPMEAa8lwKRzvDcduRtU8=
X-Google-Smtp-Source: APXvYqzllpl/S6ftD0ojhliYQ7BNkmhWRJWd5RuYBGE6oCjcmoOKKhxaOFNhgTHHtlDgNmIedTuegw==
X-Received: by 2002:a62:7a11:: with SMTP id v17mr4919968pfc.191.1576087937559;
        Wed, 11 Dec 2019 10:12:17 -0800 (PST)
Received: from [10.69.78.90] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t11sm3344493pjf.30.2019.12.11.10.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 10:12:16 -0800 (PST)
Subject: Re: [PATCH 2/2] reset: Add Broadcom STB RESCAL reset controller
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Jim Quinlan <im2101024@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191210195903.24127-1-f.fainelli@gmail.com>
 <20191210195903.24127-3-f.fainelli@gmail.com>
 <89d2d00058e34e7571fc0f50ce487cf54414cd49.camel@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Message-ID: <469c7b73-b028-1691-d5f0-0ceb3007da1c@gmail.com>
Date:   Wed, 11 Dec 2019 10:12:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <89d2d00058e34e7571fc0f50ce487cf54414cd49.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2019 1:48 AM, Philipp Zabel wrote:
>> +#define BRCM_RESCAL_START	0
>> +#define	BRCM_RESCAL_START_BIT	BIT(0)
>> +#define BRCM_RESCAL_CTRL	4
>> +#define BRCM_RESCAL_STATUS	8
>> +#define BRCM_RESCAL_STATUS_BIT	BIT(0)
> 
> Is there any reason the start bit is indented but the status bit is not?

This is a convention we have tried to adopt to denote the definition
from a register word address/offset versus the definition for bits
within that register word.

> 
>> +
>> +struct brcm_rescal_reset {
>> +	void __iomem	*base;
>> +	struct device *dev;
>> +	struct reset_controller_dev rcdev;
>> +};
>> +
>> +static int brcm_rescal_reset_assert(struct reset_controller_dev *rcdev,
>> +				      unsigned long id)
>> +{
>> +	return 0;
>> +}
> 
> Please do not implement the assert operation if it doesn't cause a reset
> line to be asserted afterwards.
> The reset core will return 0 from reset_control_assert() for shared
> reset controls if .assert is not implemented.

OK, will drop it.

> 
>> +
>> +static int brcm_rescal_reset_deassert(struct reset_controller_dev *rcdev,
>> +				      unsigned long id)
>> +{
>> +	struct brcm_rescal_reset *data =
>> +		container_of(rcdev, struct brcm_rescal_reset, rcdev);
>> +	void __iomem *base = data->base;
>> +	const int NUM_RETRIES = 10;
>> +	u32 reg;
>> +	int i;
>> +
>> +	reg = readl(base + BRCM_RESCAL_START);
>> +	writel(reg | BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
>> +	reg = readl(base + BRCM_RESCAL_START);
> 
> Are there any other fields beside the START_BIT in this register?

This is the only bit actually.

> 
>> +	if (!(reg & BRCM_RESCAL_START_BIT)) {
>> +		dev_err(data->dev, "failed to start sata/pcie rescal\n");
>> +		return -EIO;
>> +	}
>> +
>> +	reg = readl(base + BRCM_RESCAL_STATUS);
>> +	for (i = NUM_RETRIES; i >= 0 &&  !(reg & BRCM_RESCAL_STATUS_BIT); i--) {
>> +		udelay(100);
>> +		reg = readl(base + BRCM_RESCAL_STATUS);
>> +	}
> 
> This timeout loop should be replaced by a single readl_poll_timeout().
> At 100 µs waits per iteration this could use the sleeping variant.

OK, will do.

> 
>> +	if (!(reg & BRCM_RESCAL_STATUS_BIT)) {
>> +		dev_err(data->dev, "timedout on sata/pcie rescal\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	reg = readl(base + BRCM_RESCAL_START);
>> +	writel(reg ^ BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
> 
> Please use &= ~BRCM_RESCAL_START_BIT instead.
> 

I think the idea was to avoid unconditionally clearing it, but based on
the documentation, I don't see this being harmful, Jim?

>> +	reg = readl(base + BRCM_RESCAL_START);
>> +	dev_dbg(data->dev, "sata/pcie rescal success\n");
>> +
>> +	return 0;
>> +}
> 
> This whole function looks a lot like it doesn't just deassert a reset
> line, but actually issues a complete reset procedure of some kind. Do
> you have some insight on what actually happens in the hardware when the
> start bit is triggered? I suspect this should be implemented with the
> .reset operation.

This hardware block is controlling the reset and calibration process of
the SATA/PCIe combo PHY analog front end, but is not technically part of
the PCIe or SATA PHY proper, it stands on its own, both functionally and
from a register space perspective. The motivation for modelling this as
a reset controller is that it does a reset (and a calibration) and this
is a shared reset line among 2/3 instances of another block. If you
think we should model this differently, please let us know.
-- 
Florian
