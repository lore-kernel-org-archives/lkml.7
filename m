Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00E0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A84F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hT0cTPjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfCMXw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:52:26 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34822 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfCMXwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:52:22 -0400
Received: by mail-yw1-f67.google.com with SMTP id s204so2991113ywg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 16:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=f+t4V07aCemw8cZpkvomwq06lLcOjBQtHDVqyar9YBA=;
        b=hT0cTPjXYGOkK0QYxz1vIbcPOencR1uY+jwZquNNLCpAS0wnZauC8/nIJDkVWriCU8
         epif7zG1eX9SlCt6Z0Rsi55TK+GCQVV15X3qjJvRN9E/GE93nca2ZLtn0nqg/Ocwc3ZD
         in9yC6edNVQ3ZeARWnwtLoUB9PtSIO1JwnQM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=f+t4V07aCemw8cZpkvomwq06lLcOjBQtHDVqyar9YBA=;
        b=BD/uJzwE4k1SvJfxa2RRlbfTH1G8lDHWZblPMItvkOfcLfgN/Pq3z7OGQkSWNhMkXX
         A+ZjCx0CtmVCWBcrDdxswWKSptrB4cJG7Mqn0DpBWDbCarIn8MYtpgEpvesuP6Ukplpe
         VzCB2GyhI1GbiQR3xzQD7lofSj/8PSpN3oKkivAbRnVYUwTd0YRIIpt2DiTZOgz6Fhf0
         tKEi6JjU9FfG00kQapPnAOd+FD6YWQyT6ThP/yphtIUatO4oy4rR7mUeAJqXsdUpJ94/
         YoNOm5WwHu37CLVCHUkIzyryiRoPgs2u7KITTVqYazBEBYQYQGo5u82IGJYROND6J2hk
         9mGQ==
X-Gm-Message-State: APjAAAW/+fNHAvrJjkpdYxE9106SboQ7qM5f0yjpzYzazqxifQUkYnwn
        V6AqQH73+irC1sI8l6HgGbyVnsuYQWEVCAT+PpiJZA==
X-Google-Smtp-Source: APXvYqwh3mIabiSaIYbmTUO5xzXNp0J9huZbdniT74h4eblzaCj8E3NlWVfGYe7CWfT4K91Sll0tEsWNy4ivQ/yf/ug=
X-Received: by 2002:a81:7a94:: with SMTP id v142mr16143111ywc.221.1552521140654;
 Wed, 13 Mar 2019 16:52:20 -0700 (PDT)
Received: from 764776645087 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Mar 2019 16:52:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Date:   Wed, 13 Mar 2019 16:52:19 -0700
Message-ID: <CAG5bF+TCPc=m_O33RHXHrt34T1Dz1zHLSkXfpxAoOTmrffGJ7w@mail.gmail.com>
Subject: [PATCH] Bluetooth: hci_qca: Fix crash with non-serdev devices
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qca_set_baudrate() calls serdev_device_wait_until_sent() assuming that
the HCI is always associated with a serdev device. This isn't true for
ROME controllers instantiated through ldisc, where the call causes a
crash due to a NULL pointer dereferentiation. Only call the function
when we have a serdev device. The timeout for ROME devices at the end
of qca_set_baudrate() is long enough to be reasonably sure that the
command was sent.

Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm
Bluetooth chip wcn3990")
Reported-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reported-by: Rocky Liao <rjliao@codeaurora.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4ea995d610d2..714a6a16f9d5 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1004,7 +1004,8 @@ static int qca_set_baudrate(struct hci_dev
*hdev, uint8_t baudrate)
 	while (!skb_queue_empty(&qca->txq))
 		usleep_range(100, 200);

-	serdev_device_wait_until_sent(hu->serdev,
+	if (hu->serdev)
+		serdev_device_wait_until_sent(hu->serdev,
 		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));

 	/* Give the controller time to process the request */
-- 
2.21.0.360.g471c308f928-goog
