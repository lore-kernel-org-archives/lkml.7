Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA224C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F672146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewGSI+bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfLRBV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:21:57 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42110 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLRBV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:21:57 -0500
Received: by mail-oi1-f196.google.com with SMTP id j22so236638oij.9;
        Tue, 17 Dec 2019 17:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcjIbQOSWhikOPzlHM6ZEWQw/5oRTb6+fvho9ILg6nc=;
        b=ewGSI+bn9pFKrQB/G1ML4P5eLVhHbyWN3IAJc1iIjVNte/l8Xk634f6ODBfxTQJWDg
         /dpQLpULVFho3Q5K7J66qDov9VlHj1zbn/Uv8oH6gGwYXP0ziIL/WfCIuMKCk0hQnuFG
         Gty1scprHPFs+kP7bZ9iNvszjusD9ZrzF562jC/JaGXQi1EZERcIvOHCyCkr9uaQuhmu
         4dCW0zwNl7UViiHfNuXaT4ozLzMTEBZ06EISOYbWfGaCeaVrnKMTQ+FbP8iiFLeJlz51
         dwWrAUqbqtI9tSsa6f2Q8WkRyfDj4yZx+ytkAHwOoc3X5csrBLpB0DZZel/z50580oWj
         g6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcjIbQOSWhikOPzlHM6ZEWQw/5oRTb6+fvho9ILg6nc=;
        b=Cr+iVZqTcBbtt0SM9oocmHXiAXQTE+k+2NkYbSUDruS3zoybHsLZCbxcLNWxsjAY3p
         zbYz0xKFZ2WJzZREE5O6vLQxwVc5rYPrDS6nqvlWXHI/pwqsCPoZB12PzdfGDNaOUoZ6
         V9VVJrDY3WWqNYfjnG44+EELz6VFGHZJbPRyw8QGew2EjZg8GIpQEgGZo93BJ0MvlBOb
         k2urZ0JxQyG/WBxNo26tZQqRrVHpEXyX96E04clxkWKV2fODAyktl2cYPLzxMwQ3rGOg
         a0Em2bjSx7iBwD3KcGaeFMt4gzBkeEYA41nqHjNHTgbHLkyr/70Lg8wysdjE6OSoJ5X8
         UU7A==
X-Gm-Message-State: APjAAAWlOksQLg2B5pQevFTBFBuQXAL/k6B0OL0muUj7gDw5L3hwb5ag
        uglXr72YfwKPFC5SI6qnKHY=
X-Google-Smtp-Source: APXvYqxKuwWlc4EgT7EUo1OnCAvhDkLBWgjLMkVF0EAZhWLUsyOxyHlwf/0zGrCbLyZQeythINshIA==
X-Received: by 2002:aca:c415:: with SMTP id u21mr34515oif.49.1576632116439;
        Tue, 17 Dec 2019 17:21:56 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id p184sm240395oic.40.2019.12.17.17.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 17:21:55 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] NFC: pn544: Adjust indentation in pn544_hci_check_presence
Date:   Tue, 17 Dec 2019 18:21:52 -0700
Message-Id: <20191218012152.15570-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns

../drivers/nfc/pn544/pn544.c:696:4: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
                 return nfc_hci_send_cmd(hdev, NFC_HCI_RF_READER_A_GATE,
                 ^
../drivers/nfc/pn544/pn544.c:692:3: note: previous statement is here
                if (target->nfcid1_len != 4 && target->nfcid1_len != 7 &&
                ^
1 warning generated.

This warning occurs because there is a space after the tab on this line.
Remove it so that the indentation is consistent with the Linux kernel
coding style and clang no longer warns.

Fixes: da052850b911 ("NFC: Add pn544 presence check for different targets")
Link: https://github.com/ClangBuiltLinux/linux/issues/814
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/nfc/pn544/pn544.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/pn544/pn544.c b/drivers/nfc/pn544/pn544.c
index cda996f6954e..2b83156efe3f 100644
--- a/drivers/nfc/pn544/pn544.c
+++ b/drivers/nfc/pn544/pn544.c
@@ -693,7 +693,7 @@ static int pn544_hci_check_presence(struct nfc_hci_dev *hdev,
 		    target->nfcid1_len != 10)
 			return -EOPNOTSUPP;
 
-		 return nfc_hci_send_cmd(hdev, NFC_HCI_RF_READER_A_GATE,
+		return nfc_hci_send_cmd(hdev, NFC_HCI_RF_READER_A_GATE,
 				     PN544_RF_READER_CMD_ACTIVATE_NEXT,
 				     target->nfcid1, target->nfcid1_len, NULL);
 	} else if (target->supported_protocols & (NFC_PROTO_JEWEL_MASK |
-- 
2.24.1

