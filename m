Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC0EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE8520872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+5l6dnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfDPLrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:47:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43278 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbfDPLrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:47:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so10208133plp.10;
        Tue, 16 Apr 2019 04:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=n/NDS47nz9uuNytg4LeJJ+li959uQqsTwzm1mhrxiWA=;
        b=G+5l6dnjc7/uWHI49g5xNQ2VmQniZgrpDhtRlmcY+E3Z7ocVubcskS2MrTMRU9ZU1N
         L0ULzCh7L5KPDeVBbv3aI560DkAoMSHXT8dUm7C87hk2rUJYuZjB2G4yctoncZH8pt8T
         pH8fBdXKGlqeyQtXK33z7+r6JJdj8JD8M2WURaPvOg1JOtMj1vqV37D3kv/8KcRwNk9w
         o1d45pjV17t0tKE7c3wu7swo2BTkJ5qq3mPBKXgANsJyDy8TaZkptEOEnjJW3sUylrgB
         WWAIvs6OK4hoNr5DfAjomWAvTR66t3MVa9o0AY56ghuFufEyHnfQLWCwrELKiWG9EtlG
         4vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=n/NDS47nz9uuNytg4LeJJ+li959uQqsTwzm1mhrxiWA=;
        b=TA4xj7+/W1UxoCJ0/1QQfAL4ghAF/cQe63RNZwG+3hCEkxUsL8BJTR95R5N0LsVQNx
         LOSqBeCy74ygeangok9PLNZEDs6bT7Sv1sVnnUHH68EJH+aWb38SmvpqgDKIxgojxcN6
         BH7NvepfQw/aLjukhdWPEq8sw/Z+v/qhi9EY8dQVeHfwx7uUXgirumkYFlBdREyh0WGt
         wgBoIQn5IzwzCotWJbnl7Gwr4SdEgX1BRBMoSK1BB/LtaMBCLqQip3wjw8MjYJcZmAPk
         7nRpuGjPekIQ+KA12gY03R06/sjpmsENGNWPM9l3snABqv/vIoWRDSQ1AC3uxvKzDTAR
         tQ0Q==
X-Gm-Message-State: APjAAAVyfeni0m36Oavj+4hB16Q1UftCUqmaily1eZQ45UrW4EkXpCj7
        yunz3b7A79MeKjvcXyIlOxo=
X-Google-Smtp-Source: APXvYqz4waYiopA3l3q+r1qCFeqwSh3ZXJMr5uwqp8r036DYgcWkcY5QNT6ibdt+RI1A+3hXGE7RDg==
X-Received: by 2002:a17:902:b210:: with SMTP id t16mr76931088plr.84.1555415272752;
        Tue, 16 Apr 2019 04:47:52 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.11])
        by smtp.gmail.com with ESMTPSA id p6sm55942835pfd.122.2019.04.16.04.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 04:47:51 -0700 (PDT)
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
Subject: [REBASE PATCH v5 8/9] xen/gntdev.c: Convert to use vm_map_pages()
Date:   Tue, 16 Apr 2019 17:19:49 +0530
Message-Id:
 <88e56e82d2db98705c2d842e9c9806c00b366d67.1552921225.git.jrdr.linux@gmail.com>
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
Message-ID: <20190416114949.IriRKxpAeJXsUkH7hIQA6h6wH62Kqd6458itbcZ0JXk@z>

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

map->count is passed to vm_map_pages() and internal API
verify map->count against count ( count = vma_pages(vma))
for page array boundary overrun condition.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/gntdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 5efc5ee..5d64262 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -1084,7 +1084,7 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 	int index = vma->vm_pgoff;
 	int count = vma_pages(vma);
 	struct gntdev_grant_map *map;
-	int i, err = -EINVAL;
+	int err = -EINVAL;
 
 	if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
@@ -1145,12 +1145,9 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 		goto out_put_map;
 
 	if (!use_ptemod) {
-		for (i = 0; i < count; i++) {
-			err = vm_insert_page(vma, vma->vm_start + i*PAGE_SIZE,
-				map->pages[i]);
-			if (err)
-				goto out_put_map;
-		}
+		err = vm_map_pages(vma, map->pages, map->count);
+		if (err)
+			goto out_put_map;
 	} else {
 #ifdef CONFIG_X86
 		/*
-- 
1.9.1

