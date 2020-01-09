Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83600C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9602073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="TBrGHwgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgAIHId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:08:33 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35135 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgAIHIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:08:31 -0500
Received: by mail-pj1-f67.google.com with SMTP id s7so754926pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 23:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwvqhmbLPpvanCf4CYPj6H756JJZayFM0Q320MsSZZo=;
        b=TBrGHwgdiHUWcFzu5YWy2q+sBvAdh+cIpcnaPnFCmgw5aVB/ZjS6/zor5S/EXHzFEr
         wDya8GXeYBXfG6P/X2ma89hl/VywtdWGv25aTH8MdRCR5scwi5TKkHCADSFPVP/AHpvc
         O2u2y7VA5kPvTHcOc9AWdaIXo61AuIafawnq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwvqhmbLPpvanCf4CYPj6H756JJZayFM0Q320MsSZZo=;
        b=EgCZ1jDw6fqWoWoM6XBlXOhgtXuuYgnjufHQF6hiKtSs6bWcV7Q3Ni7dQAAvNnoSdU
         2n+IDgTrVJ+PWTnG34oYNekzDTeor+JKwRGuF2oixUKIJNiQPljpWmedeyMIaMQGm0Z7
         OjP9lz72iHCkrRjEwu6r86kS/PfV+vL1ieHy9ViB8cX9lTp9phynwHb86WjWx02O9+sZ
         5cBWA17xaKsdNj7gKmC3WYn1y2Lc6JrVNndbCBz1MHLNazonVr+rLAXcQS1Gtyiu5OoY
         W4mnB57h579d0nLXmZSBNWctLCOykI9zDAaLJ7vNE7HjBW9UAhEjvFQm7VtAI3cw1qxg
         gM7w==
X-Gm-Message-State: APjAAAWn6MHa0MXMyVZ8UB/xx+Xi4mvYErbq30ViAEYRBngcAL2xQQUo
        WzAic6k6uwwHqka8tAkyV+59OqVISkI=
X-Google-Smtp-Source: APXvYqwON3PZ7E29ypePrEmq0EIeeuv7pvxpkaaOGrcITDNPQdZ5KASM0AslhPi3zjBdfUq5zbE/Wg==
X-Received: by 2002:a17:90a:3643:: with SMTP id s61mr3623176pjb.44.1578553709799;
        Wed, 08 Jan 2020 23:08:29 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-5cb3-ebc3-7dc6-a17b.static.ipv6.internode.on.net. [2001:44b8:1113:6700:5cb3:ebc3:7dc6:a17b])
        by smtp.gmail.com with ESMTPSA id e2sm6363942pfh.84.2020.01.08.23.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 23:08:29 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v5 3/4] powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
Date:   Thu,  9 Jan 2020 18:08:10 +1100
Message-Id: <20200109070811.31169-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109070811.31169-1-dja@axtens.net>
References: <20200109070811.31169-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan is already implied by the directory name, we don't need to
repeat it.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/mm/kasan/Makefile                       | 2 +-
 arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)

diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index 6577897673dd..36a4e1b10b2d 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -2,4 +2,4 @@
 
 KASAN_SANITIZE := n
 
-obj-$(CONFIG_PPC32)           += kasan_init_32.o
+obj-$(CONFIG_PPC32)           += init_32.o
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/init_32.c
similarity index 100%
rename from arch/powerpc/mm/kasan/kasan_init_32.c
rename to arch/powerpc/mm/kasan/init_32.c
-- 
2.20.1

