Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3030FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082F120665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739754;
	bh=jncSt8VIZHlGgaas26TEiZSMexb0v2RL4k1czPekKkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bAHqQjUVCvzLRp0tgzHllJeaNRxCtgk7sJbk3zmnW2CeulAQ16bbkbrWJW3fiWGWV
	 xoIIYi/8s755vhb6LOAgPJKCCJpot+skpdzTb0RBZIg/WKrD1YlandymgGioT4Un/v
	 JbLQEqgYvTBVt+n87Pu2tDud8UFbXcWbvpL+/JU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406627AbfHBJzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406611AbfHBJzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:55:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D1320665;
        Fri,  2 Aug 2019 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739748;
        bh=jncSt8VIZHlGgaas26TEiZSMexb0v2RL4k1czPekKkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5z9gVvkjGT39zr5w48K9nit5UIh5UXnQyGv/hXwi1vao2PMGWlvhu3gMtIqtiOI7
         wgP1RuLEi/qwJ1osJrpF3ANvAs5Z9bntazhZWOggLuMYKlKNQAefDbf8j2u7+NglWl
         niROVTTTqYJPqRTd15fSBuCLLwS4ZjrK7GUx2Ztg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 4.19 18/32] iommu/iova: Fix compilation error with !CONFIG_IOMMU_IOVA
Date:   Fri,  2 Aug 2019 11:39:52 +0200
Message-Id: <20190802092107.548593785@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092101.913646560@linuxfoundation.org>
References: <20190802092101.913646560@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

commit 201c1db90cd643282185a00770f12f95da330eca upstream.

The stub function for !CONFIG_IOMMU_IOVA needs to be
'static inline'.

Fixes: effa467870c76 ('iommu/vt-d: Don't queue_iova() if there is no flush queue')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/iova.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -237,7 +237,7 @@ static inline void init_iova_domain(stru
 {
 }
 
-bool has_iova_flush_queue(struct iova_domain *iovad)
+static inline bool has_iova_flush_queue(struct iova_domain *iovad)
 {
 	return false;
 }


