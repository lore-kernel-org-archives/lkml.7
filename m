Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B38C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 16:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FE1206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 16:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGoPZDDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfHYQ5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 12:57:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35519 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbfHYQ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 12:57:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id d85so10043578pfd.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hkBxvfWe/1p4w8zyrS1cyny/gLryEipuz5Rr35rTXt4=;
        b=AGoPZDDYYJqI8XE397Y29qqz+kdsB0g+zqVx3N5J+MIyuRRY1PKF2Y5gI6ZbQTTk2i
         DozoFC6gp8cOo140Z0xEIjR5HHN6opiPkREyQzl/3qMImyCortFHu6hTTgAisLh50kxr
         jVzAVHxWZDcsHKNAW3BsySCHivg/Zqop4d27BCmVEzKmKq6ussUme5sIXONLIwSeKK84
         Vr3TUp961cwwbeSv9oeJxS0+onqf0Tr+/9OgGkqwvibtqoM8/ZBQWz4KUK68GWtAdoNb
         PmyQRlEU13/ttCQ6Gah0RsdfNPeUR7KZeaNJ0vfXID02RgGVKUqAqxdZczexP1jinxb6
         onWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hkBxvfWe/1p4w8zyrS1cyny/gLryEipuz5Rr35rTXt4=;
        b=oK/NZvwCAHFbu7quAf5k6DHcyuv5lOV11sdMMJSQ43QNnY4SXnkzcyqXFNAe6epD8U
         O7obRo0HtrYmINXjjPRF1qyE5IqvSvfl3mk2Mwf22T8wewk6V8ndVlrp0q2h88+zdLE5
         Z2SgRQQzdfAH2K3AXsgogixNTDQAbswUMSuEPOWBHnllo6y8yA3N5gtlCsv8uCUlb4Ru
         8S4saEknGQb9dPQJ0tQlJmBcabZMT65MkGAwrRbEF+PTTHt3PBhjbUXi0fXf6wcpCA5u
         qHUs+Rch568NdHJ1fUgr68aCRP+9R246joKlZF/HQktLWMZeTJjDUjqvE+JqTWUYoUFV
         H2+g==
X-Gm-Message-State: APjAAAWPsfiLn9sagAR/NGmZUjDFtztBaV+X+8vEfECH3xE7lg9i7DXU
        Q43nPGPGCy91Rwt84S5Nfg==
X-Google-Smtp-Source: APXvYqzPmuwZJrP1QQ3ZidGAHYnedvwKvR81Lt++/Zt9ncSMn9RjNdyRkmIFrIg0Q4u+keQA1hzQeQ==
X-Received: by 2002:a63:3fc9:: with SMTP id m192mr2712650pga.429.1566752271675;
        Sun, 25 Aug 2019 09:57:51 -0700 (PDT)
Received: from MarkdeMacBook-Pro.local (114-32-231-59.HINET-IP.hinet.net. [114.32.231.59])
        by smtp.gmail.com with ESMTPSA id y9sm8865023pfn.152.2019.08.25.09.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 09:57:51 -0700 (PDT)
Date:   Mon, 26 Aug 2019 00:57:47 +0800
From:   Peikan Tsai <peikantsai@gmail.com>
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: arm-mhu: Use unsigned int for irq of mhu_link
Message-ID: <20190825165747.GA72906@MarkdeMacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please find attached patch which fixes a warning reported by
checkpatch.pl in drivers/mailbox/arm_mhu.c.

Fix warning reported by checkpatch.pl:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+       unsigned irq;

Signed-off-by: Peikan Tsai <peikantsai@gmail.com>
---
 drivers/mailbox/arm_mhu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
index 9da236552bd7..aa5a123e38f9 100644
--- a/drivers/mailbox/arm_mhu.c
+++ b/drivers/mailbox/arm_mhu.c
@@ -25,7 +25,7 @@
 #define MHU_CHANS	3
 
 struct mhu_link {
-	unsigned irq;
+	unsigned int irq;
 	void __iomem *tx_reg;
 	void __iomem *rx_reg;
 };
-- 
2.13.1

