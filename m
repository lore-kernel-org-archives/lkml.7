Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D2AC10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD66420865
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIZNAg9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbfJDBUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:20:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33313 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731802AbfJDBUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:20:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so8393644wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 18:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lG/2whsK1e33REk5Rj0GoMCZtO++gouhkUytz/BN6jw=;
        b=pIZNAg9vXWNVJ+OGbX+JVvVRsYu99saP6L2riwZqhquqkpXlqM4ijM2p73BIA1REEc
         m/8qUdGZM+Vqh4NqpXTjRM1OGzsZGwG957k3CkTEBrj3dNeuKreQ9/E4dsTU5gCNSfBo
         lmREvD9NXRME7HgBdlGdSF86k47t5Vv/aYkbwPzFF4YP3aQMVZi2ydks1n5pJEAoWsbe
         woCfEVL4kZMlb24Ibsjb3ricwm4zuY9NEViTYFJzxnCbApZUmOSoJTHD52YwvvIzuTcD
         RMZa9DWVGvyUQ2xnNBWuQRACr+rTVwk4urpx/nCE79kNPJrdKnuJNl3jdtU06OhdenxO
         L5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lG/2whsK1e33REk5Rj0GoMCZtO++gouhkUytz/BN6jw=;
        b=fEH4LE4r4StYBkDYE0DUmLhdB35A+h4RixXaNhIch4IYJo82tI1kMHRzMGh3m1uB8u
         FaZ75o+QuhftBmAQq1cTY8gxq1tP+RwW6j7gFe5ZW6Zl6OGliczTb6yObLHO4hec0Fd9
         rFwagouAaxzz/rXJkD34EnH/wzZ/EBRCwOBZpZuYrCCMnqItEUGbiK2ppAmykgyx5Gxa
         Iq9CoISN0XdYdHEsdLJ8JRslr3KIhNo8tdnsvA70MYU6Sna3P9/TmDOzExlszd84J4mO
         FMm3TR0zKEVz/yK8DsA1K0pTkU4EIbSYrHnRNgMG+5vY5VNgg1gtbs6ojWixj/eyvr7H
         PrFw==
X-Gm-Message-State: APjAAAUDMJjdSBO4pMBvHOx4EWdbuyGyc+BG3fwEGMTgNxv3vx7thoIp
        bdbDGPvdVyTMnvGpa6LSrmM=
X-Google-Smtp-Source: APXvYqyILcXoL4w8EG+OwI4HTv3AR9IVVqFVoyowi3CeyT6F7MWOVDl0NcziJA/2o+EvgbVTontvVA==
X-Received: by 2002:a1c:9e0b:: with SMTP id h11mr8460484wme.144.1570152033162;
        Thu, 03 Oct 2019 18:20:33 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id a4sm4097404wmm.10.2019.10.03.18.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 18:20:32 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [RESEND PATCH v3 2/9] hacking: Create submenu for arch special debugging options
Date:   Fri,  4 Oct 2019 09:20:03 +0800
Message-Id: <20191004012010.11287-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004012010.11287-1-changbin.du@gmail.com>
References: <20191004012010.11287-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch special options are a little long, so create a submenu for them.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib/Kconfig.debug | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 157db30e626d..b29a486db38b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2148,6 +2148,10 @@ config DEBUG_AID_FOR_SYZBOT
        help
          This option is intended for testing by syzbot.
 
+menu "$(SRCARCH) Debugging"
+
 source "arch/$(SRCARCH)/Kconfig.debug"
 
+endmenu
+
 endmenu # Kernel hacking
-- 
2.20.1

