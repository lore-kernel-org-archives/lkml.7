Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA6CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E186F21BE5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569778597;
	bh=Qdk2g6rFXA19O83ksX68LoEMe9e94G5/RP8eW++x/4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cPrBWFkSyPOJ+lfPDYPg4xMzplwcf6OZmykgzomCGVFGiVpbRDtY4XfxuZqVlWVq9
	 6IwU7cAiAN63i1M2GzUK5nFSKo03osYnhwURcMQIaYoYRb6NwBVMZPhBXg/2Zy63qJ
	 aAQawST/AmSo/joOrrArDC9EjzaWIxGfqXWl1r5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfI2Rgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730851AbfI2Rgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:36:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9470521A4C;
        Sun, 29 Sep 2019 17:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778592;
        bh=Qdk2g6rFXA19O83ksX68LoEMe9e94G5/RP8eW++x/4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejEVjfkgRTK9E4pSfIxHOHCt4bEV+uyOBKlBNfP/2M911ZJEV+ROM68j7Uv/gqcoc
         XKfYOcCTZDSiCMT6eJTtP8rboAjfo5HgHoojlBtSa6GdOU9uSMd0wRgBBQIRPnpLpy
         95gwSInuHKh2rNVgG7Ed9vvs+1zVliMHBWCB2FQw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 03/13] mfd: intel-lpss: Remove D3cold delay
Date:   Sun, 29 Sep 2019 13:36:13 -0400
Message-Id: <20190929173625.10003-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173625.10003-1-sashal@kernel.org>
References: <20190929173625.10003-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 76380a607ba0b28627c9b4b55cd47a079a59624b ]

Goodix touchpad may drop its first couple input events when
i2c-designware-platdrv and intel-lpss it connects to took too long to
runtime resume from runtime suspended state.

This issue happens becuase the touchpad has a rather small buffer to
store up to 13 input events, so if the host doesn't read those events in
time (i.e. runtime resume takes too long), events are dropped from the
touchpad's buffer.

The bottleneck is D3cold delay it waits when transitioning from D3cold
to D0, hence remove the delay to make the resume faster. I've tested
some systems with intel-lpss and haven't seen any regression.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202683
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel-lpss-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 9ff243970e93e..5b41111e62fd1 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -39,6 +39,8 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	info->mem = &pdev->resource[0];
 	info->irq = pdev->irq;
 
+	pdev->d3cold_delay = 0;
+
 	/* Probably it is enough to set this for iDMA capable devices only */
 	pci_set_master(pdev);
 
-- 
2.20.1

