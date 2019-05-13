Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42334C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1226921019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvhlvPfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfEMHml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:42:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41770 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfEMHml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:42:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id d12so13963706wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 00:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WERxYzDoS7P0TiPMnvs6x/f95pNMjt2W3p3cXcDJuWk=;
        b=kvhlvPfaHsa2MhLBhlzN7ZeqLc6aNYNtJBpYSOQKMsDjCAV+R3yRNJ+onuLlEL2J0X
         oYeAXvLUyL8GROw/z9W8YdM4VDloh9xKvUi1nVau3ujGsJOJl4DlPaxHmyMpHoYXl2IO
         dj9ZgBVKalBU7BXJwdNbcO/0SfwprNvDDdDk6y5dlhu6Jd2N36ZQvySXgTDSOH3Q82jA
         9OhWkB6B11IOCXhuuQTx6CfPZ5qO3BKywDaYzakxLVNEevUtSznDiWOBvttXz5BvhX53
         GZo86ZkOwe2fuuHlpLC3BFVvIUlkD7QfBxOBtjtUOlt2bRLGyx4S1Me1+MtdiWFWcuJK
         1POA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WERxYzDoS7P0TiPMnvs6x/f95pNMjt2W3p3cXcDJuWk=;
        b=Wt35Q+6eJyVjC9Vd7hv3ZScI5Hr4pDF0ZhTjFFUQOqYmvpGDm6OLOMWnDBdUGsJLmw
         taMW0DfCRkCC+YUgxIVog7jnB50CJbPxmY1Quf3xQBbUPlfz+1xvVXgwVC2rdWw2TEg+
         FObcmwJUnhczrM39zAz7aH+IY2dGLppMUUwmAjr3HqgdOIjlWie7nGv8CLt7tFIDx0H/
         PCW4cXufUDukLZxV0qTWWRipry+z6SZF6dMznvT1b1koeA3MTGPPs48GDXL28bK+VMMH
         vY1rQNQfu2V48tJD0dm+4uTfmZcBMiueYpTH31zBlVkTSBN/RBlPgo1lZd0Rilb/vhBp
         mTZg==
X-Gm-Message-State: APjAAAV7a7X+bDooOYnh7SOFj9OpjcD2WLGCopIB+/E6MP3YXbFEjYVP
        nDGlJn7c4qhAWE6zFQSnr2ijuQ==
X-Google-Smtp-Source: APXvYqyZozQkpGZHOk4y/a4Pt3SprPlhW3ZxFXrms0vy6bx9PRMxI36vjtz603WWWh1jUgXCNGKShg==
X-Received: by 2002:adf:9e89:: with SMTP id a9mr2157887wrf.78.1557733359560;
        Mon, 13 May 2019 00:42:39 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id t18sm27938340wrg.19.2019.05.13.00.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 00:42:38 -0700 (PDT)
Date:   Mon, 13 May 2019 08:42:37 +0100
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
Subject: [GIT PULL v3] Immutable branch between MFD and Pinctrl due for the
 v5.2 merge window
Message-ID: <20190513074237.GI4319@dell>
References: <1557392336-28239-1-git-send-email-amelie.delaunay@st.com>
 <20190510072314.GC7321@dell>
 <20190510151556.GA4319@dell>
 <20190510151912.GB4319@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190510151912.GB4319@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-pinctrl-v5.2-2

for you to fetch changes up to d17ed797b8fd5c8765cd959ac44aaa2f090f5a89:

  pinctrl: stmfx: Fix 'warn: bitwise AND condition is false here' (2019-05-13 08:28:26 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Pinctrl due for the v5.2 merge window

----------------------------------------------------------------
Amelie Delaunay (5):
      dt-bindings: mfd: Add ST Multi-Function eXpander (STMFX) core bindings
      mfd: Add ST Multi-Function eXpander (STMFX) core driver
      dt-bindings: pinctrl: document the STMFX pinctrl bindings
      pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
      pinctrl: Kconfig: Fix STMFX GPIO expander Pinctrl/GPIO driver dependencies

Lee Jones (2):
      pinctrl: stmfx: Fix 'warn: unsigned <VAR> is never less than zero'
      pinctrl: stmfx: Fix 'warn: bitwise AND condition is false here'

 Documentation/devicetree/bindings/mfd/stmfx.txt    |  28 +
 .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 +++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   2 +-
 drivers/mfd/stmfx.c                                | 545 ++++++++++++++
 drivers/pinctrl/Kconfig                            |  14 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-stmfx.c                    | 819 +++++++++++++++++++++
 include/linux/mfd/stmfx.h                          | 123 ++++
 9 files changed, 1660 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
 create mode 100644 drivers/mfd/stmfx.c
 create mode 100644 drivers/pinctrl/pinctrl-stmfx.c
 create mode 100644 include/linux/mfd/stmfx.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
