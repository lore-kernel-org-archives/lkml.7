Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A44EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE09216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010359;
	bh=HI8Bcj0/Y78Lr5nke/yKwlk1lz1igip0lnZrf8wQm2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MTAgY09eoHUl1aXnFRIeVKksQFB9TPkFGa3Djmpc1RuJiQMYE23pmJ9LO6cRi28f3
	 2N+HjDoeAGZO3VEZ8scAA788Hn6fDWg4RFUVcYCKa+48eAQs1Obu0nxejiax3IeYK/
	 5CMDGvQdNGKpI4FImD0vcOnzTFmCAcjqwZHlB918=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfHENF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729421AbfHENFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:05:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54EBB206C1;
        Mon,  5 Aug 2019 13:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010353;
        bh=HI8Bcj0/Y78Lr5nke/yKwlk1lz1igip0lnZrf8wQm2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyBoN0jhKJ1MncLNxpknfZpaJ9lsOPQ2NS/B26B4AO2coLRlS9sCoCE9xTOrgvKdS
         d80ljS8Hik4dDwEVxoNr/Kk25OmF0g2TQz9OrWNZtfvx+P1xlRzD/XXCo+ruHk7KYW
         mh93np7lXHXvi5Ee1C8+N0YWa7Jsg9Daq8Zbv+zA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Beulich <jbeulich@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.9 33/42] xen/swiotlb: fix condition for calling xen_destroy_contiguous_region()
Date:   Mon,  5 Aug 2019 15:02:59 +0200
Message-Id: <20190805124928.876315536@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124924.788666484@linuxfoundation.org>
References: <20190805124924.788666484@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

commit 50f6393f9654c561df4cdcf8e6cfba7260143601 upstream.

The condition in xen_swiotlb_free_coherent() for deciding whether to
call xen_destroy_contiguous_region() is wrong: in case the region to
be freed is not contiguous calling xen_destroy_contiguous_region() is
the wrong thing to do: it would result in inconsistent mappings of
multiple PFNs to the same MFN. This will lead to various strange
crashes or data corruption.

Instead of calling xen_destroy_contiguous_region() in that case a
warning should be issued as that situation should never occur.

Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/swiotlb-xen.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -365,8 +365,8 @@ xen_swiotlb_free_coherent(struct device
 	/* Convert the size to actually allocated. */
 	size = 1UL << (order + XEN_PAGE_SHIFT);
 
-	if (((dev_addr + size - 1 <= dma_mask)) ||
-	    range_straddles_page_boundary(phys, size))
+	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
+		     range_straddles_page_boundary(phys, size)))
 		xen_destroy_contiguous_region(phys, order);
 
 	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);


