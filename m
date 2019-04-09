Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FB5C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E7120833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KYy8GE9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDISts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:49:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41105 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfDIStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:49:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so9941543plj.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 11:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4is5FXMpfFs6/M7ruarZlM+xNAwN3JlFJ4HA6Tf5uM=;
        b=KYy8GE9opzQ59ZYjuvmSJuWdAwAuclcWsMmiwWRixyftrq90HyX6HsZsz7eFQe5Dla
         6SZ7fJh9WCqWogocFur616cMGEuvXuRiFupiGSmjA8D1XXzBZRMx9HcGXZ8cViuruRvK
         J/4oMzTGqvdhh1iMGzCTgkRX06Xeljr4LrPsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4is5FXMpfFs6/M7ruarZlM+xNAwN3JlFJ4HA6Tf5uM=;
        b=SvTVz+fpR0biFyb0w0mYm8QcjCyNfpKjthuAY4yYdIcA34AuAvmOaKZWKezRRkxWQP
         lbsTirlaCC8G+uTgHoaqA2UE4L293KH2pidD5RO4mk0oz1Dg6oV24yhCkk9LmW7V05TW
         w4WhB56+I1VwCsuHxWGvnJ9PN+GWT7mce+hNytuk+0Wea1ggNGAXPuz8PmJ6ji3Te62P
         XIhJdFt7mg2mW0YiWEyWH1NHZ9ysaTDQVzNXrYQW4fviCgnpq52l468qXalPzMDxldH8
         HrDea0ERtOpFMW4dAPvtzmg+Y4ia79Ff596ZMDhZ5HjfB142tTf5s5Pqc7LwqSEiuIQQ
         uBNw==
X-Gm-Message-State: APjAAAXVlyc4pWcEtKM8U7aRD9gD+0BdLBdLBdGJRh7PNIqE9bDAY8oH
        kvbsVdYdHHYgHC9ZtJYznKY3Og==
X-Google-Smtp-Source: APXvYqwmo2qCq+y4pplU42yrXsyTm+zfulcJpj32giPR+ESH4uvPp9uNLtWuQS7IGSP1GP5UapUM8w==
X-Received: by 2002:a17:902:2a2a:: with SMTP id i39mr37466309plb.211.1554835787201;
        Tue, 09 Apr 2019 11:49:47 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id b63sm92777588pfj.54.2019.04.09.11.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 11:49:46 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PULL -- 5.1 REGRESSION] Bluetooth: btusb: request wake pin with NOAUTOEN
Date:   Tue,  9 Apr 2019 11:49:17 -0700
Message-Id: <20190409184917.65062-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Badly-designed systems might have (for example) active-high wake pins
that default to high (e.g., because of external pull ups) until they
have an active firmware which starts driving it low. This can cause an
interrupt storm in the time between request_irq() and disable_irq().

We don't support shared interrupts here, so let's just pre-configure the
interrupt to avoid auto-enabling it.

Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
Fixes: 5364a0b4f4be ("arm64: dts: rockchip: move QCA6174A wakeup pin into its USB node")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
Hi Linus,

Can you please apply this for v5.1-rc5? This fixes a regression that I
reported several times. I nearly just sent a proper pull request, but I
figured this 2-line patch was clearer.

This patch was originally sent here:
https://lore.kernel.org/patchwork/patch/1044896/
https://lkml.kernel.org/lkml/20190222003051.127006-1-briannorris@chromium.org/

My other series was merged, even though it gave a clear dependency on
this bugfix:

https://lkml.kernel.org/lkml/CA+ASDXMePkQDRfaSwNGnRYyGdsuvfUCXBtDK79o2mP=1hdNQUA@mail.gmail.com

Several pings were ignored, so here I'm submitting this to you, Linus.

Thanks,
Brian

 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ded198328f21..7db48ae65cd2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2942,6 +2942,7 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 		return 0;
 	}
 
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&hdev->dev, irq, btusb_oob_wake_handler,
 			       0, "OOB Wake-on-BT", data);
 	if (ret) {
@@ -2956,7 +2957,6 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 	}
 
 	data->oob_wake_irq = irq;
-	disable_irq(irq);
 	bt_dev_info(hdev, "OOB Wake-on-BT configured at IRQ %u", irq);
 	return 0;
 }
-- 
2.21.0.392.gf8f6787159e-goog

