Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68444C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B87D218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fClGr7iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbfIIOpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:45:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45407 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfIIOpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:45:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so9266025pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qv666E59dTrURX4bKRzC5KjavofhrzL5P4tc/irNvlY=;
        b=fClGr7iL00eXWgE5KsfejhexidNmnbDJiwd6BZTqLWSXsVrBUyBukK1nce7PtBqKSm
         SiBCEcRbP9Zstw6tVpUVZ3BTPr5J6aEJAtAm5R7KMfhouxphkjaljm9YohcUld3+hDWv
         RitGYzQYi71I8imxYBKy+I7e5P3tvrO/SJgYjyBYV++ijigJKToWTDH6RbkGvGwOyeaf
         WitFlNrGZEdN8Gi8l+Y2r9jfyFNE0QpfRFCQMSSFFL2YYM+1Sgz/tTlmbNN3BTzbkyaP
         F0CMwnDMYfCXndQe6SM2TD3wSQzW4kBVURFjZLmNvu6jPLAkmYLqpoWGZDQtHXLZjQb4
         KFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qv666E59dTrURX4bKRzC5KjavofhrzL5P4tc/irNvlY=;
        b=TGS6BP/Pwemkg4ate9TVW31HGMXX2m1/aF3KHTSlSWWofMhupYSHZgav3Lx5TcEITv
         Fth9ReL0ir/fk1qRUt5oag0C6DqD85H0ikPIRFSzjB26bGsNO9DGomsB5Gd/RYVKW+Oc
         kaAaaWaFBBlIrVAKmPimD4R5Z9Sw3sFG1btCF3bqiuZMn3hXuK4Y1H+vZH4hHic4f+Qd
         yqXr5irrdNvJAVOcNSb5OgvRYxJbPWlSLOb/U823UIKV0KBRZSJLRHfCfWw4usm5LGA/
         92XMKDUjMtt6ww2ZQ3IcDvDr4uTozVOlTJwyMSDTuVyDxhKCNlqgoQxB0nXjTPbTDGrB
         JRnw==
X-Gm-Message-State: APjAAAWbXZsITTBybrTmckfzkCiZChqmU+etWMJ8Ex8DKeMZl0vaiqKB
        8UQE2Vus7FdF+7g/2uXKI1EvQAVocpt1Ew==
X-Google-Smtp-Source: APXvYqxv5C5pD79JL8tTvr+mbnfBn3WJ/dgLx8mQnFKBsWx95bf8E8lwWx5+1IfAoiPTcjQQWDb98g==
X-Received: by 2002:a63:4c5a:: with SMTP id m26mr21723218pgl.270.1568040318217;
        Mon, 09 Sep 2019 07:45:18 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id t9sm15334693pgj.89.2019.09.09.07.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:45:17 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 2/9] hacking: Create submenu for arch special debugging options
Date:   Mon,  9 Sep 2019 22:44:46 +0800
Message-Id: <20190909144453.3520-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909144453.3520-1-changbin.du@gmail.com>
References: <20190909144453.3520-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch special options are a little long, so create a submenu for them.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bd3938483514..cc4d8e71ae81 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2164,6 +2164,10 @@ config DEBUG_AID_FOR_SYZBOT
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

