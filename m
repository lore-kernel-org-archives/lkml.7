Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1967C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3973214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLRtQsjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfEHLvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:51:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39785 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfEHLvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:51:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so2867798wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fxMdWr+Y0B0LQlIyW4uE4+5LAprnpZmZmdymzVpaLRo=;
        b=bLRtQsjDJ2En5fTi3GA8DSNaW3y8sw97+N3aJC9kUwBnDr9DtUaJVd1GAfVNSmmRiO
         XVqPkP2G7hYFCPZoZbvIurmgd7fdDJK/L9pHcETeIYms39KOsTn/s6OD9HS0z2Cnw61m
         TZ/WN+QIKw2dm5Nmljo850S9/F/JdV6JUWIRyh48EyZ5q//vCHUXVo5e0X9MBDRyhezu
         xOKl7hS0mUbWzBg3qofqfEZQRBPcvdme959CiKLzaJgQKH1zQ0d6apwWKZrvkQH+G+pU
         SCyGlwa/CXuXlQciKzGcU5l5NDZTFv05FCcUFF5MfOjK2kDn6P5ngH51GVtk1+IxfvZy
         ni8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fxMdWr+Y0B0LQlIyW4uE4+5LAprnpZmZmdymzVpaLRo=;
        b=ZnfvgNkbmVnOzAlq1+wt9VYqzeEt7ML7ZFeOmH9llRjp7hdOHHzwICpVnJfF182zrC
         s7x2sDyVHwyVxSR15F9hz2dU87KypImLKkJW/30sqLRh0SlmHY2HBI6hrfE+hcS+127R
         ISvRnuZTjzbuKxurFTGHDpuOHDh4KWbGU2UsFrAWy8ZOb7J5saxfKyojhrD6zFJ2z15E
         unPEYlsL1W1O9JOUib+EJapa1gT67WM5OMVWn53WpZu4HBkgDEOWU1LkYWqrE4PCEEVD
         YV3+zKlrOwsJlstLhjVPRYRyqdDX1SZOX4gmL5TxJHMLL/gyvVYr6rHLy0qFeDQDhaCn
         r7hw==
X-Gm-Message-State: APjAAAUj7O99zVFNshecmE+EndyizdFkpO5RvamFEP9phJHbfu72Q435
        mT7IAQZoggDDiQtZcxTnL/oQVQ==
X-Google-Smtp-Source: APXvYqx3tHJji8GV7ug+uIe5aYHHxknjL/dzHQLeBBZnXsZid6cAjh7dSLl2l6NzGwfPUe7wJFB1tQ==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr2672023wmj.52.1557316299503;
        Wed, 08 May 2019 04:51:39 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id r10sm3212041wml.10.2019.05.08.04.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:51:38 -0700 (PDT)
Date:   Wed, 8 May 2019 12:51:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and Regulator due for the
 v5.2 merge window
Message-ID: <20190508115137.GM31645@dell>
References: <20190505154325.30026-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190505154325.30026-1-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulator-v5.2

for you to fetch changes up to 744b13107d0d2ec36c5293d7b59129d3186c9396:

  mfd: max77620: Provide system power-off functionality (2019-05-08 12:50:14 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Regulator due for the v5.2 merge window

----------------------------------------------------------------
Dmitry Osipenko (5):
      dt-bindings: mfd: max77620: Add compatible for Maxim 77663
      dt-bindings: mfd: max77620: Add system-power-controller property
      mfd: max77620: Fix swapped FPS_PERIOD_MAX_US values
      mfd: max77620: Support Maxim 77663
      mfd: max77620: Provide system power-off functionality

 Documentation/devicetree/bindings/mfd/max77620.txt |  9 ++-
 drivers/mfd/max77620.c                             | 87 +++++++++++++++++++++-
 include/linux/mfd/max77620.h                       |  5 +-
 3 files changed, 97 insertions(+), 4 deletions(-)
 
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
