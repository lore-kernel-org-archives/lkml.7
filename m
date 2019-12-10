Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C8C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3348E2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j54TP/nA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLJUJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:09:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44541 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfLJUJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:09:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so21538171wrm.11;
        Tue, 10 Dec 2019 12:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6AQpS5vqGgn6cf28d0t5hILD50hP2Bm2ar9YDrMWAUM=;
        b=j54TP/nAwGznoZrN5sbykaR8He5pb7OtuziWr36u24bFjtgGC4fQqmYI7bt0kQ38Qz
         AIIBe0vVsCM7FpOz0f27YlcWHKCgzIuAx7vTuT4eMaNThvOD+jLiiZDSAkx0gylHcr8R
         lQ1uKTx1wQOijjR0jD4PsHKZ8GtZ1JqwSElf5tOW344+hb00eWcRKg25W0y9nlwXFTwO
         4eCh01Ccn+W/AYaYvwNxY7ecHXsrmeWhzU7dg3GtqxJd/YFZpbVffV9zh31G4a8xmoqq
         acMn+8dd9s/BK4xl7KbvCHa6yaKsJRYFirKOgOPqreB84RBGY39kNaYP+wIVoIe0uNp5
         6fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6AQpS5vqGgn6cf28d0t5hILD50hP2Bm2ar9YDrMWAUM=;
        b=L2t8D7IEqJB7L3kNpoLLXl73+iiCe/zr4iULV1An5FXx0FNeOZEZAqiiOztLWn2J8e
         qmkMbeX+RNJr4Jryj51cIgBoeGixYXC/u5FEoLbPv4EAKH3zxKjQkjT/vJ5gQ7KsGA1z
         8PEw2uWwyikoZ2PZrKmBGxFvmbNbK/N9wi04UGe4nq71XHn5fylyMv3QMC2zKYv3lMnL
         U5FMbvZWPeRcH8QJBZH3uXC5G1EGrHupZf1N0SRG9Ek8ahvP9fDpES1YzlAvZbDHdFF/
         4a8PMLr1xU7aXbj6XX6+fp/jCiBs/TMp7sm/Z6hLzR1jzRbzA5TM6yxc90/o4muUFnYi
         iQKw==
X-Gm-Message-State: APjAAAVpytTHvBPz+njRzSlg5SlulQaWP/rCzTpIqPBt8Gdfo8aBFJlj
        3rl/x96KIsAPYpXU3h5oBHE=
X-Google-Smtp-Source: APXvYqxMVlaHW5ay98kOIFO+brzIC+QLtbbjUCNbwV2fRMJftfklsg7j/ydpu5uw9XjJbdY3Vj3f5Q==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr5177155wrn.155.1576008552975;
        Tue, 10 Dec 2019 12:09:12 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w19sm4113643wmc.22.2019.12.10.12.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:09:12 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     kishon@ti.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 0/2] phy: brcm-sata: Support for 7216
Date:   Tue, 10 Dec 2019 12:08:50 -0800
Message-Id: <20191210200852.24945-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

This patch series adds support for our latest 7216 class of devices
which are taped out in a 16nm process and use a different SATA PHY AFE
that requires a custom initialization sequence.

Thanks!

Florian Fainelli (2):
  dt-bindings: phy: Document BCM7216 SATA PHY compatible string
  phy: brcm-sata: Implement 7216 initialization sequence

 .../devicetree/bindings/phy/brcm-sata-phy.txt |   1 +
 drivers/phy/broadcom/phy-brcm-sata.c          | 120 ++++++++++++++++++
 2 files changed, 121 insertions(+)

-- 
2.17.1

