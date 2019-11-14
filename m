Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4664C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC4120715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="16ljNnZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKNPrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:47:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38889 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKNPrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:47:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so6449117wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 07:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=imGdJFRY185pAjfBUWLyckhXCcG52iE7peF0ICno/F4=;
        b=16ljNnZZ3upX9VKdbIxvnGbmp3ksWorXodwuEZnI0eJMUoR/Azxa6ZKokc6j/yFYps
         yVDo39z9pyaxVEOZxpNxgPCctOMcEjHLC4kqwORp7Sc1a93fmpMCUTxjtbe87KroWh3t
         JNOufYpWTeBKlutEqIbAupCsod4OaDc1A4QTMCWCJeefaaOlYsP0wRVTZnKfQ6c0sBxo
         OXUSdslWFm1yzScrWCEq7l1+fz7s0kzHL63eeQ3CfO7aPEOQQUIw2nJGoC4x+THgjrGl
         0Yn0mnrewajEi4TZcv4v4ICQ97/j7DIFtnrNd7p4GIPVnY1eKkMSq5z3DObgHVYmdKYQ
         WLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=imGdJFRY185pAjfBUWLyckhXCcG52iE7peF0ICno/F4=;
        b=HB1TbJCfCYw/MSXACVur98JP0+co8uNf/gRbQRt5JfQnwGr/+84Upck+EYZch3EwEo
         0yQbkJZIdC0PindeIZ9Kl5b4TGi0Zx+dO4Eb3pxjd/LWITjnEJ1m29fneZsF2LvC/mTc
         nH0xYjNJayRlDSe64o8iCgPKeLdgpm+RLWfv7szmrTt8ZNYxkPiW3mHGbQus1edxU9WQ
         Z8O8G8Brt/1bP8br1mOCAAYicfZkkKlH8RE7zMos2T8OLcsmuHl/zMeFuF3ECf8UVnWH
         ahEfw0CpPi0sWJox8QDVHmvbd/I41MyHENK0x3/3hJOWj8uGHs+gN6QU3nj28Z99B5Un
         Uhow==
X-Gm-Message-State: APjAAAWCdCTqPjjJdESF9ykg+i3x0h85XjKvtvqewekJM2HYiRD5sKaq
        ZfmbJtRrnp/Fvjy7J/0i65cE6RLPVXM=
X-Google-Smtp-Source: APXvYqz7knAPH/YcnLeF5r5hBN9NhdC3ua2uUlCCJ/XubBMe9FwhaqiZw1YHW/Qo3Wdwd/M0eILyoQ==
X-Received: by 2002:a7b:cc8c:: with SMTP id p12mr8336719wma.82.1573746459863;
        Thu, 14 Nov 2019 07:47:39 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l4sm6428629wml.33.2019.11.14.07.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Nov 2019 07:47:38 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 0/2] ARM64: dts: allwinner: Add devicetree for pineH64 modelB
Date:   Thu, 14 Nov 2019 15:47:31 +0000
Message-Id: <1573746453-5123-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Pineh64 have two existing model (A and B) with some hardware difference and
so need two different DT file.
But the current situation has only one file for both.
This serie fix this situation by being more clear on which DT file is
needed for both model.

Regards

Changes since v4:
- reverted compatible change for model A
- renamed compatible of model B

Change since v3:
- state the current file is model A and add a new modelB file.

Change since v2:
- Added the HDMI connector node to model A

Changes since v1:
- Added the first patch for stating which model support the
  sun50i-h6-pine-h64.dts

Corentin Labbe (2):
  ARM64: dts: sun50i-h6-pine-h64: state that the DT supports the modelA
  ARM64: dts: allwinner: add pineh64 model B

 .../devicetree/bindings/arm/sunxi.yaml        |  7 ++++++-
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-h6-pine-h64-model-b.dts  | 21 +++++++++++++++++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 17 ++++++++++++---
 4 files changed, 42 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts

-- 
2.23.0

