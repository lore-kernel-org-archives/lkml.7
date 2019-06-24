Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B90AC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443302133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OktZxb05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfFXFJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 01:09:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45983 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfFXFJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:09:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so6784388pfq.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 22:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RVY6qs2x//IRTjLWtMXFvlJbom1+urYYXoetqrm4oak=;
        b=OktZxb05cA7jjdGotH5tWVi83rtdPg2lTEu1k0I13JUX5Cc7oGckdphOhmpETppIb/
         WB/nd70i7joZsf6C/aoyjZglz4U0O2MHKtslPtrOacDf62vt9arL/Xbsjdb1f3l2OFUk
         3bxvKb5zxBiSlia5bPgqP9/KmXTja+33FG2v/pZkgYSjv0U+SWbH/m3AbG2o5D/GLLQB
         oAmRI6J8U8i3xHTTAMItZu79RJGBTeEDMaxcSXJEeiX5AGwjXJY9N3gBuieoajvHr/fX
         R2UaNd/OCfk5AWAyMp77ZYZbYxaJ+tpVQD29b+5JU0/t1nzV6evqaSGn82ke1Agb20RK
         pN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RVY6qs2x//IRTjLWtMXFvlJbom1+urYYXoetqrm4oak=;
        b=YHObqX8ZYgLqnEfxD8VXNDq83YtiOC3wjNuHPLPFLsujo1CuDsjfJGNBw/pgo+P/ho
         E1r07n766L+xCNUeKOTMmFAPxRDM4Xd2qg9gysDfUDfilmte+jntEfDWfFq/zdaoYT/m
         JJzecknUklzaSu657dxY41zcVGRDmCcvUmFA+5QEBfdTouKItwH+rPlNFAepi8bCCxUC
         ru7X/8ATeRpazZDLpSXqpR75QoAzvzcYINnFr1HGEB+hglamcQBuOBRvzMT0ptmJU2uf
         zG8GiU+icFYtZe9lcLzC4Fie+9+pOpO9bizjS7oua+kKZ7vEpc1CzljIIg/bppZQt1bx
         JMyQ==
X-Gm-Message-State: APjAAAX99/8S/0rCznIuLzUmklh3yjlH+5o3G9c6ZlX5cK5Iaj5q8Rtj
        kq4t5E3bGdma5xCBSvVID/M=
X-Google-Smtp-Source: APXvYqyhniW0jG8SeU16sLDlT8V11Ngp3qjDdLAvp2SYBIu1uSNmdXDBP623duvkPM2tJ6jFh/QtkA==
X-Received: by 2002:a17:90a:2385:: with SMTP id g5mr23132372pje.12.1561352989891;
        Sun, 23 Jun 2019 22:09:49 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id e63sm17545179pgc.62.2019.06.23.22.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 22:09:49 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     akpm@linux-foundation.org, urezki@gmail.com, rpenyaev@suse.de,
        guro@fb.com, rick.p.edgecombe@intel.com, rppt@linux.ibm.com,
        aryabinin@virtuozzo.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH] mm/vmalloc: fix a compile warning in mm
Date:   Mon, 24 Jun 2019 13:09:37 +0800
Message-Id: <20190624050937.6977-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/vmalloc.c: In function ‘pcpu_get_vm_areas’:
mm/vmalloc.c:976:4: warning: ‘lva’ may be used uninitialized in
this function [-Wmaybe-uninitialized]
insert_vmap_area_augment(lva, &va->rb_node,

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4c9e150e5ad3..78c5617fdf3f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -913,7 +913,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
 	unsigned long nva_start_addr, unsigned long size,
 	enum fit_type type)
 {
-	struct vmap_area *lva;
+	struct vmap_area *lva = NULL;
 
 	if (type == FL_FIT_TYPE) {
 		/*
-- 
2.18.0

