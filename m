Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3158AC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C902085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="POgIrSQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfENKMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:12:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46757 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfENKMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:12:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so687339wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 03:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhynvhAiddsMm/Ocp7kfyLUqbkQfMFHtGPzDTJPS1B0=;
        b=POgIrSQvJlnEj7sbeK83izHCW7/GNPyqSQO0wUuvNg0ap2oo/MDC29Uj291gjEXA9o
         OOktcC8ZvbzM54YaY105eVEKF4L0mP0I5JKwuxFilZBTNBGicOIp6s45+vumK0A+d0P3
         Lg5xHawaznKjqnhlI4lS/ivZUVtjU8TXLr+3710P/HT7OttPffWSt9U6QN+MsbFCdFnH
         YIAp91wpgf7k1LYDfDAu48s8UWNAYXNjqe35n0aU8KP4xvylUMjUrmqZAUOgBsTxxEzG
         foOtZEBJZ10Lt2TfL2DOvQZ4hcb+RvKBIO8I6BaBW3PeRU7WiK375bDnlIQKiIx36X7k
         VTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhynvhAiddsMm/Ocp7kfyLUqbkQfMFHtGPzDTJPS1B0=;
        b=ZIzhcusgrPC8qYc7UwO3/UWeeSBV1frglI8N/fO9rV4VVgRZYqEXylFcpaeTgpuXO3
         BKo5kVbVZrYOofD2ejrm/g6BWqz1DUc1RysLA5yurVipcH7VpGFHaef2UQn/OToy8YWg
         Fot32bRdqZioduMDbPBhSvBCiLPhBsfuplLX4UNkRv2jQ+S6rIgPeedsuUd8xaEs/fYS
         BVvylPrcJCFPY7uj0B3LZpSorAlW7sE9J6aOkzMKYqcxt2k84PIf3c1Zrvh42Cd2vaFM
         o4QQ7H9NlVMWiRxb1P8zSEmsBgRTk8Vi61gojvrxZWR7Vp8oytDc4M4hp9wU4AwFXQ9E
         nGqA==
X-Gm-Message-State: APjAAAU2Y7OOUOv9bPYMSeuQH9+7BPBrTAiIjxUGNTnSCkJhhdXPE9rK
        740nY3q2GU3IEILNhBj8YzCwgw==
X-Google-Smtp-Source: APXvYqxWgcWkABQ/gpTGPgCZF14Fs8TuOZduMEHV27FG7xjEGdKo8VVbb7/N98vhPuSiXwmwHNdJHg==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr20149062wrv.79.1557828767618;
        Tue, 14 May 2019 03:12:47 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r23sm2219564wmh.29.2019.05.14.03.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 03:12:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: meson: g12a: add i2c
Date:   Tue, 14 May 2019 12:12:34 +0200
Message-Id: <20190514101237.13969-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the i2c controllers and pinctrl definitions to the g12a DT then
the busses present on the u200 and sei510.

Notice the use of the pinconf DT property 'drive-strength-microamp'.
Support for this property is not yet merged in meson pinctrl driver but
the DT part as been acked by the DT maintainer [0] so it should be safe
to use.

[0]: https://lkml.kernel.org/r/20190513152451.GA25690@bogus

Guillaume La Roque (1):
  arm64: dts: meson: g12a: add i2c nodes

Jerome Brunet (2):
  arm64: dts: meson: u200: enable i2c busses
  arm64: dts: meson: sei510: enable i2c3

 .../boot/dts/amlogic/meson-g12a-sei510.dts    |   6 +
 .../boot/dts/amlogic/meson-g12a-u200.dts      |  21 ++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 268 ++++++++++++++++++
 3 files changed, 295 insertions(+)

-- 
2.20.1

