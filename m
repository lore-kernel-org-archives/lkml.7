Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42164C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05871214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573544460;
	bh=v/F5sTUf2yWEEvuwHVbJ6XDHKXcxZ9UoFtx0jwYCzzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wp/VRa/8jSWgFMuF1xEZsROJIi1iqMzNWNJFgHu4QSflNEypZ5Ioat+igsIteqjwY
	 tyl1u8qHVi8IfYbPLUpqlkgF9kNVbgps2GixREmFO85VRjX8ePXjABCi2tHo83VZfH
	 DMTbTJO/KeCGX4raKhLR3aTsb8KNGxYnRR53MUpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKLHk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:40:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35380 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfKLHk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:40:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id s5so6212458wrw.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YfZMD2v0n4y9o90Eui6sfyXglUtKExySBM2mVvR5DAA=;
        b=Z3mC+njo5DL8+ETb81MWm1IJ62z3wcvcozjBGCfW/iW5Svg1oTcLE9dXX61u4ZR2ej
         0Cg4lgyh8zHuQ2PnNSahNOlJh8C9b0MsVxvEMBhi23Ww5OQmur581+r81rVKIodxPsxn
         l+xEUfLZRv1BASa7751D8brpFBXCoYjxB0nU7Wrj3JhJ3A5OB8FEOhNRnj/Bt/SgbkCY
         ZwqOf42NRKnqGYTmz67BKDOulppvm+iDYAHkzYWAThKUvJqUkPqOrYp8Hahbh/0glknv
         HOisGItZh1Ge6EX6g44Yqn+E9+qfoiLf7LXOEeT11o578C365DC1hqrqtreneoNWqX9u
         B1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YfZMD2v0n4y9o90Eui6sfyXglUtKExySBM2mVvR5DAA=;
        b=f93H2AsHG6UoFXDHGiDEfcAo2r1Ias4A0+PEbkpOjGsri16nLyhhmss71X+baNwEE8
         MHlxMpG3fRDfnzHzgvylVrEUT/21THjFAaD3unC6mACdjkoiedFN+3wv7W9dJ8WIQY3Z
         2d4xoPESi1D/m7YwM9lkb1DZf4dA8kGxM2JtsJciy/nEnYXnRBt20XUD8KsvdRDm3MZ8
         purzHXuoizjnDfMWtZROuN8ZcbWY4W4XI6vfi2obAnqxoKPudr8J9z3E9NmzxMl0oqx/
         0686FKtwgQ99b0spXww5eL+ooZKQh3xg6nXDW3fBNvt73CDRdq1kDGJFnd+2iG2HWBpw
         UQxQ==
X-Gm-Message-State: APjAAAUshMTUbzkCo8I0g894B+8M8+JrorvJGxII5r9DDqWebR5qKK3e
        uQwPJZ3osi66Ai/AO2H49no=
X-Google-Smtp-Source: APXvYqx54IUO1bycopDUYHtCELhFuRL69Ir+2++yoVoKNEfNI/azmSAUa6xdsxeiSU+alI5Qvxd/DQ==
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr13649065wrm.4.1573544455122;
        Mon, 11 Nov 2019 23:40:55 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x8sm17880666wrm.7.2019.11.11.23.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 23:40:54 -0800 (PST)
Date:   Tue, 12 Nov 2019 08:40:52 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/iopl: Factor out IO-bitmap related TSS fields into
 'struct x86_io_bitmap'
