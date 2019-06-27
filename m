Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A70C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8982084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ooazNoLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfF0N7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:59:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52195 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfF0N7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:59:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so5845854wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HZ7QyNPTvF6/RgnmII34ur/JGsTqdFkUnUKXTuvqG/w=;
        b=ooazNoLWOxU7IwbCJhoA5ND74omxfkNA0U1UpIkyKlNt0uKAfdvPmkJmQH421o+src
         vHLl/RyQplDDT1tW40Dp93vFXUKuqLfSJXg+XUzCJcoYTZZGO4+o0KU/ZfLagw0bgegz
         wZBSx99uweaNbb2vAFhf51jahF3xYUMLdJMKzZid2NhISCpPSl25DVCmAaHc/iCEvqzt
         V15JjUpQIM1tcn7pXWbEW6dhtbporZSui1zZxUUr7YTVTg347Lia76DJHNyeo5Dbwg1w
         hv1riHzjcdEwAokiYUSBUrUU76pCTDr2HpASIT86s3UXxmXaVYUxyRFIB2OcBe61Dt1L
         f56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HZ7QyNPTvF6/RgnmII34ur/JGsTqdFkUnUKXTuvqG/w=;
        b=o8cQRNUzOIf1p0i6QBxq2MA36zcQzKqoASIxjZjp9wqlTV8E1+XPC9SvpvVzrElrnu
         hsTV+1j9N80Ns0sQKhbG0/MeJHEGRMX6S10LtKH+0+++UWWIFoWfc2sylB8o7R3obHFR
         bROlGmwWponV/OazBZ/yEEtpYpKEKV35k41vi1SQzgoV1h2q3f9YV5M8qgDSwllaRC46
         b5RfnRBtCANxD/pxXRZjj3Y/wYfWZvE7vIcC5Am3A5ifACsOuGgPHqHkEsYwexHnKjgY
         1cjsQVw+kHnN2wuzamRej+FeYpLfugI/w6i5b/s211TDEVU6xwJc/Hgvz/Zm6vEV8EPd
         Tknw==
X-Gm-Message-State: APjAAAWIWO8V8C5QXPsS2SOlO00b6bxU8OenRDFcia2yd3STJS1lBNww
        MIrfj9ukvCiV1g1e1gx0GjD6pA==
X-Google-Smtp-Source: APXvYqwaxWiKD/K7An3E8jt0LE3Y8mQ4GeKWfysCY8bRIdbz0ryFrlEPnonTiu8gbtoYhCpar5TrSg==
X-Received: by 2002:a1c:b146:: with SMTP id a67mr3282875wmf.124.1561643989260;
        Thu, 27 Jun 2019 06:59:49 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id y184sm5473350wmg.14.2019.06.27.06.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 06:59:48 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:59:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     heiko@sntech.de, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: [GIT PULL] Immutable branch between MFD, Clk, Regulator and RTC due
 for the v5.3 merge window
Message-ID: <20190627135946.GI2000@dell>
References: <20190621103258.8154-1-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190621103258.8154-1-tony.xie@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-clk-regulator-rtc-v5.3

for you to fetch changes up to 8ed14401974830f316a419b073e58ef75a473a63:

  clk: RK808: Add RK809 and RK817 support. (2019-06-27 14:57:59 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Clk, Regulator and RTC due for the v5.3 merge window

----------------------------------------------------------------
Heiko Stuebner (1):
      regulator: rk808: Add RK809 and RK817 support.

Tony Xie (4):
      mfd: rk808: Add RK817 and RK809 support
      dt-bindings: mfd: rk808: Add binding information for RK809 and RK817.
      rtc: rk808: Add RK809 and RK817 support.
      clk: RK808: Add RK809 and RK817 support.

 Documentation/devicetree/bindings/mfd/rk808.txt |  44 ++
 drivers/clk/Kconfig                             |   9 +-
 drivers/clk/clk-rk808.c                         |  64 ++-
 drivers/mfd/Kconfig                             |   6 +-
 drivers/mfd/rk808.c                             | 192 ++++++-
 drivers/regulator/Kconfig                       |   4 +-
 drivers/regulator/rk808-regulator.c             | 646 +++++++++++++++++++++++-
 drivers/rtc/Kconfig                             |   4 +-
 drivers/rtc/rtc-rk808.c                         |  68 ++-
 include/linux/mfd/rk808.h                       | 175 +++++++
 10 files changed, 1156 insertions(+), 56 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
