Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7658C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 23:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EF8206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 23:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adPF2rXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfLJXfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:35:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39567 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfLJXfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 18:35:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id d5so3521423wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 15:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aPVFdQIWNj16ZK5RdjBKbqDPawIqCxaDmrjeIuzNinU=;
        b=adPF2rXzMF8gO757e5fLYqNf/NWfsMRveDYLbZkuTCkMirY9OWNWSontRZyC2R75eI
         wNd2hHSyTgz6mMFoW1mcQcjch/WjkWGndnjPV4RHaOlukq8MDxL0eSelvQT92CXnve4R
         oZ/XdQOoceuTnnMnGlswiJiP7Mj85DOuBAnr/1LE3xvVosSTeST0eRfA1MSxxnhKilEJ
         557jja9A+qKYnGrcFE7FBKawYUjsjTEnd7O1KfRTyTMpPgAmCnv/oRLerMKQi9pEKcyd
         1wd+y4izFFTi1tzuQ5bQmXi7XFBUxDb1wcnd9yyoAnY2C6x3hYHmefS8Vb6DyDsMS2hj
         uLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aPVFdQIWNj16ZK5RdjBKbqDPawIqCxaDmrjeIuzNinU=;
        b=S0dimu+VhobWC6SmBPDJj4laYTjdS+YjI0W2oUVWti7kiIgbMPo6mguRNvGfqJRE/X
         v4tjqvMNHTDp7GfxyvoC3PQ3VxqFF2hwtM/rAK65aiDbLgB+XTKP7VtTFhWV3Y3/GqkS
         FV4U65QJRmgWEOEzJdGykYfOAZGbwBgCqeQzgY8ZOylbwllXycsfm95hV6i5+X92cgK2
         j9F5MOkThbayxgVU9WvEMLTv7DC4WMq8d6qwD5CvYMHAlfN0zaRklUWXeaxTVk79MFJR
         asHFd+b2ZqV/7C4h/eSp0nYhZZSqStQz4TkYyc4Tulm4CO0ULzncxa7LhAJWmR6rHnXF
         wNHA==
X-Gm-Message-State: APjAAAViwPEMr6qRzA3N7EyNB0xNnUMG6IuusteuvAgns9ulN7j1o5nX
        gV9XEIqDw3x6x6WKWHHWRbw=
X-Google-Smtp-Source: APXvYqy8Ksgy0PPntHDhclphM607VPHVR5PA0lJyIgfy7XCtzEZHiOuGylmR1rQ3R47lf1vDApknGA==
X-Received: by 2002:a1c:a9c2:: with SMTP id s185mr1046723wme.119.1576020917919;
        Tue, 10 Dec 2019 15:35:17 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm59478wro.88.2019.12.10.15.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 15:35:17 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/4] soc: bcm: brcmstb: biuctrl updates
Date:   Tue, 10 Dec 2019 15:30:39 -0800
Message-Id: <20191210233043.15193-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series updates the Broadcom STB BIUCTRL register code to
support the latest and greatest chips (7255, 7216, 7211) and also fixes
the 7260A0 and B0 chips to use the correct tuning parameters.

Florian Fainelli (4):
  soc: bcm: brcmstb: biuctrl: Tune 7260 BIU interface
  soc: bcm: brcmstb: biuctrl: Tune interface for 7255 and 7216
  soc: bcm: brcmstb: biuctrl: Update layout for A72 on 7211
  soc: bcm: brcmstb: biuctrl: Update programming for 7211

 drivers/soc/bcm/brcmstb/biuctrl.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

-- 
2.17.1

