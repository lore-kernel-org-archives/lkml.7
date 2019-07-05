Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D17EC468A9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1646020989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfGESGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 14:06:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:55455 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfGESGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 14:06:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 11:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="scan'208";a="191683058"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2019 11:06:51 -0700
Subject: [PATCH 3/3] x86/mpx: remove MPX APIs
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 05 Jul 2019 10:53:21 -0700
References: <20190705175317.1B3C9C52@viggo.jf.intel.com>
In-Reply-To: <20190705175317.1B3C9C52@viggo.jf.intel.com>
Message-Id: <20190705175321.DB42F0AD@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

MPX is being removed from the kernel due to a lack of support
in the toolchain going forward (gcc).

The first thing we need to do is remove the userspace-visible
ABIs so that applications will stop using it.  The most visible
one are the enable/disable prctl()s.  Remove them first.

This is the most minimal and least invasive patch needed to
ensure that apps stop using MPX with new kernels.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---

 b/include/uapi/linux/prctl.h |    2 +-
 b/kernel/sys.c               |   16 ++--------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff -puN include/uapi/linux/prctl.h~mpx-remove-apis include/uapi/linux/prctl.h
--- a/include/uapi/linux/prctl.h~mpx-remove-apis	2019-07-05 10:40:49.441907046 -0700
+++ b/include/uapi/linux/prctl.h	2019-07-05 10:40:49.447907046 -0700
@@ -181,7 +181,7 @@ struct prctl_mm_map {
 #define PR_GET_THP_DISABLE	42
 
 /*
- * Tell the kernel to start/stop helping userspace manage bounds tables.
+ * No longer implemented, but left here to ensure the numbers stay reserved:
  */
 #define PR_MPX_ENABLE_MANAGEMENT  43
 #define PR_MPX_DISABLE_MANAGEMENT 44
diff -puN kernel/sys.c~mpx-remove-apis kernel/sys.c
--- a/kernel/sys.c~mpx-remove-apis	2019-07-05 10:40:49.444907046 -0700
+++ b/kernel/sys.c	2019-07-05 10:40:49.448907046 -0700
@@ -103,12 +103,6 @@
 #ifndef SET_TSC_CTL
 # define SET_TSC_CTL(a)		(-EINVAL)
 #endif
-#ifndef MPX_ENABLE_MANAGEMENT
-# define MPX_ENABLE_MANAGEMENT()	(-EINVAL)
-#endif
-#ifndef MPX_DISABLE_MANAGEMENT
-# define MPX_DISABLE_MANAGEMENT()	(-EINVAL)
-#endif
 #ifndef GET_FP_MODE
 # define GET_FP_MODE(a)		(-EINVAL)
 #endif
@@ -2456,15 +2450,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 		up_write(&me->mm->mmap_sem);
 		break;
 	case PR_MPX_ENABLE_MANAGEMENT:
-		if (arg2 || arg3 || arg4 || arg5)
-			return -EINVAL;
-		error = MPX_ENABLE_MANAGEMENT();
-		break;
 	case PR_MPX_DISABLE_MANAGEMENT:
-		if (arg2 || arg3 || arg4 || arg5)
-			return -EINVAL;
-		error = MPX_DISABLE_MANAGEMENT();
-		break;
+		/* No longer implemented: */
+		return -EINVAL;
 	case PR_SET_FP_MODE:
 		error = SET_FP_MODE(me, arg2);
 		break;
_
