Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16E7C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF062177E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmYexK4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbfEXCid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:38:33 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35096 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfEXCic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:38:32 -0400
Received: by mail-vs1-f68.google.com with SMTP id q13so4832200vso.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 19:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XvanOsup0AcZacIZGJvgzlGN6xUx2g80dRy7eje+QD0=;
        b=cmYexK4FBqetbwPK18QiniGVmZ92uhC8h0NzKA+MW8M9lhBSV+45GSAFcxRtZIZg1Q
         UvDSoqlMCROQMjHkPUZV9tzgmkqIFfSZJA/i0/U56ALxXVjbqfec2EkfufUOKkt7l8ks
         MRG0Sv9ahQvXpynLdRFo/JexHzDOdc6i4Vtqf89M2lJy0nKVT0V+9IQtgtCwvm3gJ4VF
         sdefjl8uGXBy81PeyKZwEQj7zK9eTOp2pT37lGGcFJcnkRatmiegLZNuwo4gC9P1htko
         oMWtQD9ffURCYeYK5xyiGMmmQjbYohgTbHKMwhz0lZkL6RR/TD4vxlm0XfYtwJgxTh9k
         28bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XvanOsup0AcZacIZGJvgzlGN6xUx2g80dRy7eje+QD0=;
        b=CjXayguOBpqpbPlf5ms4g5WIstIci5Ug2+Y2nzWfZTD4AhkXfgHpjphhuLh2sL7379
         rgQiFA+uajjZfqmMRpeeyEzCk0sJMdYB+QSxhOXT6JY5DGGJZwb/MJIVKh1B0Bqv7qxw
         P9oHjIWbpabArbX5HaYmLBrCzqoyFpHKRN1WwtrmwxxcMZ6YETn4YxYG8lri8avThBrA
         wAtByXrA5aITzSsEy2geA8R/il4+XCPOjC1sEgDYseVQyhhwsz4GXtzHw7Vj3yPyLOGU
         LQy+99THUFJr+M9W0tQVLqxhnHNsJJcN8FSAtrM9KARiTpy1e7/f5069Jd18YIgAS9jk
         zVNg==
X-Gm-Message-State: APjAAAWz2EUP+qPbvXF/S4Rj0yS3iEj1tD3vhmLv4nLq8f9az0HUWkUL
        b7IcNBl14nNRvMt7kw/JK+k=
X-Google-Smtp-Source: APXvYqw9cnoq7GyYprdKx3oHAf9Ae/BEpK8fSmDkRJyujfvyQ9MlKaM7QCjNSmucf080ymj9rutKhA==
X-Received: by 2002:a67:dd8e:: with SMTP id i14mr6545291vsk.149.1558665511952;
        Thu, 23 May 2019 19:38:31 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id p70sm361931vsd.25.2019.05.23.19.38.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 19:38:30 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geordan Neukum <gneukum1@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Matt Sickler <Matt.Sickler@daktronics.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: kpc2000: Add dependency on MFD_CORE to kconfig symbol 'KPC2000'
Date:   Fri, 24 May 2019 02:36:36 +0000
Message-Id: <20190524023639.6773-1-gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523053643.GA14465@kroah.com>
References: <20190523053643.GA14465@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kpc2000 core makes calls against functions conditionally exported
upon selection of the kconfig symbol MFD_CORE. Therefore, the kpc2000
core depends upon the mfd_core, and that dependency must be tracked in
Kconfig to avoid potential build issues.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
v2 changes
  - base patch on staging-linus
  - only add MFD_CORE dependency as the UIO dependency has already been
    handled by YueHaibing

 drivers/staging/kpc2000/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/kpc2000/Kconfig b/drivers/staging/kpc2000/Kconfig
index febe4f8b30e5..ef0f4abe894a 100644
--- a/drivers/staging/kpc2000/Kconfig
+++ b/drivers/staging/kpc2000/Kconfig
@@ -2,6 +2,7 @@

 config KPC2000
 	bool "Daktronics KPC Device support"
+	depends on MFD_CORE
 	depends on PCI
 	depends on UIO
 	help
--
2.21.0

