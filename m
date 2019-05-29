Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEB6C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C71C24198
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FewxfTwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfE2Uys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:54:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35447 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfE2Uyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:54:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so2423626pfd.2;
        Wed, 29 May 2019 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=XEF+EmzNlq0iTdBffbmE28VfoH3p6+OLJWmtZrEIKfU=;
        b=FewxfTwOlv1bo4k6KlkJJbPh119DvzZKYMIbK3W5FIEva+v82cWNDprr1QMBQn/dKv
         JDkE4hlYb3l835iwltJmyWN+XLIKJ34j7Aul/uNV8rWU2geLEpk/MwP3qHSshS+RWXcW
         Wb5GqqLD+UWknPNv4SSAZNcoehhJ8+NisPq6Pf+K+/Zosyx3U+58ygWQ56LVDsPQ58xc
         BAOs5igw6inu1j1Sl00nLHnFkasiUa3Y1ZwR8laYpH5XpXYr0PqbDhRXVl1SDIvN4FsX
         s6LkNfGn6Ml30lfF26EMIhy+Af4tssQ4WiTuzPYbpddXwqcQSw+fFqdQ4ws6q8xFJDse
         1/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=XEF+EmzNlq0iTdBffbmE28VfoH3p6+OLJWmtZrEIKfU=;
        b=DL+OhrhGIiZMFWqLkgRtqUwZnPPwJHCJvnjLZW0EgsscMd1QwLxf3DS4CVA5VSsYxX
         5erVaMONomRMEHv0JNqMe/ybhtkNXTWGcG5/9wdHuUJL9qYgEe4g/38///B3kBRcfRMo
         2xhhWtYstmyGZkiBysWF60QYQiJgokCtZBJjAit4zeSK3eDTWFDSFLK7hvXUdcucKji7
         efJYVKXd4aCl08nFXTbqX0novZcneHvGto7qqfD79G2Bcd+ghPIB44uuNLgu8Yc1GFBt
         qcWzC112rufr07SbPA1fOJ9kl80sfyFijOJVBpzeteyoOage2u5dKMx6HMbdR4ZUJcdp
         nkpg==
X-Gm-Message-State: APjAAAVDUA8TRtQz8w/J9GqTuybL3GnwRESmI7HnAG6NQE44jwrZk9Zd
        hFMPW0ehAwD1A7tMlyAh7jI=
X-Google-Smtp-Source: APXvYqwIqDcbKzzi8om0kXep83lmfrBLBQfha8joO4BDBvWZ9dnjFPh2VPBxlm3Jku90/koOXGHbcA==
X-Received: by 2002:a17:90a:36d0:: with SMTP id t74mr14734286pjb.4.1559163287158;
        Wed, 29 May 2019 13:54:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a30sm452373pje.4.2019.05.29.13.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:54:46 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Vardan Mikayelyan <mvardan@synopsys.com>,
        John Youn <johnyoun@synopsys.com>,
        Douglas Anderson <dianders@chromiun.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH] Revert "usb: dwc2: host: Setting qtd to NULL after freeing it"
Date:   Wed, 29 May 2019 13:54:43 -0700
Message-Id: <1559163283-2429-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b0d659022e5c96ee5c4bd62d22d3da2d66de306b.

The reverted commit does nothing but adding two unnecessary lines
of code.  It sets a local variable to NULL in two functions, but
that variable is not used anywhere in the rest of those functions.
This is just confusing, so let's remove it.

Cc: Vardan Mikayelyan <mvardan@synopsys.com>
Cc: John Youn <johnyoun@synopsys.com>
Cc: Douglas Anderson <dianders@chromiun.org>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/dwc2/hcd.c | 1 -
 drivers/usb/dwc2/hcd.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index b50ec3714fd8..bca64b0d4d15 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4676,7 +4676,6 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 	urb->hcpriv = NULL;
 	kfree(qtd);
-	qtd = NULL;
 fail1:
 	if (qh_allocated) {
 		struct dwc2_qtd *qtd2, *qtd2_tmp;
diff --git a/drivers/usb/dwc2/hcd.h b/drivers/usb/dwc2/hcd.h
index c089ffa1f0a8..f6bc48432b04 100644
--- a/drivers/usb/dwc2/hcd.h
+++ b/drivers/usb/dwc2/hcd.h
@@ -574,7 +574,6 @@ static inline void dwc2_hcd_qtd_unlink_and_free(struct dwc2_hsotg *hsotg,
 {
 	list_del(&qtd->qtd_list_entry);
 	kfree(qtd);
-	qtd = NULL;
 }
 
 /* Descriptor DMA support functions */
-- 
2.7.4

