Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E68FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151F420850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bLg8Anx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfCTRU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:20:58 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40370 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCTRU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:20:58 -0400
Received: by mail-yw1-f66.google.com with SMTP id p64so1774777ywg.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=NRgonLpvOeEqya4RSsHwTFSvx6sxh8xK6I9nddGGbYA=;
        b=bLg8Anx7wn3yrjCPPCLHbChSv+0zoQv7GTrK5SZsckybDg41AnBqS0g/xC0NluuPaP
         3A6qLkU4t4P3WjvGD3bJhPyJomcR65NOD5sys2RlnhzOqhRW4uLof6XD+3UN8VAWAv+l
         yNF2OLn499Y1uthNwJQVZPCn9IiSzi6nZFN4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=NRgonLpvOeEqya4RSsHwTFSvx6sxh8xK6I9nddGGbYA=;
        b=d6jTTe44E2uC67QaJFvMEQuYsYmGp9MqdimzWL6j8OZl+w8dV8vPjDXxCdY++emxID
         OFQ3/Wnyi41FW0z9VfEAgSGg0fePP8Eu4dsaFEb6QbGSQ2KQ4Op2kIL0sHvEZfVG6P8E
         3BrmCXFOaDE7Gw7TrZabUmWd0G+EHkV6h2gGGzrMCFKel2N7xgblpdRJ3jJq7lVc8lZ5
         ZWHAjbaua4SOXl9baGRN+Eazw2/BmuR/su3/r7r5fz7pne/VmpA4ra0kVaMTHSJad0lN
         ke4NiPSGObryvTtHdnNZvxHD4gdrWpkhoY3K3jdPd7lW+k4N7rlIZVPDBRJjg4nQe8f/
         HPfA==
X-Gm-Message-State: APjAAAUE4xTr0+zCAmYrMfgAYuxW535wcRkGsvme5cNAop6+FQX5CaNo
        JCO1gtWShx91OoC0XDBlvvGPjw7lXx7US2iQp/WPtg==
X-Google-Smtp-Source: APXvYqw7QDd4M3k1yul3weU+q3geWiInnX/5SWeeiIKWwXyXUx4stfRfe6fRYviX4MmUXKgBbXHGrTKh2ai5BvjTcpI=
X-Received: by 2002:a81:7a94:: with SMTP id v142mr24536801ywc.221.1553102457575;
 Wed, 20 Mar 2019 10:20:57 -0700 (PDT)
Received: from 764776645087 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Mar 2019 10:20:56 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Date:   Wed, 20 Mar 2019 10:20:56 -0700
Message-ID: <CAG5bF+TKCJp8Pvmf888GPrJ58ZAOoZpH7Yo94pLgpqWmPt4nvg@mail.gmail.com>
Subject: [PATCH] arm64: remove obsolete selection of MULTI_IRQ_HANDLER
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 config selects MULTI_IRQ_HANDLER, which was renamed to
GENERIC_IRQ_MULTI_HANDLER by commit 4c301f9b6a94 ("ARM: Convert
to GENERIC_IRQ_MULTI_HANDLER"). The 'new' option is already
selected, so just remove the obsolete entry.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 117b2541ef3d..7e34b9eba5de 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -159,7 +159,6 @@ config ARM64
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA
-	select MULTI_IRQ_HANDLER
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 	select OF
-- 
2.21.0.225.g810b269d1ac-goog
