Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE78C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D2B22C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/Voi5Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbfGYMoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:44:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45222 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387824AbfGYMoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:44:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so22981568pgp.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtTD1zW4DFFiIXNHW0lcZtx2P/QwbKs4fO50xTY7/Rw=;
        b=M/Voi5AdNRJuu0f0xVFvWhBGojmOjd9MpiuUS35IZonb5vauyAmAVyzUK52ayLrBN3
         SgiKz3juyYSfNnGjkkTgz45hx6I04HFDTNBTt5UcmCB10eN9SXlRz8/eDLc4EkW0+xea
         qo1zB+JSSfmtRWicQU+daV9QinrXpqhhLHr+xUIW8CaIOt43tAjHH7qysSd5oYOW6T9T
         2yf1t8gNceqUK0rD0LtilyNSrWzlAtQOEy8VPDKVPXoW7btTLsu5WKhZLl21/LpxSyWd
         7/BEc0333JvmoowXxOmujyOVAzCT4EcfNujLbgdwtJxCnHFPG6L1VN/dvmBYNBtSVDVa
         BKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtTD1zW4DFFiIXNHW0lcZtx2P/QwbKs4fO50xTY7/Rw=;
        b=Qs4thdMWMt8yDNqKx9mAMqhL5kV4/xFRzOEj7xOQFl2Ln8ii2fwioCqEs10gcWInm1
         Ef9uCM/BdRTsetjeRC6K57QBygSTz0DHmsRF2vq5TvO7N1/u10lu6o62KGFHPGG01OBH
         jQXtF8sLLnpvAtIqwX16TQqhWKC6pW3SrZfjtnjK4uE2E47tB/JAhMucnsZXRkA4ue+s
         gsFCPIKqrd53gwk+yErYVwLHQQqbuEtz7dR/vTYMfoIE+9UR+WWkMUuFUpDd+65yEg9u
         ayul3Tth0kuCeimn+Mys9Q70FPf0kU+/aIEHSLykyy+qAtFL/wxq95JHmREca7zsa7e0
         d5eQ==
X-Gm-Message-State: APjAAAWr4lWRTHUZ0+2UI5wAtvwACj12Yyh272gxgD/BIVLR2tQfEuQZ
        73tql6b1Ad8+vvb/03qNilE=
X-Google-Smtp-Source: APXvYqw8t1BcANx6QWJK3Ufj5nZnJSHUkXSuUFta0coSy0Mzsvx9vA+JC+8xkN6Rom4g6ZLvZYhrkg==
X-Received: by 2002:aa7:8b11:: with SMTP id f17mr16520924pfd.19.1564058671500;
        Thu, 25 Jul 2019 05:44:31 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id 195sm86924983pfu.75.2019.07.25.05.44.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 05:44:30 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org, Matt.Sickler@daktronics.com
Cc:     Bharath Vedartham <linux.bhar@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4] staging: kpc2000: Convert put_page() to put_user_page*()
Date:   Thu, 25 Jul 2019 18:14:18 +0530
Message-Id: <1564058658-3551-1-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

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
        - Added back PageResevered check as
        suggested by John Hubbard.
Changes since v3
        - Changed the changelog as suggested by John.
        - Added John's Reviewed-By tag.
Changes since v4
        - Rebased the patch on the staging tree.
        - Improved commit log by fixing a line wrap.
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 48ca88b..f15e292 100644
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

