Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D88FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EFC2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263667;
	bh=kfzpepb7fGSIONoXWEvpmOfepPP8bfAsuuweC3L1zEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bXD3EzZY7YDZ1IfQrk+yd2yBGet2OHHGjObX1R8VgvGpIn80AFI3dr1P6VnwaSHxp
	 u8yfWJpQH9T1tdFn0v4u1Vo3lidHxhFJCw3aUZ893khLt5bMt6VvaGtJJ9p+SeEpcN
	 WDxXeyD3LVSoX59q6XQYegC8OLOLvk13cBiHXTTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439073AbfJPWHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395553AbfJPV6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:04 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 022ED21D7C;
        Wed, 16 Oct 2019 21:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263084;
        bh=kfzpepb7fGSIONoXWEvpmOfepPP8bfAsuuweC3L1zEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDRdexTcwi5HzIt05t88DCcOFOXPXii2RY1JEfOjqpXvvBIVQBFu9Q7zkAjVHILv/
         V2zaMSmcLsL7cWLRXxwP5lPh8N23x9j3BBOHUKL4x6ttT6Sh4reEoayqO3HVkgh+l3
         s22sI1TvVsqXRUwlXKsI06PSYXhZagfMIrX4Cjwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bruce Chen <bruce.chen@unisoc.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.19 42/81] gpio: eic: sprd: Fix the incorrect EIC offset when toggling
Date:   Wed, 16 Oct 2019 14:50:53 -0700
Message-Id: <20191016214838.464592821@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bruce Chen <bruce.chen@unisoc.com>

commit e91aafcb51f3c5001ae76c3ee027beb0b8506447 upstream.

When toggling the level trigger to emulate the edge trigger, the
EIC offset is incorrect without adding the corresponding bank index,
thus fix it.

Fixes: 7bf0d7f62282 ("gpio: eic: Add edge trigger emulation for EIC")
Cc: stable@vger.kernel.org
Signed-off-by: Bruce Chen <bruce.chen@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-eic-sprd.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -529,11 +529,12 @@ static void sprd_eic_handle_one_type(str
 		}
 
 		for_each_set_bit(n, &reg, SPRD_EIC_PER_BANK_NR) {
-			girq = irq_find_mapping(chip->irq.domain,
-					bank * SPRD_EIC_PER_BANK_NR + n);
+			u32 offset = bank * SPRD_EIC_PER_BANK_NR + n;
+
+			girq = irq_find_mapping(chip->irq.domain, offset);
 
 			generic_handle_irq(girq);
-			sprd_eic_toggle_trigger(chip, girq, n);
+			sprd_eic_toggle_trigger(chip, girq, offset);
 		}
 	}
 }


