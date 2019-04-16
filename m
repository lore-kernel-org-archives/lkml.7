Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342AAC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047D12087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU96DRv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfDPLrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:47:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40463 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfDPLrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:47:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so10222508plr.7;
        Tue, 16 Apr 2019 04:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
        b=cU96DRv2ov3f6Cd6NK8xcTZ/pxd6ORU1P19E6pQIz3B49Xye1iNecd9iNZibBfJcjQ
         zuIvUPJ+CLar5CQjZRDX3VQ1TZCDeFWlILHsb8dRJWggD00EqzXEkyE8uJG1kMP2eIvp
         n24W6tCY3AanegajVewju3yYDXmhf0X9II/qFV5HCylGUkejdXzo9E/koqfyqUqq8zr9
         mW/ZBFGmtcso0v4QTX5OavZW9KBMU22Tan8pYhZR4Ld+BqKTsHamZTqQU3PDd55gPcFI
         MsgxhBrhXIs5Fh8xdDdB8AJYcTdBC4NqYXVKmPD9APCljql55oe+X1QMkhe2S4UTALoW
         5KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
        b=fiUXcVlwFy+SyOiTggObEjB40RVf1GEu1PEt/3SlbEcG0zBCAqO01M0vemv2jmlB1I
         y/ZID8JVzhN/6gJpW4lX85dyG5cCzYh+1cjHD/OqxgAod2tweBAQsg0icy6iCOb55wBf
         Oyo8N51nY0G29m3PmAEhvUDikjeSLfmLpxG4tBhmdUx47kY6LN8tS7TAHsnhKAqbWHDe
         fOxGkfJ00oKYVt2zJ3uXQE8vAGadbiBey3vC2iKJ0+2sgzjS8fnjoU8WmGvWXmFn49ui
         +mVSzpicuz5Ko+ftMWBKMkrwtpyteuHXqs+rkzt5WKTtoSm+9z83IvlnWlB3Q92lm0lz
         0DSQ==
X-Gm-Message-State: APjAAAWFsJWuSwpfCz4sEtrixzVxMwPbw3nOHNKgq9jqRVHWhOR45hYQ
        uLIgBnzgXMM0sl0kTKUlJnw=
X-Google-Smtp-Source: APXvYqzDjDcAV7GNAw1BnDNouVWt6jT57KNhFlyZntYAXIOvC1nqtveURqFOLb2rK8ycg0MhFKUzow==
X-Received: by 2002:a17:902:d24:: with SMTP id 33mr83552990plu.246.1555415224705;
        Tue, 16 Apr 2019 04:47:04 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.11])
        by smtp.gmail.com with ESMTPSA id p6sm55942835pfd.122.2019.04.16.04.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 04:47:03 -0700 (PDT)
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
Subject: [REBASE PATCH v5 3/9] drivers/firewire/core-iso.c: Convert to use vm_map_pages_zero()
Date:   Tue, 16 Apr 2019 17:19:44 +0530
Message-Id:
 <88645f5ea8202784a8baaf389e592aeb8c505e8e.1552921225.git.jrdr.linux@gmail.com>
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
Message-ID: <20190416114944.T-xqlQGxfLfUBgpsyFH2RrzMnRNBUr9-I5c9dm6R-ME@z>

Convert to use vm_map_pages_zero() to map range of kernel memory
to user vma.

This driver has ignored vm_pgoff and mapped the entire pages. We
could later "fix" these drivers to behave according to the normal
vm_pgoff offsetting simply by removing the _zero suffix on the
function name and if that causes regressions, it gives us an easy
way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/firewire/core-iso.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 35e784c..5414eb1 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
 int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
 			  struct vm_area_struct *vma)
 {
-	unsigned long uaddr;
-	int i, err;
-
-	uaddr = vma->vm_start;
-	for (i = 0; i < buffer->page_count; i++) {
-		err = vm_insert_page(vma, uaddr, buffer->pages[i]);
-		if (err)
-			return err;
-
-		uaddr += PAGE_SIZE;
-	}
-
-	return 0;
+	return vm_map_pages_zero(vma, buffer->pages,
+					buffer->page_count);
 }
 
 void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
-- 
1.9.1

