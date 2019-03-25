Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13807C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75E7206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eICupXCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfCYKDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:03:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39655 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbfCYKDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:03:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so9340948wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BEySt4vCv34IdyGWOMiVdKBVLMjCgxH48wqT3pqewH4=;
        b=eICupXCSEYozREncd20DXAs/NYwW6m9XSCcupAu446YgCAMIltU37EdmAKBlILklyk
         Zm0vv8c+dLvy+89g1hS1DXCjwRfrLTXsdDtWVZ7pqvzAfu9tYcN6jqbq6ckww7JWEcGT
         oDK0ONzwa3pvFWJjT2l7eIc4buYnWWqk63aCp8qh3IBhzmMKM2kOyZ0IAJfZUlWgSyu0
         FfLeAMEKILTKi4b8gSqCloyyFMw31yZV5G4uIkcz7UwsQl9OBgw7xbP+MQg0oFOFN9ky
         BmrdRjAaLUCJM5ijRV5sA3gKNZe+EDW2hD03kcMsKTWg4G+mXIDmjxouLKrdPC4t5Xp0
         nuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BEySt4vCv34IdyGWOMiVdKBVLMjCgxH48wqT3pqewH4=;
        b=dIg0PaTFgFjUJh4cXQr3x4LW7WFDQRrgLkOunk6ayyxTKF0a5wJShFah642rAAXQAz
         kUwf/iO3lWaWKJnrYRMzaD46HppZ1ivDgR0+ktgR7GYnLZzuc8qzlS6hyxUYM9w0efaU
         qyRjFDwcIt+Xi2qUKdl6/e//tuBpzva2xHpm2xUMu0uVclz0h+6q2rvFypO9240jyQhW
         XK7IeciPTQBMkDdWypMsQY9ryrSNk44wlJ9qoNEgdXAsj/aECWeHC+mB1KglY4mamX5X
         VVVCMzxJiwmhqxvRSBaCJJXbZbZzpCR7AHHISsux/F0KBxO754QESKLUKQVpvErymGJY
         Vs5A==
X-Gm-Message-State: APjAAAVDX30xMGq3yUZFOadvGJfp7r44SLO4bEuoEzbXlsFB8K1CJoqS
        lHUBxuMFnq8kDitQLJ5stsgX7w==
X-Google-Smtp-Source: APXvYqxEwjlaBKKaKcRUvQR9inpAKfsnGGUQe+AippB05cgJ7HhVWMNcaAqvgT2N42V9PI+5r6/i0w==
X-Received: by 2002:adf:b68d:: with SMTP id j13mr10633095wre.50.1553508222174;
        Mon, 25 Mar 2019 03:03:42 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g12sm11581215wrw.40.2019.03.25.03.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:03:41 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] arm64: dts: g12a: Add peripherals
Date:   Mon, 25 Mar 2019 11:03:36 +0100
Message-Id: <20190325100339.749-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add following peripherals :
- SAR-ADC
- USB
- Mali GPU

Dependencies :
- ADC

Depends on CLKID_AO_SAR_ADC_SEL, stable clk headers tags will be
available after v5.1-rc4

Bindings has been merged for 5.2-rc1

- USB

USB depends on the CLKID_PCIE_PLL, stable clk headers tags will be
available after v5.1-rc4

USB2 PHY depends on missing Reset bindings, have been applied to
reset/fixes, waiting to be merge into master or immutable branch/tag

Bindings has been Reviewed, waiting to be applied

- Mali

No Clk or Reset dependencies

Mali GPU bindings are still in review.

Changes since v2 :
- dropped applied patches
- collected review tags

Changes since v1 :
- dropped already applied "Add AO Secure node"
- dropped meson-g12a-u200.dts uart_AO change
- fixed includes overall to fix build for each patches
- removed disabled status in dwc2 node
- removed uart_ao_a_c pinctrl
- fixed uart pinctrl node name

Neil Armstrong (3):
  arm64: dts: meson: g12a: Add SAR ADC node
  arm64: dts: meson: g12a: Add G12A USB nodes
  arm64: dts: meson: g12a: Add mali-g31 gpu node

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 117 ++++++++++++++++++++
 1 file changed, 117 insertions(+)

-- 
2.21.0

