Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02735C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D3D20835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwZwO/mg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfCSCWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:22:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35235 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfCSCWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:22:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id j5so12615970pfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+cqpEOgVsQX6FuKbkjkqnPdK6JJEhfhSEvMIkCtIVgk=;
        b=BwZwO/mgWw5cmeGQm07gg2bfziVPZ2aU3Vz8l9vhecEXfsRq1wSNLw5Tv+yoAr4k6e
         QfcEA2+DQTTXbDaHXA8Quutyc5CY8LDUaHkqOISw8iBUR/dvs0yFXwhZyT8R4RnRvaik
         KPtZ2hALQAlGX1QFF5QVZVR6tkmcCp+oX0SlhSzKvqSvm3PLsXqywOOy5EHyo8Pyx2vS
         odp83dilftZ3mXWQaGhoshFSyINw4LYI6tGaRywK7Dd11M80UdE4NViEOWK7UPfUzza2
         0y7QmRBNIAy3JVAQlWVVE/67nyWjwXO4GQ2vYciubrJBZZGh3pq7KI3y4a4NmMPx/ufi
         NXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+cqpEOgVsQX6FuKbkjkqnPdK6JJEhfhSEvMIkCtIVgk=;
        b=TTYrJ64XVq956/hApKkU/yVagxZz8HMJKbiIJDXWLVU83tWd7z/MRQCkHKueytjB4+
         +FNjkr1PsUgUe+RVYOn4ZCl9k07+YpV+jjosmmdShw3Ko3Y78n2hWq/ZE7YNh8ZYFRIS
         Px8piXFOmpCAf0e4lW+uq9tunybyeZuRXBM4yu5i80/s7KyQOiVos6Jz8YhooagqjRAP
         wW1w1cGxl44I6P4Xu8clhKclISJqX3TcTnDMKhYHu4J3JFqzqTTiRJ207vnLR+oioFex
         vpt1TabgVqEM7HLlmwXcbiP5lj+FNe7VQYPC+utU6EqvwzcwVE5D3dhWwnpJSGTtlxkX
         Pntw==
X-Gm-Message-State: APjAAAXN0oBsvxQbWtmMCBesaxnMuctBhDzg02xNMIO/IOXG/SU9z1tQ
        ZG6CKVJa2q1JvAvy84c9BfQ=
X-Google-Smtp-Source: APXvYqyDvI4zt3fFzBxE7EA/O8ssnYTAAyn+bRG1R0qqvVNexLq29fF+EGU3IMdTuIzc3YDUOwMWrw==
X-Received: by 2002:a63:6e8d:: with SMTP id j135mr20527765pgc.160.1552962124157;
        Mon, 18 Mar 2019 19:22:04 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([106.51.22.39])
        by smtp.gmail.com with ESMTPSA id i79sm24658598pfj.28.2019.03.18.19.22.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 19:22:03 -0700 (PDT)
Date:   Tue, 19 Mar 2019 07:56:38 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [RESEND PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to
 use vm_map_pages()
Message-ID: <7ba359eb1aceac388d05983c1f29b915bdf291f9.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

Tested on Rockchip hardware and display is working,
including talking to Lima via prime.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index a8db758..a2ebb08 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -221,26 +221,13 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
 					      struct vm_area_struct *vma)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
-	unsigned int i, count = obj->size >> PAGE_SHIFT;
+	unsigned int count = obj->size >> PAGE_SHIFT;
 	unsigned long user_count = vma_pages(vma);
-	unsigned long uaddr = vma->vm_start;
-	unsigned long offset = vma->vm_pgoff;
-	unsigned long end = user_count + offset;
-	int ret;
 
 	if (user_count == 0)
 		return -ENXIO;
-	if (end > count)
-		return -ENXIO;
 
-	for (i = offset; i < end; i++) {
-		ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
-		if (ret)
-			return ret;
-		uaddr += PAGE_SIZE;
-	}
-
-	return 0;
+	return vm_map_pages(vma, rk_obj->pages, count);
 }
 
 static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
-- 
1.9.1