Message-ID: <20191112074052.GD100264@gmail.com>
References: <20191111220314.519933535@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111220314.519933535@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> This is the second version of the attempt to confine the unwanted side
> effects of iopl(). The first version of this series can be found here:
> 
>    https://lore.kernel.org/r/20191106193459.581614484@linutronix.de
> 
> The V1 cover letter also contains a longer variant of the
> background. Summary:
> 
> iopl(level = 3) enables aside of access to all 65536 I/O ports also the
> usage of CLI/STI in user space.
> 
> Disabling interrupts in user space can lead to system lockups and breaks
> assumptions in the kernel that userspace always runs with interrupts
> enabled.
> 
> iopl() is often preferred over ioperm() as it avoids the overhead of
> copying the tasks I/O bitmap to the TSS bitmap on context switch. This
> overhead can be avoided by providing a all zeroes bitmap in the TSS and
> switching the TSS bitmap offset to this permit all IO bitmap. It's
> marginally slower than iopl() which is a one time setup, but prevents the
> usage of CLI/STI in user space.
> 
> The changes vs. V1:
> 
>     - Fix the reported fallout on 32bit (0-day/Ingo)
> 
>     - Implement a sequence count based conditional update (Linus)
> 
>     - Drop the copy optimization
> 
>     - Move the bitmap copying out of the context switch into the exit to
>       user mode machinery. The context switch merely invalidates the TSS
>       bitmap offset when a task using an I/O bitmap gets scheduled out.
> 
>     - Move all bitmap information into a data structure to avoid adding
>       more fields to thread_struct.
> 
>     - Add a refcount so the potentially pointless duplication of the bitmap
>       at fork can be avoided. 
> 
>     - Better sharing of update functions (Andy)
> 
>     - More updates to self tests to verify the share/unshare mechanism and
>       the restore of an I/O bitmap when iopl() permissions are dropped.
> 
>     - Pick up a few acked/reviewed-by tags as applicable

>  23 files changed, 614 insertions(+), 459 deletions(-)

Ok, this new version is much easier on the eyes.

There's now a bigger collection of various x86_tss_struct fields related 
to the IO-bitmap, and the organization of those fields is still a bit 
idiosyncratic - for example tss->last_sequence doesn't tell us that it's 
bitmap related.

How about the patch below?

It reorganizes all those fields into a new container structure, 'struct 
x86_io_bitmap', adds it as tss.io_bitmap, and uses the prefix to shorten 
and organize the names of the fields:

   tss.last_bitmap         =>  tss.io_bitmap.last_bitmap
   tss.last_sequence       =>  tss.io_bitmap.last_sequence
   tss.io_bitmap_prev_max  =>  tss.io_bitmap.prev_max
   tss.io_bitmap_bytes     =>  tss.io_bitmap.map_bytes
   tss.io_bitmap_all       =>  tss.io_bitmap.map_all

This makes it far more readable, and the local variable references as 
short and tidy:

   iobm->last_bitmap
   iobm->last_sequence
   iobm->prev_max
   iobm->map_bytes
   iobm->map_all

Only build tested.

