Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2C5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEAA205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oL4k6qj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfDBRHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:07:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34587 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDBRHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:07:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id r186so2866859wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QBNq7le2jZSJyRpdM1cgMwf2lNrxN2g3bFYOjN6Y2GA=;
        b=oL4k6qj0MZG50uCLAgKHJ3LVwuV+WDBZKc34PpubG1Eu0SYhIKV4MAHHiXZC/tDkWv
         pKQ4eZKe1yGWCbNocC6dWnDHlRMBoWr9cj1aBWyJ5c8yDcNjvjS2fd/67dujhDDM7yse
         Doo/1m47JR9fIs21mBFKOTgckJrp8MMNOqgXfxU8IWo1QOXIdtsGaMVbqqOvB38g1LvK
         az2q3c0ZoBfm/FhWvbPtSaD5CeDAqwGNBrpwjAfb+xRfNVTV+P4oIuj6Unqzv33+SHDq
         GPxO6bTHiT6mB0hN2Bxtj5PEIUe4jAEQ5Uo4gLyOoyNZulWPEbqoWpAZNmBpe15fdnMn
         TNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QBNq7le2jZSJyRpdM1cgMwf2lNrxN2g3bFYOjN6Y2GA=;
        b=DltGFfONmLdUOA4zKxZWBrgIlDzlJlSzOSNsWwzkeRDlqcetOjlVkKwmWx5BWGK5yG
         H8ksrqK2kHwvPWjLvItnWFjY6WwS8AGIZOXKbLO8Bqg2fMJjSfZrl10THovLIpU+mPCm
         QtNr0jUyd7eN6VnuNVKldpxYIIL9/LBXbvx3fZvDiXXTNVKeCI6XSUXWzdZ0OibLdnAX
         qwwGAmnzb1yVMLU0ZecYrOhuKWcgY4FrmbxU9g2YNS5O32mPN5MjJ/Z4MNXWtH07ZGIX
         CCBMtYTwiZypgnFyL0KiyWhbMdAzHgCmtT6yceEqoKLbmxn0dgbHFFZ1wP/ar76MlGVT
         vHkw==
X-Gm-Message-State: APjAAAW1nJRqcp4AXp7lLY3TEuL9FiDwOOu31PYOPgBkZAhsJcvK9Zze
        xXuRHcZufKMKUVStANYMwtPeHNW+
X-Google-Smtp-Source: APXvYqyMxCLLp7aPYKt9NXVq6dLhe1YQ1QVsf58FhrZEN/PB+Mo2NLaBjjN0NKSfcSTZ2PYZPCxAOg==
X-Received: by 2002:a1c:9942:: with SMTP id b63mr4085566wme.116.1554224831727;
        Tue, 02 Apr 2019 10:07:11 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id e9sm22098922wrp.35.2019.04.02.10.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 10:07:11 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH v2 1/3] habanalabs: remove extra semicolon
Date:   Tue,  2 Apr 2019 20:07:07 +0300
Message-Id: <20190402170709.29562-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an extra ; after the closing brackets of a while loop.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index e3797f582436..6cbfd560721e 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -1044,7 +1044,7 @@ void hl_device_fini(struct hl_device *hdev)
 			WARN(1, "Failed to remove device because reset function did not finish\n");
 			return;
 		}
-	};
+	}
 
 	/* Mark device as disabled */
 	hdev->disabled = true;
-- 
2.17.1

