Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10276C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2C02084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bOihTjlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfFSRaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:30:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfFSRaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:30:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5JHSON2487281
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 19 Jun 2019 10:28:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5JHSON2487281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560965305;
        bh=cyYOWsd+go28Suqmk8A5CI+l/wMO6uHxsUAQABzOvOY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bOihTjlE7pRRAmv2NqLN33XUQg2PYtuLaihEouiRKZogQdudARbwrwPhA6mKPrnVA
         Nwy24u1i53Kd6I2hvOvN1YZRlu/kAmbs8qrRhZQSH5tSsf7WYvPT9zIxtQ6UInVMfF
         9/MqSaX3J6zfJR78H6CkuRMoXvzoMCXx/FvW7d2Kmfavqect8kZVa/9QZwI4AddQmU
         nBwYEAwq9EmCNfecysMzKCUMUczkKeKYIJjo9vGSCeVZhl/7aZvPpZhEyeO4YqG56t
         1CvXgE54uk6YM0kf1KEt4p9OW5Kuka1Xn2QD4JH3wJyZP87auOqr2ahforbbP99zsx
         /4H26oKaa7YIA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5JHSM7o487272;
        Wed, 19 Jun 2019 10:28:22 -0700
Date:   Wed, 19 Jun 2019 10:28:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qian Cai <tipbot@zytor.com>
Message-ID: <tip-1b7aebf0487613033aff26420e32fa2076d52846@git.kernel.org>
Cc:     sean.j.christopherson@intel.com, cai@lca.pw, hpa@zytor.com,
        gustavo@embeddedor.com, mhiramat@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, bp@suse.de, suravee.suthikulpanit@amd.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        puwen@hygon.cn
Reply-To: bp@suse.de, suravee.suthikulpanit@amd.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, mhiramat@kernel.org,
          tglx@linutronix.de, sean.j.christopherson@intel.com,
          gustavo@embeddedor.com, cai@lca.pw, hpa@zytor.com,
          mingo@redhat.com, puwen@hygon.cn, x86@kernel.org
In-Reply-To: <1560954773-11967-1-git-send-email-cai@lca.pw>
References: <1560954773-11967-1-git-send-email-cai@lca.pw>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cacheinfo: Fix a -Wtype-limits warning
Git-Commit-ID: 1b7aebf0487613033aff26420e32fa2076d52846
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

Commit-ID:  1b7aebf0487613033aff26420e32fa2076d52846
Gitweb:     https://git.kernel.org/tip/1b7aebf0487613033aff26420e32fa2076d52846
Author:     Qian Cai <cai@lca.pw>
AuthorDate: Wed, 19 Jun 2019 10:32:53 -0400
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 19 Jun 2019 19:21:32 +0200

x86/cacheinfo: Fix a -Wtype-limits warning

cpuinfo_x86.x86_model is an unsigned type, so comparing against zero
will generate a compilation warning:

  arch/x86/kernel/cpu/cacheinfo.c: In function 'cacheinfo_amd_init_llc_id':
  arch/x86/kernel/cpu/cacheinfo.c:662:19: warning: comparison is always true \
    due to limited range of data type [-Wtype-limits]

Remove the unnecessary lower bound check.

 [ bp: Massage. ]

Fixes: 68091ee7ac3c ("x86/CPU/AMD: Calculate last level cache ID from number of sharing threads")
Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1560954773-11967-1-git-send-email-cai@lca.pw
---
 arch/x86/kernel/cpu/cacheinfo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 395d46f78582..c7503be92f35 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -658,8 +658,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
 		per_cpu(cpu_llc_id, cpu) = node_id;
-	} else if (c->x86 == 0x17 &&
-		   c->x86_model >= 0 && c->x86_model <= 0x1F) {
+	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
 		 * LLC is at the core complex level.
 		 * Core complex ID is ApicId[3] for these processors.
