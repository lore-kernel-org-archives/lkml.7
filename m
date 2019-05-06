Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DC5C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A0F20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557138737;
	bh=3JCJMc9zODDgLmmFccVN0ejlvOewwJV9G5errqUneAo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Jcm4XCTL/WaJSPa1BwVx1B0kNU+ROF/7LaLVc6m0kRWel0/TAKxUPXkkMqbMhMpXw
	 1raSrcHyl5mxX6jWCunHnV21BDgAHlRVYPquTDB1spELiMFuLtar3jBxQH5Sos/dEQ
	 IhNpo7xX+Ly92KqkUntwBPCUyLQYoqWazdExa16g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfEFKcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:32:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37515 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfEFKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:32:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id y5so14552993wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ynI90WlNjiUrk7TSctsvegrBgd0dj4yzlFdlx0swr1U=;
        b=M7RmK4/Np4ooIlwTbdQlwikWtK+dYJaL9imrzICSUR1tx6mbLLyoVbWzodJ4SJ+rDx
         PP9CXSnx+iK6O5xidu48tuFNotKb7RCA4Ou55HNvFZ4d128EcaGA5cMqXYaK72TIO0fl
         Dy2AXZl+t6qsxkdVAdKJ0q8AAQAIGn2sawNRji2x5u/ZHibTen0dGjO094LheP3kGa1y
         USV+dhZOvnzljl4GayeJ8kQf3Dfa4Ee4ElNgI4t7chhxSdiRqQ6WfTz5uIOc0+x7Raq4
         AaqDPCIVp6riIoq0bzvgN2sJvZpsAR0D5h+KUuQ9t7xs9iY3zpoiF9xcaS0GCiwNKOJl
         kI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ynI90WlNjiUrk7TSctsvegrBgd0dj4yzlFdlx0swr1U=;
        b=AAUzLg20mNzFPNIVGwsQRG4QsLVo1fVUKD//dL7Ir55JGFe603Ma5Wl7zM/9OJPZNG
         hJRZmVV7RseiEWUkHuIHthc8q2931nbCnSaa07tzYWrLK28X8iSyC6LNKnPZO7POp/pF
         MaMz0jeD0ZThZ1T6qFqOn5YgjnQptC1YNEZq9U3vUoaQSGoWBei1FCnsVSfKY+jC2hQ/
         qIYGICzAtO/CSmVxssWwY1+Z01Z54pvPQovpgpN24bWbDKlWG5Cx2se7yHOOFKNvZLQu
         zND+QNbSHJGurI/WA16YFtg3inUqRyZG5IHkZud4FNwu74dIveH03ePqw+PZrYcvXKcj
         6xBw==
X-Gm-Message-State: APjAAAXYyT/pyqB7y/3GdntpHXa8i9cgzyMDWWZFMeBjXN4hU5PwapJS
        bUdhZN1ukvRI6B7ciKiVGL8=
X-Google-Smtp-Source: APXvYqxbz1p3fFcYVed8i8oIzYauNaj5AQtruiK/xWAtnM+nz9iZ7ntN7m9PRMeWD5zpKpuzqYVbjA==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr15395677wmf.125.1557138732056;
        Mon, 06 May 2019 03:32:12 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v18sm8475914wro.11.2019.05.06.03.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 03:32:11 -0700 (PDT)
Date:   Mon, 6 May 2019 12:32:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/kdump changes for v5.2
Message-ID: <20190506103209.GA124678@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-kdump-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kdump-for-linus

   # HEAD: b9ac3849af412fd3887d7652bdbabf29d2aecc16 x86/kdump: Fall back to reserve high crashkernel memory

This tree includes two changes:

 - Raise the crash kernel reservation limit from from ~896MB to ~4GB. 
   Only very old (and already known-broken) kexec-tools is supposed to be 
   affected by this negatively.

 - Allow higher than 4GB crash kernel allocations when low allocations 
   fail.

 Thanks,

	Ingo

------------------>
Dave Young (2):
      x86/kdump: Have crashkernel=X reserve under 4G by default
      x86/kdump: Fall back to reserve high crashkernel memory


 Documentation/admin-guide/kernel-parameters.txt |  7 ++++--
 arch/x86/kernel/setup.c                         | 32 +++++++++++++++----------
 2 files changed, 24 insertions(+), 15 deletions(-)

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
index 3d872a527cd9..c15f362a2516 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -71,6 +71,7 @@
 #include <linux/tboot.h>
 #include <linux/jiffies.h>
 #include <linux/mem_encrypt.h>
+#include <linux/sizes.h>
 
 #include <linux/usb/xhci-dbgp.h>
 #include <video/edid.h>
@@ -448,18 +449,17 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 #ifdef CONFIG_KEXEC_CORE
 
 /* 16M alignment for crash kernel regions */
-#define CRASH_ALIGN		(16 << 20)
+#define CRASH_ALIGN		SZ_16M
 
 /*
  * Keep the crash kernel below this limit.  On 32 bits earlier kernels
  * would limit the kernel to the low 512 MiB due to mapping restrictions.
- * On 64bit, old kexec-tools need to under 896MiB.
  */
 #ifdef CONFIG_X86_32
-# define CRASH_ADDR_LOW_MAX	(512 << 20)
-# define CRASH_ADDR_HIGH_MAX	(512 << 20)
+# define CRASH_ADDR_LOW_MAX	SZ_512M
+# define CRASH_ADDR_HIGH_MAX	SZ_512M
 #else
-# define CRASH_ADDR_LOW_MAX	(896UL << 20)
+# define CRASH_ADDR_LOW_MAX	SZ_4G
 # define CRASH_ADDR_HIGH_MAX	MAXMEM
 #endif
 
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
 
