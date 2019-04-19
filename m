Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FC7C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE1420645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="svMwLn7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfDSTDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:03:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfDSTDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JG4ihS337513
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 09:04:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JG4ihS337513
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555689885;
        bh=jCjFg1Ql7U/ETLNTR8pecG5A+r8szVV+sh9mwdueUHs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=svMwLn7Y741aJMCo7Iy/rhaNnMS9Hxu3+ATwgcD3vIl+LqcLmpt4LXA8GV65nm5CB
         YwoRxkVwFxIg4pjOd9Fy4YZigweBKuMaUqlLNAricp9zsCH25YxcNrtV/sWjrpSMn0
         RpTEuBRaecx9P67aDpMX3QiWyjXAMAAH2mntgdYVX8M43Yke4ktbroSnhtassqhPoj
         P3vpPbnxG6z8RK150Si/sg+xVVscp79jaqws0DTQCqsZ2pJQyXAe/4JT83F+lvXdf+
         nLw17+8BdY+T+SWeiZrLv1VivpJOAgkTKlLNUhTcvEOjhrrlNj0eWg7xTl/by9k1Lh
         bAci0IQZyWT3w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JG4irg337510;
        Fri, 19 Apr 2019 09:04:44 -0700
Date:   Fri, 19 Apr 2019 09:04:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-14e581c381b942ce5463a7e61326d8ce1c843be7@git.kernel.org>
Cc:     ak@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: ak@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190330004743.29541-8-andi@firstfloor.org>
References: <20190330004743.29541-8-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/kvm: Make steal_time visible
Git-Commit-ID: 14e581c381b942ce5463a7e61326d8ce1c843be7
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

Commit-ID:  14e581c381b942ce5463a7e61326d8ce1c843be7
Gitweb:     https://git.kernel.org/tip/14e581c381b942ce5463a7e61326d8ce1c843be7
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 29 Mar 2019 17:47:42 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 19 Apr 2019 17:58:57 +0200

x86/kvm: Make steal_time visible

This per cpu variable is accessed from assembler code, so it needs
to be visible for LTO.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20190330004743.29541-8-andi@firstfloor.org

---
 arch/x86/kernel/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5c93a65ee1e5..3f0cc828cc36 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -67,7 +67,7 @@ static int __init parse_no_stealacc(char *arg)
 early_param("no-steal-acc", parse_no_stealacc);
 
 static DEFINE_PER_CPU_DECRYPTED(struct kvm_vcpu_pv_apf_data, apf_reason) __aligned(64);
-static DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64);
+DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64) __visible;
 static int has_steal_clock = 0;
 
 /*
