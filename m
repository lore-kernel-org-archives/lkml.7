Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB2CC76196
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 17:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061122183E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 17:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZwHW5P5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfGTRcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 13:32:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37158 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfGTRcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 13:32:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so15504397pfa.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 10:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=TdusF53r7yLCmYFWdH2/Tx4Y0JTP7HLyZW39DsqTHPo=;
        b=jZwHW5P5iF1JlnF80DO5TcIm6+g+ZDUG5S+6/RgtYHw6KLyFLYlVXEl9Z9sEeemBht
         AYzMVLvL3O1rDCMBLgk5oQsBWzZVN5hNiP1d1yvkc+hIb1SfYyj77grFFke4jf+M89gj
         gOXjKJddqkWZIG4l07gU+qGnKbvmbTwg7jyMy1DL01btiBLhboZzNa0mKZWxEczosnB7
         sQgcWCSGwoPOHdX1Ks41hNOl72N9rUE0sMXRSbhtDPDgbglGRTOaR/Xz9OkRXIvF7k0b
         Ah/g+c3esfGzqVES5VRKtJ7p4pPfjSTa2Sb5eLncBfFh4LSw1n8fk72XKKx/03e+N6Aa
         LmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=TdusF53r7yLCmYFWdH2/Tx4Y0JTP7HLyZW39DsqTHPo=;
        b=KwRxIL7PmYqg0tcssaSgICAZx07rhESzYlKOsktoQ3ASdi6oq3Dh3Rx2VEhmuixPMy
         vaJv74pknA99sGlCbyLbKv6fNdwl/Rv8MrzkKGujGUEC42hIHsUnhzsrBjJybOHQwwAg
         4A3kSyA9wj9OySLK+AekXE8D91YHbi6wYpjBQcYeFcJcuacUQ2n+Yl9ZjCnMctS57xOq
         hLN2zX3NM0hvH3E1oNxuG3xFeSYvgvKKAODxTKFypfb9cFWIqD8Gl4oJvdSDoabBMlz/
         XuCG+ZtrfrPgF7Q2l/wCys3dOA6kxA2JtpHiC3dvSA2Pz037TXTy15DHYvuHqbK7d7D4
         mbSA==
X-Gm-Message-State: APjAAAXP/3NRHHXViuvKJHegfzfC1zj6WqHWYEHYSd9lV1+R9pXtEPz6
        /peS6RSzButgoI2a10XJsYbRiuVl
X-Google-Smtp-Source: APXvYqy1NouX9k2wgafeV1ABXeztSNXyhgk4bnippRUInrONZlwFZn4ypyphRPbcnEpCMfQ+hVo6tw==
X-Received: by 2002:a63:3805:: with SMTP id f5mr28163350pga.272.1563643941385;
        Sat, 20 Jul 2019 10:32:21 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id l44sm30570928pje.29.2019.07.20.10.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 10:32:20 -0700 (PDT)
Date:   Sat, 20 Jul 2019 23:02:14 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     ira.weiny@intel.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, Matt.Sickler@daktronics.com,
        jhubbard@nvidia.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux.bhar@gmail.com
Subject: [PATCH v4] staging: kpc2000: Convert put_page to put_user_page*()
Message-ID: <20190720173214.GA4250@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d ("mm: introduce put_user_page*(), placeholder versions").

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matt Sickler <Matt.Sickler@daktronics.com>
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
Changes since v1
       - Improved changelog by John's suggestion.
       - Moved logic to dirty pages below sg_dma_unmap
       and removed PageReserved check.
Changes since v2
       - Added back PageResevered check as suggested by John Hubbard.
Changes since v3
       - Changed the commit log as suggested by John.
       - Added John's Reviewed-By tag

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

