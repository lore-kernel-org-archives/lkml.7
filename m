Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C137C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22781206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OCE7EeNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfLDP75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:59:57 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44781 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbfLDP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:49 -0500
Received: by mail-qt1-f194.google.com with SMTP id b5so185946qtt.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mrHgWWXHUWXBn03njwP1uC49SHZHRCptq6VAl454YEg=;
        b=OCE7EeNTEySaYudN4WgDJVntl4hVVBO7kvt/qF2UoQCwbINGo+Mf5j0z+FJXLkjS5i
         YKQ3ii7bigLttEUa4f3W2IFSMCn8uqQ5/X1ODXUaH2XygO5L+lvs0BqWaq0OiftYXt+Z
         5eIxrfDN5lOpZt3j1qm1EZ0QHqEAFtH96JK+4Aroi69TMwsapzZ++1Sy1HTGY/4XynNB
         1ALtddFyBSWXeHLkNkAvaMhtZD43k0IEOT7PZIPGe/C2F/QDkuxpJhoaJZoBhPgrCAc9
         eHNfkpunSUY3VfO/lAmmh3ptTexrSfpOjgr0avhEga6w5lkHNBeCWeROXyGfCpp2Pkz2
         AE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrHgWWXHUWXBn03njwP1uC49SHZHRCptq6VAl454YEg=;
        b=IjqM3jcdpurlvMQk9isZRm1FueTV794lCx2AMfLX/YjEbolKNeiweqvm4+8409x9Fa
         gr6WLnPrNLoAoDtOrW3FlPfR/VfrPb4vujfspeBdjPErBpRSMIECUdKcNsPQW3dYrHb0
         OqyLLxhagOQCT07KN2eBmuwOnUsEQuqxdGgerwameDgZolZpniucRE9n7TT4cprwyoKV
         Qgqqfm8IfgbpaWO04pgK//a12r+KZ14V42yf765h5LtOg22y1brIpW5/KjapZam+AUmr
         7ujNXxS3Zbr3Y2L0wVUF7467oQF2nW3Ihz6FDc7EdqP0aW++FecZWa/njX2R2fxgi3jZ
         ONvg==
X-Gm-Message-State: APjAAAWkLrqxKCH8kmnwYn0893cd6n9nAkrJfDMdMkicpc/n47OaCvF3
        itr1wrTK2mkizH0R4e5mpsJiIZZAX7E=
X-Google-Smtp-Source: APXvYqxHHSk1mtXaYINaTUQhuobJKQpL4nM2E+jFFMZb3TTDjUtboPmbRHiWO39AwzRbeusBuN7zEA==
X-Received: by 2002:ac8:71da:: with SMTP id i26mr3321440qtp.271.1575475188330;
        Wed, 04 Dec 2019 07:59:48 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.07.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:47 -0800 (PST)
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
Subject: [PATCH v8 05/25] arm64: hibernate: pass the allocated pgdp to ttbr0
Date:   Wed,  4 Dec 2019 10:59:18 -0500
Message-Id: <20191204155938.2279686-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
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
2.24.0

