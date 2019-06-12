Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7E9C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703D5206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLRmbEDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407374AbfFLIiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:38:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37410 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406602AbfFLIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:38:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so15901565wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zEGC7bloUInKKL+DUNhE6x/IkEkaiZLhwNuCCj09Fa4=;
        b=LLRmbEDvN1F30J1ViNFt0jOcgI7x0HNEbqY73E1AJJxQ1BpRFKt1z1heNqlJbudX3F
         Gwoemkihvre9pdvDS2T+WajYDN2ShUrn5LR5AbkOAyRNXTmWIUyL6vSEcIXPZ+yJpSlU
         rwS+u6hb0W7g1gORjYZH6NPghSg5v0YmcBAKnGm0dNXJdiM+jxKMLuHbP5jJZsXqwFYk
         J/M1M6Uj3e2WBYuMTuXueF6E4g+vrZWdG7kDGxiPgKON6f8k4qV1mFJAPG4tJgu2yzer
         zwPJaBOny7m8vPp6+RFCJ5hi2zQMaywquIUYz0jpv4E09OKwhdHlsvWjWXHaTHesBOxs
         MmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zEGC7bloUInKKL+DUNhE6x/IkEkaiZLhwNuCCj09Fa4=;
        b=YV111lvy8oXdMfUx9/J6xJCyx2Rxt1otqdbMVZl8RolojkFS0zMxe+YSPH2O4yiLxC
         HoL3QiJBG4VRMfDZFZfgw0n6laOcJG8wRO/QCY4GAtCLZVcYRZOEF9nrJIO6K2riu3St
         iquzr2ZNFYcurS1fGazLuxrtCsOX/r5CEfNEXx4Uw0hQ5nA69QbGEZStAvtoYdEEwxI3
         j0YlcvMfjENylZUBUp6LMAIPxJbuhxQjzYoWGdBe/4moTWSMS/pU7neGNcSlpSm6/pgY
         +PwlGSpTOhYOE4gaox234YMx82ZdmU7f3mcgQzyROq5rWlDmTDItMuqwjWQDcfCi2X2e
         o1og==
X-Gm-Message-State: APjAAAWGGykxkv0Ekvml4i+34j2S61oX2FSCvPNhha9Iv2y+0r/oKagv
        2o41bz/25RmrkBdKzIFL5GFwyQ==
X-Google-Smtp-Source: APXvYqz4myACSUXii+sPixCR4wr3xycQ7CDZh1eGwODEpYlJozoSUkLSl9jz4rgOJMWI4nYDttAmmw==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr17257224wru.264.1560328729634;
        Wed, 12 Jun 2019 01:38:49 -0700 (PDT)
Received: from dell ([2a01:4c8:f:9687:619a:bb91:d243:fc8b])
        by smtp.gmail.com with ESMTPSA id z5sm4369065wma.36.2019.06.12.01.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 01:38:48 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:38:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 3/3] mfd: madera: Add Madera core support for CS47L92
Message-ID: <20190612083846.GZ4797@dell>
References: <20190530143953.25799-1-ckeepax@opensource.cirrus.com>
 <20190530143953.25799-3-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190530143953.25799-3-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019, Charles Keepax wrote:

> From: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> This patch adds all the core support and defines for the Cirrus
> Logic CS42L92, CS47L92 and CS47L93 smart audio CODECs.
> 
> Registers or fields are named MADERA_* if it is part of the
> common hardware platform and does not conflict with any other
> Madera codecs. It is named CS47L15_* if it is unique to CS47L15
> and conflicts with definitions on other codecs.
> 
> Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/Kconfig                  |    7 +
>  drivers/mfd/Makefile                 |    3 +
>  drivers/mfd/cs47l92-tables.c         | 1948 ++++++++++++++++++++++++++++++++++
>  drivers/mfd/madera-core.c            |   58 +
>  drivers/mfd/madera-i2c.c             |   11 +
>  drivers/mfd/madera-spi.c             |   11 +
>  drivers/mfd/madera.h                 |    7 +
>  include/linux/mfd/madera/core.h      |    4 +
>  include/linux/mfd/madera/registers.h |  195 ++++
>  9 files changed, 2244 insertions(+)
>  create mode 100644 drivers/mfd/cs47l92-tables.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
