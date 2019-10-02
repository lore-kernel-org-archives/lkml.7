Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE1C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2122190F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nMHtAt3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfJBI6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:58:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53294 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfJBI6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:58:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so6262784wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 01:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGigccZRHcOe6mnr3dySXizOwIoRRgR/GRDjKzSx57Y=;
        b=nMHtAt3zgJxjcaQ6D3dcCo7jyxkk3j51b2aUZHJnFspegFYzV/XJHUA2BEz4Lko2n8
         dqcl8flDFKoNFHFDBjAcIPf+YIHoa8paJHgnaj1iFrtgkXcuiiMaRoRssIQ9cSMMMzDE
         GJ2twjskYndZ0JhiuAgtKGPcitjppwJ9sMljnzL6oRuD37awsadGvXALO5VzYvtXBGH8
         KYH8At9E7Y74tH2Dp0B5o5Ceh3MUYNpQndOxo04eAt3PDKr+0mhnRLP6QfAwnqvOyNrB
         z8vEITM4UFxUtL1bGQ6IEnL854xC2vufXbgAf/uDuJ1s/ExH35l5icK1Gn+ciPtM1zW6
         TMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGigccZRHcOe6mnr3dySXizOwIoRRgR/GRDjKzSx57Y=;
        b=VdW9Ph+YKzaGcwZ4qlZ/sR40S0Hys1HNylzSqOIrDCX6/ANWN0bRbMZsOKk3GwBKDV
         Gj9WR3CoyfYAZVz61+u9rgnAjpLWOLfhk4B7t+QMXT1NhFYnmrh2+r1hAX1ACkAT1D0x
         nFwho07SvoLSDtT8y2HJW4gvYJqicjnTGtOpkCbXhWyQrlyae98YwnW+i90BqaDUSx7C
         I4ZjXJI7r/OFrIGTZzFC3kU6s+XX5umkUXxWu2YslKWHjGD0Vg0f1qqox28r/BXsciOs
         l1lClefQk4HuFMzC7egDCHat39RdUW3vuGrftT9uxVTjvpd64x2yiw1nZ8Deo5kY2ZkZ
         66vg==
X-Gm-Message-State: APjAAAV6E3GcY4QhU6HvIISGeMDUZFcXXYnqOQEnT7RB26k4PAlLUsgS
        yAn7dWwps0LzNYMZrcNiMisLgQ==
X-Google-Smtp-Source: APXvYqzyVRb6WScpGMgQlwmQaYkvHsLLv7VL9IVwN03FBI5LC9wI3I9G5Y60sn88O85AiijPGWtoqw==
X-Received: by 2002:a05:600c:2151:: with SMTP id v17mr1859179wml.56.1570006686541;
        Wed, 02 Oct 2019 01:58:06 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b186sm10115616wmd.16.2019.10.02.01.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 01:58:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/4] iio: pressure: bmp280: code shrink
Date:   Wed,  2 Oct 2019 10:57:55 +0200
Message-Id: <20191002085759.13337-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series contains a couple changes that shrink the driver both in
terms of LOC as well as actual generated code.

Bartosz Golaszewski (4):
  iio: pressure: bmp280: use bulk regulator ops
  iio: pressure: bmp280: use devm_iio_device_register()
  iio: pressure: bmp280: remove stray newline
  iio: pressure: bmp280: use devm action and remove labels from probe

 drivers/iio/pressure/bmp280-core.c | 114 +++++++++++++----------------
 drivers/iio/pressure/bmp280-i2c.c  |   6 --
 drivers/iio/pressure/bmp280-spi.c  |   6 --
 drivers/iio/pressure/bmp280.h      |   1 -
 4 files changed, 51 insertions(+), 76 deletions(-)

-- 
2.23.0

