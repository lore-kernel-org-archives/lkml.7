Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6A2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096ED20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRXUec85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfDZQme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:42:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37192 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfDZQmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:42:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id b12so2326094lji.4;
        Fri, 26 Apr 2019 09:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIYxhFesKlaJKvCRd5GEV8ylksbPoPuDhuxnZyXe+lM=;
        b=lRXUec85QpnTxn4JvXTirbpk3YDLK9pwaQeCnDS4NARagx9m39Zx/hVvr3S2Lmgp/h
         KKOemYgeryLlHNOraH4Ji3Y3ZcIQRR08w4OanwX9C5jhUDewsmch0BNtTX9JTAmvDbyv
         8kGh4NZ6SPHmlE8fUHdc/PmgpaaPSd/4wrDcA+NcET545xPSBK4zoKnRcd5PLCVxb7+2
         Ritnt/Vp+r5wYoz0ZpAqMlesRRnNjpR2jy64HZrFCxk2fkyFWPTj8ets5eJ393V5twJ2
         j07rmJX9gDKEjxlsDCEbMEKTlAOiw4wv4flUmbbp+2ORaTtdApFjPrCFsfVfqJ+sss1M
         SNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIYxhFesKlaJKvCRd5GEV8ylksbPoPuDhuxnZyXe+lM=;
        b=RCo9j/YLyUCNC/O2wEipUQxTslc6et5ZzDOIrAJiIRL4sYz4/yrU0CCSDXoUU8s0uY
         7gSClk52/C4UEyIudKIGAjAlnLobKxkFpajUvZMQFcq+cFxymr6uPz9onLwDLp4XOo0q
         e5qe5pu4GA2HTuBjrAbVZz9GcVs65GGC8QDwNDxw6GO3VQ8/rQmUNQiGkk0Ra7Mj3+0O
         j1VJt/CGVauDphLvKdqVLWUJq0aIl6T5CAIbYhJRQVQytGXxV4A1X3STaQ9JzTKb0cI1
         AVOu6uMc/skLo13MDQOzuwr38zqnV/jslsNlkW0wLwpBHSiPLbVBGshwOMzcqn8lfNm1
         8xiQ==
X-Gm-Message-State: APjAAAWXzbKnGgczm9p/wH4uA+eE6X6Rorl0sSU1AmyrlqGy9cCtwhHN
        V29NG5YH9zi+kmJoJkpxAeUciL8ZTes=
X-Google-Smtp-Source: APXvYqwnNJiHlf02rN+ACkV4g64q2KKcXUgBUke5zUTcY9Yefu5Am1AfvEZno46Ulb+ciDdly7da6w==
X-Received: by 2002:a2e:978c:: with SMTP id y12mr12706542lji.70.1556296951171;
        Fri, 26 Apr 2019 09:42:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:2492:ad61:69f1:23cc])
        by smtp.googlemail.com with ESMTPSA id q11sm5637807lfc.51.2019.04.26.09.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 09:42:30 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kyungmin.park@samsung.com
Cc:     bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 0/5] mtd: onenand/samsung: Add device tree support
Date:   Fri, 26 Apr 2019 18:42:19 +0200
Message-Id: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds device tree support to Samsung OneNAND driver.
It was tested on Samsung Galaxy S and Samsung Galaxy S Fascinate 4G,
an Samsung S5PV210 based mobile phones.

Tomasz Figa (5):
  mtd: onenand/samsung: Unify resource order for controller variants
  mtd: onenand/samsung: Make sure that bus clock is enabled
  mtd: onenand/samsung: Add device tree support
  dt-binding: mtd: onenand/samsung: Add device tree support
  mtd: onenand/samsung: Set name field of mtd_info struct

 .../bindings/mtd/samsung-onenand.txt          | 46 +++++++++
 drivers/mtd/nand/onenand/samsung.c            | 94 +++++++++++++------
 2 files changed, 113 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/samsung-onenand.txt

-- 
2.20.1

