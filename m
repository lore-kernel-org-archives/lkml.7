Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA01C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 12:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A561620830
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 12:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGXb9TYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfGGMRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 08:17:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34593 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfGGMRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 08:17:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so13245066ljg.1;
        Sun, 07 Jul 2019 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SAMwT6DUHJKtrCvN/jv0WTWZlT3Adyo0fAKhCuWcf/M=;
        b=UGXb9TYxQ1dBTwuX3uGHVTmta0ifDlJxXCd4M9XkNcUsWKPrmDg/CZbHn+FrBTHdbS
         QfermUCUSCzF7h87ARN2ABT3YKJHtW/wUqxrzM7hrTHsooQpQ7mUvqjM46s0sDh9oeMa
         z0f74B/exNKvRNUCS57FdYfRE724+VU0UpwJPETsWqYFhzoZjeNFTqvfcXjwRGUVUJhE
         5jtqNWWueunkokujlQNtNbDsXzkiGaWK3PKinIQMOwq91oCb+wa+KA/TNtAO91HiLCc/
         jnrWcNF1ibLWXns72CIeXDaYvXWr/IBR++C7HKFjVDFNWrBKatuA/NWE7j2lkZWw+zxw
         RuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SAMwT6DUHJKtrCvN/jv0WTWZlT3Adyo0fAKhCuWcf/M=;
        b=ezDV6l01Q0YHKKnTDoEsRcavknyxi8ZhJOdHTXiuITNOslSU6DzrxFzBGNwNGJMfeC
         ffWkm/1q8eu0T0VrWleZ0ijF7aN8AIDndcsUA7NCpeZqcCt9Z533qi7oWn/VvX/QDa0P
         k2vcuoU47I6pGSbri1iL3jv8qecN6cmuJugpJW7wDNUbrtIODFHWFoOJ48LGU63FO6Ml
         BdxY0Vz3q1yL9lxKiF/OL1JpvOZwN5+ygHAm/Jfjw30cjcwU3Z97RnRFADBiQMeW7M5B
         oA3NPrMvRfJEM0qTL6TalcC6sXHvDvJN+H/YjViSxMav1QfhNC6Hpqrt9Qch+NyUmiMY
         Ki4g==
X-Gm-Message-State: APjAAAVMv+0okSbeeZxyt03CP9ZAYn+K+3gYEtHyDNfPpAGVAG4ERV3j
        vjXIwE8ZR85XUdoWRyG+G/6NS/BC
X-Google-Smtp-Source: APXvYqzNMEnTfyeHiRkT/y6hMxdp+rpP0WXLeaAkmVVzTOIjXt8uOj2OZlcpOAEi7CsgYl/Jk1hz4A==
X-Received: by 2002:a2e:b0f0:: with SMTP id h16mr7289700ljl.21.1562501849425;
        Sun, 07 Jul 2019 05:17:29 -0700 (PDT)
Received: from localhost (122-109-207-82.ip.ukrtel.net. [82.207.109.122])
        by smtp.gmail.com with ESMTPSA id n1sm2225136lfk.19.2019.07.07.05.17.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 Jul 2019 05:17:28 -0700 (PDT)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com
Subject: [PATCH] usb: host: xhci-hub: fix extra endianness conversion
Date:   Sun,  7 Jul 2019 15:17:19 +0300
Message-Id: <1562501839-26522-1-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't do extra cpu_to_le32 conversion for
put_unaligned_le32 because it is already implemented
in this function.

Fixes sparse error:
xhci-hub.c:1152:44: warning: incorrect type in argument 1 (different base types)
xhci-hub.c:1152:44:    expected unsigned int [usertype] val
xhci-hub.c:1152:44:    got restricted __le32 [usertype]

Fixes: 395f540 "xhci: support new USB 3.1 hub request to get extended port status"
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 drivers/usb/host/xhci-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 3abe70f..b7d23c4 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1149,7 +1149,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			}
 			port_li = readl(ports[wIndex]->addr + PORTLI);
 			status = xhci_get_ext_port_status(temp, port_li);
-			put_unaligned_le32(cpu_to_le32(status), &buf[4]);
+			put_unaligned_le32(status, &buf[4]);
 		}
 		break;
 	case SetPortFeature:
-- 
1.9.1

