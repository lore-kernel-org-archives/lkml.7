Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516EFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D7C2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDd2dfHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfCTNkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:40:06 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:44398 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfCTNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:40:06 -0400
Received: by mail-pf1-f169.google.com with SMTP id a3so1939279pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=10bfi8c9aasvRCzXb6fZaP3wXcQwybcEs2fMQNWvwkY=;
        b=pDd2dfHBnJqg5Smba+IKApiNySdvZa9EtoVYUdWF4pXD0EESHUDX8DRdrCP1ei+08d
         JqfAQrGiGrH47uWS2QrGSX+RHuCm6AyE0Xze4DXnGcFroCOTbgDTK0YGj9F6uPZrvm0+
         WR1+Bf5cYYtZSKX11bKLzJmiudElO3VYRRJjTshXSgt59Ls/0nMDEpWJH2KMEu09CU5a
         ekHTWj/m+BkHlOY4ltXRxq/ZeaO3La7mkRy6lJIzk5qeDMyGxu20rw66cdIHKx8d5IiN
         MTIKhG+6zIPxhnFtsM0TB8p39vJ0rCGI50yulpFLmiLEVfu5KrKBBst78VyO0enOksAC
         6W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=10bfi8c9aasvRCzXb6fZaP3wXcQwybcEs2fMQNWvwkY=;
        b=hK7KrNjRvxDZ0B8zsBE0rvKpmZ3T7fO3W44uj8bB7LQaVaegKKJfDHNNg8ipnhnJH8
         mLHfB1qpR6sYnQhk9TKrStfh2rTFYR7rZ9q4LULHm/I3HWX9eeij9y+htdxNcbFa3ZFD
         ag5v0j/Gs2zK99LulV5jXlHAMhTdL6o56wj5xMXD3VXjV7Q3lC8Os8rAfNYGwRMz25cj
         8xJoy+sCSvqnXkSZ+ctrj8ElJar/FYf6OJI/KOSKEBhbq6nopKs9pSJnuCzShyJWKQyy
         G5AwOnjfJRAgjlTPgnMn08gBz74CXazXbcatLZ8YiDbEtnuPUqUGDfGAB/g2+zwuo5O4
         sY5g==
X-Gm-Message-State: APjAAAVPO+39IcvJmX7kQ8qKKtueP6mMeStXF1G//mEaxOBwPHIYwUvQ
        Yiq4Bk9MSdtOc98a8zXTDlo8eKS5dPA=
X-Google-Smtp-Source: APXvYqx8bfS6DvNDYRqicnNzErTC24QJb6A9EwJkDKnEEKEB8WOU9Wp4yRe8TQo7T8NDBIxG3qyfZg==
X-Received: by 2002:a65:448b:: with SMTP id l11mr7851720pgq.450.1553089205068;
        Wed, 20 Mar 2019 06:40:05 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id x62sm3681224pfx.117.2019.03.20.06.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:40:04 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCHv1 0/2] qcom: pms405: adc fixes
Date:   Wed, 20 Mar 2019 19:09:56 +0530
Message-Id: <cover.1553088982.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of fixes to the adc node in PMS405 to get thermistors to work
correctly.

Amit Kucheria (2):
  arm64: dts: qcom: pms405: calibrate the VADC correctly
  arm64: dts: qcom: pms405: Rename adc outputs as per schematics

 arch/arm64/boot/dts/qcom/pms405.dtsi | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.17.1

