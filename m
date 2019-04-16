Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A2BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1E620870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlNJmhvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfDPLsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:48:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36919 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfDPLsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:48:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so10228457pgc.4;
        Tue, 16 Apr 2019 04:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=F9hIq6OqtC1SVS2O3U7ZkPoLnNclA70DsapCWy7Q+lE=;
        b=RlNJmhvPVJ3UxKO1l98lIMDXQUnrSkDMLarOhFladUUf3Fd2LaDOG6+U01Z2z+YiG6
         sNYefT86LOIxnqlnmYbZyAcDruQYSCoLZfKjsI5qTBm4ikzvhilXTlPgz8vD0vD1p4zp
         nUgSswnCr91BRUTNAb6b5zyVdAQ+av7Sc02gJFy++x4EdGU7Ba+eVKI/tSv7RiqlDMKy
         SLqyqJH65OUoe0UtHrsN3h68RjIqxVfa3ycMpFEZs+Uo8eJrS3RcKM40edoCs9WmwoYn
         teADUMkiqANnatUpNqvAlG9eQwygGnntxE0k2iDAigCWgYcsyUHjVSZh8cAxSeXbIBT7
         1ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=F9hIq6OqtC1SVS2O3U7ZkPoLnNclA70DsapCWy7Q+lE=;
        b=U/azVyU03cCV7FyH23v4DcY7Alkt01yfwKwrvEBfcewV95PIouBlqS5omAEtenRFMV
         7CXrnuycyGSkxAre7oKB3cWxOg+/hxjbtPSMu1tejUILrDWFAFbXy4swQOK/pnsHMicm
         pKqNq2+gHj5cClFBXUPps7GSUwAIRDySfPkIjTvnzeWcCPaw2Y5aziQYNdz5JcR9RplM
         uHU7chpE6XsEYZ8epRQAax1hwlJbyJm1yOQRn13A1NW8jRQykeUgeSxQMfEmyMkV7gRk
         xIL/h+kDZqwi40iwjyg9yy5B/fccO8FkIb3YqeRUF0vg5NVUJeioEUXMj2nLmeJiw3xU
         I01Q==
X-Gm-Message-State: APjAAAUiPQjyQvhhRI4SXtPB0VWsjT5st4OAsxlI4yKykMAVbA4Yz+eI
        JSmwSo0rQEM0B85iazgrvS4=
X-Google-Smtp-Source: APXvYqx2gh4QQGIyXcsK611dByHpjpx+tKjskfqa9rV5hBQis2QAQtHs+h2xQ6nYUrNHQ3rVd4NVTA==
X-Received: by 2002:a63:f115:: with SMTP id f21mr70665089pgi.65.1555415282264;
        Tue, 16 Apr 2019 04:48:02 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.11])
        by smtp.gmail.com with ESMTPSA id p6sm55942835pfd.122.2019.04.16.04.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 04:48:01 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com,
        sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com,
        peterz@infradead.org, linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com, stefanr@s5r6.in-berlin.de,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [REBASE PATCH v5 9/9] xen/privcmd-buf.c: Convert to use vm_map_pages_zero()
Date:   Tue, 16 Apr 2019 17:19:50 +0530
Message-Id:
 <acf678e81d554d01a9b590716ac0ccbdcdf71c25.1552921225.git.jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416114950.gVSZZKh8NOY13wFCg-fm0gWWyU4S90gsZNsWDygvxUA@z>

Convert to use vm_map_pages_zero() to map range of kernel
memory to user vma.

This driver has ignored vm_pgoff. We could later "fix" these drivers
to behave according to the normal vm_pgoff offsetting simply by
removing the _zero suffix on the function name and if that causes
regressions, it gives us an easy way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/privcmd-buf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index de01a6d..d02dc43 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -166,12 +166,8 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma_priv->n_pages != count)
 		ret = -ENOMEM;
 	else
-		for (i = 0; i < vma_priv->n_pages; i++) {
-			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
-					     vma_priv->pages[i]);
-			if (ret)
-				break;
-		}
+		ret = vm_map_pages_zero(vma, vma_priv->pages,
+						vma_priv->n_pages);
 
 	if (ret)
 		privcmd_buf_vmapriv_free(vma_priv);
-- 
1.9.1

