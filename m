Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8796AC32792
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 00:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580E02086A
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 00:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gSADe+cF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbfJDAJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 20:09:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41625 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfJDAJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 20:09:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so2751360pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 17:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJSnURvrTnKRW7XCAUl3csqPTcgWZWsUjhaWf0zhO5g=;
        b=gSADe+cFeT+SNla0USBTTbchOiQAsLsRGopRcflGKL9W5IS3MZZoAp5zvVcQxKEobL
         0+BvUipTyKtCca0sEjQt7eqoBiJ+flXQzgKMFNQ/N3iKesdiWlqD2Pp7jIcOoWLV4+XB
         FzpHiowmCWE1ZCeO9vMa6CPlQ7XWKtY/kd0+QY+sgpXwGJSt0fLhGaflhT/j+xp8gtd2
         PHvXETltk4MySeO015s3XAkDt/wi8Oo4/N5lw6i8GNafH91OOVZC+4MRN3iOXqdEr0Kl
         GUcxgD4g/eSQkLZfUvO/X9RrLxeGOqsErk1D/MlPz/mv+RVoqwl0i6AVUZ2+2u9KKfLB
         NHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJSnURvrTnKRW7XCAUl3csqPTcgWZWsUjhaWf0zhO5g=;
        b=fxmxnofdHdRpIaf6ijY12qQJ0GXCYCQkWjDRcch38393jbsArw4c99lhXG0W7VGs/j
         zRz6eVCWXFUFIkvc2Vfi/fo19n4gFTmjgZkWsQUW44Q7L4w8NO7mb+V4TzpkLn8XmzOp
         oYsqrD4DIoFf8Gx8LFSQn7niQJ0gl1fWncqASo2VtMiTOe2wG2biNL0se7JXQbTfNeTf
         TFhNy9htZfHLOuGRru2bouJ5GxB3FET0Hi+rnOvhc23pE7SvbLECc1HT7NSpG7ZpX7HU
         PGyrIcaoR7twpd/E8R+2N5xTYHXnJWDuaBuok5f9gyNCmT1qVOP1mSyCkFUDZaAiEw/H
         GipQ==
X-Gm-Message-State: APjAAAVM3IxV86iu4FLS1j4EbBs0PelvWwHa/XFekDkRsJb7wmSiABTc
        jiLbeDwedw0PPoRDIS3mr839VK5gtng=
X-Google-Smtp-Source: APXvYqxCQMs3UqvPro/uqk4/SIPuDqadTVA4fcofBe/lfbWVzELrP9px1CS+soylpvxJoqmS0m7Zjg==
X-Received: by 2002:a62:8749:: with SMTP id i70mr13449404pfe.12.1570147795117;
        Thu, 03 Oct 2019 17:09:55 -0700 (PDT)
Received: from mkorpershoek-XPS-13-9370.hsd1.ca.comcast.net ([2601:647:5700:f97e:44ec:171c:55e2:48])
        by smtp.gmail.com with ESMTPSA id g4sm4267913pfo.33.2019.10.03.17.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 17:09:54 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_core: fix init with HCI_QUIRK_NON_PERSISTENT_SETUP
Date:   Thu,  3 Oct 2019 17:09:32 -0700
Message-Id: <20191004000933.24575-1-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some HCI devices which have the HCI_QUIRK_NON_PERSISTENT_SETUP [1]
require a call to setup() to be ran after every open().

During the setup() stage, these devices expect the chip to acknowledge
its setup() completion via vendor specific frames.

If userspace opens() such HCI device in HCI_USER_CHANNEL [2] mode,
the vendor specific frames are never tranmitted to the driver, as
they are filtered in hci_rx_work().

Allow HCI devices which have HCI_QUIRK_NON_PERSISTENT_SETUP to process
frames if the HCI device is is HCI_INIT state.

[1] https://lore.kernel.org/patchwork/patch/965071/
[2] https://www.spinics.net/lists/linux-bluetooth/msg37345.html

Fixes: 740011cfe948 ("Bluetooth: Add new quirk for non-persistent setup settings")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Some more background on the change follows:

The Android bluetooth stack (Bluedroid) also has a HAL implementation
which follows Linux's standard rfkill interface [1].

This implementation relies on the HCI_CHANNEL_USER feature to get
exclusive access to the underlying bluetooth device.

When testing this along with the btkmtksdio driver, the
chip appeared unresponsive when calling the following from userspace:

    struct sockaddr_hci addr;
    int fd;

    fd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);

    memset(&addr, 0, sizeof(addr));
    addr.hci_family = AF_BLUETOOTH;
    addr.hci_dev = 0;
    addr.hci_channel = HCI_CHANNEL_USER;

    bind(fd, (struct sockaddr *) &addr, sizeof(addr)); # device hangs

In the case of bluetooth drivers exposing QUIRK_NON_PERSISTENT_SETUP
such as btmtksdio, setup() is called each multiple times.
In particular, when userspace calls bind(), the setup() is called again
and vendor specific commands might be send to re-initialize the chip.

Those commands are filtered out by hci_core in HCI_CHANNEL_USER mode,
preventing setup() from completing successfully.

This has been tested on a 4.19 kernel based on Android Common Kernel.
It has also been compile tested on bluetooth-next.

[1] https://android.googlesource.com/platform/system/bt/+/refs/heads/master/vendor_libs/linux/interface/

 net/bluetooth/hci_core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 04bc79359a17..5f12e8574d54 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4440,9 +4440,20 @@ static void hci_rx_work(struct work_struct *work)
 			hci_send_to_sock(hdev, skb);
 		}
 
+		/* If the device has been opened in HCI_USER_CHANNEL,
+		 * the userspace has exclusive access to device.
+		 * When HCI_QUIRK_NON_PERSISTENT_SETUP is set and
+		 * device is HCI_INIT,  we still need to process
+		 * the data packets to the driver in order
+		 * to complete its setup().
+		 */
 		if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
-			kfree_skb(skb);
-			continue;
+			if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
+				      &hdev->quirks) ||
+			    !test_bit(HCI_INIT, &hdev->flags)) {
+				kfree_skb(skb);
+				continue;
+			}
 		}
 
 		if (test_bit(HCI_INIT, &hdev->flags)) {
-- 
2.20.1

