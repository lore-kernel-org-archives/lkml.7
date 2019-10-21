Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC805CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45DA2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xEhVtga6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfJUK62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:58:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37287 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfJUK61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:58:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so12292741wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=M+Rr/WbPC8m7dZLhfszJHtex79KIwoH5LRc6fwcboyc=;
        b=xEhVtga6MQRbG6XAjBCACpSU2T15US9KjrquctDHuyVAap92YsR4cpqZxx2G5wqwtw
         ua/RA9+ma6tcuCAlgqO8oSmy3+2IFSb4BlVTWZKEGr9GajuSihUV3DE8khNmcmFYtiMF
         MEqNJ2rvrw0GjYVb3MOf+F/qm7FO0UNbewTyd1M1m3C0ymePmRk2531mV+YdyoGtf7ig
         AL/rCtOUhQyNJtiBGvKqBYud+v2dZIN/s0VGGekoBELHF8OeUGVWQTIe4l2CNXt0TB9H
         wuaXEWJhnF/8GTR5539dLHqIVqAL7baluYHVUg3fBY2GlvEJ7+ZZIxmAMU/eZFjCFrXd
         UcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M+Rr/WbPC8m7dZLhfszJHtex79KIwoH5LRc6fwcboyc=;
        b=ELV+U4qN0olLrgOQ0g07rhizvwi2Ts5eD7zLqJIVeOFWOTGlePspX1xyigOK3dB8ho
         5QKPA4L3BavQ3cExxqmEA5i6xUmauNnYKHKTRsW5fRpt619y6dC655Q1Ir5KZzcp7nD3
         0Bl9ZZD65MbElEIKx9cqYa/xpN/eua1NOlZmTWn0j/qHJc3+b2jghAns3VvfMVDBmK5c
         iLtGPygAckX9u1w4yPyxZN8ZDpAsaOi0Xs24dECE0BVw08gphgaeXW9LGqPCFET6iaAW
         sMuQlVh9HT4TjuiJJa5+NvesUy7KqVadO2lVHIDoeU6i7oxEs679Sz9Mh4W9FWH2Aqms
         gPng==
X-Gm-Message-State: APjAAAXN9qkdFchTsqyFYuFazHC2AU47MoJCYt/UqmJRcgi+cJOlYezj
        CnUOXtxfSREUiY3PIoMPaQEdhA==
X-Google-Smtp-Source: APXvYqyZaLFdktAFhb8++mIsfBPmw4LFdRDLPPon8Kt+H7Xg6gt/0KS3EztE21y/XGtYBi3ex7C0uA==
X-Received: by 2002:a1c:f305:: with SMTP id q5mr18617648wmq.137.1571655505510;
        Mon, 21 Oct 2019 03:58:25 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id q22sm12544289wmj.31.2019.10.21.03.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:58:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 0/9] Simplify MFD Core
Date:   Mon, 21 Oct 2019 11:58:13 +0100
Message-Id: <20191021105822.20271-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFD currently has one over-complicated user.  CS5535 uses a mixture of
cell cloning, reference counting and subsystem-level call-backs to
achieve its goal of requesting an IO memory region only once across 3
consumers.  The same can be achieved by handling the region centrally
during the parent device's .probe() sequence.  Releasing can be handed
in a similar way during .remove().

While we're here, take the opportunity to provide some clean-ups and
error checking to issues noticed along the way.

This also paves the way for clean cell disabling via Device Tree being
discussed at [0]

[0] https://lkml.org/lkml/2019/10/18/612.

Lee Jones (9):
  mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and tidy error message
  mfd: cs5535-mfd: Remove mfd_cell->id hack
  mfd: cs5535-mfd: Request shared IO regions centrally
  mfd: cs5535-mfd: Register clients using their own dedicated MFD cell
    entries
  mfd: mfd-core: Remove mfd_clone_cell()
  x86: olpc: Remove invocation of MFD's .enable()/.disable() call-backs
  mfd: mfd-core: Protect against NULL call-back function pointer
  mfd: mfd-core: Remove usage counting for .{en,dis}able() call-backs
  mfd: mfd-core: Move pdev->mfd_cell creation back into mfd_add_device()

 arch/x86/platform/olpc/olpc-xo1-pm.c |   6 --
 drivers/mfd/cs5535-mfd.c             | 124 +++++++++++++--------------
 drivers/mfd/mfd-core.c               | 113 ++++--------------------
 include/linux/mfd/core.h             |  20 -----
 4 files changed, 79 insertions(+), 184 deletions(-)

-- 
2.17.1

