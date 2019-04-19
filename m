Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F058C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1978520693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qCfiWotw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfDSTDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:03:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbfDSTDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JFw6N9334295
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 08:58:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JFw6N9334295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555689487;
        bh=fxoaYFXzm8oUelrq0ptqBMNVzN93Pa9mqi4ewbdGKfU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qCfiWotw7ihbphy0XSz3BoiFyL+2pbWmr6sHrLXFLvfxAyzbbv0wF7bMxQFB1NEZh
         90PaM+QQhj+UziOiNzzmWcMlAVADTnv+DmRNvQm+IclpqUwp+oXrOgp52v9K+6LwfZ
         wyDre1NZwOFBg5LcFt6r0Ap4NLOB5cTX/6L6udn433efM7snKrrTNYqwOftv3tDCZ5
         LYLmMBXVR9vHU7KO7OOwdzqwiB47Ui4stQTFVwsVayLB9QuJxNjL7C1qTskd4N0hd+
         ClxQr+5COGK4bXlGq1u6T0fLPMFBgRJuzymBAJAuxqGMhqf/i7k+Uqy7OrNVSM7vIz
         bROJaNV7zEwjw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JFw6M0334292;
        Fri, 19 Apr 2019 08:58:06 -0700
Date:   Fri, 19 Apr 2019 08:58:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-d3748c8533f576969837f11e69c39d3f080c0e2b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, yi.y.sun@linux.intel.com
Reply-To: yi.y.sun@linux.intel.com, mingo@kernel.org, tglx@linutronix.de,
          ak@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190330004743.29541-6-andi@firstfloor.org>
References: <20190330004743.29541-6-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyperv: Make hv_vcpu_is_preempted() visible
Git-Commit-ID: d3748c8533f576969837f11e69c39d3f080c0e2b
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

Commit-ID:  d3748c8533f576969837f11e69c39d3f080c0e2b
Gitweb:     https://git.kernel.org/tip/d3748c8533f576969837f11e69c39d3f080c0e2b
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 29 Mar 2019 17:47:40 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 19 Apr 2019 17:52:49 +0200

x86/hyperv: Make hv_vcpu_is_preempted() visible

This function is referrenced from assembler, so it needs to be marked
visible for LTO.

Fixes: 3a025de64bf8 ("x86/hyperv: Enable PV qspinlock for Hyper-V")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Yi Sun <yi.y.sun@linux.intel.com>
Cc: kys@microsoft.com
Cc: haiyangz@microsoft.com
Link: https://lkml.kernel.org/r/20190330004743.29541-6-andi@firstfloor.org
---
 arch/x86/hyperv/hv_spinlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index a861b0456b1a..07f21a06392f 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -56,7 +56,7 @@ static void hv_qlock_wait(u8 *byte, u8 val)
 /*
  * Hyper-V does not support this so far.
  */
-bool hv_vcpu_is_preempted(int vcpu)
+__visible bool hv_vcpu_is_preempted(int vcpu)
 {
 	return false;
 }
