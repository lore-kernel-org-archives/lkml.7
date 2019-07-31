Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC999C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FD5206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVgGkcZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbfGaKAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:00:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43716 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbfGaKAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:00:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so31588775pfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zdY0mkeKz6wFUj2+Iv8tunD7YaIRXeWWDHoAU4rKgeM=;
        b=VVgGkcZXih1qP647R+vl7D9o6i6k9DG70z7bLhVqwiDo1I2LqOLWTfCxu1ekWU8Oya
         MwEwA/ZuDdiIjsYgsaiTci2krnAu1CwkbmYxrPbBvNPFQ9JFVDziVMAcSqPWRHs4lq04
         eI8Qlsc4M0rhnDkmVf3nL9eFWhg8iOfazXarSVuZhau84pupSABqznhLh2lILMK91nnT
         YGCyj4xbFKyuUDmEbJF1jY6Fm2EpIINazzDGWHkrMQoNsb0g439ecgk+ose0bATGLK5g
         hiheflMKKhsVqN9mrAHTwXt8/17bJZUvTS9PYUwqXvnXAZaFfSmuyVzGOpAmJBQqVv9m
         a4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zdY0mkeKz6wFUj2+Iv8tunD7YaIRXeWWDHoAU4rKgeM=;
        b=pdaUXXrIkAfnmjyfOMeL6aLD74wuJcHwu6Hth0oFQHdQYHNhb8kWYUBQL5v4Prxpt4
         aMKkflAtBaprRlpyi7zwkTdsD61J64VhASQ1pMu4xYXRWmYyApULqhFKTkoA1ZojPHdp
         erfejiQ8J5TiX++MlLsRwHUVGWIn1Uci4b/FPSO1YJJDLaFnlWFKBr12UB3bjoviSw+v
         ySpvNqbUpcxbggqtV5Yx7QNsHQzmnQv28zvaZBNZ/pvu3pGhiTAcZNb8uPIO19TOvTCs
         WDOFEJdjj2PV9LS33AWyCPOHSEkVq2xrOC8IHvRr8bGjc+iNKs+bb+JkcGa1hyPejC5u
         wOtA==
X-Gm-Message-State: APjAAAUYKlOweedH75obX6izO8btkJwmahAvW7PHOMpSsU/u3ekLFgOS
        ql07y2J/SpzqiW69C9LFrPyX7Q==
X-Google-Smtp-Source: APXvYqw0Y6Qj3vWMUij/ygCH6W9UuQ+3IAOIfy6H/S2xq+XR2JPcqDpQWOgNffD6qg6gLUIyLkFXiA==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr116459163pgr.52.1564567250359;
        Wed, 31 Jul 2019 03:00:50 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m6sm68611352pfb.151.2019.07.31.03.00.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:00:49 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Optimize the Spreadtrum SC27xx fuel gauge
Date:   Wed, 31 Jul 2019 18:00:22 +0800
Message-Id: <cover.1564566425.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set adds new attributes for userspace, and fixes the the
accuracy issue of coulomb counter calculation, as well as optimizing
the battery capacity calibration in some abnormal scenarios.

Any comments are welcome. Thanks.

Yuanjiang Yu (6):
  power: supply: sc27xx: Add POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN
    attribute
  power: supply: sc27xx: Fix conditon to enable the FGU interrupt
  power: supply: sc27xx: Fix the the accuracy issue of coulomb
    calculation
  power: supply: sc27xx: Optimize the battery capacity calibration
  power: supply: sc27xx: Make sure the alarm capacity is larger than 0
  power: supply: sc27xx: Add POWER_SUPPLY_PROP_CALIBRATE attribute

 drivers/power/supply/sc27xx_fuel_gauge.c |  175 +++++++++++++++++++++---------
 1 file changed, 124 insertions(+), 51 deletions(-)

-- 
1.7.9.5

