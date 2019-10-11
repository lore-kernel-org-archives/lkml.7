Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7DCECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487F8214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="RKtDHonT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfJKBZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:25:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32999 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfJKBYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:24:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so9995686wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmqV2OM13rN8g9gqwuFQcG1AzY2kvl68qXweRe9btYY=;
        b=RKtDHonTyK0sInyXe7q4IAP0UAFPpt2iYIJSb4NBAyqX4KDr2rkltPXrZXLKCAn31t
         Lf1kCT4wGGXqCRuEmtvRsHfkBnaf/9lHVNdkmCGG3HNKJ/ItU/vQClHo/qjb1MexbkbZ
         O5agLhB9srSGfpRqN7jq4pFEGxwcv3dFki7/cFpIKsvwS0oId6J8FQFGKHjsO0FwhkwU
         XeabN3inSXjkfULEysQLgjGlCXEVB779fXrlAFpk/PRHeXPh4IArrMUQKCVIY8JudJ9R
         HrOan2FF5oOrQNm2BvRgCe9yTEVaaQwc34y+PzWX/kmuA1e338AY9rS/u2XnQf7gpiJi
         ZBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmqV2OM13rN8g9gqwuFQcG1AzY2kvl68qXweRe9btYY=;
        b=i1daY4Xg01KVL1nWKqNgZ66dSedTNuAWIcke73I33Z/AlcPHA4w5Xs8ZIdHBRHDMZx
         JRD43NDG+zZWedJ7WGQ/vOHEyrWHVM6XkPlY+A1iqaxwB8mbd61yDvLphInhVU7V37wK
         EF8TpUDKqr+yB0jlfIVfcoLtEZKjIE5rdsdBGijfwHAr9wc/pB+wGeCah1gWnIpSma74
         r+wwYOnFccGjk0RGfDOw+/Z0ZerILZSS/cYnwW9koJZ7iU0r3+XlFwSemSXEYvPKEobt
         jMtFuFH2m2flH45nuya3Tw2YNax2kXmlcohnYIsru6HxTYSXx2jP3UZb8Jg9mqUahDDJ
         SfQQ==
X-Gm-Message-State: APjAAAUPJqOvAh7Y6oYL0rLZt20jOV9KM5ukTwSzPlAT6Ez4IQZgnWu8
        vBhPAfj6+JXdlG6itsDAJkifYFfA4mc=
X-Google-Smtp-Source: APXvYqxjMvKf23uxoAePg8zl7LYOV5o9nNZkcYnQ2Q4YPUsDdmCOTGtfRnbYn3XkuqD0FGyTthfm+Q==
X-Received: by 2002:a5d:6942:: with SMTP id r2mr10262902wrw.363.1570757061939;
        Thu, 10 Oct 2019 18:24:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:21 -0700 (PDT)
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
Subject: [PATCHv7 24/33] x86/vdso: On timens page fault prefault also VVAR page
Date:   Fri, 11 Oct 2019 02:23:32 +0100
Message-Id: <20191011012341.846266-25-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
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
2.23.0

