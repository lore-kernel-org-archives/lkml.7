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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37A1FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67A42168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV/mvzRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405758AbfJPOtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:49:07 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37336 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731322AbfJPOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:49:07 -0400
Received: by mail-oi1-f194.google.com with SMTP id i16so20289556oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w1bxrgVA37G+vlASPmtvWKFuCtmhkeFNcRz6WRlmRjU=;
        b=cV/mvzRfHOQQSRtHHeQpRDH7Gm9zRPlfcWS9R5ZhcSzGTi98v3A9AAlhUsyazP7Laz
         5lmdp7D4vUQEi557gGii1CzHcNk+MgGKFrm/cbfY1drUb2PsXsHH1vYEBIfhUBte9h8R
         +9K66Slzy/v6RP1V8mAbkgQ3peCNr+vnwZ52Z6CdCaYh1cL+7DtTrGfiWg0yNmOAH2fe
         3ivwLseXQjkqFqEd99cHdWz/ycBGljWtsgl3pL+TsNn8LYHynVV2lxeDQp+j1qJOqsy8
         QgH3QGjL2dSW+TWsc0lbEwc34KDF8Pm5togWdw8MIEuc4PLQkfJQE1Cc3aNOtIo4JYVx
         4UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w1bxrgVA37G+vlASPmtvWKFuCtmhkeFNcRz6WRlmRjU=;
        b=G0sOZDQmwxVDQ4vVcx1+xNzX3xFahTQ/ciYTmOG5+C1w6Ke80VW39LZiGLWzdCuJU/
         XJdYKKsMBu3IiQ+r+0f1AVpFbQbptYkssg+AM0AuMbE4jYtj0HcOevn5Dv2+x0rJZQb3
         IDZKAs5IfwuTyL51WC6CQ2aYvLPs690TYbLQj58AQSuZ6A87gx70hDxdWLrMpKMrUn7f
         fBui8lkn74aahpIxHwb3HaSrHn4z0Wxw1p0Kx4Z5sEiW6/fjVWKn7SP2/pmhxuXADmYJ
         pCUBhvhCjXzxRDuOcThVF0JnAjoxKVganEom/IMyqxwPIWrDNhL9EqPZ4v9jKlItOnI6
         d2GQ==
X-Gm-Message-State: APjAAAWggiUWGyvArOUu/8UN+vXhm+mDTUdo29Sgp+7qgM9H3/JWUmI/
        52w9AeLX9u1ARrBUHdQyau4=
X-Google-Smtp-Source: APXvYqyN5zisgMnkVtiqZYBEqq7Y3oEfz/wNwyVWCQzqSRIXm/Hfh5W+j6xi9TCcQ44CZ63kx7p2kg==
X-Received: by 2002:aca:dd07:: with SMTP id u7mr4009174oig.106.1571237346163;
        Wed, 16 Oct 2019 07:49:06 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id k3sm7281574otn.38.2019.10.16.07.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:49:05 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH -next v3] arm64: mm: Fix unused variable warning in zone_sizes_init
Date:   Wed, 16 Oct 2019 07:47:14 -0700
Message-Id: <20191016144713.23792-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016031107.30045-1-natechancellor@gmail.com>
References: <20191016031107.30045-1-natechancellor@gmail.com>
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

Add __maybe_unused to make this clear to the compiler.

Fixes: 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Fix check for CONFIG_ZONE_DMA32 as pointed out by Will.

v2 -> v3:

* Use __maybe_unused attribute instead of preprocessor ifdefs
  to conform to section 21 of the coding style as pointed out by
  Catalin.

 arch/arm64/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 44f07fdf7a59..71b45c58218b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -212,7 +212,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	struct memblock_region *reg;
 	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
 	unsigned long max_dma32 = min;
-	unsigned long max_dma = min;
+	unsigned long __maybe_unused max_dma = min;
 
 	memset(zone_size, 0, sizeof(zone_size));
 
-- 
2.23.0

