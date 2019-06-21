Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75EDC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A18A20673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="U/ePaK8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfFUI7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:59:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35144 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfFUI7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:59:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so2683499plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 01:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4bJVSAowx8t/cxxp9cv6smvKfxDPXT8u9MmQ6mO3sDU=;
        b=U/ePaK8tXP07xOTAuQcgBMObbVfGYNIWLv5JXHrC5etbmv0PLidyI7dGDcGub6NzPk
         OHv9lW6GFHNXgrfDj3m5lUrYq1hQlVS1+MI3Lz7lHy2yCepJdruSBdccuJLfeIADbSNu
         Ccq1sF1hvqdVW1wrYIylCbqe7GPkJsxHr739eJ/wDxzC68wt98mFKeubQM0N68ieAJXb
         j731IoJKsTNL8rtnpEK5uXS78IuzD3DLUChHI/tD53j9VR3p03GFKeTGEyHUTQtGiCkn
         DnVqEDj9m6TEjx4X8Ie79gZWjBtRuh70od7VZ8woEvshnFl5tqGU0wNflNQ5Bq4olbzn
         oWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4bJVSAowx8t/cxxp9cv6smvKfxDPXT8u9MmQ6mO3sDU=;
        b=YBvE80BNpEHkX9ouSDy4IFsKJvN3ptdeQXT3iJPEHMPRjRxNOIae3dLSHXvv2wTIlQ
         359Vh3hzmS5lK25jTJmVrPJ27vGpR/A8JFgIXpzuvuB4g0orCs++Nl5SV5KjXjc5IC62
         icyiOumgLI77M5MStPocSRN/++WTkA1o0eI0bo0ySvDoR+cXVJZG+QTJAJ+oZzAVany2
         HrPUwJO2MmK8QgOb6yY00+QLG9Z1bZfgHqM1FeYQ7126nD5cMUK/RuJ7ibxcBQW68jJR
         ZfYUWoJqCBesqLxeKi3KrPPrwKC0aA81N7gOXXNcIuZh7ner4HhwA6V0V+MVuxz0KNC5
         36eg==
X-Gm-Message-State: APjAAAWCxLG7tm7xSKZ0Vjs/QsuNJ8Mb1+7aXTs7KiztoTpTdyoQioT/
        +VUjq5PGW4GLJtRmk8L5UMS9Ag==
X-Google-Smtp-Source: APXvYqx8jg2L3co0DYC0wN++64bpnfJeWPOTJom1WsTagX1aHyyqtbHPWcDS6G7HVNDTWBpYaIuMIA==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr66988266plf.137.1561107539850;
        Fri, 21 Jun 2019 01:58:59 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id y19sm1796356pfe.150.2019.06.21.01.58.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 01:58:59 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Daniel Drake <drake@endlessm.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] Bluetooth: btrtl: HCI reset on close for RTL8822BE
Date:   Fri, 21 Jun 2019 16:58:40 +0800
Message-Id: <20190621085840.6341-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtek RTL8822BE BT chip on ASUS X420FA cannot be turned on correctly
after on-off several times.  Bluetooth daemon sets BT mode failed when
this issue happens.

bluetoothd[1576]: Failed to set mode: Failed (0x03)

If BT is tunred off, then turned on again, it works correctly again.
This patch makes RTL8822BE BT reset on close to fix this issue.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/bluetooth/btrtl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 208feef63de4..7e9930f0f231 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -608,10 +608,11 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	case RTL_ROM_LMP_8723A:
 	case RTL_ROM_LMP_3499:
 		return btrtl_setup_rtl8723a(hdev, btrtl_dev);
+	case RTL_ROM_LMP_8822B:
+		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 	case RTL_ROM_LMP_8723B:
 	case RTL_ROM_LMP_8821A:
 	case RTL_ROM_LMP_8761A:
-	case RTL_ROM_LMP_8822B:
 		return btrtl_setup_rtl8723b(hdev, btrtl_dev);
 	default:
 		rtl_dev_info(hdev, "rtl: assuming no firmware upload needed\n");
-- 
2.20.1

