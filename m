Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0FEC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AA720656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="c5wjAUfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDVI3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:29:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47303 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVI3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:29:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3M8T0of1558059
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Apr 2019 01:29:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3M8T0of1558059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555921741;
        bh=sXb7yU/ts38GiFwN9tuHzlc2JHuc2L0qKhLT4jHsP2Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=c5wjAUfqbu7uulXmVpA8Hx0mB3SPgZ1scIkHzdlZVe5sCfQMRCC36K6eNyXnIw2Vf
         XiR3k3YcHysXhf87FVxv8OuIpJPvpAKLvGgquo4/E5t6tqyehqqESdxH1VciCrqaDt
         gPgKNhNsxWfEIhHgp8EXR5y0mzo6L/LNYb1Kh0lZs337jqjpw968bf5ND1tZAfe+nH
         pPGVMLU+twMDblyrtye9roMmCUtZzsfwkifVlo5CW589NN3noca8MrhvszGYYeFLXP
         Tlyi9rm/RlKSqSHYN9g1LJ/81fweeENug9QPAKimpVmYPYAIz4jSCyBGwIj4W5WPV0
         qZ8naPXIvpmAQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3M8SxLu1558056;
        Mon, 22 Apr 2019 01:28:59 -0700
Date:   Mon, 22 Apr 2019 01:28:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Young <tipbot@zytor.com>
Message-ID: <tip-b9ac3849af412fd3887d7652bdbabf29d2aecc16@git.kernel.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, konrad.wilk@oracle.com,
        bp@suse.de, paulmck@linux.ibm.com, jkosina@suse.cz,
        okaya@codeaurora.org, jgross@suse.com, hpa@zytor.com,
        linuxram@us.ibm.com, thymovanbeers@gmail.com, x86@kernel.org,
        kookoo.gu@intel.com, ptesarik@suse.cz, mingo@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, yinghai@kernel.org, dhowells@redhat.com,
        bhe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        dyoung@redhat.com
Reply-To: mingo@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          yinghai@kernel.org, ebiederm@xmission.com, bhe@redhat.com,
          dhowells@redhat.com, tglx@linutronix.de, keescook@chromium.org,
          dyoung@redhat.com, corbet@lwn.net, paulmck@linux.ibm.com,
          bp@suse.de, jgross@suse.com, jkosina@suse.cz,
          okaya@codeaurora.org, gregkh@linuxfoundation.org,
          konrad.wilk@oracle.com, hpa@zytor.com, linuxram@us.ibm.com,
          x86@kernel.org, thymovanbeers@gmail.com, kookoo.gu@intel.com,
          ptesarik@suse.cz
In-Reply-To: <20190422031905.GA8387@dhcp-128-65.nay.redhat.com>
References: <20190422031905.GA8387@dhcp-128-65.nay.redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/kdump] x86/kdump: Fall back to reserve high crashkernel
 memory
Git-Commit-ID: b9ac3849af412fd3887d7652bdbabf29d2aecc16
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

Commit-ID:  b9ac3849af412fd3887d7652bdbabf29d2aecc16
Gitweb:     https://git.kernel.org/tip/b9ac3849af412fd3887d7652bdbabf29d2aecc16
Author:     Dave Young <dyoung@redhat.com>
AuthorDate: Mon, 22 Apr 2019 11:19:05 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 22 Apr 2019 10:23:05 +0200

x86/kdump: Fall back to reserve high crashkernel memory

crashkernel=xM tries to reserve memory for the crash kernel under 4G,
which is enough, usually. But this could fail sometimes, for example
when one tries to reserve a big chunk like 2G, for example.

So let the crashkernel=xM just fall back to use high memory in case it
fails to find a suitable low range. Do not set the ,high as default
because it allocates extra low memory for DMA buffers and swiotlb, and
this is not always necessary for all machines.

Typically, crashkernel=128M usually works with low reservation under 4G,
so keep <4G as default.

 [ bp: Massage. ]

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-doc@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Petr Tesarik <ptesarik@suse.cz>
Cc: piliu@redhat.com
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thymo van Beers <thymovanbeers@gmail.com>
Cc: vgoyal@redhat.com
Cc: x86-ml <x86@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Zhimin Gu <kookoo.gu@intel.com>
Link: https://lkml.kernel.org/r/20190422031905.GA8387@dhcp-128-65.nay.redhat.com
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++--
 arch/x86/kernel/setup.c                         | 22 ++++++++++++++--------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..24d01648edeb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -704,8 +704,11 @@
 			upon panic. This parameter reserves the physical
 			memory region [offset, offset + size] for that kernel
 			image. If '@offset' is omitted, then a suitable offset
-			is selected automatically. Check
-			Documentation/kdump/kdump.txt for further details.
+			is selected automatically.
+			[KNL, x86_64] select a region under 4G first, and
+			fall back to reserve region above 4G when '@offset'
+			hasn't been specified.
+			See Documentation/kdump/kdump.txt for further details.
 
 	crashkernel=range1:size1[,range2:size2,...][@offset]
 			[KNL] Same as above, but depends on the memory
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index daf7c5650c18..c15f362a2516 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -541,21 +541,27 @@ static void __init reserve_crashkernel(void)
 	}
 
 	/* 0 means: find the address automatically */
-	if (crash_base <= 0) {
+	if (!crash_base) {
 		/*
 		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
-		 * as old kexec-tools loads bzImage below that, unless
-		 * "crashkernel=size[KMG],high" is specified.
+		 * crashkernel=x,high reserves memory over 4G, also allocates
+		 * 256M extra low memory for DMA buffers and swiotlb.
+		 * But the extra memory is not required for all machines.
+		 * So try low memory first and fall back to high memory
+		 * unless "crashkernel=size[KMG],high" is specified.
 		 */
-		crash_base = memblock_find_in_range(CRASH_ALIGN,
-						    high ? CRASH_ADDR_HIGH_MAX
-							 : CRASH_ADDR_LOW_MAX,
-						    crash_size, CRASH_ALIGN);
+		if (!high)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						CRASH_ADDR_LOW_MAX,
+						crash_size, CRASH_ALIGN);
+		if (!crash_base)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						CRASH_ADDR_HIGH_MAX,
+						crash_size, CRASH_ALIGN);
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
 		}
-
 	} else {
 		unsigned long long start;
 
