Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CD7C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9053D21726
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxDO9Mih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfEQRPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:15:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45972 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfEQRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:15:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so7878394wrq.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=naBDVzNGnuVxSb0pTsKKkPbTR5+S/nyhRezxbIQImGI=;
        b=NxDO9Mihh7z44KOHGLa6bSIJFZtx6H541W8inGiEpi2KcfUSXgBzbBn7f4uVmM+pG+
         7ta8+rCgV7E7zl2TLDmSa5qDNQMoBpBX1OvnmCWObWviXUBH0VEB9RhQOXaHUx7PbMuD
         aHeglqmIiT3aO1d85gHDKdLdPsb3QNfy58Rgwv4x5nvw3mUySlxt7fNF69QdyzULLJJn
         MiYwTrxydOHyxxcDd894x9LkF9si91JZBvx67YHxBf70PQCI19ohuVVMPdXQaBDD423n
         jBTzHlrTPaaC1tURHSGQuPVfAktXZcNxm9Fg/F6K0dW0OAcbQxZKGuweqf80DDJlY2ju
         mJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=naBDVzNGnuVxSb0pTsKKkPbTR5+S/nyhRezxbIQImGI=;
        b=fedRwm3lcq7KpjcpZJAW37ovKPwxYs6fVyXuoxCbTsB6fT5/mtpmlhyCqwvWpLXDdT
         xXxOfg0kiR2LKr0XLfhDGPCRdgV8Q3xhHOIW0VhWS/nWT+9ZqYelbMI2Wp7fOoAWzSFA
         HVDUU1tIeJZXil0V5P3CxUuV8ljDtvQpp2G8wzxtvQzQTO71CrNQa1GSeMGi1Ql1K7Gz
         K8XtvHnK7dsYfOtxBD7Yhdwv8hRaF2SYQa0vWphaTV/1J57Loxmywez4MF/R8V8eimfU
         X1kLQxuzYK65J5LsgAxgTE5P1vJgoi/kl+if+uYRwvwxwpS2dkZwxPsPzFiKz4rRt8bl
         S8TQ==
X-Gm-Message-State: APjAAAX2iKrDMhzwInn4jP89gu+q8m7QZT74+j/fkigwdv2bmK/EY1ch
        SENJPsl+nBEVIAyUsppSZyU=
X-Google-Smtp-Source: APXvYqz7NydXbhX+o2llvFWzV+tiLQyONNyiarXtGB7cf8wB17IWMiogs4UQTD+QQ8NVDUxsy/Pq9A==
X-Received: by 2002:a5d:5506:: with SMTP id b6mr33951846wrv.221.1558113312505;
        Fri, 17 May 2019 10:15:12 -0700 (PDT)
Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:15:13:4c1a:d2d1:436c:979b])
        by smtp.gmail.com with ESMTPSA id r2sm17816331wrr.65.2019.05.17.10.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 10:15:11 -0700 (PDT)
From:   Dmitry Vyukov <dvyukov@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kmemleak: fix check for softirq context
Date:   Fri, 17 May 2019 19:15:07 +0200
Message-Id: <20190517171507.96046-1-dvyukov@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

in_softirq() is a wrong predicate to check if we are in a softirq context.
It also returns true if we have BH disabled, so objects are falsely
stamped with "softirq" comm. The correct predicate is in_serving_softirq().

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index e57bf810f7983..6584ff9778895 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -588,7 +588,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	if (in_irq()) {
 		object->pid = 0;
 		strncpy(object->comm, "hardirq", sizeof(object->comm));
-	} else if (in_softirq()) {
+	} else if (in_serving_softirq()) {
 		object->pid = 0;
 		strncpy(object->comm, "softirq", sizeof(object->comm));
 	} else {
-- 
2.21.0.1020.gf2820cf01a-goog

