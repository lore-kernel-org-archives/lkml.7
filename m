Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED227C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE22B218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lEXpT6ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbfGYKzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:55:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60333 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfGYKzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:55:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PAtH0n968013
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 03:55:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PAtH0n968013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564052117;
        bh=WfrP/i4bTQGAma/Qr181evUxuhN3iZ+FHHT7WBq9K6k=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lEXpT6ie/f+/dRTFdFOhXubTGbLg02qJyBevjsNVhwV0Rwv7JCLRYCnYWT9p+8wJ9
         mVtv2hL5FqJTTpvHetb0cQBhVeBs4hxkGukmpEn40317FU+FUxx6fccptXWiov2PGa
         Ztt0GqgIpJZwljMKKl8gZtYwAJq586rDQBrINR88OiUE5Ba6NJZJN5pMLbfeseCPyg
         YFvfVfG/wufyIF/IEFMcpzmyfEZm5sRUShoE2m5arR+n0fhyJfZSqYpsASiCWSlZnt
         1QBwH2fXdCTuuua2qmlf1c4E/yK9s5b71EuW0aoPfbkTOO0Zj7G0FWDmoug+OwxiW1
         iyngwtUZZFjJQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PAtGGI968010;
        Thu, 25 Jul 2019 03:55:16 -0700
Date:   Thu, 25 Jul 2019 03:55:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhenzhong Duan <tipbot@zytor.com>
Message-ID: <tip-517c3ba00916383af6411aec99442c307c23f684@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, zhenzhong.duan@oracle.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, zhenzhong.duan@oracle.com,
          hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <1564022349-17338-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1564022349-17338-1-git-send-email-zhenzhong.duan@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/speculation/mds: Apply more accurate check on
 hypervisor platform
Git-Commit-ID: 517c3ba00916383af6411aec99442c307c23f684
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  517c3ba00916383af6411aec99442c307c23f684
Gitweb:     https://git.kernel.org/tip/517c3ba00916383af6411aec99442c307c23f684
Author:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate: Thu, 25 Jul 2019 10:39:09 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 12:51:55 +0200

x86/speculation/mds: Apply more accurate check on hypervisor platform

X86_HYPER_NATIVE isn't accurate for checking if running on native platform,
e.g. CONFIG_HYPERVISOR_GUEST isn't set or "nopv" is enabled.

Checking the CPU feature bit X86_FEATURE_HYPERVISOR to determine if it's
running on native platform is more accurate.

This still doesn't cover the platforms on which X86_FEATURE_HYPERVISOR is
unsupported, e.g. VMware, but there is nothing which can be done about this
scenario.

Fixes: 8a4b06d391b0 ("x86/speculation/mds: Add sysfs reporting for MDS")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1564022349-17338-1-git-send-email-zhenzhong.duan@oracle.com
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 66ca906aa790..801ecd1c3fd5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1226,7 +1226,7 @@ static ssize_t l1tf_show_state(char *buf)
 
 static ssize_t mds_show_state(char *buf)
 {
-	if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
 		return sprintf(buf, "%s; SMT Host state unknown\n",
 			       mds_strings[mds_mitigation]);
 	}
