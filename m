Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED8EC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD7421473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="a1B4CJaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfENO05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:26:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40958 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:26:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id h11so3012793wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xo30xwvbJA7vC66mclDC+YHAOBu9mjboSFr2MJ8sIkM=;
        b=a1B4CJazlurgVaQLDCYH/QOGHp+/p5etIFGptl1W62ONAx6U3RDXJXTKd2M2P39Gek
         aFEKW4XmW9mBars8x0oQfyOljHLaWGC3IDMQxIe51gkJ9nBLU524QESKxwDuoeKdmPd0
         i1wzZnfEtllMr7ZKgIgeJRk7jgAv01EIsOjwPZiQ9+D9kEpqdtjQO/crlDsp39WkskPF
         ybRAUTiYNNsHQLl6Mi6TKidPWJnX0yRwg93HPaiwF6raYh22p0LpMN/rQa3/o6tg8BTK
         VS8uNVsuXMvp7E5B9EOV9QHGUEnAwI2DuN7nqHRFovcdQrsJZwTAnu3mJJoY/PEFqUEh
         W/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xo30xwvbJA7vC66mclDC+YHAOBu9mjboSFr2MJ8sIkM=;
        b=V0lHqWHAO/bEjSxAq5JJo/nwLf1T0DJokcpgclIUw/AuK4tLqGozNs6WVWLXQVMihB
         uLFVdznvQCNeUnNR/+hJ5UHn0jQ3pfGaGnZVcnufQbpgqHXV6Zm+5KBO2NQVdDbKds+P
         1IG/AWzWwjUGm/Sg6tlacvE5RWuzyeTgbURaAKS9JOGwG2LVk5q3o24gzxF9JD0UEZPT
         RDb7+kzy4G7ee/xVjmHF7uYQP9/dpg0d2vglLnehDUtM91Mx0CuOsxQUti38qCAwZRPR
         Tl8gpD1jKe8eHvGcYWhMCa4mWjFKkV6m0o4AMXdGnvgysDiqeCtHrFK0BPprcljMjS+6
         PCrA==
X-Gm-Message-State: APjAAAXlumOfU4t4HvPXquadFvDo3CP6DpOd+8mBTVMe9pmmYxUyxsT4
        IVIrCzYp/hzqveS2OH6WJ8Kfyw==
X-Google-Smtp-Source: APXvYqyxM8SBZKfuvPU5hDHnz2X0CskNKmcHoNnyDsUoWSQq5AQWOIwbyW+/3fdboHLdg35Qv7soLw==
X-Received: by 2002:a1c:7a12:: with SMTP id v18mr4071578wmc.69.1557844015433;
        Tue, 14 May 2019 07:26:55 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h15sm12343642wru.52.2019.05.14.07.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 07:26:54 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] arm64: dts: meson: g12a: add audio devices
Date:   Tue, 14 May 2019 16:26:41 +0200
Message-Id: <20190514142649.1127-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds audio related devices to g12a SoC family.
It adds the clock controller as well as the memory, tdm, spdif
and pdm interfaces.

At this stage, the HDMI and internal audio DAC are still missing.

Notice the use of the pinconf DT property 'drive-strength-microamp'.
Support for this property is not yet merged in meson pinctrl driver but
the DT part as been acked by the DT maintainer [0] so it should be safe
to use.

Changes since v1: [1]
 * Had missing axg compatibles for the fifos (one last harmless change ...)
 * Fix a few underscores in node names

[0]: https://lkml.kernel.org/r/20190513152451.GA25690@bogus
[1]: https://lkml.kernel.org/r/20190514111510.23299-1-jbrunet@baylibre.com

Jerome Brunet (8):
  arm64: dts: meson: g12a: add audio clock controller
  arm64: dts: meson: g12a: add audio memory arbitrer
  arm64: dts: meson: g12a: add audio fifos
  arm64: dts: meson: g12a: add tdm
  arm64: dts: meson: g12a: add spdifouts
  arm64: dts: meson: g12a: add pdm
  arm64: dts: meson: g12a: add spdifin
  arm64: dts: meson: g12a: enable hdmi_tx sound dai provider

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 1233 +++++++++++++++++--
 1 file changed, 1142 insertions(+), 91 deletions(-)

-- 
2.20.1

