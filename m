Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57956C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C0D206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573545591;
	bh=bQaBI78QuclvCx9ertGCVoFdSBp3UC5ogBpCfxAcApU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=05e9w//6D6/uxjdRbh5SizADFqzZX5AQrPb5MMwUJ/LsYwTBjN2UBLWZo5ewrxDQ6
	 cyTodfAuuvTIIvT1S7KF3wYuYSNEOtfVNMHwBeWaAccOtIuslJjBlySKuRe60ldVFb
	 ri+W6Yf/UU3W7aoEXirzZhKXCN1pESFJqrpEb1Lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKLH7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:59:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33432 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfKLH7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:59:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so1665358wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5coWVwuUzsoKFZjns49fECylYTjbnYEVIDZWNpnY0L8=;
        b=XYhl3mjtz5WWw9sZqqaQVc3KwVGjATqCG4AiebppdVZ1tGi0m2JwhfHo+Y/7T0dzXa
         25Zeh9SXTPfVEC4txDW8G3YSeptodq5Gd0uenjTRLzTpvgDWF+I8rmj5j1RMrGsXwYRJ
         rAr1iz7JnIFNM+ByXVynQBxUyMKeCVpQxosZyGPhkRcbaQmHIvhg+4BacYyTCgqFDrER
         BHo4Xyrb9zBR8QiBAih0XCCuJUcmq1t5oQsRg5G6Zn2a41s+e6cyX9lxTPV+ThWc0rfC
         etgkFv7SNr6+HiPc8FyV2r9T6hUyPZwBwLE0+obf1vkJSkO9hp9H3xO7Cfy92htCNAca
         P6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5coWVwuUzsoKFZjns49fECylYTjbnYEVIDZWNpnY0L8=;
        b=P/waaSwQz05De2fpt8kvMlV4P7Lx28dqukO2DtXQnBQvrNCyByqwNRYPEHuLIRmGLv
         tlaSESTAOhhTjSbIC610Xyc0y8vpzJipOnopoOgCLqFlPlVozNyQEgQCCKjZrR24YfId
         jJ4aWE+RL9snlK3Au2ri46pON8tdyU0bSyM0F5N85iaHg2b4zJ6Ofraj3PBnyD1WGCAM
         eWUtAVAFV0eeEhu/AFbeIs/r70kgB4GjUsg7Ad5DmkzlFRUvPqHRe0ZuJQfciXNQaF9P
         miIyDybiuH40GcjXEyP5lBitv4ts6yc1MJjgHpRbbw5/NLFhNgqIRnMC28MJG6TBQt9Q
         j+lw==
X-Gm-Message-State: APjAAAUahhgnaXXMyDv8wTiZeVrTbLqwju+b3v78vUozt1ynQokntLZo
        JatLfc+MhY3OqMLwqPhY9Og=
X-Google-Smtp-Source: APXvYqxhZ2C38RuYH/z24m6FQfwV11R2kPMxurd1FxSouUX+ybaSGE6BiQvpV5DFE1GXLPrpP7y/Bg==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr2398311wmc.136.1573545584666;
        Mon, 11 Nov 2019 23:59:44 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h205sm2972879wmf.35.2019.11.11.23.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 23:59:44 -0800 (PST)
Date:   Tue, 12 Nov 2019 08:59:42 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/iopl: Harmonize 'struct io_bitmap' and 'struct
 x86_io_bitmap' nomenclature
Message-ID: <20191112075942.GF100264@gmail.com>
References: <20191111220314.519933535@linutronix.de>
 <20191112074052.GD100264@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112074052.GD100264@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> How about the patch below?
> 
> It reorganizes all those fields into a new container structure, 'struct 
> x86_io_bitmap', adds it as tss.io_bitmap, and uses the prefix to shorten 
> and organize the names of the fields:
> 
>    tss.last_bitmap         =>  tss.io_bitmap.last_bitmap
>    tss.last_sequence       =>  tss.io_bitmap.last_sequence
>    tss.io_bitmap_prev_max  =>  tss.io_bitmap.prev_max
>    tss.io_bitmap_bytes     =>  tss.io_bitmap.map_bytes
>    tss.io_bitmap_all       =>  tss.io_bitmap.map_all
> 
> This makes it far more readable, and the local variable references as 
> short and tidy:
> 
>    iobm->last_bitmap
>    iobm->last_sequence
>    iobm->prev_max
>    iobm->map_bytes
>    iobm->map_all
> 
> Only build tested.

On top of this we can now do the slight reorganization of field names 
below.

    io_bitmap.io_bitmap_max => bytes_max
    x86_io_bitmap.prev_max => bytes_max


The point is to harmonize the fields in 'struct io_bitmap' with 'struct 
x86_io_bitmap':

    io_bitmap.map_bytes      io_bitmap.bytes_max
         iobm.map_bytes           iobm.bytes_max


which makes following segments of code really tidy:

  memcpy(tss->io_bitmap.map_bytes, iobm->map_bytes,
               max(tss->io_bitmap.bytes_max, iobm->bytes_max));

The other point is to remove the 'prev' notion from the TSS data field - 
there's very little "previous" about this - we have this bitmap loaded 
right now.

Also note the cleanup of the bits/bytes union:

   iobm->bits           =>   iobm->map_bits
   iobm->bitmap_bytes   =>   iobm->map_bytes

