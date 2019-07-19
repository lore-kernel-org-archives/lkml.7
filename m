Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B79CC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D279D2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGjkJsZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbfGSUCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 16:02:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45256 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfGSUCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 16:02:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so14899258pgp.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=5N6LdOFrJjCGue8cmzcmZMQF0A64ylNe67FM2v5UYwc=;
        b=UGjkJsZMA2fiZtIAfmbFGijLgKyG17B3eQ5YtmodVmWNxm4QJS+OfEyZ+Yx0rDQby2
         gnj1ZAjcG7OI7VSuae91ptxx0prbKEh6VLzS2BftpTlOw7ct6KvfS89UEMgXf3CKrAUm
         VaSB94oa9pL4apBBZkcMyNzGYnpzyBzTuQq30KTDOHMXp7Xb9c9oc9841+wEnQyr+ujd
         Q2anwrvnoScMKEKCNV3+pPM0tIGmNLbdiVFoc3Mc4Omod3QzKFB5m7AZ+WgiGgw39cIs
         N8SknDNp4z08kAzx0YLMPgaREHUUUqxXxTMX9u3ky5Xw4RULICCNa2aGIxbU5/gx3dQE
         NTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=5N6LdOFrJjCGue8cmzcmZMQF0A64ylNe67FM2v5UYwc=;
        b=SpOxchHs9rdCAu3LH9DQW2v2Cxp5AmuCUZN8MViKL0cH7zHJeWYR49cPKOn3iOrP7m
         9XZ1B/T050pvV4s4XDtAvKnfg4UxDQRqtrfHR8mARIfc0Wc+52sSS8OC+M24qi/TMPor
         4V8bGUXS2nuwr0Ly0t6p16iYxmff6z4LqucdrC1t/Bubm5sFEDPEmpmw9RkGjmo13KU2
         2Kf5qbUAwskIm7cLN/Izs3/BZXRkWXye+/Xz3sIDollCdMIIoHHT6KoZLyj466kdNNh8
         8pl0NZiuWQx0KzHW3Xdb1CL71Iwt0A4szuWELWRiKowZ5daxEYEZxxRT4y06WCl9+wnJ
         jr1w==
X-Gm-Message-State: APjAAAWsdFB5mZ7VySwrSTcwvhZEDl2jzsDGg2RdT0+dwR6gNrf6groi
        ZF9aG5bRyvM8U86zPLpcjVg=
X-Google-Smtp-Source: APXvYqyUkjtJ5/kr1NKh5evL+FbdXcRYyIgbQbmLhNrEiZG/igGdTIgx+LqU2x5WMPCYNej1LAZAWw==
X-Received: by 2002:a63:f807:: with SMTP id n7mr57629925pgh.119.1563566564159;
        Fri, 19 Jul 2019 13:02:44 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id c8sm37375979pjq.2.2019.07.19.13.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 13:02:43 -0700 (PDT)
Date:   Sat, 20 Jul 2019 01:32:35 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     jhubbard@nvidia.com, ira.weiny@intel.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, Matt.Sickler@daktronics.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v3] staging: kpc2000: Convert put_page to put_user_page*()
Message-ID: <20190719200235.GA16122@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been issues with coordination of various subsystems using
get_user_pages. These issues are better described in [1].

An implementation of tracking get_user_pages is currently underway
The implementation requires the use put_user_page*() variants to release
a reference rather than put_page(). The commit that introduced
put_user_pages, Commit fc1d8e7cca2daa18d2fe56b94874848adf89d7f5 ("mm: introduce
put_user_page*(), placeholder version").

The implementation currently simply calls put_page() within
put_user_page(). But in the future, it is to change to add a mechanism
to keep track of get_user_pages. Once a tracking mechanism is
implemented, we can make attempts to work on improving on coordination
between various subsystems using get_user_pages.

[1] https://lwn.net/Articles/753027/

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matt Sickler <Matt.Sickler@daktronics.com>
Cc: devel@driverdev.osuosl.org 
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
Changes since v1
	- Improved changelog by John's suggestion.
	- Moved logic to dirty pages below sg_dma_unmap
	and removed PageReserved check.
Changes since v2
	- Added back PageResevered check as suggested by John Hubbard.
	
The PageReserved check needs a closer look and is not worth messing
around with for now.

Matt, Could you give any suggestions for testing this patch?
    
If in-case, you are willing to pick this up to test. Could you
apply this patch to this tree
https://github.com/johnhubbard/linux/tree/gup_dma_core
and test it with your devices?

---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 6166587..75ad263 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -198,9 +198,7 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 	sg_free_table(&acd->sgt);
  err_dma_map_sg:
  err_alloc_sg_table:
-	for (i = 0 ; i < acd->page_count ; i++){
-		put_page(acd->user_pages[i]);
-	}
+	put_user_pages(acd->user_pages, acd->page_count);
  err_get_user_pages:
 	kfree(acd->user_pages);
  err_alloc_userpages:
@@ -221,16 +219,13 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 	
 	dev_dbg(&acd->ldev->pldev->dev, "transfer_complete_cb(acd = [%p])\n", acd);
 	
-	for (i = 0 ; i < acd->page_count ; i++){
-		if (!PageReserved(acd->user_pages[i])){
-			set_page_dirty(acd->user_pages[i]);
-		}
-	}
-	
 	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
 	
-	for (i = 0 ; i < acd->page_count ; i++){
-		put_page(acd->user_pages[i]);
+	for (i = 0; i < acd->page_count; i++) {
+		if (!PageReserved(acd->user_pages[i]))
+			put_user_pages_dirty(&acd->user_pages[i], 1);
+		else
+			put_user_page(acd->user_pages[i]);
 	}
 	
 	sg_free_table(&acd->sgt);
-- 
2.7.4

