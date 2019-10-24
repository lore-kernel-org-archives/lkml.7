Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B02ECA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EEF21D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ajFk24nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733070AbfJXW7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:59:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45313 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732966AbfJXW65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:58:57 -0400
Received: by mail-io1-f65.google.com with SMTP id c25so177481iot.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hIAFt5NPNEcTJjheJJ7IFoP1QwOV2b47sLZxfo5ML0c=;
        b=ajFk24nn7MaVF1UXN3SYe+082t8H3p1T+unPsMnYo5MLGiysAPhdHHBqSNcAs9Dj7g
         M74uQnxp9Al/Ibh40zpDUgicdCCRj9a14WULDZzfwbbuBlhLHpalRhh86On02pJR1Lno
         5laMI1GF6hgzE0EjAI5jdvSZPUvCIkt/U3/7CM6WgfCyE2PDQahhk4VyD31Bakaa/xiJ
         z1KQ8VW73KY/7dvy6e166XjtiJvw0kaclFDfIhovqEoceOBWZjMTm5bVYD4i6NY0UTFL
         IcHxyadIJOonendiqIAZd+vdeOwJNGA1jGCKzQFPCnFlel4TVKykHJTZxRFWJABXMup1
         884A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hIAFt5NPNEcTJjheJJ7IFoP1QwOV2b47sLZxfo5ML0c=;
        b=EYP70jtfJdnI+PlieLDNDDRQPGNILYRLEhajMldU5lYZlccUcaYsvi+h6NlPZGC7sj
         N9kqtYWQ9Znb91/24GWPWsCegpO7SBgbwJVbsoFaYAo7UZk3VP2hkh4odMclptRJSQh/
         dStYw8rs3hZ7rTkRr0wID+yqXlxez1dOQXUAkMglw37TfpYOL+Xk2k5GcY51yrcAPGnB
         6co9wVs3F+4F3TDGZL8tY4+ufLk4rRMI3A4Goox9mDh1/uVzdTtPOdGs1DmuL9LuSUEk
         rlIx0km+JrDTzptChTND+rWWAl0WsFhgjIGGmrmBr41rzYFK1hxkUsUWukwvZGCmUqtB
         b1cQ==
X-Gm-Message-State: APjAAAVKI+y6msaH/IsPPwxG+CJp1gwYOoB8GVRHHxFpcGEWaoDAOXrm
        hTwDVy12igm5KghfdGKoYpBToA==
X-Google-Smtp-Source: APXvYqxgOjI7iUMDkwHlJSHTab/FO1wxtN8dxivhZMVQwZy1W9sGjYGqLFcYhLtt3n3B+f8RWCC0bA==
X-Received: by 2002:a02:950b:: with SMTP id y11mr808962jah.100.1571957934933;
        Thu, 24 Oct 2019 15:58:54 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id b18sm58112ilo.70.2019.10.24.15.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:58:54 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, hch@lst.dev, greentime.hu@sifive.com,
        luc.vanoostenryck@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 3/6] riscv: mark some code and data as file-static
Date:   Thu, 24 Oct 2019 15:58:35 -0700
Message-Id: <20191024225838.27743-4-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191024225838.27743-1-paul.walmsley@sifive.com>
References: <20191024225838.27743-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several functions and arrays which are only used in the files in which
they are declared are missing "static" qualifiers.  Warnings for these
symbols are reported by sparse:

arch/riscv/kernel/vdso.c:28:18: warning: symbol 'vdso_data' was not declared. Should it be static?
arch/riscv/mm/sifive_l2_cache.c:145:12: warning: symbol 'sifive_l2_init' was not declared. Should it be static?

Resolve these warnings by marking them as static.

This version incorporates feedback from Greentime Hu
<greentime.hu@sifive.com>.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/vdso.c        | 2 +-
 arch/riscv/mm/sifive_l2_cache.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index c9c21e0d5641..e24fccab8185 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -25,7 +25,7 @@ static union {
 	struct vdso_data	data;
 	u8			page[PAGE_SIZE];
 } vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = &vdso_data_store.data;
+static struct vdso_data *vdso_data = &vdso_data_store.data;
 
 static int __init vdso_init(void)
 {
diff --git a/arch/riscv/mm/sifive_l2_cache.c b/arch/riscv/mm/sifive_l2_cache.c
index 2e637ad71c05..a9ffff3277c7 100644
--- a/arch/riscv/mm/sifive_l2_cache.c
+++ b/arch/riscv/mm/sifive_l2_cache.c
@@ -142,7 +142,7 @@ static irqreturn_t l2_int_handler(int irq, void *device)
 	return IRQ_HANDLED;
 }
 
-int __init sifive_l2_init(void)
+static int __init sifive_l2_init(void)
 {
 	struct device_node *np;
 	struct resource res;
-- 
2.24.0.rc0