Only build tested, but 100% perfect, guaranteed.

Thanks,

	Ingo

---
 arch/x86/include/asm/iobitmap.h  |  6 +++---
 arch/x86/include/asm/processor.h |  2 +-
 arch/x86/kernel/cpu/common.c     |  2 +-
 arch/x86/kernel/ioport.c         | 10 +++++-----
 arch/x86/kernel/process.c        |  6 +++---
 arch/x86/kernel/ptrace.c         |  4 ++--
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/iobitmap.h b/arch/x86/include/asm/iobitmap.h
index a075f0c55fb3..faba42c7d3de 100644
--- a/arch/x86/include/asm/iobitmap.h
+++ b/arch/x86/include/asm/iobitmap.h
@@ -8,10 +8,10 @@
 struct io_bitmap {
 	u64			sequence;
 	refcount_t		refcnt;
-	unsigned int		io_bitmap_max;
+	unsigned int		bytes_max;
 	union {
-		unsigned long	bits[IO_BITMAP_LONGS];
-		unsigned char	bitmap_bytes[IO_BITMAP_BYTES];
+		unsigned long	map_bits[IO_BITMAP_LONGS];
+		unsigned char	map_bytes[IO_BITMAP_BYTES];
 	};
 };
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4358ae63c252..d1f2c1eb14e9 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -381,7 +381,7 @@ struct x86_io_bitmap
 	 * outside of the TSS limit. So for sane tasks there is no need to
 	 * actually touch the io_bitmap at all.
 	 */
-	unsigned int		prev_max;
+	unsigned int		bytes_max;
 
 	/*
 	 * The extra 1 is there because the CPU will access an
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eea0e3170de4..a35a557429e7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1862,7 +1862,7 @@ void cpu_init(void)
 	tss_setup_ist(tss);
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
 	tss->io_bitmap.last_bitmap = NULL;
-	tss->io_bitmap.prev_max = 0;
+	tss->io_bitmap.bytes_max = 0;
 	memset(tss->io_bitmap.map_bytes, 0xff, sizeof(tss->io_bitmap.map_bytes));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index ee37a1c25ecc..203f82383bf6 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -86,7 +86,7 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 		if (!iobm)
 			return -ENOMEM;
 
-		memset(iobm->bits, 0xff, sizeof(iobm->bits));
+		memset(iobm->map_bits, 0xff, sizeof(iobm->map_bits));
 		refcount_set(&iobm->refcnt, 1);
 	}
 
@@ -112,9 +112,9 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	 * exit to user mode. So this needs no protection.
 	 */
 	if (turn_on)
-		bitmap_clear(iobm->bits, from, num);
+		bitmap_clear(iobm->map_bits, from, num);
 	else
-		bitmap_set(iobm->bits, from, num);
+		bitmap_set(iobm->map_bits, from, num);
 
 	/*
 	 * Search for a (possibly new) maximum. This is simple and stupid,
@@ -122,7 +122,7 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	 */
 	max_long = UINT_MAX;
 	for (i = 0; i < IO_BITMAP_LONGS; i++) {
-		if (iobm->bits[i] != ~0UL)
+		if (iobm->map_bits[i] != ~0UL)
 			max_long = i;
 	}
 
@@ -132,7 +132,7 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 		return 0;
 	}
 
-	iobm->io_bitmap_max = (max_long + 1) * sizeof(unsigned long);
+	iobm->bytes_max = (max_long + 1) * sizeof(unsigned long);
 
 	/* Increment the sequence number to force a TSS update */
 	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 8179f3ee6a55..c4e76a540b51 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -350,14 +350,14 @@ static void tss_copy_io_bitmap(struct tss_struct *tss, struct io_bitmap *iobm)
 	 * permitted, then the copy needs to cover those as well so they
 	 * get turned off.
 	 */
-	memcpy(tss->io_bitmap.map_bytes, iobm->bitmap_bytes,
-	       max(tss->io_bitmap.prev_max, iobm->io_bitmap_max));
+	memcpy(tss->io_bitmap.map_bytes, iobm->map_bytes,
+	       max(tss->io_bitmap.bytes_max, iobm->bytes_max));
 
 	/*
 	 * Store the new max and the sequence number of this bitmap
 	 * and a pointer to the bitmap itself.
 	 */
-	tss->io_bitmap.prev_max = iobm->io_bitmap_max;
+	tss->io_bitmap.bytes_max = iobm->bytes_max;
 	tss->io_bitmap.last_sequence = iobm->sequence;
 	tss->io_bitmap.last_bitmap = iobm;
 }
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 6baa5a1a9f1c..f27c322f1c93 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -700,7 +700,7 @@ static int ioperm_active(struct task_struct *target,
 {
 	struct io_bitmap *iobm = target->thread.io_bitmap;
 
-	return iobm ? DIV_ROUND_UP(iobm->io_bitmap_max, regset->size) : 0;
+	return iobm ? DIV_ROUND_UP(iobm->bytes_max, regset->size) : 0;
 }
 
 static int ioperm_get(struct task_struct *target,
@@ -714,7 +714,7 @@ static int ioperm_get(struct task_struct *target,
 		return -ENXIO;
 
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   iobm->bitmap_bytes, 0, IO_BITMAP_BYTES);
+				   iobm->map_bytes, 0, IO_BITMAP_BYTES);
 }
 
 /*
