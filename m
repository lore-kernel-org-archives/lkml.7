Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A5AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601EF20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582296;
	bh=5e8+6GoShf4X7zAQc83nvtQcCfJqsmWxkyfwWNVDOVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zWPSk2Or4Y4mjGoV1rvIfO5zaJnDVGZxMgS4HVkZfeFQQrBpirTh8TlWN3Q9RLrtO
	 sBzxarEPs1TFMrhpY9rFXoADEU44kzV7toyWKDBzmtJoyRE+coXpm2k2MfgyQZsrXn
	 JckWS/ohTyU4QuTFo9lCQlLKclLyIAnI/a/XLauU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfCZGiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:38:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731055AbfCZGiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:38:11 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCFC020863;
        Tue, 26 Mar 2019 06:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582290;
        bh=5e8+6GoShf4X7zAQc83nvtQcCfJqsmWxkyfwWNVDOVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQ3SJCIBFodmvZ6Pude5gCrF9rx2af7WKQMldXgXcMvOz4od0Fm2SC9LavjABxzUf
         05JlVO2Jfc6f0HRU258WxfIMnY3qE4GkHbfVVsW8Il/jx0CyLcQq+pWGJxk8XbsN5x
         iQNxwGxm6lOO9ra9B9uCEXvWmxkz0G+20l6TFgOc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.0 11/52] iommu/iova: Fix tracking of recently failed iova address
Date:   Tue, 26 Mar 2019 15:29:58 +0900
Message-Id: <20190326042701.509197091@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Richter <rrichter@marvell.com>

commit 80ef4464d5e27408685e609d389663aad46644b9 upstream.

If a 32 bit allocation request is too big to possibly succeed, it
early exits with a failure and then should never update max32_alloc_
size. This patch fixes current code, now the size is only updated if
the slow path failed while walking the tree. Without the fix the
allocation may enter the slow path again even if there was a failure
before of a request with the same or a smaller size.

Cc: <stable@vger.kernel.org> # 4.20+
Fixes: bee60e94a1e2 ("iommu/iova: Optimise attempts to allocate iova from 32bit address range")
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/iova.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -207,8 +207,10 @@ static int __alloc_and_insert_iova_range
 		curr_iova = rb_entry(curr, struct iova, node);
 	} while (curr && new_pfn <= curr_iova->pfn_hi);
 
-	if (limit_pfn < size || new_pfn < iovad->start_pfn)
+	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
+		iovad->max32_alloc_size = size;
 		goto iova32_full;
+	}
 
 	/* pfn_lo will point to size aligned address if size_aligned is set */
 	new->pfn_lo = new_pfn;
@@ -222,7 +224,6 @@ static int __alloc_and_insert_iova_range
 	return 0;
 
 iova32_full:
-	iovad->max32_alloc_size = size;
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return -ENOMEM;
 }


