Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C992FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F71218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bptSRtBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436851AbfJPUAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:00:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36792 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436834AbfJPUAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:00:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id o12so38034579qtf.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1tiYj23HzXJX4ZgHt0ym5ajKMNsnlXF/xQZzBPKQP48=;
        b=bptSRtBN3xr8useYmB7iLV+OcV0ABHihVJ91UYRzIEEb848dVyygGn+GE2+y3sD+H/
         Ehgz4BslCL365594q2uwcmw87mAuhVCKVq/TyG5alBLrXhyPibXYtKRBQWqMAkZ9CoYC
         9gsBU+jwTuKTMeH0NqgRU0ie6dAH9U4KR8K9yJfl/vmKON73ksH2ohoeFCWPK6TWnGs/
         JY6rS3hpFuit6exKgtq1rRDzbjh8aCparhwYVDnwi0yOtbtg6XsW3ND76Y4zZO7Kgb/v
         K5H0M1+2n/9/qGjrK17r20FGbMgWr0Qfx2uD66/tMR219XpCScNUfnH9v+OJDVSWzhgA
         YK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tiYj23HzXJX4ZgHt0ym5ajKMNsnlXF/xQZzBPKQP48=;
        b=H/2qPmSg4z5ubu8cDVouel6sEPLqpHMJxgd9XSjCXO/0SWl3JlbdzCxAnZj5AiUokN
         Evj9nWaQC3zGF5CKdFOYDEGwEJsmCFq1iyHaFJM9OfFbX1bL/rEgxi8x2HaNw2+cdnL4
         STmPpSIHaRe3KspIe3Ta3fmukDKTeBCg5ktvKn64vFMSybjpLJlvPQDrBUGxohJDHzKc
         IT/duSlzbYEZC7SqP+AXSDLGtkUS7gKIIMtVKtrXezVf4k7xAbV00yPMAxF0B7x+WqxH
         t36+GxzpXVZT+Jf17mELHNoIL7TMYbqY5bKLcTM6bRpjZkLPx/Yr3ZsPWVctRomnxXZD
         rzLg==
X-Gm-Message-State: APjAAAXui+ETi9F2UJ2ziMv1tAWEWns6WCA7/Rau6qFdM783e3hHknxH
        nueTetXFp0J+Ym8U1VMbwlnv3g==
X-Google-Smtp-Source: APXvYqwmRVQSdQU55owY+pKif3Q4GJGRGYVJkFk5zjZ7AznjZD2B0mWV7kq/8erD2qHWWjyifhfziA==
X-Received: by 2002:ac8:550d:: with SMTP id j13mr46331075qtq.37.1571256045529;
        Wed, 16 Oct 2019 13:00:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:00:44 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: [PATCH v7 05/25] arm64: hibernate: pass the allocated pgdp to ttbr0
Date:   Wed, 16 Oct 2019 16:00:14 -0400
Message-Id: <20191016200034.1342308-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ttbr0 should be set to the beginning of pgdp, however, currently
in create_safe_exec_page it is set to pgdp after pgd_offset_raw(),
which works by accident.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index a96b2921d22c..ef46ce66d7e8 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -269,7 +269,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	 */
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
-	write_sysreg(phys_to_ttbr(virt_to_phys(pgdp)), ttbr0_el1);
+	write_sysreg(phys_to_ttbr(virt_to_phys(trans_pgd)), ttbr0_el1);
 	isb();
 
 	*phys_dst_addr = virt_to_phys((void *)dst);
-- 
2.23.0

