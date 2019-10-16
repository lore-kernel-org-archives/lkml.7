Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DD0ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236FE20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrQSV0DS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390832AbfJPDMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:12:53 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45021 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfJPDMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:12:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id w6so18699833oie.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 20:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ps4EVuybUtMjAwr2oDyFkpx78Fm0dPag8RJXIQ6sLRI=;
        b=ZrQSV0DSQt7/CAKfrEigLHdIDxlswOYjHDG8Db1U4KxJFnjeaWuWtikRq/3XpXID1M
         gEDgZDoEhzsJGePOYjhPxfdCfpEHlJ7Dq//a01bSFAAAlShkI0FOhqh5fY5IR+SKMwmv
         VHlJUHMZbeE1WhKSkougzM4IAzZwPQC9NqTFKvmijHSJiLgsCiBJW2/kboNMG7DBnfcA
         NIL/mxk50sekpXtHWP3hT0HFd2VKHnfTm5YfqaOCLuiGjlUZ6rxf3EIGNJ4QYyuaAi5+
         JeBECp//LbCgcWj8DCInG85WHymzN6y1arfB5rJoJgSKaMx2CKyOOe6w5HJ7iSp/U/T7
         qJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ps4EVuybUtMjAwr2oDyFkpx78Fm0dPag8RJXIQ6sLRI=;
        b=K8BTFeQ9Q21o81Xvwz3mSqP8WH7lpuhVXt5GNdlg4JW0WZ1cmL6coPPhcgY9V46pxO
         pUdUb8q7VPn7zTkaK3iGxwFy3gXPOtzjaHvzHlZMzEVI9efvPIyVgQ5gXj3oArXvlkE7
         FbMkzlDzo+BFU1teIsTMsESc4YLJElW0lnEQH4tWbSe7ZSOcOWY96EfL6FiRfSilvXRf
         K22dpd017H//7Qirp+8JIwsJKfFVf4BFLVU52oQWVDYE0r/L2neoVwWrchLcV8DPBq46
         QTdpteWJHcUeGiN+nBQaekIdNl7KpH4kHnh5924HQyBmxTbt/2WFflCSjRCpUqBbT4wn
         6iqw==
X-Gm-Message-State: APjAAAUMdLLkn13G33RqG4AwAkV5PNuH5L1ZSHnWJxSDmSq7ypUp4p7l
        THsUpnp2A4HtLQ6nhqAC7Lk=
X-Google-Smtp-Source: APXvYqzemvPwAicUlAsZF5hC3V69o0sHDC/Cuz34m2aXl5tSu0Nnv1l9LFQAJXp8eeTxDpJgZqStsQ==
X-Received: by 2002:aca:48d8:: with SMTP id v207mr1499400oia.113.1571195572447;
        Tue, 15 Oct 2019 20:12:52 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id z10sm7854337ote.54.2019.10.15.20.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 20:12:51 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH -next v2] arm64: mm: Fix unused variable warning in zone_sizes_init
Date:   Tue, 15 Oct 2019 20:11:08 -0700
Message-Id: <20191016031107.30045-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015224304.20963-1-natechancellor@gmail.com>
References: <20191015224304.20963-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building arm64 allnoconfig, CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32
get disabled so there is a warning about max_dma being unused.

../arch/arm64/mm/init.c:215:16: warning: unused variable 'max_dma'
[-Wunused-variable]
        unsigned long max_dma = min;
                      ^
1 warning generated.

Add an ifdef around the variable to fix this.

Fixes: 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Fix check for CONFIG_ZONE_DMA32 as pointed out by Will.

 arch/arm64/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 44f07fdf7a59..359c3b08b968 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -212,7 +212,9 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	struct memblock_region *reg;
 	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
 	unsigned long max_dma32 = min;
+#if defined(CONFIG_ZONE_DMA) || defined(CONFIG_ZONE_DMA32)
 	unsigned long max_dma = min;
+#endif
 
 	memset(zone_size, 0, sizeof(zone_size));
 
-- 
2.23.0

