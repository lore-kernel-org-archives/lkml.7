Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D9CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B4E20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ArUUrSAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCFVi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:38:27 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45382 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFVi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:38:26 -0500
Received: by mail-qk1-f195.google.com with SMTP id v139so7758357qkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 13:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Kmnz/guZPJnRPV2xKUGZraLYc52bC6Yc94Bjksc5cLM=;
        b=ArUUrSAD2NzcY95UPnvXBFw4Gk7PHBSGPLEXvuPWD9s325FpXawK7pCWywUUWl6QTt
         Cgd6/7byaLnFT0ZxV8kfojcps7U8mXF7PC0KtFVWE1P3ir0lnnyTOSD5pAKuky+qYfzy
         iCv35q/Dw855IUoti90UxpL7M1Td+z0dJQBwdRrj92aGotU4N9POqNFSYidpecR2LCLN
         sAn7RD+PT0ltHqUb06im4BZgkhjl7T+mZjJ+lzQDEjZW/BjGOVtkueP9e3RolKvHHil+
         J/PdgQ00McBiKhDjAGcH9DpsEQS/bxxVuI0pgELNX9IzdnUzioUWt2CKNB1WrBnyDFdX
         mDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kmnz/guZPJnRPV2xKUGZraLYc52bC6Yc94Bjksc5cLM=;
        b=ae4khgjQrUCdgUpQbQhsGmtIzy25fGCprJ2f+l1uVoObioh7DehxLhK8gkxL3piJpa
         hMBpMBZJQWxCUTus99Dpchrdq+XrdPQh1fkVdISygHeHxPMFiTbSIq6+lHKGlDcOfAPK
         gfwXqvL1Czn3S2qMkxlLBlXaaWm+kyn4MddLzzvXIt1nnvewHzm+4yYtfzChmf0FYi0P
         9nQaO1mJFUQ+UvIZIOsPbeXgmEvsfacbpAJvo2aTN2piFl0CZQzfxF0b0QO44JGuM0GC
         t5iRKtFlWd1c+wiBDVnKAMiq9ntVh1egZn35Wj4+1XG+CcJYqI//Ox3sH6zWtRHdZkS5
         zMug==
X-Gm-Message-State: APjAAAUaosaqDdVNGv+GTsMavdUQAC8HtVhUkyr3RrVVkVx1CUWIB7uc
        tAlNwkg7M8AdpDeBrWuGhd7MrQ==
X-Google-Smtp-Source: APXvYqzhAatQmCLy5HofCjyR6wWxVLm2DK3OoMKMB9x4IwyuBT8dyVzRYZgLkPpJwmjS4oVdYI9OLA==
X-Received: by 2002:a37:d409:: with SMTP id l9mr7699999qki.211.1551908305925;
        Wed, 06 Mar 2019 13:38:25 -0800 (PST)
Received: from ovpn-121-103.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z140sm1389873qka.81.2019.03.06.13.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 13:38:25 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     akpm@linux-foundation.org, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] Revert "x86_64: increase stack size for KASAN_EXTRA"
Date:   Wed,  6 Mar 2019 16:38:06 -0500
Message-Id: <20190306213806.46139-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a8e911d13540487942d53137c156bd7707f66e5d.
KASAN_EXTRA was removed via the commit 7771bdbbfd3d ("kasan: remove use
after scope bugs detection."), so this is no longer needed.

Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/include/asm/page_64_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 0ce558a8150d..8f657286d599 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -7,11 +7,7 @@
 #endif
 
 #ifdef CONFIG_KASAN
-#ifdef CONFIG_KASAN_EXTRA
-#define KASAN_STACK_ORDER 2
-#else
 #define KASAN_STACK_ORDER 1
-#endif
 #else
 #define KASAN_STACK_ORDER 0
 #endif
-- 
2.17.2 (Apple Git-113)

