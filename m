Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E35C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7362D20838
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="B5cgJ620"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfGKHgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 03:36:33 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:32928 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKHgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 03:36:32 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jul 2019 03:36:32 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 508BEC01
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 07:27:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6Ldinn9E4n1y for <linux-kernel@vger.kernel.org>;
        Thu, 11 Jul 2019 02:27:26 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 2A4D16F6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 02:27:26 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id s83so5803922iod.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=X6Z4l/JCt0vrAzTI2h9ZAgt6VJx8sy/c7Jhl6qpnxtE=;
        b=B5cgJ620d3ZMpNa1G6S58M+oUNja9lxJD/3DbqQQ93KJ3PcWiMcxlTG/amKvq3j2Gp
         pRiE1AmRc1JY8Sjx8DCP5bM/9XpaeHEGWPxHk7PvLqdHZk3+imC4zK0kCBPofu2LfFDe
         PoYANvx2C2YDJKnkW3Z7e+OYbxsvOFy9fvf13eqIwF4jDepHNoGR26LtkC+UPVwCl9YU
         gCL3pzHzExUWWSGYbBgUL6EnNFOad7g+KiOA4rYVK7m9inz8KLIwzG9E8x7V3NLyrrrv
         NMNb7wFw5QgMx1cafyxNzCOcn9LfBdAMiVYSKNK7PbQOULlKxcTqIoFq3FYebPKshazh
         oCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X6Z4l/JCt0vrAzTI2h9ZAgt6VJx8sy/c7Jhl6qpnxtE=;
        b=TxZDtFYHHwdxJ56rwGvr93SXbhXixDcOrmx9A3EiEplsiFlzY0Vkx3qz5Ne26jV4yr
         csXYXyxa8dW1znJe8IllzQwc0mK7vnpt/ZEQHfjb3sNQoQ+85avIjaGjujYjjUwujTlr
         VgkDtzOAXBhUSKrtlFiLhhiSM23XRW8Aetb7L8z3MX8uEFHY5ra8QYM1u1zu8Uidu4pc
         SYPHTWvTaganMCYBYhwU92OBwJalcL4YynhPG0TjnBt2v+VpoYdxkqwiED0bHCkeK7us
         J7jIrMH5YWhSeKlf3jOFusMNqaPvo+ofH2cqpBc4vwfTGjJc4i7zisRbU4ejV95yRl4q
         8ybQ==
X-Gm-Message-State: APjAAAU8FjiimiRFlQ5whaQ5Z/Phv0K1oIImSt4SyUOthyHfRFKfc63b
        HUcasT00/y1EtpMotN5wgug/Lnt1a73gArCGmeqUToffKQRkZoKHH8iBG7oeobBgs+zb4rMVQ5a
        6v9U6kpgx39bT6H1R8YlrAe3nIPpK
X-Received: by 2002:a5d:8253:: with SMTP id n19mr2771291ioo.80.1562830045521;
        Thu, 11 Jul 2019 00:27:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwykBuhMY0MflryJAdOCZjSU5Q8jTPnO1WMGnm3QHHt+0CnduoPwCZxjmV6fOsHBxPhCV2Z2A==
X-Received: by 2002:a5d:8253:: with SMTP id n19mr2771269ioo.80.1562830045327;
        Thu, 11 Jul 2019 00:27:25 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id i23sm3303359ioj.24.2019.07.11.00.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jul 2019 00:27:24 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] block/bio-integrity: fix a memory leak bug
Date:   Thu, 11 Jul 2019 02:27:12 -0500
Message-Id: <1562830033-24239-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

In bio_integrity_prep(), a kernel buffer is allocated through kmalloc() to
hold integrity metadata. Later on, the buffer will be attached to the bio
structure through bio_integrity_add_page(), which returns the number of
bytes of integrity metadata attached. Due to unexpected situations,
bio_integrity_add_page() may return 0. As a result, bio_integrity_prep()
needs to be terminated with 'false' returned to indicate this error.
However, the allocated kernel buffer is not freed on this execution path,
leading to a memory leak.

To fix this issue, free the allocated buffer before returning from
bio_integrity_prep().

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 block/bio-integrity.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4db6208..bfae10c 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -276,8 +276,10 @@ bool bio_integrity_prep(struct bio *bio)
 		ret = bio_integrity_add_page(bio, virt_to_page(buf),
 					     bytes, offset);
 
-		if (ret == 0)
+		if (ret == 0) {
+			kfree(buf);
 			return false;
+		}
 
 		if (ret < bytes)
 			break;
-- 
2.7.4

