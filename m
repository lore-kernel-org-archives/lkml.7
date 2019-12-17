Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB7DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED7A207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576583921;
	bh=L5lxRTzSNp4ks5tEsK6AIFU/41ai81zRbGneyw0LgqQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=lMOhkjJ3jXD2oT6+NrWh1+Lzex7u6566dTZSftKS22rT6pwSJufdLR1E0ydE/g0ZP
	 qbrU2NirsfHh2ZtI2kMRvzDj+/FNPWJ9/2hVWU8QmLQiyjuYCTJyIfff0R6ZKul2Od
	 TFiCAB79LXDDXFZGpBkX/MOregk3TbTeD+8QsF9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfLQL6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:58:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39598 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfLQL6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:58:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id b72so2821007wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 03:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+cSaJo2wJ2trVZMOQSxkm5SUsVdrJgp73QdhioCoKFk=;
        b=VSiv8t2UY4QyXwHetDfV0D0WZj23LrCh/ROzFuGOlsoj/XGAjgCxIIeaCx04wgVcPr
         YPLjXZVaYvalrqNcGcR+/A21P52DSbFzmUTJ+mUTDMO5sM4DGk1lhIwojl2O8swkN3FZ
         kF6EZbgu59k6x2xdKThNpDLA/wkt0EDklliTycvlDo40PeYvmHkbmYWLTcvDkvV/0hGG
         xLp6tRky7VpB9pqdWtUddPjMBvgMF0/CckHW1kraKe8eUElSZ60oldQvxnFxgpGRdeAj
         lWnCGnsR6IjWR4m6BZ6zpywKjEu5XLcgo27AJ23f9Rc2tcW6BRfwCnZdkh00221aFNA2
         i8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=+cSaJo2wJ2trVZMOQSxkm5SUsVdrJgp73QdhioCoKFk=;
        b=LOkJRH7rzkNXIEoRx7Qcz5peBZSP5g+BGLHLtHI1Km/FZe0GbpaUgyrCq4uoXa7/X1
         jdkCnWcfl95UtjfM34PFFdqabIP8zCJUZwRbJHJlXUjHmS/jF8jhXfYX8L7HJOo5LCr6
         cr1j9QLO9ZVnks6uMYuohNlEEVo5UJXlPLw92WXJctUwcIjW5AN2tIqUGris4EYYg9IN
         WlVKldEDxcPDPwIAAMxOt7egU3/EPNLIJbcK307t4wUW+mBAZCDyWauzi0H+1Nh+V+a6
         jLrgwP6/qZ62eL6ewgtQFCkoxPi3itnfUtiExLTGgaU6moWdYRaa4V9pzyqxFHFSHtWj
         UrAw==
X-Gm-Message-State: APjAAAVlUGOatDxDofV7uTXXbQ7b0sDEG59WCNtFh/KXAkXo4+BLnKdf
        Yga2kOS83r3oDEG8lhLbpOg=
X-Google-Smtp-Source: APXvYqyuN60BpgMqUMx46aW8dNM2MvjkD/OzLjWrYHAC4TlrOKb51cqbiheW7/zAfWkKiQ4RdypkJw==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr4790224wmc.119.1576583918151;
        Tue, 17 Dec 2019 03:58:38 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a184sm2828923wmf.29.2019.12.17.03.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 03:58:37 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:58:35 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fix
Message-ID: <20191217115835.GA100231@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: af164898482817a1d487964b68f3c21bae7a1beb x86/efi: Update e820 with reserved EFI boot services data to fix kexec breakage

Fix kexec booting with certain EFI memory map layouts.

 Thanks,

	Ingo

------------------>
Dave Young (1):
      x86/efi: Update e820 with reserved EFI boot services data to fix kexec breakage


 arch/x86/platform/efi/quirks.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 7675cf754d90..f8f0220b6a66 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -260,10 +260,6 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 		return;
 	}
 
-	/* No need to reserve regions that will never be freed. */
-	if (md.attribute & EFI_MEMORY_RUNTIME)
-		return;
-
 	size += addr % EFI_PAGE_SIZE;
 	size = round_up(size, EFI_PAGE_SIZE);
 	addr = round_down(addr, EFI_PAGE_SIZE);
@@ -293,6 +289,8 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	early_memunmap(new, new_size);
 
 	efi_memmap_install(new_phys, num_entries);
+	e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
+	e820__update_table(e820_table);
 }
 
 /*
