Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28624C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A1721925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573546322;
	bh=VcR8tv0wh9g8kZmHO/HgLm+Rr276wIHuSJyIyMSKDPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XPfBULjA2oANDJnfjInt58RfOiNOZm7RsTgKoDTv1sJAuE7GumScc8Pu752ANGSeg
	 otOrTvb/LPmlYiuJhk5awX3F+iPio93Kl0aFXvD3OtLMy/L2MS2/YxsqfJGKHmmYzX
	 BrwvFSp7gRr8Hfec56XzoimEKu56eJZgh49H9K7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfKLIMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:12:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34950 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLIMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:12:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id n4so14229376qte.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 00:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kt7J2laxHQ4pWQrrVLE48aAp/b3AC/hHVCv/0m4lmtk=;
        b=Y0UsbTOCwHsVFcxd4N9UrjgdfCdcE7UdvpH4OGd+JivnepMeaVRq6Wato1ghR3IC0z
         ODg7e4GSXwcKC4Ikt1P/Zcz46L/2xDC/IxcJRgU0FN7r0Xm76IvByMnmKFnGvNYDjSva
         BXhKTET58532s4hFirnMRcd39XYwjAoUlytcYmx2xOHf8qYMqrbiNYYAqFoDiZvWFi7l
         xrdXlFelpwOHOq5Lh5IxKIPeQFNsWcFBcEMDUYYCrHpzZPa4lpSaqI1WmiC9mrnvjgW7
         wwJb4jkoJPJtSpuw0ocLe1Cj/6WqsgLyoUUFYxmUMoNI+N0u+txPHKW+/9ar+vLTcVV4
         qXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kt7J2laxHQ4pWQrrVLE48aAp/b3AC/hHVCv/0m4lmtk=;
        b=bTxq8Em2gylFY3rd8l+MmUSmqSbWWAUUU/xXHrBRKybybMpMTCrQ2fY9LUN8EnjfKj
         oLKt0OAXtFE8KrBo1KQ7SaofM+usSNx5jg11BidfRwzb+HasF4sV1/XtJzDsXUimUvJ2
         dueEaq0K6QCgq/Ho7B/hPjSSKHqd8Cev3ND4UhSJSbWtUtD95QniTXP2IPW3P5TAS6V9
         aiSFUTqVg/JKF/Ib1XL67sKrsSlXnZZBSuy+4+1NsCQL05CfHvaxv56NVOu7ZlTKKkyA
         BzpKqdZkTbsJciVC12yc1DJqwsR2Y/NwYd1/BKtHXOowvqplpTkrhzaskK3AlIy+49uY
         kAWQ==
X-Gm-Message-State: APjAAAUIDAModd1MxgEXoVpfgHvPcRq6qdgIzg5nVX3w+NNoKbjJaCme
        6cgzMvBOIBujtyUbR9l3Qcg=
X-Google-Smtp-Source: APXvYqzY/DXYDodTnnEAQx0YLr5+650L5zPT7ndeHAWKf24VhLOUaIXKozEOi467IRLglpAOFAdxLA==
X-Received: by 2002:ac8:682:: with SMTP id f2mr30812560qth.140.1573546317546;
        Tue, 12 Nov 2019 00:11:57 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 19sm9205090qkg.89.2019.11.12.00.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 00:11:57 -0800 (PST)
Date:   Tue, 12 Nov 2019 09:11:53 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/iopl: Clear up the role of the two bitmap copying fields
Message-ID: <20191112081153.GG100264@gmail.com>
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


Here's another one, which makes the pointer-caching logic a bit clearer 
IMO:

Firstly, it lines up the two related fields in the namespace:

   x86_io_bitmap.last_bitmap        =>   bitmap_copied_ptr
   x86_io_bitmap.last_sequence      =>   bitmap_copied_seq

It also constifies the pointer to better signal that it should never 
actually be used for anything but comparison

I think the 'bitmap_copied_' ptr/seq pairing makes it more obvious, and 
removing the 'last' language makes it a tiny bit clearer that this bitmap 
is special because we copied its contents into the TSS.

This makes code like this a tiny bit easier to read IMHO:

+                       if (tss->io_bitmap.bitmap_copied_ptr != iobm ||
+                           tss->io_bitmap.bitmap_copied_seq != iobm->sequence)

I marked it RFC because you might not agree. :-)

Only build tested.

Thanks,

	Ingo

---
 arch/x86/include/asm/processor.h | 10 +++++-----
 arch/x86/kernel/cpu/common.c     |  2 +-
 arch/x86/kernel/process.c        |  8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d1f2c1eb14e9..b45ff7c1419f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -367,12 +367,12 @@ struct entry_stack_page {
 struct x86_io_bitmap
 {
 	/*
-	 * The bitmap pointer and the sequence number of the last active
-	 * bitmap. last_bitmap cannot be dereferenced. It's solely for
-	 * comparison.
+	 * The bitmap pointer and the sequence number of the last copied
+	 * bitmap. bitmap_copied_ptr must not be dereferenced, it's solely
+	 * for comparison.
 	 */
-	struct io_bitmap	*last_bitmap;
-	u64			last_sequence;
+	const struct io_bitmap	*bitmap_copied_ptr;
+	u64			bitmap_copied_seq;
 
 	/*
 	 * Store the dirty size of the last io bitmap offender. The next
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a35a557429e7..5a74c5b11b1c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1861,7 +1861,7 @@ void cpu_init(void)
 	/* Initialize the TSS. */
 	tss_setup_ist(tss);
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
-	tss->io_bitmap.last_bitmap = NULL;
+	tss->io_bitmap.bitmap_copied_ptr = NULL;
 	tss->io_bitmap.bytes_max = 0;
 	memset(tss->io_bitmap.map_bytes, 0xff, sizeof(tss->io_bitmap.map_bytes));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c4e76a540b51..ecf97855ed68 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -358,8 +358,8 @@ static void tss_copy_io_bitmap(struct tss_struct *tss, struct io_bitmap *iobm)
 	 * and a pointer to the bitmap itself.
 	 */
 	tss->io_bitmap.bytes_max = iobm->bytes_max;
-	tss->io_bitmap.last_sequence = iobm->sequence;
-	tss->io_bitmap.last_bitmap = iobm;
+	tss->io_bitmap.bitmap_copied_seq = iobm->sequence;
+	tss->io_bitmap.bitmap_copied_ptr = iobm;
 }
 
 /**
@@ -388,8 +388,8 @@ void tss_update_io_bitmap(void)
 			 * sequence number differs. The update time is
 			 * accounted to the incoming task.
 			 */
-			if (tss->io_bitmap.last_bitmap != iobm ||
-			    tss->io_bitmap.last_sequence != iobm->sequence)
+			if (tss->io_bitmap.bitmap_copied_ptr != iobm ||
+			    tss->io_bitmap.bitmap_copied_seq != iobm->sequence)
 				tss_copy_io_bitmap(tss, iobm);
 
 			/* Enable the bitmap */
