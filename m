Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C99C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 19:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0312320718
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 19:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGTqsTSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfKQT00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 14:26:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50271 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfKQT00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 14:26:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so15095297wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 11:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=t9aaV7Y07uDlOSn2HWkdSrjG6IbrSgwno/ewx62YFgw=;
        b=ZGTqsTSGpeOcAps94KKtC3MoeDsmBR1GxQ+5gwvxQsWLSgHSMV43uBDYbacvMhMTr5
         ZAU0EbNDpG6tb5y3M5LIvd3i7zKgn7UbpwGtYqnDmlTjzSRcQy2dlNjYlrCNWAVzBHHP
         TeUK2dRqPpf48JS2RunHooUkdlYD7iMef9Yiv65EZw7YjjPjG/66h9sA0XHdOCYvKNWC
         sqwv3agRwvuW2da0DXepimzL4VqRCPlJ2OqnGGPIcEtXrKVpUZ2SZTN7H4bDstulQ0+K
         XT0WSNTladqsn7q2mBWKdsyDeOCCIZwvujdYoFK3nocneWqhBqgXsHPj1+1TcpW/V75K
         HNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t9aaV7Y07uDlOSn2HWkdSrjG6IbrSgwno/ewx62YFgw=;
        b=hHCJTiFZtkEwK6i+62LqyNi/oT7Zu5cFCwa1JNrnjZb1GYrjdCOm3yBwpal5Jk/6zy
         MF8jzEhYqiFjumq+SjbQpvJ/YPfgQ8JsPCR7ub/yaNxwzOFpBZB7hIIieUxwNAYQ6oSJ
         J7H2fsn9Mbjuw1R2WGF5yddYku13cw8IiSkhr+Z4dKnxMEPSo7zbCBxkiu9u/uWlhr01
         QH4tQCWVMSaiZ8/OzSxVQbwgCCzCrlhB6Y+QYTHIGx2p3a1qqAyNNkM/jwCYGlvetO0f
         CajW6R9BUi0a90n2QMfvuaeK5pFjqHWJO4+MmB/UVGH4c0NAzUazmW9BhoOQjO7V0g0g
         vDtQ==
X-Gm-Message-State: APjAAAWKNLYnHxFjOwKHysBmOuo6dUPx/Iy/X0DTVoqjzEAXbinrfe1O
        CfeN8VRrckK20u0FjvMDi0DvdtzFCws=
X-Google-Smtp-Source: APXvYqy+GbmBFv6INM3kzlkW7Ni2Sglmj/uWA7CD4bZ8C4vfhtZIolQmx+yiXwpNGE9x5acLEAs4OA==
X-Received: by 2002:a05:600c:410:: with SMTP id q16mr24547220wmb.2.1574018783669;
        Sun, 17 Nov 2019 11:26:23 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j3sm19671024wrs.70.2019.11.17.11.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 11:26:22 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/2] habanalabs: make the reset code more consistent
Date:   Sun, 17 Nov 2019 21:26:19 +0200
Message-Id: <20191117192620.27639-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the hl_device_reset we ask about the hard_reset argument when we want to
differentiate between soft and hard reset, except for three places where
we use "from_hard_reset_thread". Replace one of those locations with the
hard_reset argument as it is guaranteed that if we reached to that
line in the code during hard_reset, it is from a kernel thread.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Reviewed-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 2f5a4da707e7..80205d8584ce 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -891,7 +891,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	 * can't really exit until all its CSs are done, which is what we
 	 * do in cs rollback
 	 */
-	if (from_hard_reset_thread)
+	if (hard_reset)
 		device_kill_open_processes(hdev);
 
 	/* Release kernel context */
-- 
2.17.1

