Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2733AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E386D218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wHR4ItWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfC2Pdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:33:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33984 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbfC2Pdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:33:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so3144107wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCCYZzG5Ka9N2oZ7rttqC09lmztU1e5JZDTYPl18vOw=;
        b=wHR4ItWvESwCW43C9tWHsCFK9V6gu0YOKGckKb8Z3kMeIzkIKTjGuaVv2UIN9aeWzi
         BpjE9VSIjvr5S/K88iK204/7ecIOs6SIiy1t8Tq0i28axpXU+0d/OoBOPVMBNlMV9mvi
         5oB2mYCOffwIo8OBvkEdGVWTlapFH2E7meQy67KN6h38K9NodTEGdnisT+vvKtTFTbCH
         LTZhaunBkQKxO3hr8jBcsTlnygJc8T2DU9DHmz9uPhTpmnd1iQWvZlE8SNBf04m+Tf7M
         2XANNRuO7EbQyMu8FB1x2wPTije34hacTNsJqS1lbVBY/Zi/AMqkxKyrcFFQ1wCCRziQ
         7WvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCCYZzG5Ka9N2oZ7rttqC09lmztU1e5JZDTYPl18vOw=;
        b=tIuOzLII5dEa5cNDjzpRDuDyGO1Pf4hNGGbiirxnWbAa142CosMQzFOj4gAJ9/DUfH
         654t6e2I0zoXE75ys1Vyql62HM4q0eBxfajkGquTMIo8iDS6tjnBZSegg3uqaSLZhAv1
         bto2aGpCynSxOIRtgjkPT1Ei46Bp8dLfJsaOxpf9VWGBTwGS/jjsUocPJDlnkhA87RR5
         Z3Z+vu3SnrGsIyCDP2PJGZGleYD7KjXzsezKdnVg681bo7Ccz6lMJltN9V2MxgWGs4wQ
         yOCR++AEjZPzIVWN98UYdRY3m6P7zJjGxHHA6bSUOskcmOSzvEWDo1CqwqwaQ7xzW9CF
         QZ4A==
X-Gm-Message-State: APjAAAXiItEhPfgNM5C6SI8wzGHBfhHFlqoKoqOVSmCPVz9EWXWqX8y/
        kS7x8+56sB786IPUtunoRxYfLQ==
X-Google-Smtp-Source: APXvYqxdSf6XsxRRtkdzz5tcSjr7T+I/B+Cef6fa3PvYVwpHHlB36/NXAlsVCkRMNBlvfnX0EP8NvQ==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr14632674wrs.155.1553873613265;
        Fri, 29 Mar 2019 08:33:33 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s18sm1930173wmc.41.2019.03.29.08.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 08:33:32 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] clk: meson: fix mpll jitter
Date:   Fri, 29 Mar 2019 16:33:22 +0100
Message-Id: <20190329153325.23869-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported on this [0] mpll series, We are observing a lot of jitter
on the MPLL outputs of the g12a. No such jitter is seen on gx family.
On the axg family, only MPLL2 seems affected.

The jitter can be as high as +/- 4%.

This is a problem for audio application. This may cause distortion on
i2s and completely break SPDIF.

After exchanging with Amlogic, it seems he have activated (by mistake)
the 'spread spectrum' feature.

This patchset properly set the bit responsible for the spread spectrum
in the mpll driver and add the required correction in the related clock
controllers.

Jerome Brunet (3):
  clk: meson: mpll: properly handle spread spectrum
  clk: meson: gxbb: no spread spectrum on mpll0
  clk: meson: axg: spread spectrum is on mpll2

 drivers/clk/meson/axg.c      | 10 +++++-----
 drivers/clk/meson/clk-mpll.c |  9 ++++++---
 drivers/clk/meson/clk-mpll.h |  1 +
 drivers/clk/meson/gxbb.c     |  5 -----
 4 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.20.1

