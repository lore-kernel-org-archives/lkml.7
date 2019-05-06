Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41706C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0913B2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154531;
	bh=UukgufM9/vhDOz0WdQ0i3a4zD1CH0CaTiYFaHkKz0a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v11wYkFai+iARqVrTJpLKzIEVRQDrSisrKz6hw5scotvruzm5U/PcGrSBJS1usoeJ
	 Crd2EDk4RxNcFRW8ILrJc7gUF9XVJ49iVshgBBBRkV7pZClgCPBBeEBH5JCiQHZvpC
	 ivEwfiW9/zIXbLlKCOj4ee/CFFtf7xWvlAcK8p7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfEFOza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfEFOpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:45:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C33A2053B;
        Mon,  6 May 2019 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153953;
        bh=UukgufM9/vhDOz0WdQ0i3a4zD1CH0CaTiYFaHkKz0a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqRHk5pzU1/0oRxA1xWoRtIJR59vmOW+t2rSsmjnp2qKNaghmtrKWc0p2b1GEHC/R
         9bms3BFw8L2+NIqQCoAtIe5BbeUUf2FJYuEwj1VAvaZ7vSaU35mzv7h7nncGdaoe45
         VosjWsVorUVSOlznIQASShhsjxjH7j6nd2zCPKqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 59/75] Bluetooth: btusb: request wake pin with NOAUTOEN
Date:   Mon,  6 May 2019 16:33:07 +0200
Message-Id: <20190506143058.626686512@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.287515952@linuxfoundation.org>
References: <20190506143053.287515952@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

commit 771acc7e4a6e5dba779cb1a7fd851a164bc81033 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2893,6 +2893,7 @@ static int btusb_config_oob_wake(struct
 		return 0;
 	}
 
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&hdev->dev, irq, btusb_oob_wake_handler,
 			       0, "OOB Wake-on-BT", data);
 	if (ret) {
@@ -2907,7 +2908,6 @@ static int btusb_config_oob_wake(struct
 	}
 
 	data->oob_wake_irq = irq;
-	disable_irq(irq);
 	bt_dev_info(hdev, "OOB Wake-on-BT configured at IRQ %u", irq);
 	return 0;
 }


