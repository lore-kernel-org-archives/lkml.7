Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB687C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C83320842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Dh/+7RnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbfI3XWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:22:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39077 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbfI3XWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 19:22:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so6493984pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 16:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oD29p9MztJ0+RG65sUk0y34KEPusU0JDw36LEVrb3DM=;
        b=Dh/+7RnHcSNPu7iFzG4FCn7R4X50q8rBrl/G7Gtjs3SzU9elJmVJzuWimYKVKzvex0
         0cAVsUl1VKUbTofnpFFmHlvsWmaIcYDvycKtRt8Hji43hjeBXrQswpYIKQnd7aUtU5MI
         ur1VGuiON4lQlYpOdff0bLlLBsFqfJPDE6RMW9zuu4EcQikQr8FBDVQgqFvfi0V0M+RQ
         oZDCjCtTu7LoPjowkun4rJBTH07KC78J3E3N5dUxDyQifXx5rNrg47ifQWJFNrQoB6Ax
         kqCT0TiyHMr88THW7korngsuFeOx3nCZYM/acKlLsk0rEUMdqtPudIRaA4b4SOS5pw2u
         nTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oD29p9MztJ0+RG65sUk0y34KEPusU0JDw36LEVrb3DM=;
        b=TYBxga/X/hPBj+ZqfxlM1/gDS+gygM07BvNCDS9BZJR2iVlWF6GusLJoi3f53i16tV
         +e/et1LqGzlIaxm18xkQPPRK2+zZaNxRBln8W4tSp4l+NuWnrSOrTBeF36zAyOEjha5j
         CBJ+8kyH0qU0YpWC9cOfcbg1h5LkOIV3pmfZQoZI1/u7QeiLx1RKVIcvbQSH5Ra5qspk
         V1A8tPEuugwnSzxlzltU+9ap4J2fLDQDUCTVMpcSAbel8jjBbEH9e3uzLtVL4Tv6wzkk
         US2Sgh3adJldHj1z4Cv1znAKjF+8V5j02r0LSAcvbngHWI6bdNtF56/KkFgKbxH9qUsw
         5Vxw==
X-Gm-Message-State: APjAAAXd9ooLE5qT+cDrI6Xxw2X8kUqDGkROpktlO4FZZv1CdPymUZ6i
        ddM6LJtQxci6A4I6BygTwIWCywGIRy4=
X-Google-Smtp-Source: APXvYqxArfBwf2OYAS2ryb5cgYk6T4irZNLwLtqsdIA+0Qk8MxomHoH5QY+tr74ygd6ZBdj4xaOTFQ==
X-Received: by 2002:a63:e444:: with SMTP id i4mr27267478pgk.45.1569885770188;
        Mon, 30 Sep 2019 16:22:50 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 14sm379629pfn.21.2019.09.30.16.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 16:22:49 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de, jgg@ziepe.ca,
        christophe.leroy@c-s.fr, palmer@sifive.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] scatterlist: Validate page before calling PageSlab()
Date:   Mon, 30 Sep 2019 16:22:35 -0700
Message-Id: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify sg_miter_stop() to validate the page pointer
before calling PageSlab(). This check prevents a crash
that will occur if PageSlab() gets called with a page
pointer that is not backed by page struct.

A virtual address obtained from ioremap() for a physical
address in PCI address space can be assigned to a
scatterlist segment using the public scatterlist API
as in the following example:

my_sg_set_page(struct scatterlist *sg,
               const void __iomem *ioaddr,
               size_t iosize)
{
	sg_set_page(sg,
		virt_to_page(ioaddr),
		(unsigned int)iosize,
		offset_in_page(ioaddr));
	sg_init_marker(sg, 1);
}

If the virtual address obtained from ioremap() is not
backed by a page struct, virt_to_page() returns an
invalid page pointer. However, sg_copy_buffer() can
correctly recover the original virtual address. Such
addresses can successfully be assigned to scatterlist
segments to transfer data across the PCI bus with
sg_copy_buffer() if it were not for the crash in
PageSlab() when called by sg_miter_stop().

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 lib/scatterlist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index c2cf2c311b7d..f5c61cad40ba 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -807,6 +807,7 @@ void sg_miter_stop(struct sg_mapping_iter *miter)
 		miter->__remaining -= miter->consumed;
 
 		if ((miter->__flags & SG_MITER_TO_SG) &&
+		    pfn_valid(page_to_pfn(miter->page)) &&
 		    !PageSlab(miter->page))
 			flush_kernel_dcache_page(miter->page);
 
-- 
2.7.4

