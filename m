Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C48C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA4820B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="sBV/YYyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDGBzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 21:55:22 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40916 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfDGBzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 21:55:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id w20so6028452qka.7
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 18:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TmYQ7hFkjaBeCconcL7FY5cmVjdiG0ObsQxHd0Hzpm8=;
        b=sBV/YYybBMJg+IbMv0Bn3eyugsTpwOASRjvjBmcgA92WeTbWT5ZlMEJh3TM2auXwGU
         ear4C1AA2SPKcgpL7dA396DQkXirIUXS67wlmW89++4iu+6H4OBsiCTvWawNwD0FB7ZM
         AxhPXHIaE1viUkIvlvaULhtzm059uOuhFu0JCK4zA8mHzpVtOb5LM1bu7S3xY3HdiU2h
         sgLSQAqZU6pLTARXFoMtnLs3CmmLLSBakDy/DPiIFbjyy3AsMxd/1sxVCm47wRq6zQDu
         VeSsZOlDt/JRbdmrLahXvsy2S11LMiP5w54kttZ3qFFjUlyiAANDbhKI4iaOFegGad/L
         G6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TmYQ7hFkjaBeCconcL7FY5cmVjdiG0ObsQxHd0Hzpm8=;
        b=VlrJhvGN9P8nuhzLiv4G32p7OCrzB9kaDRIp7bwwfLWfHE8zJjt3JYdHwNbbbnH/hU
         MvY8DpFlAklXEOk9QPxxN0RbNAui8ZK7Qk2EB2snhiXfxBPuuDsxLn2dd4kde4mMv7gi
         wDUaOeAuXi6nfv2HNw5eMxOkchRNKS5HPSgxDH2hVR8g/gmCkyObUEjfGfGPkqmzvImy
         ECHgfm1d94FhBEzGd8sRKSOMPWybdV9YM7JRl+fXYNRD5L4FiQkY0fqGz3kV9fGncQ0j
         bZgQrAM2aSjyZ9rD9PsZ1Tx8SUf/KSdOaKfRpEZVT4D2wxuEZZjeRAOhDn0NDVruJd8/
         l7Yw==
X-Gm-Message-State: APjAAAURuDQq8FYyiqNdYV6CpR1KHmbA7BwIxLxi5Av6CdRI9qrmGTnX
        5vCMcX5eqd70HHLjiI1JnOTReg==
X-Google-Smtp-Source: APXvYqyeMwDlrefLZK6tvhMZ1SBBDwrIQ/U3yZLm87VAJniwapXmOCBm8dtIoJwMHKjnFME3z/o0XQ==
X-Received: by 2002:a05:620a:1646:: with SMTP id c6mr17645924qko.69.1554602121104;
        Sat, 06 Apr 2019 18:55:21 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 11sm18748299qtu.5.2019.04.06.18.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 18:55:20 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     oohall@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/pseries/pmem: fix a set but not used value
Date:   Sat,  6 Apr 2019 21:54:47 -0400
Message-Id: <20190407015447.39292-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 4c5d87db4978 ("powerpc/pseries: PAPR persistent memory
support") set a local variable "count" in dlpar_hp_pmem() but never
use it.

arch/powerpc/platforms/pseries/pmem.c: In function 'dlpar_hp_pmem':
arch/powerpc/platforms/pseries/pmem.c:109:6: warning: variable 'count'
set but not used [-Wunused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/platforms/pseries/pmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pmem.c b/arch/powerpc/platforms/pseries/pmem.c
index 27f0a915c8a9..f860a897a9e0 100644
--- a/arch/powerpc/platforms/pseries/pmem.c
+++ b/arch/powerpc/platforms/pseries/pmem.c
@@ -106,7 +106,7 @@ static ssize_t pmem_drc_remove_node(u32 drc_index)
 
 int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
 {
-	u32 count, drc_index;
+	u32 drc_index;
 	int rc;
 
 	/* slim chance, but we might get a hotplug event while booting */
@@ -123,7 +123,6 @@ int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
 		return -EINVAL;
 	}
 
-	count = hp_elog->_drc_u.drc_count;
 	drc_index = hp_elog->_drc_u.drc_index;
 
 	lock_device_hotplug();
-- 
2.17.2 (Apple Git-113)

