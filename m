Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A6E2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Zm4taa0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfKLB26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:28:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35378 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfKLB2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:28:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id 8so1226303wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLHfRBzVcQOMHPLFQbTm4vIzETfB2gC5g5OyUjlWFMs=;
        b=Zm4taa0fqd0V2OIXZGfR00pMrgYgTXiiHgFzMlmIqbxN/huuDCz3U9KuaY8ynXa1x8
         9ujrlsvAXomfGjZbrrYmE7DI4vF+74DBTmDTE1+zZ6O04UzJbB2AfeuK1mUOwuzlTr6w
         KpoYPGWTuyJBXCvuZp9BBKHiNoOUlGUHb4s0UEnymt0kZwkQc6KnsgcSCKvpVpsKAAC+
         9OQ3eG6TU1XnwLXNjt2JWj6nz5JkSHcF5HgUXS9jUI0T6Lu3QrCAT/dXYvn1GhnFUzeE
         CtLZDwDVcoEsMH/JM2s0fULANXi/V8GU+Te39xmjxdgpXPYBStujgoNdPs5NQXQwMvSF
         LM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLHfRBzVcQOMHPLFQbTm4vIzETfB2gC5g5OyUjlWFMs=;
        b=gfKRBG7OXDNK/ivioCgTGQenys4yy8RRaLBk9tNur+x1Nodqt4d7b+aCjYOLLbn5BK
         E1Wu5iBYeGmA5OMmEWR2fAUv/m2xWaidBHdiwtXCrieyV11ty5sbzalKAB6E85E30+CH
         RKnn1pPl2y+pRbiBhrhXCTrKkPoA6p1UtbTkUKXmkCpPocL1NgboqWP5fJFgFSeVUBHN
         a9OJhTf0f0y3M0+8QP6gFgZcIFYVcxWfYHEWecebPdvg16bwyqkAXmz8wwr86nNEdGN1
         OtE1QTipF3ppPhvn7psYuxdqQw4dxstYC/QV8CySMxHkKho/DEgwzqZHYUuJf6J0Ybx/
         9XWA==
X-Gm-Message-State: APjAAAU8pRKAVFss9Kvt3G3P+CzHzVAtOIddi3MCeRj6GRGA2N1WJeO7
        taBKo9Up4hwId6j6OImi5TvGUEDuSVM=
X-Google-Smtp-Source: APXvYqxrCn/GtTlwgZN4e+FAimd9glCR7wgRozyGrmAowLDgpRZPtbaoRrxR2LuUHfILHaOMe+gELQ==
X-Received: by 2002:a1c:2745:: with SMTP id n66mr1499686wmn.171.1573522085381;
        Mon, 11 Nov 2019 17:28:05 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:28:04 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv8 25/34] x86/vdso: On timens page fault prefault also VVAR page
Date:   Tue, 12 Nov 2019 01:27:14 +0000
Message-Id: <20191112012724.250792-26-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As timens page has offsets to data on VVAR page VVAR is going
to be accessed shortly. Set it up with timens in one page fault
as optimization.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index f6e13ab29d94..d6cb8a16f368 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -169,8 +169,23 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		 * offset.
 		 * See also the comment near timens_setup_vdso_data().
 		 */
-		if (timens_page)
+		if (timens_page) {
+			unsigned long addr;
+			vm_fault_t err;
+
+			/*
+			 * Optimization: inside time namespace pre-fault
+			 * VVAR page too. As on timens page there are only
+			 * offsets for clocks on VVAR, it'll be faulted
+			 * shortly by VDSO code.
+			 */
+			addr = vmf->address + (image->sym_timens_page - sym_offset);
+			err = vmf_insert_pfn(vma, addr, pfn);
+			if (unlikely(err & VM_FAULT_ERROR))
+				return err;
+
 			pfn = page_to_pfn(timens_page);
+		}
 
 		return vmf_insert_pfn(vma, vmf->address, pfn);
 	} else if (sym_offset == image->sym_pvclock_page) {
-- 
2.24.0

