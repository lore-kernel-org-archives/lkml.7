Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E83C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADB721994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uG2RJ7Gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfGZTdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:33:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43657 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfGZTdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:33:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so25215451pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZMz7g4AgOx4LjZHETS+rUqwaKxF1Ur0tqe/gkV6SSF4=;
        b=uG2RJ7GxHf4F+PsfSrFEhcOkc2xWKqke5LuZRx6/qKaSwdfHs6DjIyXZO9JXBOoPSE
         qTzga2sI5ee1q9lxd/t9Le0lCRQLiX1u4l8CmEUAOwx/dH3FJk9OF4Nha7sl8YiEfvXX
         6vxjcngCvqTmv1cKRwZ6f6IZjcN5XsDXJzPyc+ZHHiXvh9haUO/0+cP6jQnDs6H/H9ri
         mOZpZU4W/hLTXzjv2qqfrAFbPvvnL9k0pRhgL8CS4zVhB3Qai1T2nlsEfqge3tLwOaGq
         JCsvg7I0SeK5/yag8/OTLe7t2axSgbBrTcZv2MXz6TJXJdkhfiycySfZaHklKkTsyTud
         1/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZMz7g4AgOx4LjZHETS+rUqwaKxF1Ur0tqe/gkV6SSF4=;
        b=fVtAaO0vYQgYios72B4NReLmwJ7Ba/y0nPoldXdlsTzc65ZWSt5+Yt2wCU3/d/BUXO
         7Ss43xdxIPSX1oCSbAsdrfOH+nkshXRIqs2VjxSmH66ls6bF2eEEPhLjxET8WV+Cyl7j
         a2MxIEyuiYTXpCWOBx/P7GOCP5EJnv8AovqyXVJlpHBgINbjR6fUtZh8zAC68Sb1TUQQ
         peJrL8PFSANohrfBkllICe6c1OKUQTnYKNDD03BXZBneU1Y6W1OcTGSJodF6IrP+juMI
         zAQcz4YsOp5UvpL+Ifnf23dBFiboTeK/Njmjf6HdGaXtJe+AVGuq1HU1k9E6wY5KgEoL
         9HSg==
X-Gm-Message-State: APjAAAWfVDdf7DZHv0TQfCkUvxAIrcP3UPkAjZ59QaIL2wfHMxH3oV3p
        9oIeQbamz2nxu2gwx5oZ9u4=
X-Google-Smtp-Source: APXvYqyKxFEnr0gqZJeRO17PpLeXYBGDPQWOCOfthfDDs5T0J+tdcUSxbOoA/BHuesiqS6HFfqyojg==
X-Received: by 2002:a17:90a:9301:: with SMTP id p1mr99375409pjo.22.1564169631701;
        Fri, 26 Jul 2019 12:33:51 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e189sm31824212pgc.15.2019.07.26.12.33.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:33:50 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     dafna.hirschfeld@collabora.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dma-contiguous: do not overwrite align in dma_alloc_contiguous()
Date:   Fri, 26 Jul 2019 12:34:32 -0700
Message-Id: <20190726193433.12000-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726193433.12000-1-nicoleotsuka@gmail.com>
References: <20190726193433.12000-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma_alloc_contiguous() limits align at CONFIG_CMA_ALIGNMENT for
cma_alloc() however it does not restore it for the fallback routine.
This will result in a size mismatch between the allocation and free
when running into the fallback routines after cma_alloc() fails, if
the align is larger than CONFIG_CMA_ALIGNMENT.

This patch adds a cma_align to take care of cma_alloc() and prevent
the align from being overwritten.

Fixes: fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
Reported-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/contiguous.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index bfc0c17f2a3d..ea8259f53eda 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -243,8 +243,9 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 
 	/* CMA can be used only in the context which permits sleeping */
 	if (cma && gfpflags_allow_blocking(gfp)) {
-		align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
-		page = cma_alloc(cma, count, align, gfp & __GFP_NOWARN);
+		size_t cma_align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
+
+		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
 	}
 
 	/* Fallback allocation of normal pages */
-- 
2.17.1

