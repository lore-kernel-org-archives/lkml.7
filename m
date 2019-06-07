Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D3EC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4F6208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMKmc3Qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfFGN6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:58:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36531 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbfFGN6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:58:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id u22so1260201pfm.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pVtZoIezp4EZoxmrqjiaf83Hj5lKnOSnqkUcz0EsdG4=;
        b=bMKmc3Qs0i6IPkHlIJ9dvkXbcBX37jSZbWTihX4pRuNDXqqawp1i5SHM0RiNU/CVJM
         b5gCZCp7o0JSojOc9jOU18YRxp/GOONF93CdnXL0fAuJJ3Z4AKSf4lUjr8IrhivGTGAb
         dI+JlNrel2lHIEKIT+IGMUTUGTIyjUisOldgyIKUL3x0ORUsUawR6omTUXWtLX1WaFhi
         iAtOvqsxBc1hufpfSmzp7yLVAtz82Z9nWd540YHWC8yBcXOTFbxdMrAJ0tOdrXi0kyp3
         kQNqXi3P0i4JpaKCoKAy1u2EeeqjffLqVK3PPWCRZ+dk+JzAbrRkrw3gV8gfNzq6u57+
         UJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pVtZoIezp4EZoxmrqjiaf83Hj5lKnOSnqkUcz0EsdG4=;
        b=TENk650CzC3aYw4uXO6dnTqpI+5zrVFwTW1iIVyuJA8b/b+iw8FSxc52i9DFgrPD27
         4zFCenqY4M0Vy2aNmGfBcWNjfKtpRnyZpxkZrZZVJXir92Ug0MXXWq1uVCDmttTecT4k
         aHEuvKFotP7sGfrYjyFzyd8iQvquJoKS042t5jVEdDScdqMxCl/VV+Rui3JLLszf3Mjr
         TmPRyPYET2FVZwzWCWrByQRk9jXOYJPM6OG1EhIDEjaaPknsIbWUBn8cJTvLQdmJ+PMa
         YOEUfulWhUMncjY8xsIuGTvV/glpchdIkZAyZ9gC56/t0RFDw4jwvmi8iHJFjJxm6JNR
         /vzQ==
X-Gm-Message-State: APjAAAVk9RI4ItAsJEt74Q0ClLQaLRv5TLWCJ2q4IlR2KmVB2UhTgdlF
        2UkeXF2h55xFDFMTJEl4Mhg=
X-Google-Smtp-Source: APXvYqwjGGdvkLX7hz6WAgriXBrPobOza8hooIwH8c0/wCZhXdjlw26LkbeKz0HFv5vMuYt3Iy4HDQ==
X-Received: by 2002:a17:90a:a596:: with SMTP id b22mr5563800pjq.20.1559915931140;
        Fri, 07 Jun 2019 06:58:51 -0700 (PDT)
Received: from ubuntu.localdomain ([112.21.182.86])
        by smtp.gmail.com with ESMTPSA id w190sm2438716pgw.51.2019.06.07.06.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 06:58:50 -0700 (PDT)
From:   zhangjinghai99@gmail.com
To:     linux@armlinux.org.uk, akpm@linux-foundation.org,
        rppt@linux.ibm.com, vladimir.murzin@arm.com, tglx@linutronix.de,
        ebiederm@xmission.com, f.fainelli@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        21cnbao@gmail.com, JingHai Zhang <zhangjinghai99@gmail.com>
Subject: [PATCH v1] arm: mm: make arch_mmap_rnd() static
Date:   Fri,  7 Jun 2019 06:58:15 -0700
Message-Id: <20190607135815.43418-1-zhangjinghai99@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JingHai Zhang <zhangjinghai99@gmail.com>

arch_mmap_rnd() is only used in mmap.c, make it static.

Signed-off-by: JingHai Zhang <zhangjinghai99@gmail.com>
---
 arch/arm/mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index f866870db749..0a7a046fcd90 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -171,7 +171,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	return addr;
 }
 
-unsigned long arch_mmap_rnd(void)
+static unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
 
-- 
2.17.1

