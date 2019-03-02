Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6818CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8292087E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfCBTUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 14:20:01 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:36578 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfCBTUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 14:20:01 -0500
Received: from p5492e5b8.dip0.t-ipconnect.de ([84.146.229.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h0AAw-0003VP-I3; Sat, 02 Mar 2019 20:19:58 +0100
Date:   Sat, 2 Mar 2019 20:19:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: [GIT pull] x86 fixes for 5.0
Message-ID: <alpine.DEB.2.21.1903022015180.1638@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

Two last minute fixes:

  - Prevent that value evaluation via functions happens in the user access
    enabled region of __put_user().

  - Correct the definition of a Hyper-V hypercall constant.

Thanks,

	tglx

------------------>
Andy Lutomirski (1):
      x86/uaccess: Don't leak the AC flag into __put_user() value evaluation

Lan Tianyu (1):
      x86/hyper-v: Fix definition of HV_MAX_FLUSH_REP_COUNT


 arch/x86/include/asm/hyperv-tlfs.h | 2 +-
 arch/x86/include/asm/uaccess.h     | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

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
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index a77445d1b034..28376aa2d053 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -284,7 +284,7 @@ do {									\
 		__put_user_goto(x, ptr, "l", "k", "ir", label);		\
 		break;							\
 	case 8:								\
-		__put_user_goto_u64((__typeof__(*ptr))(x), ptr, label);	\
+		__put_user_goto_u64(x, ptr, label);			\
 		break;							\
 	default:							\
 		__put_user_bad();					\
@@ -431,8 +431,10 @@ do {									\
 ({								\
 	__label__ __pu_label;					\
 	int __pu_err = -EFAULT;					\
+	__typeof__(*(ptr)) __pu_val;				\
+	__pu_val = x;						\
 	__uaccess_begin();					\
-	__put_user_size((x), (ptr), (size), __pu_label);	\
+	__put_user_size(__pu_val, (ptr), (size), __pu_label);	\
 	__pu_err = 0;						\
 __pu_label:							\
 	__uaccess_end();					\
