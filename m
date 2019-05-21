Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C152C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B8520863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9Hh46xD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfEUGPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:15:46 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:39116 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfEUGPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:15:46 -0400
Received: by mail-pl1-f180.google.com with SMTP id g9so7894727plm.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 23:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XC+eEUZvBVBb4aYgFpg9LPA+oLBOm7v87SIH5uTfoe8=;
        b=E9Hh46xDXyvdhvjiDl/zOYoVTr4s/wcGNu0TQe4rtJhIfrO8WcmFW+N3OSIySzNQdJ
         VCtYHZnpUg4LPMJpymqQj30ifcO0CNOsuZ4sMi0JevdCLCnjwtiGWqLvKZnhbLLghYis
         IqQ1km5YEC5V3axSejHr3glQk7F6cGs0xHVLo6HkcetvQOJT6JIqspCOFK6TIKr4IwzM
         NJH6rvpCF2aSjcV7ATtlX0U6hFpPmVhVvT6CG+6mOJLod5tg5qGM7nwNR0unXqOBx5/w
         +MSyPym13LYgACIDQ7IM/3rxJZRAkdwUQsOnIwU19lA9bxGXiYWkgrdY152i8g7G4DhW
         fJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XC+eEUZvBVBb4aYgFpg9LPA+oLBOm7v87SIH5uTfoe8=;
        b=X4HMpNHO+Zsrq107csbVyv5dZkbZ2xiMWkv70I5YNqdCtYqKuKSB3KztoPTiSpSUx3
         5iERNo/k+tmvLOZvGj7gxhFhIsqkBMMmxnD8yjZIUFLBtMIkOwJQ/qqLm7JEH8PKa/yG
         sNGocCeULHLt2w7UXkkh6yvXnQCC7gukeldYTkc4y83jy/Ft2PJWdIaJ3DT7GxHrwRiz
         ypbrgbAj6vhI7w5vKdeTjEJ4i7ZGJnQd3xjyiIfypOIm1GH1sm+fZZz8fRFedMlI9kcY
         R0H7Q8vsHacfutWTcBLizXCqkkHcprV6x9BuXVOWQ/7duZls/xETe5C38e6oR7G17RWa
         QhDg==
X-Gm-Message-State: APjAAAWouCTJhAG7bZuay1xz0BuOWinCOyjHTD/Nxjx0szRok+LgdtzP
        7wNskH9VUP7/9aPRHlp32kzNFw==
X-Google-Smtp-Source: APXvYqx4LD5IXOQ/g+5k6YFlSh/BqB8wc/yP3F0PNuJdb2JU8YQtRaH/baFUQ6b+zuM9oZwkcVw3IA==
X-Received: by 2002:a17:902:7592:: with SMTP id j18mr20820598pll.213.1558419345690;
        Mon, 20 May 2019 23:15:45 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k9sm23064259pfa.180.2019.05.20.23.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 23:15:44 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 0/2] Return immediately if sprd_clk_regmap_init() fails
Date:   Tue, 21 May 2019 14:09:50 +0800
Message-Id: <20190521060952.2949-1-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function sprd_clk_regmap_init() doesn't always return success,
drivers should return immediately when it fails ranther than
continue the clock initialization.

The patch 2/2 in this set switchs to use devm_ioremap_resources()
instead of of_iomap(), that will make caller programs more simple.

Chunyan Zhang (2):
  clk: sprd: Switch from of_iomap() to devm_ioremap_resource()
  clk: sprd: Add check for return value of sprd_clk_regmap_init()

 drivers/clk/sprd/common.c     | 9 +++++++--
 drivers/clk/sprd/sc9860-clk.c | 4 +++-
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.17.1

