Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1CDC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D803826EF9
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kmx0j1Xo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfEaUiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 16:38:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41630 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfEaUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:38:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id s57so2517093qte.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tnvn0j3jQuNVnh4maksP0eUXsR5Rv7Q1R8NyX+YF/3g=;
        b=kmx0j1Xo6ZpFg7gOpbZ4hsgkkFHeGEe5pWViZ23rcfuFYHArqroB22XYicw/D3C5LJ
         dK4Y0qJ3hyuhXSuRlqoFV5YuWy1G00UBDyTXuioGIGFv6WnqT25b30lCXrdVcTfRKIiP
         Wz264x7/hiIua3MDBJkygTmZsCHEEiuxn0ZuN5IMSjfiQp+2CyvzipE1R/Z+zsT/+4U4
         hdq7QfTEG4LU0HXvZHaRd+wEamjJlvYnUu6DXO6xM171BClLbv+lngtfF8MsfSjgy7iC
         QyaVVm+4+HWRBOECzNQSc0A3AGevbXE2QY7hsiAWegBYC4XGj7/cxfZ7SeeD+N3KIy3/
         gZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tnvn0j3jQuNVnh4maksP0eUXsR5Rv7Q1R8NyX+YF/3g=;
        b=b+DYFfgLEttJQJZDxIAqwWTAVEMMZMyOZrLBMqWt/Ny4XPaz4RU3ZkHL+dGKBpfvao
         rnh2UGuka4lyNK0V6C02NVYdX+qZZQFwAKG+xOKIJcg4bgoVgCFmzyocmBFdrDTGHHeH
         Oqzfa2JUkPz8z2+OMvRN4NAVG9uLIYedt+PUs197DWGIqj12wk1mzh9I09DlfR8vksLr
         Frgsf0BCduB3WLYhbMpI6KcncGsISCHv5LeH/LvTunPvXRJK6kVloC4WO8hveVOYeebB
         ziWw8uWM+vn8CQQ7PQp4TI5aeNeu44rcH8ESxgIXAG788sLdWqecijY2np/dKwBg937X
         MQRA==
X-Gm-Message-State: APjAAAX+CAQnCy/VfNsW6Q44bVcXBJEO+G0HiyEiglM0vKg8ea2xSZbF
        mWIQWwU8i4HQCHnTEelfBQ/wAA==
X-Google-Smtp-Source: APXvYqzD7lCntch+s1p2mwX8rLQxK69CDgBxwPQoO6P73eBQEDqKoiQsAPXwEueDgKjJkKKAioAPOw==
X-Received: by 2002:ac8:18b2:: with SMTP id s47mr11035556qtj.75.1559335131952;
        Fri, 31 May 2019 13:38:51 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i123sm3924286qkd.32.2019.05.31.13.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 13:38:51 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] x86/mm: fix an unused variable "tsk" warning
Date:   Fri, 31 May 2019 16:38:26 -0400
Message-Id: <1559335106-3239-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"tsk" is only used when MEMORY_FAILURE=y.

arch/x86/mm/fault.c: In function 'do_sigbus':
arch/x86/mm/fault.c:1017:22: warning: unused variable 'tsk'
[-Wunused-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 46df4c6aae46..a10e518dcdf8 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1015,7 +1015,9 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	  vm_fault_t fault)
 {
+#ifdef CONFIG_MEMORY_FAILURE
 	struct task_struct *tsk = current;
+#endif
 
 	/* Kernel mode? Handle exceptions or die: */
 	if (!(error_code & X86_PF_USER)) {
-- 
1.8.3.1

