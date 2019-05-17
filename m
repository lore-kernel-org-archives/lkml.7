Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22D3C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A16D2087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="a4/CLRN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfEQUA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 16:00:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45364 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfEQUA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 16:00:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so4154573pfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 13:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lg0scq7ATtl+Uy4MZvq90qbS0KQJXUTHcmarZyhdZgw=;
        b=a4/CLRN7zdrzGXpuqcZ1iDrmfmc9ztK6BC2fcst1/mvDKJc+gPdwvVLz/qGbNTr76N
         vOQe7e4fiR9CSIUKPNfGC1eoYJrlj5eFtt7lHZdzNw4sacC6fB3RrAs/jcrKlL51iZXr
         vN57FCbyhFZO40ehms0IlL1jDfdHmofz/5X6LywNZxrupl626tUU6EAMWXqNOGFYCjQW
         /Rs6S84mgbAuIsUM2nl98kmaGWD0AODgKCyBhNlwWr27BPUEtzsRHLa4LQqtWFsHsqEu
         kGEoA+9dX8LtjxHhbbYljkkDNZ5PUmMktPw+JrsZTwZBSpcNTWoyv8ZJlYQUi0pbTryC
         H2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lg0scq7ATtl+Uy4MZvq90qbS0KQJXUTHcmarZyhdZgw=;
        b=BP7WaOFAp04gfyVhmjScJZSZZ/UEvvqX2trxjlLWRpP+oe4B6n29aHU+1wbzI0bxid
         43e4+/3uW/5M0C/MccuLWOn64JpkQzN0hVVjeiCLR3iaF/ZrLqUXOaMSiB52b/Fxly0U
         icBZiCHsEm40cu152dJLk+lK852OOlTTcOcpYL+/uR6UeE8jI44FVmotVhMGDwhhkglo
         Ts5U3z337wasw4ZHEU5IShJn+phKzxRN5gjyUINY9wq/zbwe5sOA+JhfhzrsG8OdFsH0
         L2NUgUKQQ4QWnswhxv88RQuXk1iEGDDk4JPn4wAO4+cnMZlmIETXEB1S6rWlJoP1ywQF
         DHlQ==
X-Gm-Message-State: APjAAAUgpGk2OuMOC2PJQN+2GTNbZSwJQZh5wNrfm3oZpFwBYgjxfj7v
        T+5NVj3MK9inzsyvcqyi0qSbRL6amnKnpQ==
X-Google-Smtp-Source: APXvYqxjdaYTTQoM3b44xM6BSnFtcVQd0tiRcNbTAGEcMeI4R7/yqyItL2FOpJPIfhv4WODwmWYhqw==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr59764281pgc.25.1558123226574;
        Fri, 17 May 2019 13:00:26 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id k13sm4369739pgr.90.2019.05.17.13.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 13:00:25 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arch64: export __flush_dcache_area
Date:   Fri, 17 May 2019 12:59:56 -0700
Message-Id: <20190517200012.136519-1-salyzyn@android.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some (out of tree modular) drivers feel a need to ensure
data is flushed to the DDR before continuing flow.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
---
 arch/arm64/mm/cache.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index a194fd0e837f..70d7cb5c0bd2 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -120,6 +120,7 @@ ENTRY(__flush_dcache_area)
 	dcache_by_line_op civac, sy, x0, x1, x2, x3
 	ret
 ENDPIPROC(__flush_dcache_area)
+EXPORT_SYMBOL_GPL(__flush_dcache_area)
 
 /*
  *	__clean_dcache_area_pou(kaddr, size)
-- 
2.21.0.1020.gf2820cf01a-goog

