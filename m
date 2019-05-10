Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94ECC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549F420881
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="C0hRRVJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfEJPxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:53:32 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:42041 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfEJPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:53:32 -0400
Received: by mail-wr1-f48.google.com with SMTP id l2so8465871wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmYcNnwfKVscZCmwdjK6jhJ9WBHb6BXwy0H5GLHZ/VU=;
        b=C0hRRVJkS6zB+gVPwbTFLoQ/yrTJe0AdMUE73ja1XnESm9WmkHP+J9t1kL18F89+Ar
         Egg+kK9TylG8JTm6oqDQCeiK74nWu62vsP4nIgEBc8KBnTx6Cf8K8cgtOQEyVzIVKj21
         6wnLy3HMAlGd7LjVvWStoqLs91EkMu4NqovsGbMkzOIo+ayRm8P3sVzd52760Q3bQ8Kv
         NktQEj+r/gGlKKS/J2qED2hxbwxNRj/NjVGpeZxBbtTmR0nZxmetlLSK8lIbKSa9epcP
         DSog5ymi+1RkFJTHrMV2sRa/tkMuTeaU3G/LXcDIoQ/5nEsU5Cgcr9F+RoM3IXjR52Pp
         H/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmYcNnwfKVscZCmwdjK6jhJ9WBHb6BXwy0H5GLHZ/VU=;
        b=MA7+F+UGwx0jNCuVyUbNQZbKo/JY01fA0X6VAIoOnaccBQDCpZkuInV5EGcfYLObSP
         LNqT+/ophyzds64FUtsMQKU5f6MbPgfgGy4+GBLXr7AVV3U61vGRlQR0lNtxJvxo/zmJ
         uWQLwp0HHR+FivMKV2XV6hsP44B+8vIjk/ntylUcphw5wCQvUKbfhZWv5gYCnUvAhROz
         U25sqqdCzz+ShHBU7QPBtdZ6HMm+XAXAx9ewCf5xRh8O0sGrthlit3Y2oAUMm5wfCou2
         d3P4/bu4o5+uOGaEyEVqH59JZIFS9FxtuY4ZUTRYzxBMuUeDwLZOPpByJa3Zc5YgqtpY
         lZFA==
X-Gm-Message-State: APjAAAVHaphnPBFcwMMVBdr3sL22RKpg5prbxC5ElinALjmTUgI+4/Fx
        ojNs/iFaOu7Ku4CeUgCQwmFwew==
X-Google-Smtp-Source: APXvYqxG++tIt5+P1saVu6V+j0sm+4hTQruPueDBJA4MZeuRgE44zFdvgStVURuvnv+y7381WMKuKA==
X-Received: by 2002:adf:e5cc:: with SMTP id a12mr8663276wrn.78.1557503610457;
        Fri, 10 May 2019 08:53:30 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id u14sm5333860wrn.30.2019.05.10.08.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 08:53:29 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: meson: g12a board node order
Date:   Fri, 10 May 2019 17:53:25 +0200
Message-Id: <20190510155327.5759-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The order of the nodes in the u200 and sei510 is bit fancy.
Order nodes by address, then node name, then aliases.

This makes rebasing is little less painful

Jerome Brunet (2):
  arm64: dts: meson: sei510: consistently order nodes
  arm64: dts: meson: u200: consistently order nodes

 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 92 +++++++++----------
 .../boot/dts/amlogic/meson-g12a-u200.dts      | 50 +++++-----
 2 files changed, 72 insertions(+), 70 deletions(-)

-- 
2.20.1

