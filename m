Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5C6C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B10B20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y/nTBPXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCGAlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:41:01 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:36129 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGAlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:41:01 -0500
Received: by mail-pg1-f170.google.com with SMTP id r124so9796834pgr.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4x5zl4XrRUOum0f7U/KopUS0LDLXAgXGCRRmdPNHGaI=;
        b=Y/nTBPXHQAevdNAHgaU9GXbh50k9dOMg6e7dlJAvPhrQdj6ke39AfBdsIiAvQLSpPY
         bi8z8+YGz9NGyXg1YUJTvBDVYdR2y74hnI9XdyRKiwpOv3ePC3FW6Qc9o82IYvjeSnkR
         idgFQHKPeXYCm/u3z6+oC3geJZJrIVr4SMhgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4x5zl4XrRUOum0f7U/KopUS0LDLXAgXGCRRmdPNHGaI=;
        b=FD5vetcEozpVZf6b0aDpXMgKwK0UR7uWA19NlaVZyCiS0d2b62+/9LMI3JXIsNnX1u
         OokmFMG4SAhDG2pHwwbJXoKlqqUb+jHM42d7WXRnt/tYAtsEFReWNQsFVftNXQfFZxbw
         +IXSeU36fpKQoqQvij7aZSMkZ5dTrYlThtRGE3N+wy1xroALVA7umgsCU4P6Qvs6cZ8U
         fQUooSkKW7I5TVetI+4pKaCkNs2mTgAZSYZTmFwnGiBVFS+VRJgaEamuHIpbCBhbDPcb
         zTtWrLgjJ36eN3r3fWwad2L/5YD/GuM+eMBcwGcYntzb5RYXTacgIpFF+tqD30KwoF6e
         xxPQ==
X-Gm-Message-State: APjAAAXb3zLGep78az02SdHDCULIobBAxYtjHlEvF0Aco63CB5zLD/JU
        FAxahY7+e6C0xO0zXqmHO8j7Gg==
X-Google-Smtp-Source: APXvYqxu+4iWreBMjQVKj9+0KaxCH6ZRRYF/v/fBNwcp/kiN88Td9IEmed2ZNNvGNXddWyoMSYLw9A==
X-Received: by 2002:a62:5249:: with SMTP id g70mr10015704pfb.115.1551919260477;
        Wed, 06 Mar 2019 16:41:00 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o76sm8361985pfa.156.2019.03.06.16.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 16:41:00 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/2] Bluetooth: hci_qca: Fix WCN3990 firmware download
Date:   Wed,  6 Mar 2019 16:40:39 -0800
Message-Id: <20190307004041.38059-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware download to the WCN3990 often fails with a 'TLV response size
mismatch' error:

[  133.064659] Bluetooth: hci0: setting up wcn3990
[  133.489150] Bluetooth: hci0: QCA controller version 0x02140201
[  133.495245] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
[  133.507214] Bluetooth: hci0: QCA TLV response size mismatch
[  133.513265] Bluetooth: hci0: QCA Failed to download patch (-84)

This is caused by a vendor event 'without command' that is misinterpreted.
Drop the event.

Matthias Kaehlcke (2):
  Bluetooth: hci_qca: Rename STATE_<flags> to QCA_<flags>
  Bluetooth: hci_qca: wcn3990: Drop baudrate change vendor event

 drivers/bluetooth/hci_qca.c | 65 ++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 9 deletions(-)

-- 
2.21.0.352.gf09ad66450-goog

