Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F03C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B3620856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140015;
	bh=kagwd1ylNsxoBvVHd9sVCOBYVZC7U39vfhkvbL21L5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2mhExVaDt4SWbBQ+K8PxA8kN16xLHcju7LgqdDFg8CSH0e3Q3MNK+NKyJopxvNftD
	 ZLjwmkXMQRppBqaqbsdzX2kRdrwq09dDyAM0S6cVC/rFYxdWMt37vrUDr7D/Xrm+s9
	 g0Lch4oioqOU2Y80asOAzE/+Z6npHGq45LIoWVec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbfDARde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387632AbfDARda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63322208E4;
        Mon,  1 Apr 2019 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140009;
        bh=kagwd1ylNsxoBvVHd9sVCOBYVZC7U39vfhkvbL21L5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uszkw2rHOAQ/0dyqDKKBFPP91pSxGp76XjCnm/LXYmju8YkEYJOI/6EM+IrBWpPa3
         xPmnTroaoCECBuSm1XfOzIZc5wMtK/+YPlFw9VvHYI6x+9EjA0OMSNTsizVP8ButEy
         pLXdzNmUCM1HpkKHyPE4cdU00PIY9vXMBX+DBTWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 078/131] PM / Hibernate: Call flush_icache_range() on pages restored in-place
Date:   Mon,  1 Apr 2019 19:02:28 +0200
Message-Id: <20190401170058.681712612@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f6cf0545ec697ddc278b7457b7d0c0d86a2ea88e ]

Some architectures require code written to memory as if it were data to be
'cleaned' from any data caches before the processor can fetch them as new
instructions.

During resume from hibernate, the snapshot code copies some pages directly,
meaning these architectures do not get a chance to perform their cache
maintenance. Modify the read and decompress code to call
flush_icache_range() on all pages that are restored, so that the restored
in-place pages are guaranteed to be executable on these architectures.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
[will: make clean_pages_on_* static and remove initialisers]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/swap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 12cd989dadf6..160e1006640d 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -36,6 +36,14 @@
 
 #define HIBERNATE_SIG	"S1SUSPEND"
 
+/*
+ * When reading an {un,}compressed image, we may restore pages in place,
+ * in which case some architectures need these pages cleaning before they
+ * can be executed. We don't know which pages these may be, so clean the lot.
+ */
+static bool clean_pages_on_read;
+static bool clean_pages_on_decompress;
+
 /*
  *	The swap map is a data structure used for keeping track of each page
  *	written to a swap partition.  It consists of many swap_map_page
@@ -241,6 +249,9 @@ static void hib_end_io(struct bio *bio)
 
 	if (bio_data_dir(bio) == WRITE)
 		put_page(page);
+	else if (clean_pages_on_read)
+		flush_icache_range((unsigned long)page_address(page),
+				   (unsigned long)page_address(page) + PAGE_SIZE);
 
 	if (bio->bi_error && !hb->error)
 		hb->error = bio->bi_error;
@@ -1049,6 +1060,7 @@ static int load_image(struct swap_map_handle *handle,
 
 	hib_init_batch(&hb);
 
+	clean_pages_on_read = true;
 	printk(KERN_INFO "PM: Loading image data pages (%u pages)...\n",
 		nr_to_read);
 	m = nr_to_read / 10;
@@ -1124,6 +1136,10 @@ static int lzo_decompress_threadfn(void *data)
 		d->unc_len = LZO_UNC_SIZE;
 		d->ret = lzo1x_decompress_safe(d->cmp + LZO_HEADER, d->cmp_len,
 		                               d->unc, &d->unc_len);
+		if (clean_pages_on_decompress)
+			flush_icache_range((unsigned long)d->unc,
+					   (unsigned long)d->unc + d->unc_len);
+
 		atomic_set(&d->stop, 1);
 		wake_up(&d->done);
 	}
@@ -1189,6 +1205,8 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	}
 	memset(crc, 0, offsetof(struct crc_data, go));
 
+	clean_pages_on_decompress = true;
+
 	/*
 	 * Start the decompression threads.
 	 */
-- 
2.19.1



