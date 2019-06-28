Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43021C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AA02086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAkI39n4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfF1CqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:46:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34191 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfF1CqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:46:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so2200749pfc.1;
        Thu, 27 Jun 2019 19:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=19iGsB+gEzyIr57/DpIGaBLmn8xqXumBOeEKleUog6g=;
        b=KAkI39n49Ass7U/Nf8g3gWdeUapZ73JL/FuCVDyj7KPGdjml4DHirbXTnyxaPFe7z7
         4zq1nlaPwHu5SwtPupDsa5wzMMmNeLJrGA34P/C/4/cCjmKOBEfHLTA4UEm+feRLDFEy
         GIjytQrUJFQkl0ba3/+cmmCQ6yq17yxF2lbu/skEbXaH2cVRzf+Q7L4+CNHBSzX9Zok6
         I4RGvKePGxKKI/UwRROlHsuToWj5bC7Kj8PehNUpVCnqw2aqyl/bFwPYyFLuhZn1tGkE
         t0Xc4qREepFTc0rdO8SjDFqAKuOYK2m6C2gb2WBjM6RJvHXrC4IW+NZ3IP/hMsLugJVn
         Waow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=19iGsB+gEzyIr57/DpIGaBLmn8xqXumBOeEKleUog6g=;
        b=mpxZ0xGktCP+F0RkoSAhBs74PQlp9c3uIvTvf6od/WUIUnVaff+dlplHNmHTxvw4O8
         EfbFIZhnFsxlLIXUnWZoR8M2Q4FuZ60Ormh5LWVk8FWUE83f3GxvApgCtI4RGCeshbcq
         c6SHhOWZWIxRpVUrGqsZzF1uNCmdKwVyaor1eaUtrSzidtWuISnClXiidBP92wRk7mzf
         5rqX/EU8afT8j8b/IPEKPPq489NA0djSkl9BDMSdOdOBR3znq1alQZCLuuqAIR5eP5o2
         H+C7fQbUgkLp3F1fz0fUmPVL667EQ5Ilz9si00ktHyG5q7gwj0UuICUt2gT0KUBhW3q3
         3pVg==
X-Gm-Message-State: APjAAAVW1u2hhDaS92F4B7aqBs0cX5bGVww90KgAsyo2ucZ/VBS/ZNZD
        Jnn+8BGOPU+oUM9tQsXLRSw=
X-Google-Smtp-Source: APXvYqzNRJWtbX7Zwkkxcl6M+n/9qnAlFuGw48cAbce0wvCkRN1fAwrY2avACJO0KHR2ij69oepZOQ==
X-Received: by 2002:a65:534b:: with SMTP id w11mr7104029pgr.210.1561689964266;
        Thu, 27 Jun 2019 19:46:04 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q5sm394597pgj.49.2019.06.27.19.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:46:03 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/27] sh: mm: Remove call to memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 10:45:48 +0800
Message-Id: <20190628024549.14823-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 arch/sh/mm/consistent.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 792f36129062..b09510adfae9 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -58,8 +58,6 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	memset(buf, 0, memsize);
-
 	r->flags = IORESOURCE_MEM;
 	r->start = dma_handle;
 	r->end = r->start + memsize - 1;
-- 
2.11.0

