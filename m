Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86157C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C1C217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Dt+aF7pK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfCON5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:57:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32822 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfCON5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:57:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id i8so9710242wrm.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eXn3G/Dv/jMf0Zy1oiULOES6u/xLdhm6zlhAgPsnjl4=;
        b=Dt+aF7pKkaI2ErQpqL022yb4QLPaktxnpZqKzJp+huBIVCJQdb/IAoOrjE2uVfspbA
         SY8qEc5hYbgXMF/OfdhUDjztTgpvmqNwLDx2jx2KoCqtqYRmaRqxaLuszYectqennN+J
         fAq9xA4wwdFDZYpMh+HXpbjNjhp/2f/Tg3wLyU/lXrbP94f25PX6HFHFUtPN2ZmmLlCu
         F16V+5gM9RIUl6fdefzwgRfej2u4Ynu0rn7jfkO/0GWYjydU4o73FBKbs7V0bG2teCcI
         Fb9UqYJ+msVJkrc44pbpOjQ75jwhYIgLbIbo1THM0lABVpSEngNBeITPWgdqr3XjX5G0
         6HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eXn3G/Dv/jMf0Zy1oiULOES6u/xLdhm6zlhAgPsnjl4=;
        b=fFxJtcgjU1pGBCbjZLQ2wntDpwfAZwSkAW0PkJs7pE8dtesIdO2WufpNDDz1wwEXBo
         bym80uscNIachUoczD6N3dMTtZRa2bi5ZscsOoc6dqavqCbtCPOiR0EgQYdUhZjBLV0N
         jfP9oFtjwzwTGVQ9kQAPfKevwlAx1ygZHGPUbyqEijbP58lWSkOKt6yeGCw3ncMgvvPV
         VV4o5i5zwrwR0eTO/ucJJDzfKhVIivTdwCKMMKdKi8t/PgGi508qR4FQddNHKHbM0xjf
         4zxhaxVo+mQ1Y85MkJuwnKdTAiGalc6Tng5LHq2FwfuIrrwAMfK/hRQNFknyBv0/pWpt
         pM/w==
X-Gm-Message-State: APjAAAXg46qChIZdmclQuHRRSItep96o+xT7vlwVVncUmsKe8iAHqt5L
        A4uZpBde77vOe+SlU2SLH2524w==
X-Google-Smtp-Source: APXvYqwZ40ySoOedl3XMletCrmpyZ4NeWqtqXb4cL0ltD+zaaaZ9dJz9ZkiUegy+1UbPTPzhkNAA8Q==
X-Received: by 2002:adf:e3ca:: with SMTP id k10mr2475797wrm.277.1552658218670;
        Fri, 15 Mar 2019 06:56:58 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a14sm2131900wrx.96.2019.03.15.06.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Mar 2019 06:56:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: meson-gxm: Add support for the Mali T820 GPU
Date:   Fri, 15 Mar 2019 14:56:53 +0100
Message-Id: <20190315135655.28359-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds :
- Optional reset properties in the midgard bindings
- Mali T820 Node in Amlogic Meson GXM DTSI

Changes since v1:
- Updated midgard DT wording following the recently submitted 
  bifrost bindings

Christian Hewitt (1):
  arm64: dts: meson-gxm: Add Mali-T820 node

Neil Armstrong (1):
  dt-bindings: gpu: mali-midgard: Add resets property

 .../bindings/gpu/arm,mali-midgard.txt         | 14 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi    | 27 +++++++++++++++++++
 2 files changed, 41 insertions(+)

-- 
2.20.1

