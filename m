Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B181BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871A62173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WIim+Jzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391678AbfETOhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:37:36 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:37441 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731837AbfETOhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:37:36 -0400
Received: by mail-wr1-f47.google.com with SMTP id e15so14911454wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XhITG8r1vNkTCHFKM+YaAb439MLc72/vlXKVj7QWfUc=;
        b=WIim+JzhP1LYbCN1OmF9ULJZSE0ip0fGM5+jViv9j9twDp0BhzyHQ/rIwKo5LU/ZqX
         WA699SIwko+9yh6FNwBJKQhIOLUqXPs2p4BpAy4RXk9NwK7dyiGV8RrxVzpd5Ru3SVEI
         9Hqlhh+y5CNjXFVla/CJE8c/LrlQnqorRexnkBYngJlIfRa2Rv8xpZBsvqr7dZPsXnCA
         ur4QQfbUWG3bDzNu84YM6b+dKk2QGElWZCgCBEfdJ71HA7wOEBLzCI31ay/ymfJfxQmL
         WjIaJqFR66/b4OYRdja/WZ+lJHtvqMr6qVD+GXOi9FMNR6bjiNz2rLavLCzBj8uKwH8U
         vVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XhITG8r1vNkTCHFKM+YaAb439MLc72/vlXKVj7QWfUc=;
        b=CATos8Dgq9TQyAQLMpg1XlmWYW6zsPZoyXjT2c3T8MtZnmdWmKgg3EfJojZkVpMFAc
         TCT0qffOpqHZ/Idzg3a+nQAGsb1vL5TTwZZpNI7WwgGtIpdH+94EvWAIME5eDfjgZPNR
         vKQs/SnNEiOAyOat4aUA0PANKpZEduUGMM5F5097DHa2e7pYJSk1BRy9+C5I7x5Yx0cs
         F/QjcmmTV1ANpaa6bxkpY59v/kTqeRuU7jjfcagU8q+WyqUGj5AAS/iYszqc3dcch6cP
         V3/a1hh4DVYq8nA/jl9WC1H+m5GBYNySvJQdznZcrXIA4hV2ob2tHPsqSoi+rDHanNPd
         1mCw==
X-Gm-Message-State: APjAAAWJAjl3lowus7skpeME77f9JslpR+BN4U3tJhwmwhQ4dO4nJqFA
        rGlEFdSQEH9Jfq2L8BSX84NkcMbQkf5ddg==
X-Google-Smtp-Source: APXvYqwnSXPnI+q0H7qUyt6TFjaq7N5LFUn9YOBwuJv3uTSQjR5xuREGOuXviK3FGTWqYQnSvvgBdA==
X-Received: by 2002:a5d:4e46:: with SMTP id r6mr45832358wrt.290.1558363054684;
        Mon, 20 May 2019 07:37:34 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b136sm19076204wmg.1.2019.05.20.07.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:37:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] nvmem: meson: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:37:30 +0200
Message-Id: <20190520143732.2701-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the SPDX Licence identifier for the Amlogic NVMEM drivers.

Neil Armstrong (2):
  nvmem: meson-efuse: update with SPDX Licence identifier
  nvmem: meson-mx-efuse: update with SPDX Licence identifier

 drivers/nvmem/meson-efuse.c    | 10 +---------
 drivers/nvmem/meson-mx-efuse.c | 10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

-- 
2.21.0

