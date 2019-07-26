Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBC0C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB3822BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dI3W3+aY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfGZL2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:28:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41649 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfGZL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:28:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so31972929lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yms7A0Dj/ss/bfob7fvSwoSoaN3YOnXapMDkDt2JkGk=;
        b=dI3W3+aYZkRhr2cVhzUptcUM2pwVVATteZ4VZ3NtR71AqBqGIYfrf8yrxzStuM+3nE
         tya5Wiu6pzLKkBX88Pc9jxDP11Kp2Nb7gJvFfjHY3wHbyJTa9MjgkhXMMSLglyktzkm3
         rtfP0GDsu4nDfg7oDxj6j5NfrKRKG9nFa1yKVgkG+vm4TleEGCA4h4MB8cJEZeWnFrVx
         66ajVkJqxzTBxoq8QcMEGK7KzPudl9gdTSkKZ9JTKZKCDGv4Ao7DdYIPa5uPBiKKxwIV
         QUSwtaEwhzZ9sq1FGfEOxB2hVT7HFBdpqVMA8nbZVRahng8T1uE6i7OUfifFilHWGBbe
         be7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yms7A0Dj/ss/bfob7fvSwoSoaN3YOnXapMDkDt2JkGk=;
        b=UKXOaJBd0Yd47GMBfu8MSWV2ACxtrx021KiZPc1Yz1YnJu/FxcOCqV61CL6YZYPCdG
         0LmluNzkWLnnjfm4Vvg0CsOWVuPKCHR7zUV0Iquv3LmIRKj80rE4GKou9Krunpfs2kRX
         kVXdlUf2MuocZk8IhaK82awku5KjmJ4xadm7gvmje24A2+vHzwfs3gWsyuMjGxVX214e
         ivd/WH9td98hst3Xa+3Hk61rQuqqqz0Sc6dRBzquaa8Tj76+38PTuJ1DRT9fs8qqzsb8
         5Jf2xlxb7T7KTS4TjsYEsnSx4+UjXGwZSZx9UdSkBdA5zTfa5VPIFVUlaaXFSiQUwbh7
         s+Gg==
X-Gm-Message-State: APjAAAV9qjbgdAd28/QTcaLkFCbI+cr5mNw+WRtw8O2LV90PrvI5GcJU
        wtyiShtKLrTvgoQ4HERaP07Jqg==
X-Google-Smtp-Source: APXvYqx05CPqPaf24TqfXHUET5OwIsXvhc0hYDuun6wEBRgaKaaGpBp1xs/Z6Ozl1ehbTYYA+0UBew==
X-Received: by 2002:a19:be03:: with SMTP id o3mr43992429lff.88.1564140496719;
        Fri, 26 Jul 2019 04:28:16 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id b27sm10020400ljb.11.2019.07.26.04.28.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:28:16 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     linus.walleij@linaro.org, heiko@sntech.de
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/2] pinctrl: rockchip: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:28:12 +0200
Message-Id: <20190726112812.19665-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fall-through warnings was enabled by default the following warning
was starting to show up:

../drivers/pinctrl/pinctrl-rockchip.c: In function ‘rockchip_gpio_set_config’:
../drivers/pinctrl/pinctrl-rockchip.c:2783:3: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
   rockchip_gpio_set_debounce(gc, offset, true);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/pinctrl/pinctrl-rockchip.c:2795:2: note: here
  default:
  ^~~~~~~

Rework so that the compiler doesn't warn about fall-through. Add
'return -ENOTSUPP;' to match the comment.

Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/pinctrl/pinctrl-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 62a622159006..dc0bbf198cbc 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2792,6 +2792,7 @@ static int rockchip_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 		 * still return -ENOTSUPP as before, to make sure the caller
 		 * of gpiod_set_debounce won't change its behaviour.
 		 */
+		return -ENOTSUPP;
 	default:
 		return -ENOTSUPP;
 	}
-- 
2.20.1

