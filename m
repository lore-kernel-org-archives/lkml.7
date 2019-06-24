Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14DEC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF88221530
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="ZjvM1TUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfFXGYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:24:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46295 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfFXGYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:24:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so6511758pgr.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pbnnd8izcGZKojl0PAuQtOXrWbhGmDWvjwa6KZ4Vaic=;
        b=ZjvM1TUi/T4fCBeNXp+wj0GMAZG9W7FexedmAEwr1vitPQqPi7joKlwvTdV04cadzX
         N8VEemayP0VA1MPMhMCF+AFWWGCgBvqWd/PhyqPUsPbPdAe47lgAhW0+QDNOyTePWMlo
         nExvIHIOD02U8k6fMCrK/z+G3oQhZfHuCyNYNEKuotXFJsNzNiupZ3YKSBU2YzBjGiIi
         rThnJz85t8oA7Jucp6u3j+j/kq6we+WgzdHh/cQI2A2eSMZiTQBP2JYXnlMJjzo28g8S
         aXaIdl0wlQ4BeHDzYvEyFsrY1i9lpNXbbUB7Rv5UY8x8Msj1+FGGvfIYmpPNb4Fntk60
         WhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pbnnd8izcGZKojl0PAuQtOXrWbhGmDWvjwa6KZ4Vaic=;
        b=s4AB/CwkBhRyHDeQtAhEUgP3fT0ddPd1KeN5sktYKR4BAUSF8K1Yq7H+o42oNzRsEa
         scse91N8gD+9Eg+90oIIftumwBGw88YXT81IvaD2EOvh/BN+YwqEKw6XJkNi+X3fKl3O
         Pr0j3w2IUGeJpE+RirpUTHdtdosJEpq4PZA53g1XXonCyWr/wBHP/SLpEnmXmUIr52dE
         KWhRWmIsGV88HYJXVhdBYAx+oqkXEANoMzU2pfEKY6oAjVSB7KpzmGIDVPtG3xLRCA80
         /fI2knmPggRuMYOPFqUSXyebY83QWY+siLs9BOZ0+yp8RzY+FUaEquj3VeY3QEn3XOJl
         hhbA==
X-Gm-Message-State: APjAAAWVaQ8bMCKfELzkKX1cvK3rfnHbzq3QSNQz/4RysttVJyaVpB6r
        x6TO2nz9VEOfMSZ+vjT6MWFyN5M7BEtGrw==
X-Google-Smtp-Source: APXvYqzQQmPP8obThfTh2+jCJaqjHof51Bt4ABhyWSpN/apoVyHKuqn4uUHUbCTA38hKsdrNsLNzww==
X-Received: by 2002:a17:90a:2385:: with SMTP id g5mr23432400pje.12.1561357474818;
        Sun, 23 Jun 2019 23:24:34 -0700 (PDT)
Received: from starnight.endlessm-sf.com (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id r15sm14517333pfc.162.2019.06.23.23.24.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 23:24:34 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Daniel Drake <drake@endlessm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v2] Bluetooth: btrtl: HCI reset on close for Realtek BT chip
Date:   Mon, 24 Jun 2019 14:21:16 +0800
Message-Id: <20190624062114.20303-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <CAD8Lp44RP+ugBcDYkap3tUL1NSq+knGJbO9A6UAmCtcjPgxTQQ@mail.gmail.com>
References: <CAD8Lp44RP+ugBcDYkap3tUL1NSq+knGJbO9A6UAmCtcjPgxTQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtek RTL8822BE BT chip on ASUS X420FA cannot be turned on correctly
after on-off several times. Bluetooth daemon sets BT mode failed when
this issue happens.

bluetoothd[1576]: Failed to set mode: Failed (0x03)

If BT is tunred off, then turned on again, it works correctly again.

According to the vendor driver, the HCI_QUIRK_RESET_ON_CLOSE flag is set
during probing. So, this patch makes Realtek's BT reset on close to fix
this issue.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
v2:
 - According to the vendor driver, it makes "all" Realtek's BT reset on
   close. So, this version makes it the same.
 - Change to the new subject for all Realtek BT chips.

 drivers/bluetooth/btrtl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 208feef63de4..be6d5f7e1e44 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -630,6 +630,10 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 		return PTR_ERR(btrtl_dev);
 
 	ret = btrtl_download_firmware(hdev, btrtl_dev);
+	/* According to the vendor driver, BT must be reset on close to avoid
+	 * firmware crash since kernel v3.7.1.
+	 */
+	set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
 	btrtl_free(btrtl_dev);
 
-- 
2.22.0

