Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A57C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414B821537
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329620;
	bh=8UdnhDRDCXVmHeHGWPfuIs+09ukLnHnS9IVuTpCx35Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dbjeRlvKTtjuHfrTTxQqy8qy+5zZusdokEnfwntJxr1QzklXR9FKGLYugIFiJCjDF
	 OFQGGj8d3kc8GqCMg7TI190+kNeAfAqJHh75V+aT6vB8Nthd5JgIiUIb6bLg3dtNBN
	 dhlXbVIqpq3rcHRR5SyljWB+IxCxrJWz5kvbqQpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfD0Bq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbfD0BnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36FDC215EA;
        Sat, 27 Apr 2019 01:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329387;
        bh=8UdnhDRDCXVmHeHGWPfuIs+09ukLnHnS9IVuTpCx35Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQTRR33/4j/mpnfCv5N+D01MD0Mod3hbPTgbNa1jjkK56eta4Fe1vcMYkfdon4AQS
         g6XuCxCDfY4TcljcSCof96Ws9PZlNKvV2TbzYmjIR1Ju1DeOHSQeRQDAFYSyifL+ak
         85RHpRhG8ifvliSVLa3aH4hFD3DZ85pKqvWrfV/g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brian Norris <briannorris@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 24/32] Bluetooth: btusb: request wake pin with NOAUTOEN
Date:   Fri, 26 Apr 2019 21:42:15 -0400
Message-Id: <20190427014224.8274-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit 771acc7e4a6e5dba779cb1a7fd851a164bc81033 ]

Badly-designed systems might have (for example) active-high wake pins
that default to high (e.g., because of external pull ups) until they
have an active firmware which starts driving it low.  This can cause an
interrupt storm in the time between request_irq() and disable_irq().

We don't support shared interrupts here, so let's just pre-configure the
interrupt to avoid auto-enabling it.

Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
Fixes: 5364a0b4f4be ("arm64: dts: rockchip: move QCA6174A wakeup pin into its USB node")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b8dffe937f4f..dae8723dde8c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2893,6 +2893,7 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 		return 0;
 	}
 
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&hdev->dev, irq, btusb_oob_wake_handler,
 			       0, "OOB Wake-on-BT", data);
 	if (ret) {
@@ -2907,7 +2908,6 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 	}
 
 	data->oob_wake_irq = irq;
-	disable_irq(irq);
 	bt_dev_info(hdev, "OOB Wake-on-BT configured at IRQ %u", irq);
 	return 0;
 }
-- 
2.19.1

