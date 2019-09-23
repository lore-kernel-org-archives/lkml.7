Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427F2C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E9720835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcfwY9h7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbfIWJMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:12:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54758 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfIWJMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:12:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so8961478wmp.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k+ihouvg9ktK+RPpq8jbxn4t7z2EEY8Zp2WQ3HmFaa8=;
        b=BcfwY9h7P3Ftd5yxA7yFQ4nZ6zy6L/c4fdMp3K7rW+5g/KpW8+ECLPLhdB2yV+aOyG
         qsw1xe6jfEYskUxCGFfoiP4YvITMpzZ6IIkKd4ybaFKuZ//MB4+0rFoR0QJiZLm58/mH
         4osMvit3DRwJUmp0fXGZwlnPhdN0r4f6oE5X39nawvQ5mT+jtpAuDWhBGADq4l+yQlal
         Jk03ieW4/zrW1o+gLaM9g3FylB7AwAkLGg9cDcEETKUSGFO2nNfEhzviFSquXTUyvCvE
         kcUphtBRvvVrLPnGA5Z3UMJD0ahPQp4Q7eMIUB1jTOlgeJEDAqmjrEzz+CWGImcjfad6
         ZJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k+ihouvg9ktK+RPpq8jbxn4t7z2EEY8Zp2WQ3HmFaa8=;
        b=T5rt9X/X4nsxsqqg2Gn2u6xmhH4/tKC/StM5N9dSny+ydbQJ5kpZYA49CqGHrlorJJ
         m2lKzQ7QtpAu1Q8Cy++qzqocbGOBDIFAauxUO0fO3OpZ5euQyNp/ZReJNvZAftukjzTF
         qX9iFSobI46M5IuIRLP+NJ2mCacbkzA5A1uz7Ng8+78tDNLkeTBC78wc6GS5Mwq7qGJk
         ydBeR0jeZLt1HhvBzbTRYzJ1yIzeBCs4oRoYjB9+uazGfZ0jPJXihQE6pIcdxI6pX/Pr
         t2ZCJ2WfSihSP50bjgA1Bk7vofBgvW3E0YYji8z0RMRfAd1sG42qID+rwjZGZ1nWpKux
         y3hA==
X-Gm-Message-State: APjAAAV1kSkw3xBMWDCh8aZI2GbDcxFavAxtwVsBobTsBNVF4wLE6gKx
        ZkywqWn23S8Ca394vhykI4Y=
X-Google-Smtp-Source: APXvYqwqWj7YFcCwBI7sEfAPMtl1he+AyZT/cGaAdO0SMepetzqGuwM9QFzNoBrFpPcJtbM1H3rjXQ==
X-Received: by 2002:a05:600c:241:: with SMTP id 1mr12810468wmj.162.1569229951689;
        Mon, 23 Sep 2019 02:12:31 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id x6sm14312751wmf.38.2019.09.23.02.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 02:12:30 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: errata: Update stale comment
Date:   Mon, 23 Sep 2019 11:12:29 +0200
Message-Id: <20190923091229.14675-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Commit 73f381660959 ("arm64: Advertise mitigation of Spectre-v2, or lack
thereof") renamed the caller of the install_bp_hardening_cb() function
but forgot to update a comment, which can be confusing when trying to
follow the code flow.

Fixes: 73f381660959 ("arm64: Advertise mitigation of Spectre-v2, or lack thereof")
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/kernel/cpu_errata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 1e43ba5c79b7..f593f4cffc0d 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -128,8 +128,8 @@ static void install_bp_hardening_cb(bp_hardening_cb_t fn,
 	int cpu, slot = -1;
 
 	/*
-	 * enable_smccc_arch_workaround_1() passes NULL for the hyp_vecs
-	 * start/end if we're a guest. Skip the hyp-vectors work.
+	 * detect_harden_bp_fw() passes NULL for the hyp_vecs start/end if
+	 * we're a guest. Skip the hyp-vectors work.
 	 */
 	if (!hyp_vecs_start) {
 		__this_cpu_write(bp_hardening_data.fn, fn);
-- 
2.23.0

