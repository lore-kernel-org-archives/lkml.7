Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81349C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7C22171F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSaOVEZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbfGOVtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:49:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46142 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732378AbfGOVte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:49:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so8944143plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=oinAVDdEDGtey1Xr7e/GPvK2Adfq62yyiXEFUaR6hwI=;
        b=lSaOVEZxxYEquXCqQBG9SYGwG6t1vNg5IwoDUHqEvVIVJhOJlwBY9FugfmiKkRP4f9
         bXyF67J6jg2jl8nfMgv1KWkCx6N17R7M+dlEe5Z43adeIJaqjWjFfqTiLZUywXyLNHlK
         7MYSlSRi8Y0ZlGG9OjlxUoyEB5dRd33OkmEmCOeSVcrNzEnaZhjMNtoQ5rp+VHiYpo8l
         5OXqZqytZ+NvLskxl+Sy/353FjNs/uWn8ngNxEqq1K84N7F4EHUaX51GrZVgm8AqHYmG
         BNOH1MlAf/PKQmF3h2Y1vn/leJyYbowl0Kt6aloRxdGUd1csJequKM4S+3/jQc8TzyeM
         8TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=oinAVDdEDGtey1Xr7e/GPvK2Adfq62yyiXEFUaR6hwI=;
        b=FnghWjsMY48mSIqdt/QPup/jv/Nyz9vGkOn4FVZkmyY+pZ+WwP2Kk+Q+MiFFBwC8f1
         JIR/4sLDKpU/iuMXH2U6Mcy6HNogSvpONmS5Pg/giTrrmu7qgFiL13V1oSUflYc6xCeS
         Y9cbDNVTwF8Lp31NW2o8pe4If1/GfwDCbSxZGW6WxKyN6CeaMfjow1wa60jCMuITNwpF
         DBkLJZILekFsscq3eetaI7PQRYgOy+qHWsOcX7sVR+itLqzTa2gjNJof/KflcqhlvEqp
         DolmeXklnGfwi2U+Ar6/JBanbxE2o7ZXsG9fhvt3qCESq4GUmazjC8LR6u5s8Su8Pf3S
         90+g==
X-Gm-Message-State: APjAAAUdX34Of3uZ6BTfvatzEgI3ISJwf31FORBekHsarbbSjarXDphN
        ak4Rv2lJc3q8VFRerxK57xQ=
X-Google-Smtp-Source: APXvYqxWZCB5othLdOpAzVbLNid2vDo95VYJQsCqTTyT13mpLHDfYQvvAWW2OmRXbPSMrSLgUWUbVg==
X-Received: by 2002:a17:902:a606:: with SMTP id u6mr28487937plq.275.1563227374215;
        Mon, 15 Jul 2019 14:49:34 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id b3sm27375833pfp.65.2019.07.15.14.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 14:49:33 -0700 (PDT)
Date:   Tue, 16 Jul 2019 03:19:26 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Matt.Sickler@daktronics.com, gregkh@linuxfoundation.org,
        jglisse@redhat.com, ira.weiny@intel.com, jhubbard@nvidia.com
Cc:     linux-mm@kvack.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: kpc2000: Convert put_page() to put_user_page*()
Message-ID: <20190715214926.GA29665@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been issues with get_user_pages and filesystem writeback.
The issues are better described in [1].

The solution being proposed wants to keep track of gup_pinned pages
which will allow to take furthur steps to coordinate between subsystems
using gup.

put_user_page() simply calls put_page inside for now. But the
implementation will change once all call sites of put_page() are
converted.

[1] https://lwn.net/Articles/753027/

Cc: Matt Sickler <Matt.Sickler@daktronics.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org
Cc: devel@driverdev.osuosl.org

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
Changes since v1
	- Added John's reviewed-by tag
	- Moved para talking about testing below
	the '---'
	- Moved logic of set_page_diry below dma_unmap_sg
	as per John's suggestion

I currently do not have the driver to test. Could I have some
suggestions to test this code? The solution is currently implemented
in https://github.com/johnhubbard/linux/tree/gup_dma_core and it would be great 
if we could apply the patch on top of the repo and run some 
tests to check if any regressions occur.
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 48ca88b..3d1a00a 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -190,9 +190,7 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	sg_free_table(&acd->sgt);
  err_dma_map_sg:
  err_alloc_sg_table:
-	for (i = 0 ; i < acd->page_count ; i++) {
-		put_page(acd->user_pages[i]);
-	}
+	put_user_pages(acd->user_pages, acd->page_count);
  err_get_user_pages:
 	kfree(acd->user_pages);
  err_alloc_userpages:
@@ -211,16 +209,13 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 	BUG_ON(acd->ldev == NULL);
 	BUG_ON(acd->ldev->pldev == NULL);
 
-	for (i = 0 ; i < acd->page_count ; i++) {
-		if (!PageReserved(acd->user_pages[i])) {
-			set_page_dirty(acd->user_pages[i]);
-		}
-	}
-
 	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
 
-	for (i = 0 ; i < acd->page_count ; i++) {
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

