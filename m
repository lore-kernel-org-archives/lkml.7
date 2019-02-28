Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8685C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9002921850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbfB1LEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:04:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49219 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731102AbfB1LEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:04:14 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1SB43XZ3010598
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 03:04:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1SB42N23010585;
        Thu, 28 Feb 2019 03:04:02 -0800
Date:   Thu, 28 Feb 2019 03:04:02 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lan Tianyu <tipbot@zytor.com>
Message-ID: <tip-9cd05ad2910b55238e3c720c99ad896dc538301b@git.kernel.org>
Cc:     mingo@kernel.org, Tianyu.Lan@microsoft.com, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, Tianyu.Lan@microsoft.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190225143114.5149-1-Tianyu.Lan@microsoft.com>
References: <20190225143114.5149-1-Tianyu.Lan@microsoft.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/hyper-v: Fix definition of
 HV_MAX_FLUSH_REP_COUNT
Git-Commit-ID: 9cd05ad2910b55238e3c720c99ad896dc538301b
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

Commit-ID:  9cd05ad2910b55238e3c720c99ad896dc538301b
Gitweb:     https://git.kernel.org/tip/9cd05ad2910b55238e3c720c99ad896dc538301b
Author:     Lan Tianyu <Tianyu.Lan@microsoft.com>
AuthorDate: Mon, 25 Feb 2019 22:31:14 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 28 Feb 2019 11:58:29 +0100

x86/hyper-v: Fix definition of HV_MAX_FLUSH_REP_COUNT

The max flush rep count of HvFlushGuestPhysicalAddressList hypercall is
equal with how many entries of union hv_gpa_page_range can be populated
into the input parameter page.

The code lacks parenthesis around PAGE_SIZE - 2 * sizeof(u64) which results
in bogus computations. Add them.

Fixes: cc4edae4b924 ("x86/hyper-v: Add HvFlushGuestAddressList hypercall support")
Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: kys@microsoft.com
Cc: haiyangz@microsoft.com
Cc: sthemmin@microsoft.com
Cc: sashal@kernel.org
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: gregkh@linuxfoundation.org
Cc: devel@linuxdriverproject.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190225143114.5149-1-Tianyu.Lan@microsoft.com
---
 arch/x86/include/asm/hyperv-tlfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 705dafc2d11a..2bdbbbcfa393 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -841,7 +841,7 @@ union hv_gpa_page_range {
  * count is equal with how many entries of union hv_gpa_page_range can
  * be populated into the input parameter page.
  */
-#define HV_MAX_FLUSH_REP_COUNT (PAGE_SIZE - 2 * sizeof(u64) /	\
+#define HV_MAX_FLUSH_REP_COUNT ((PAGE_SIZE - 2 * sizeof(u64)) /	\
 				sizeof(union hv_gpa_page_range))
 
 struct hv_guest_mapping_flush_list {
