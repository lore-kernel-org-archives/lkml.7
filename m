Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051B5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0BD21773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bRcvWgBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfDWNgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:36:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40954 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWNgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:36:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so81647wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4u08udtdpGGPguEldhC30tabgRiyMWYpo/ojtODeRdg=;
        b=bRcvWgBpOj0RWdeX94IxO4UTI/+Ra3Sb+cXVTRx41P16iSB/IMw+b7XDIE07xPSF/w
         VWR9bFOxCLJ9yGYSOw4hqx5sRto7ofp+7SJWjKBOwykGq8Kjnym5cItMIvRZb6UHXBhe
         Wq6kUfi2a4RQBNP8Q7LgBDM/bnUn7TZhXdEE/YzjQpRkMjEGwLKuhzm9O9pT5pc5wrBf
         p2oWvc9WwVaVEbvE/2QlR9vqRBwi5m2wjBPEBW9pcSmakfSnrLT5b9y0VYJBzupu4Mhu
         pLZTaxWmfa7/jHPhs19z1KFmK1DO0TrwUEulKvAoPAx1P4nEwMzwcu4F1oNLvf7FcJrC
         5gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4u08udtdpGGPguEldhC30tabgRiyMWYpo/ojtODeRdg=;
        b=hGjoaz1ZkqUoXyv49Ojv8Mf8xk7955tCzoQ07A2AVObldxmeWC5xoJp2ZDgdmZJ3fT
         71Uw2pWOPq6eTqa7gIYC8NNjgTI3zLka76ilVtnhN6Q+OMSjm1XDptCdc04pXWra2+ug
         NlVnBDmyKGA5jgpqAi6Jl4oqQs1x5S/RospDPzLk0cfqADx+zb/81qQcIxdXFdWf2xsh
         qwsfdp/aPEkurpg7NJh2XX9vvuOzdzasmMpSw98eKb3GV6hMjdI2miTG9BkYRqv5INKx
         U0BeyNeOruypPIi5Afpr7IjQJzEXb4AE0zoXu4Gk5Eo6wF0cRt9OwGN8T4V//Hel24FH
         v4Ww==
X-Gm-Message-State: APjAAAWd7Ri/puIDwQYjp+8w8cLBt/7pJoW6dC81UyeIj5ZT3lDq2/BA
        MboMJNhs8I05xEfX+kuQTLS15A==
X-Google-Smtp-Source: APXvYqy5PogfeuOQbSn5JeMGn87hNjbwlkH3Q+iOPgz4uXZIcpAZNYHJngaceD0LBFkTCeHS84kFtw==
X-Received: by 2002:a1c:4d02:: with SMTP id o2mr2407969wmh.134.1556026611281;
        Tue, 23 Apr 2019 06:36:51 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z20sm13509543wmf.34.2019.04.23.06.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 06:36:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] pwm: Add support for Amlogic Meson G12A
Date:   Tue, 23 Apr 2019 15:36:43 +0200
Message-Id: <20190423133646.5705-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the PWM modules on the Amlogic Meson G12A SoC
family, including bindings changes and DT nodes.

Changes since v1:
- Add two different AO compatible to distinguish the different clock sources

Neil Armstrong (3):
  dt-bindings: pwm: Update bindings for the Meson G12A Family
  pwm: meson: Add clock source configuration for Meson G12A
  arm64: dts: meson-g12a: Add PWM nodes

 .../devicetree/bindings/pwm/pwm-meson.txt     |   3 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 179 ++++++++++++++++++
 drivers/pwm/pwm-meson.c                       |  30 +++
 3 files changed, 212 insertions(+)

-- 
2.21.0

