Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF461C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB0824D4A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559622239;
	bh=gLtAailyS6IJm8z2V2PeInJ4Zh8RQw5AhexkL1edZlQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GCfEO+QlzFpmRK1y/q3hcGb/YHBa28UUVGssEWsF2CgkhbvFfLmn0YV4Qe0VFY7mZ
	 7YRH9i5WK16r0HsunUyW+yqOf/sSMmBqkKAJdtC9zJe4eMHVQo8JEEvRdFgvOC0qyc
	 j91HIwKFk0fl8FDmzL7b+kPhzp8F0j5QWzpsSuo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFDEX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 00:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfFDEXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 00:23:47 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C498D24CA4;
        Tue,  4 Jun 2019 04:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559622226;
        bh=gLtAailyS6IJm8z2V2PeInJ4Zh8RQw5AhexkL1edZlQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Cam4pLTngHKbpei8gF74EopX7nX49t8VOukQeGIYWDwfJxCUpn/HHzpXC/6yv3Lbi
         mD9+WZgi6RoCqqxVoYLpJTJxAwCO6UQqV89tXiAwC6xD/1tDPHs0ghtyCHW8ha9Kzn
         ENTn73F6Rk+QP+lOB42/QBxsDkFAKrCPa5JpXW2A=
Received: by wens.tw (Postfix, from userid 1000)
        id 6A0A35FCDF; Tue,  4 Jun 2019 12:23:43 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Vincent Donnefort <vdonnefort@gmail.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] rtc: pcf8563: Fix unhandled interrupt storm
Date:   Tue,  4 Jun 2019 12:23:34 +0800
Message-Id: <20190604042337.26129-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

While bringing up my Pine H64, I encountered an interrupt storm from the
pcf8563 RTC. The RTC chip's interrupt line is shared with the PMIC, and
was not properly added to the device tree. Also, the driver was using an
trigger method incompatible with the PMIC, preventing the interrupt line
from being shared. Last, the driver only clears and masks the alarm
interrupt, while leaving the timer interrupt untouched. This is a
problem if previous systems left the timer interrupt enabled, and there
was an interrupt pending.

This patch set fixes all three issues, one per patch.

Please have a look.

Chen-Yu Tsai (3):
  rtc: pcf8563: Fix interrupt trigger method
  rtc: pcf8563: Clear event flags and disable interrupts before
    requesting irq
  arm64: dts: allwinner: h6: Pine H64: Add interrupt line for RTC

 .../arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts |  2 ++
 drivers/rtc/rtc-pcf8563.c                           | 13 ++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.20.1

