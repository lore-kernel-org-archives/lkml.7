Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603E7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AAC20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582163;
	bh=osksYnRANX103ay6Q36JiByj9ieYJ4k7K1JZH5YKYmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IF+wV2+lgmY8Ko2Pk2NjIecG1EiYgL4lYtjTlEseqR5DiHhBE/SsgcNQ16w7t5VwD
	 yY6OZHNSBtaRpWIgfV8xKLF0pZilEBpT6s9BSl9xQymKvHgSg1OWrBlXKVqEija/IX
	 kGEP6RflFT2JZEAfD8zHim+xpZ7325mChkFBXEx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfCZGgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730944AbfCZGf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:35:59 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC2BF20823;
        Tue, 26 Mar 2019 06:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582158;
        bh=osksYnRANX103ay6Q36JiByj9ieYJ4k7K1JZH5YKYmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C25Z0a1ewCHOHtOWKxqkCQKupH/61zDMnusL7XV67UbCWcKf58efX6HDDiF/bFIlj
         5C83ed3WrP4UCO2NJEk1zl2xjK5n8hTZDZfJJReITyeIyEFr9OWRPMAw+cWRrzYzUp
         gBK0j3u0FgEj/M4ROWtkh4vjznoDeLymikFVNZwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Deepak Rawat <drawat@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 4.19 07/45] drm/vmwgfx: Return 0 when gmrid::get_node runs out of IDs
Date:   Tue, 26 Mar 2019 15:29:50 +0900
Message-Id: <20190326042703.059597782@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Deepak Rawat <drawat@vmware.com>

commit 4b9ce3a651a37c60527101db4451a315a8b9588f upstream.

If it's not a system error and get_node implementation accommodate the
buffer object then it should return 0 with memm::mm_node set to NULL.

v2: Test for id != -ENOMEM instead of id == -ENOSPC.

Cc: <stable@vger.kernel.org>
Fixes: 4eb085e42fde ("drm/vmwgfx: Convert to new IDA API")
Signed-off-by: Deepak Rawat <drawat@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
@@ -57,7 +57,7 @@ static int vmw_gmrid_man_get_node(struct
 
 	id = ida_alloc_max(&gman->gmr_ida, gman->max_gmr_ids - 1, GFP_KERNEL);
 	if (id < 0)
-		return id;
+		return (id != -ENOMEM ? 0 : id);
 
 	spin_lock(&gman->lock);
 


