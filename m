Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBAEC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F28321852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rVxhWBqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfIQPWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:22:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34714 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfIQPWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:22:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id j1so4939041qth.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DdZlDwcFPhh8rvrDyAJz9Ugy4zGsw4IHuoR+wrsMaI4=;
        b=rVxhWBqZUXptSOUuNLwzM1QF914j9olYHZoIkK/w1mFyYdP8/hKVApoXbjxJzVEEMe
         bYigUq5wm7A8aUIEVwR3V3QgtfN4RiurGYNjghCz390nLgTPjYyUifJ5E3X9KrpnB5MH
         tusprRofm5unPUiBnSNB9gTWJo88OM+vsG4YjaBHC2hl1sRf1gC5YUmtMGnCRjXywtJF
         bVfmr8nfc55ak855MGlSC7regqhjFilJcxINM9Gd/MpmZSKm1i/tUa40zPrL8DyjV2Sc
         /fCKpLyVWb2+Kyoy9675rc1Kdfu/TkG1bjOcU0DUrxErpMV0Hpn0QH8kszCnRqKHk86U
         m2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DdZlDwcFPhh8rvrDyAJz9Ugy4zGsw4IHuoR+wrsMaI4=;
        b=Y8Cbj30pen9H0CFUh9Hak7WLxxpEYX9sFcldBn89p0tprv1eg1/5CGD+gS7qM/h8WP
         D9lIsKsbSgHEWUeZ7TlFmnkZIfkBKQRHJDuva2oQ+POyZ6FhyRMDO1mIYxOaKHLd3dv6
         sOLE8IxBp5OJAuC+TsNlmDVuil248l4lrYmDm4f7EKlLQWNi3BOj1/vG0WQWFNOrmtT1
         uylgufvyQFtZilUNmob1e4kLdkppoUg5XbZdCiD+AMh4LFUmjjSnM2hO59ICjC/+Hol0
         tX6g9d2XUY+A3vmCT7RWTI2iPQYyn//Z1K09FFNI64Nw/tTK6cR44WjDvSUCFQIqAGXu
         BRtQ==
X-Gm-Message-State: APjAAAXh4ZwYbSHyKzXGCCCfpzGg0TXve2hmMz56loQbnqM9h85A9F6T
        Xaons7bmRI9tZ04HZ2cVcrMGIxXDVPQ=
X-Google-Smtp-Source: APXvYqxgmEOqbhOFoKOE8dOOPpUk78ORIvn/Vj2ugt6BXuvvexABhWqWrEVBLAGoUFHtZBDZIjDSCw==
X-Received: by 2002:ac8:70d7:: with SMTP id g23mr4315285qtp.78.1568733763286;
        Tue, 17 Sep 2019 08:22:43 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b16sm1697306qtk.65.2019.09.17.08.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 08:22:42 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, linuxram@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/pkeys: remove unused pkey_allows_readwrite
Date:   Tue, 17 Sep 2019 11:22:30 -0400
Message-Id: <1568733750-14580-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pkey_allows_readwrite() was first introduced in the commit 5586cf61e108
("powerpc: introduce execute-only pkey"), but the usage was removed
entirely in the commit a4fcc877d4e1 ("powerpc/pkeys: Preallocate
execute-only key").

Found by the "-Wunused-function" compiler warning flag.

Fixes: a4fcc877d4e1 ("powerpc/pkeys: Preallocate execute-only key")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/mm/book3s64/pkeys.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/pkeys.c b/arch/powerpc/mm/book3s64/pkeys.c
index ae7fca40e5b3..59e0ebbd8036 100644
--- a/arch/powerpc/mm/book3s64/pkeys.c
+++ b/arch/powerpc/mm/book3s64/pkeys.c
@@ -307,16 +307,6 @@ void thread_pkey_regs_init(struct thread_struct *thread)
 	write_iamr(pkey_iamr_mask);
 }
 
-static inline bool pkey_allows_readwrite(int pkey)
-{
-	int pkey_shift = pkeyshift(pkey);
-
-	if (!is_pkey_enabled(pkey))
-		return true;
-
-	return !(read_amr() & ((AMR_RD_BIT|AMR_WR_BIT) << pkey_shift));
-}
-
 int __execute_only_pkey(struct mm_struct *mm)
 {
 	return mm->context.execute_only_pkey;
-- 
1.8.3.1

