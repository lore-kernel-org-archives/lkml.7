Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80959C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506CB218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlJiJVyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfFQHDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 03:03:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34437 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfFQHDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:03:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so8642968wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4+pITYSfaf6rsitQnMBBcSbRxuZE47ZzaATw3AkXEIY=;
        b=GlJiJVygE2SJu2dlv813B1LT1RBKsB8OADALaafZKHFOhQ6+Veg/uRGRyHJ9lHmpoQ
         y2JLsWtApQC7szDYnTKUWgYBQknS8vLCK0cl8EgERMGZ9zLX/OugYJ4McPN/eGHWAyHR
         L2bLqp/FOdRjxFs0rgdKIKWFBxOjOAd9qRnR40dMDOpSH/V4oYJmqiUwimyX62BBsJ91
         HLTyEfJb7c4L7wl+TgA/oEMGHFHnGjGk19dEK2ercGoMHw6rJ25h32PTHHW6HGF+FuiW
         k2M/vsYAcUeBRxC84OvLHu1q3A2Vpv+fHsMVrc09tMivqGC0PoIRMU39XYBCoqGfaU2Z
         FUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4+pITYSfaf6rsitQnMBBcSbRxuZE47ZzaATw3AkXEIY=;
        b=OTWjJyfPu8fSzIYAB6OtcyygQ6LUWVmVnPDQDZnUp7mMIvM8DQGjMwa632nbsrk6VJ
         bmSlYE3yc+PMDop0RCwR2DsD0w/hLs653BkTZeuEgB01PwW0SIo4RueBNX67eprxoq5c
         AUMAzOXpq24O04z3im+61VsK50Y/Iqyayg/WQrbCvtevafYXpd4tlchzT0QwguC1sZBI
         xjfOwYEguBijiu3mH/pwQ/e9XnG1lGwf7O4APFMn7iA5vh8Vy6sH6FgDTJu5MI2Urcfc
         0epLMvmK5DJ5NTfjSyZBenXzGL3C/JwAetgYc2D+9YWVWLdEKY/sWHcIhgTW8IcgeAjR
         OXIA==
X-Gm-Message-State: APjAAAUKffHnfZxfW9m+i15Na6pEDJ2w1hnjEZtYjVpGBGqH1TpweF4D
        eCaWpsH95yIZGVd2zhfNE3qCaiy4q/A=
X-Google-Smtp-Source: APXvYqzNat4IzfDWlts1T6Zm9jqhh/J1uCafDL7GG5Mn60bm6L8LeVgA4j3nnEkpv4fL1f34nwj4bA==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr59875456wrv.347.1560755023967;
        Mon, 17 Jun 2019 00:03:43 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id u23sm8108217wmj.33.2019.06.17.00.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 00:03:43 -0700 (PDT)
Date:   Mon, 17 Jun 2019 08:03:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, t-kristo@ti.com
Subject: [GIT PULL] Immutable branch between MFD and Regulator due for the
 v5.3 merge window
Message-ID: <20190617070341.GC16364@dell>
References: <20190612144620.28331-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612144620.28331-1-j-keerthy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulator-v5.3

for you to fetch changes up to 7ee63bd74750a2c6fac31805ca0ac67f2522bfa5:

  regulator: lp87565: Add 4-phase lp87561 regulator support (2019-06-17 08:00:24 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Regulator due for the v5.3 merge window

----------------------------------------------------------------
Keerthy (3):
      dt-bindings: mfd: lp87565: Add LP87561 configuration
      mfd: lp87565: Add support for 4-phase LP87561 combination
      regulator: lp87565: Add 4-phase lp87561 regulator support

 Documentation/devicetree/bindings/mfd/lp87565.txt | 36 +++++++++++++++++++++++
 drivers/mfd/lp87565.c                             |  4 +++
 drivers/regulator/lp87565-regulator.c             | 17 ++++++++++-
 include/linux/mfd/lp87565.h                       |  2 ++
 4 files changed, 58 insertions(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
