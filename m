Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3997BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2B92145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0+6yg5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbfGOTw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:52:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44622 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfGOTw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:52:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so8211178pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=VvTFFsjpspmxJg0Zk+lQCOkMvx372OdaubqDPGmaJoo=;
        b=Y0+6yg5uqNAPdQD+ah/uXtJodBiOu7qXGUZsamO3dQTNlZJzjg4Ek26PN9sH6cPymb
         yvR0TfhEiZSxvEWJREY4WRbKyM9hxRYvEyrRK+nFIVTjd5wGPQeM30hJAvFss33qjOr6
         a5lf0Z0h0i0GZU8VbvfaF5gPmTNLiJIByg5+vUiVbxaIVScuLtuDWJCmBENGOlV8KHVP
         myqNj9DcwuUhbVYJHd/itZBOFC97cVLWqm1lHnGNzPoaLmMwYpW6KTiRNUSyzsRHwMI3
         QJzx5hp785DtFA36ySOTX7rwRUUC/c5ya6BCZiOXxIALW7dYtFG/We6ISxZhV9/cZeit
         dtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=VvTFFsjpspmxJg0Zk+lQCOkMvx372OdaubqDPGmaJoo=;
        b=uoaGCteYa6dFKZaMV6+/tJ/OKO4m/UW6UtNkEFcpl00IYQwpdgujiGXw3UQLt9eHHP
         gqUAiV0NgAmsycf8tsyyc6r/yWrz/nJ+wXHh5kz6NmcfJZkRpirsETUNn/bRV9V6dWDA
         I+JhKUnWvTL948Pzsr6rG1ZqVrNsX35smr3PxGLdDh3xWsAWC0X7rbvcmTZbKcdhG1v2
         yA5YFv4a/rNLXlyCpMfUTiQenGyUreUZSaUfzJp1SNUqSjYAd7MPSjmsMYtEDX3GItTO
         5/Tdp6hyfIS/zBISCMS5kjDTclYF1zwDyCCPw5GjFiCiSnOzFFOFMXz/ls5UjVFbZG3t
         c1Vg==
X-Gm-Message-State: APjAAAWFV6ZJPeEFfvTa4w0XMWXaywMiaVWtf8U/vzXEUp1f14kmkwa4
        KCC360NzuNfqwqF9yomYbso=
X-Google-Smtp-Source: APXvYqxtbt1CwITtkPLgUNHbiaJHv2JbNvwx/AC2tPpYW32s+HW5FL1w8utKSmIMyppuIpJFC7FuGg==
X-Received: by 2002:a17:90a:5288:: with SMTP id w8mr31337291pjh.61.1563220377447;
        Mon, 15 Jul 2019 12:52:57 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id u3sm15869368pjn.5.2019.07.15.12.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 12:52:56 -0700 (PDT)
Date:   Tue, 16 Jul 2019 01:22:48 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     ira.weiny@intel.com, jhubbard@nvidia.com,
        gregkh@linuxfoundation.org, Matt.Sickler@daktronics.com,
        jglisse@redhat.com
Cc:     devel@driverdev.osuosl.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: kpc2000: Convert put_page() to put_user_page*()
Message-ID: <20190715195248.GA22495@bharath12345-Inspiron-5559>
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

The solution being proposed wants to keep track of gup_pinned pages which will allow to take furthur steps to coordinate between subsystems using gup.

put_user_page() simply calls put_page inside for now. But the implementation will change once all call sites of put_page() are converted.

I currently do not have the driver to test. Could I have some suggestions to test this code? The solution is currently implemented in [2] and
it would be great if we could apply the patch on top of [2] and run some tests to check if any regressions occur.

[1] https://lwn.net/Articles/753027/
[2] https://github.com/johnhubbard/linux/tree/gup_dma_core

Cc: Matt Sickler <Matt.Sickler@daktronics.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org
Cc: devel@driverdev.osuosl.org

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 6166587..82c70e6 100644
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
@@ -229,9 +227,7 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 	
 	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
 	
-	for (i = 0 ; i < acd->page_count ; i++){
-		put_page(acd->user_pages[i]);
-	}
+	put_user_pages(acd->user_pages, acd->page_count);
 	
 	sg_free_table(&acd->sgt);
 	
-- 
1.8.3.1

