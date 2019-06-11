Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2E1C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6BD2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsMd+xEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403980AbfFKFvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:51:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38660 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403944AbfFKFu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:50:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so11449023wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 22:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kly7+Qt5xgnscUX+7DRt3V/f8ODrjOcAq6cJBlXMldk=;
        b=GsMd+xEk9xuFFJKvlng5kASPD5wS0s6JqUyNIFvY+xjh5AE9ktjOkAbKDkS9QMVo+6
         mqGgnYHMcPLJT+FGGyXSPqksrS5jutsqSOawzEeQBQkpRTCDDhjfBjwNjcJga7BIHsLh
         Hhcrcvw/sBZSxP6gYvvMILAt/Z+HCGMMRCq3uOnfi6SHv8FbvX4KyZys4W5dLG+Nras4
         pWBQlWPO1E4CfLT5+vbWjYqSv50EGVRU/4PvwM+vJaPGAvB5k/uq4r5J2OdzW2Te68ar
         WTjhqqwmnVabP9rQ9px3+xTu1tS0500/yi0P7WJNeSIc7QAgvau0VdM20EAM4/06m8RP
         hotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kly7+Qt5xgnscUX+7DRt3V/f8ODrjOcAq6cJBlXMldk=;
        b=MW3hCOYGNQzc+pFelzbL5bPcBkOaXnBGUAfJMQV7ri3MS4LV5zOhDD4AVH2mva2RvI
         13geK/27V3DhBk/T8+77DwfmhsPTokC/SYRd1pQPNi7sqM5ex0gBs5XRCZvIQRpc2soO
         /MeAFKzBUncR0gzNW9MEGB+jmX4gQu/oGl094Wwa7NsKbordddWRdky7E42WytPwa2Hd
         CcS9j+u7qd/UX2Lea4hnHgu1eQWXkAN2v1HbxiPNBWTjmNrV/h8EXkaJIhQ2IkM+sfMX
         +s4L4LO5M003udw0DELMe++IDyf5Fya3ftNs+bqWRsZ+Xtb5XCOs2Zck090nY2HTpFm1
         se3Q==
X-Gm-Message-State: APjAAAXBblf63vX7QtGawI73AlmYCjh2YpiYudeomh0NTrk5NMjZemf5
        D2IgMPPhlgAbrq1Dii+zc2RatvGtgz8=
X-Google-Smtp-Source: APXvYqyaNrUR7aVYK6fNfEWgmwjwziSpGICMV7A18plmjNIIhvsUgH4dlbTYE9/KJ+8NYJt0tgCNwg==
X-Received: by 2002:a5d:5607:: with SMTP id l7mr16865969wrv.228.1560232256289;
        Mon, 10 Jun 2019 22:50:56 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j8sm11968056wrr.64.2019.06.10.22.50.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 22:50:55 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 7/8] habanalabs: add WARN in case of bad MMU mapping
Date:   Tue, 11 Jun 2019 08:50:44 +0300
Message-Id: <20190611055045.15945-8-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611055045.15945-1-oded.gabbay@gmail.com>
References: <20190611055045.15945-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch checks if an MMU mapping is erroneous in that the physical
address that is being mapped is NOT divisible by the page size.

If that thing happens, then the H/W will issue a transaction which will be
translated to a wrong address, because part of the address will not be
taken (the remainder of address/page size).

Because the physical address is being handled by the driver, a WARN is
suitable here as it implies a bug in the driver code itself and not a user
bug.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index a80162c5c373..176c315836f1 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -913,6 +913,10 @@ int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size)
 		return -EFAULT;
 	}
 
+	WARN_ONCE((phys_addr & (real_page_size - 1)),
+		"Mapping 0x%llx with page size of 0x%x is erroneous! Address must be divisible by page size",
+		phys_addr, real_page_size);
+
 	npages = page_size / real_page_size;
 	real_virt_addr = virt_addr;
 	real_phys_addr = phys_addr;
-- 
2.17.1

