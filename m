Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4648FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144D82084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e2Pwq8N+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfDLJXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:23:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44570 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfDLJXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:23:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so10979461wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6c5xGsgEUsBmr+NfEPZmljbvAMnY7PKQByP0HLkSwg=;
        b=e2Pwq8N+XLbow9tRHSQP4MLvNZNC8O0Kzpx94hFulcpf6DCqJHmyJb4BhB69iV181v
         rMj7qeb3B8+t+9M9emNOfOsLxsA0D/DHVKpHxMSNyuPdlywcG3i6fZjYKYBu8n5Kt+Hb
         I/lGi/35kXN/8KYe76Ue30A4lAkqN3jBBpi6GuWLq8DlFepoZrY0C4zc7RQZHp+YHSDY
         BFw6gDksLOQAYFO8T8R5mISq10dkrbd6FyReN0nvLtxp1GKkcoJInn5Z1Ckr4FQOWeRz
         QCSwjGhaoNvs+nMHnNMA86Ruy46GeEnVWWqiighrZh5FlncK8Fjj4PvDzrkw33dDqSrb
         QOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6c5xGsgEUsBmr+NfEPZmljbvAMnY7PKQByP0HLkSwg=;
        b=awtEGCjigCHjFZvR76NvCRB4YV7MDLUh+Oox1F9tT8eL8qU32IrXM5n8GaECxEUT/o
         ZJLFKhYGPoCForuAexIkvOd27WbbMwjPLc6BVTInicAgpnUGtUKhWVevdJWw3I6mAiEp
         5PqY93/qKj1cvDCaStJqYwkfj6WYWX/UVgFU2FuR7tbji3pm0t3lErEW9pmzPhcWz98v
         HF5lSTpAEiiExoOstIxTQHf9PfPuAJwXpuHl171Y2NgK1isXXJqERFW61J0KQMfLVeTI
         efnUoCsa3IVSrdBbR4XThwhizHtlC1SyvAMAx7LzCE4d98Ji0e315VdVgJlvML2jjxaA
         oF+A==
X-Gm-Message-State: APjAAAWStV0l48dutI6bKHTi84ez+ur2w+2/vVeRQawg7BrburiqDT08
        XOYaV+g1rzt2XVGvz53Z1NJrgw==
X-Google-Smtp-Source: APXvYqyj8Gu+Ubs+zej9YnxEdsDcovDEj6rsPye3Ho5bURXKk2LkzZRoqINhMeKNdlfTQIYRoZMMog==
X-Received: by 2002:adf:e50d:: with SMTP id j13mr36968828wrm.165.1555061019438;
        Fri, 12 Apr 2019 02:23:39 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s21sm6630224wmh.22.2019.04.12.02.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 02:23:38 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] pwm: Add support for Amlogic Meson G12A
Date:   Fri, 12 Apr 2019 11:23:34 +0200
Message-Id: <20190412092337.6941-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the PWM modules on the Amlogic Meson G12A SoC
family, including bindings changes and DT nodes.

Neil Armstrong (3):
  dt-bindings: pwm: Update bindings for the Meson G12A Family
  pwm: meson: Add clock source configuration for Meson G12A
  arm64: dts: meson-g12a: Add PWM nodes

 .../devicetree/bindings/pwm/pwm-meson.txt     |   2 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 179 ++++++++++++++++++
 drivers/pwm/pwm-meson.c                       |  17 ++
 3 files changed, 198 insertions(+)

-- 
2.21.0

