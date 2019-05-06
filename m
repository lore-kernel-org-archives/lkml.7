Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F52C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AA720C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci7YCJu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEFM51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:57:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41919 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfEFM51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:57:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id d9so6342970pls.8;
        Mon, 06 May 2019 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+F4BP6Z6pdgPYBmGiDkA2x8IUuujt5MWxpyaN1c1LKs=;
        b=ci7YCJu8+XUKg2RH1l7XMjiZfMGXRlgke94KizZTcHgAu/4ILy9koavEnzpOFp6d3r
         bnicWCemdUKK2FDI4I7bL2+Smk55v/5HqkV3SYS8/TxVGXTjAz3rVeCNvmXV2U+8yUso
         xnbWkC7aO+qaROgZHWtU9/PbAkwGFxbNkUJDqPwDYVDghdWEpYy5ukkwFBV9Lgre1vlh
         s3H3YsGq+6nafuECKlm6LkEeVLE7YNwFibHgzGwa1mExr+kYcyy2h6n2YpDuXCy45OQd
         gIQv/pYHU7/d9/X7E9ancWi8L5uTFMNKWrE6L95rvMQSXjMMQ0JBpttEqkzMk3MpckWF
         VPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+F4BP6Z6pdgPYBmGiDkA2x8IUuujt5MWxpyaN1c1LKs=;
        b=rJDQJpg3FZ6xf9mva4hQhTlyz8HKt4HJ6V2CCbZLc40kY6NdlyHWo1YkOsLGzVQ3+S
         RMJs5crlJTVX6d4/SIlksVz4x5FKVYV8Gbgo+mgntIEKBugq4XUJK0jMPkzSapeMel0I
         27aBk1cPQj9JqO886Z1n+rBV5ga+WPKGp6v6A9XPwwqEjoydg6SwIGYMZsFI6qjX4/Z2
         jGqK2cnENJ3l0byz0L2ZzvqzDYIgmnoisKRI1auh12M3oIUPAHZgk5NjqZ6OW0c8MDQK
         JUFcZTs5J5Ddu70ACgKOz36EnYO7owZy8T9I6e0vk/b013vEvU3XJKDFHaw4wcab3H9a
         BPJQ==
X-Gm-Message-State: APjAAAWVD8bbOqBb7PvwfNsJNLgglfbPA2+AdScPeg5Aw2A1q0tAgQdG
        GpfomHtIV0PFLacPqNi8Ddk/Tefn05s=
X-Google-Smtp-Source: APXvYqzptrCaNBB1gCCDzvNE3XVvaRMoRZesFUuCFxpdpCnucKJPfLFldDhcTXa/OCsExmHmkkUx8A==
X-Received: by 2002:a17:902:9a48:: with SMTP id x8mr32230389plv.133.1557147446632;
        Mon, 06 May 2019 05:57:26 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id a6sm13696382pfn.181.2019.05.06.05.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 05:57:26 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH 2/2] usbip: Remove repeated setting of hcd->state in vhci_bus_resume()
Date:   Mon,  6 May 2019 21:55:50 +0900
Message-Id: <20190506125550.7826-2-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506125550.7826-1-suwan.kim027@gmail.com>
References: <20190506125550.7826-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hcd resumes, hcd_bus_resume() calls vhci_bus_resume() which sets
hcd->state as HC_STATE_RUNNING. But after calling vhci_bus_resume(),
hcd_bus_resume() also sets hcd->state as HC_STATE_RUNNING. So, setting
hcd->state in vhci_hcd_resume() is unnecessary.

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/usb/usbip/vhci_hcd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index e6f378d00fb6..335d61676fb4 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1252,8 +1252,6 @@ static int vhci_bus_resume(struct usb_hcd *hcd)
 	spin_lock_irqsave(&vhci->lock, flags);
 	if (!HCD_HW_ACCESSIBLE(hcd))
 		rc = -ESHUTDOWN;
-	else
-		hcd->state = HC_STATE_RUNNING;
 	spin_unlock_irqrestore(&vhci->lock, flags);
 
 	return rc;
-- 
2.20.1