Thanks,

	Ingo

 arch/x86/include/asm/processor.h | 38 +++++++++++++++++++++++---------------
 arch/x86/kernel/cpu/common.c     |  6 +++---
 arch/x86/kernel/process.c        | 14 +++++++-------
 3 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 933f0b9b1cd7..4358ae63c252 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -333,11 +333,11 @@ struct x86_hw_tss {
 #define IO_BITMAP_LONGS			(IO_BITMAP_BYTES / sizeof(long))
 
 #define IO_BITMAP_OFFSET_VALID_MAP			\
-	(offsetof(struct tss_struct, io_bitmap_bytes) -	\
+	(offsetof(struct tss_struct, io_bitmap.map_bytes) -	\
 	 offsetof(struct tss_struct, x86_tss))
 
 #define IO_BITMAP_OFFSET_VALID_ALL			\
-	(offsetof(struct tss_struct, io_bitmap_all) -	\
+	(offsetof(struct tss_struct, io_bitmap.map_all) -	\
 	 offsetof(struct tss_struct, x86_tss))
 
 /*
@@ -361,14 +361,11 @@ struct entry_stack_page {
 	struct entry_stack stack;
 } __aligned(PAGE_SIZE);
 
-struct tss_struct {
-	/*
-	 * The fixed hardware portion.  This must not cross a page boundary
-	 * at risk of violating the SDM's advice and potentially triggering
-	 * errata.
-	 */
-	struct x86_hw_tss	x86_tss;
-
+/*
+ * All IO bitmap related data stored in the TSS:
+ */
+struct x86_io_bitmap
+{
 	/*
 	 * The bitmap pointer and the sequence number of the last active
 	 * bitmap. last_bitmap cannot be dereferenced. It's solely for
@@ -384,7 +381,7 @@ struct tss_struct {
 	 * outside of the TSS limit. So for sane tasks there is no need to
 	 * actually touch the io_bitmap at all.
 	 */
-	unsigned int		io_bitmap_prev_max;
+	unsigned int		prev_max;
 
 	/*
 	 * The extra 1 is there because the CPU will access an
@@ -392,14 +389,25 @@ struct tss_struct {
 	 * bitmap. The extra byte must be all 1 bits, and must
 	 * be within the limit.
 	 */
-	unsigned char		io_bitmap_bytes[IO_BITMAP_BYTES + 1]
-				__aligned(sizeof(unsigned long));
+	unsigned char		map_bytes[IO_BITMAP_BYTES + 1] __aligned(sizeof(unsigned long));
+
 	/*
 	 * Special I/O bitmap to emulate IOPL(3). All bytes zero,
 	 * except the additional byte at the end.
 	 */
-	unsigned char		io_bitmap_all[IO_BITMAP_BYTES + 1]
-				__aligned(sizeof(unsigned long));
+	unsigned char		map_all[IO_BITMAP_BYTES + 1] __aligned(sizeof(unsigned long));
+};
+
+struct tss_struct {
+	/*
+	 * The fixed hardware portion.  This must not cross a page boundary
+	 * at risk of violating the SDM's advice and potentially triggering
+	 * errata.
+	 */
+	struct x86_hw_tss	x86_tss;
+
+	struct x86_io_bitmap	io_bitmap;
+
 } __aligned(PAGE_SIZE);
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index dfbe6fce04f3..eea0e3170de4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1861,9 +1861,9 @@ void cpu_init(void)
 	/* Initialize the TSS. */
 	tss_setup_ist(tss);
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
-	tss->last_bitmap = NULL;
-	tss->io_bitmap_prev_max = 0;
-	memset(tss->io_bitmap_bytes, 0xff, sizeof(tss->io_bitmap_bytes));
+	tss->io_bitmap.last_bitmap = NULL;
+	tss->io_bitmap.prev_max = 0;
+	memset(tss->io_bitmap.map_bytes, 0xff, sizeof(tss->io_bitmap.map_bytes));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
 	load_TR_desc();
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ccb48f4dab75..8179f3ee6a55 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -350,16 +350,16 @@ static void tss_copy_io_bitmap(struct tss_struct *tss, struct io_bitmap *iobm)
 	 * permitted, then the copy needs to cover those as well so they
 	 * get turned off.
 	 */
-	memcpy(tss->io_bitmap_bytes, iobm->bitmap_bytes,
-	       max(tss->io_bitmap_prev_max, iobm->io_bitmap_max));
+	memcpy(tss->io_bitmap.map_bytes, iobm->bitmap_bytes,
+	       max(tss->io_bitmap.prev_max, iobm->io_bitmap_max));
 
 	/*
 	 * Store the new max and the sequence number of this bitmap
 	 * and a pointer to the bitmap itself.
 	 */
-	tss->io_bitmap_prev_max = iobm->io_bitmap_max;
-	tss->last_sequence = iobm->sequence;
-	tss->last_bitmap = iobm;
+	tss->io_bitmap.prev_max = iobm->io_bitmap_max;
+	tss->io_bitmap.last_sequence = iobm->sequence;
+	tss->io_bitmap.last_bitmap = iobm;
 }
 
 /**
@@ -388,8 +388,8 @@ void tss_update_io_bitmap(void)
 			 * sequence number differs. The update time is
 			 * accounted to the incoming task.
 			 */
-			if (tss->last_bitmap != iobm ||
-			    tss->last_sequence != iobm->sequence)
+			if (tss->io_bitmap.last_bitmap != iobm ||
+			    tss->io_bitmap.last_sequence != iobm->sequence)
 				tss_copy_io_bitmap(tss, iobm);
 
 			/* Enable the bitmap */
