Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05020C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76732082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256845;
	bh=5UBgb3ucyPTecMIazajYjVh/VbUOtV54elSjJEHVjjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qrlJCNxJuo34TtYezLi8qisnA7TOlKha6hxG+ucIFqTOUcKh6Au63L7ilaVfzGvs1
	 ehw4jgB+H41eB0ekxtBGzXbav07Otf4bMOxxquenpjJVm5f22DvRbGUhxfeROMhKi3
	 5TLvnq4/eM7+B/UZseWkOsUiwpRRomwdESAkhvdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389848AbfCVMOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389637AbfCVMN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:13:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BF6820830;
        Fri, 22 Mar 2019 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256838;
        bh=5UBgb3ucyPTecMIazajYjVh/VbUOtV54elSjJEHVjjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7qBTbsK1dHLxHaHYc3h7rcKrdomJvO4XEBEkMmB9NLnIvadOZc3ENkKG0marA3ZX
         bgnCkBQBLn3HZ+8ua3vPE17lNqnro0Y4QIgPwiwuHcGbw3ZpKfLWYW/6pgg9ukp8Qe
         4k0KaNZC1VNx143+WL2vBcOEpbGBM3yNCtgbDvkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.0 051/238] CIFS: Fix leaking locked VFS cache pages in writeback retry
Date:   Fri, 22 Mar 2019 12:14:30 +0100
Message-Id: <20190322111301.438582621@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Shilovsky <pshilov@microsoft.com>

commit 165df9a080b6863ae286fa01780c13d87cd81076 upstream.

If we don't find a writable file handle when retrying writepages
we break of the loop and do not unlock and put pages neither from
wdata2 nor from the original wdata. Fix this by walking through
all the remaining pages and cleanup them properly.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifssmb.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -2125,12 +2125,13 @@ cifs_writev_requeue(struct cifs_writedat
 
 		wdata2->cfile = find_writable_file(CIFS_I(inode), false);
 		if (!wdata2->cfile) {
-			cifs_dbg(VFS, "No writable handles for inode\n");
+			cifs_dbg(VFS, "No writable handle to retry writepages\n");
 			rc = -EBADF;
-			break;
+		} else {
+			wdata2->pid = wdata2->cfile->pid;
+			rc = server->ops->async_writev(wdata2,
+						       cifs_writedata_release);
 		}
-		wdata2->pid = wdata2->cfile->pid;
-		rc = server->ops->async_writev(wdata2, cifs_writedata_release);
 
 		for (j = 0; j < nr_pages; j++) {
 			unlock_page(wdata2->pages[j]);
@@ -2145,6 +2146,7 @@ cifs_writev_requeue(struct cifs_writedat
 			kref_put(&wdata2->refcount, cifs_writedata_release);
 			if (is_retryable_error(rc))
 				continue;
+			i += nr_pages;
 			break;
 		}
 
@@ -2152,6 +2154,13 @@ cifs_writev_requeue(struct cifs_writedat
 		i += nr_pages;
 	} while (i < wdata->nr_pages);
 
+	/* cleanup remaining pages from the original wdata */
+	for (; i < wdata->nr_pages; i++) {
+		SetPageError(wdata->pages[i]);
+		end_page_writeback(wdata->pages[i]);
+		put_page(wdata->pages[i]);
+	}
+
 	if (rc != 0 && !is_retryable_error(rc))
 		mapping_set_error(inode->i_mapping, rc);
 	kref_put(&wdata->refcount, cifs_writedata_release);


