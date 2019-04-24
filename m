Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C5BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FDC20675
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127505;
	bh=zHSCUcAtNlSPFebN/+vW9er446FTkkzct/Tnmfi+F2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kb+aSzOT9NIFs0ZJcyH6UwgkwTq4kiDcyXgfptwFkmL8LxubJsZf99negNzTP4Fb4
	 Y2POWqX4t6OdrQEBXEmBiy9oShjDueujTkHK/2Uq2eVjm03ZDTy5xonYlHp0uGwWuB
	 R8+LOknZXkKm9fSVfNTIT9EMVE7XOaTVJObs6Tc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392403AbfDXRiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392381AbfDXRiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:38:18 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A46D218B0;
        Wed, 24 Apr 2019 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127497;
        bh=zHSCUcAtNlSPFebN/+vW9er446FTkkzct/Tnmfi+F2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PuQJeYcdjowUrBtAZqZuOtAkeNAzrKZqXf04/GDGcbPpwLM6/kyErKjgOaUWN5nNu
         JBuIatiKSBitIewsKEOrRC4kPBA3UUb5xKzJAdje9aXEM3z1H8C+98sahluCGQRjkc
         rotrSmrJydXo8ZfQ18BxJri/AEi1/DEnt1TbAFro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhong jiang <zhongjiang@huawei.com>,
        Yang yingliang <yangyingliang@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 112/115] mm/memory_hotplug: do not unlock after failing to take the device_hotplug_lock
Date:   Wed, 24 Apr 2019 19:10:48 +0200
Message-Id: <20190424170931.214760929@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

commit 37803841c92d7b327147e0b1be3436423189e1cf upstream.

When adding memory by probing a memory block in the sysfs interface,
there is an obvious issue where we will unlock the device_hotplug_lock
when we failed to takes it.

That issue was introduced in 8df1d0e4a265 ("mm/memory_hotplug: make
add_memory() take the device_hotplug_lock").

We should drop out in time when failing to take the device_hotplug_lock.

Link: http://lkml.kernel.org/r/1554696437-9593-1-git-send-email-zhongjiang@huawei.com
Fixes: 8df1d0e4a265 ("mm/memory_hotplug: make add_memory() take the device_hotplug_lock")
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Reported-by: Yang yingliang <yangyingliang@huawei.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -505,7 +505,7 @@ static ssize_t probe_store(struct device
 
 	ret = lock_device_hotplug_sysfs();
 	if (ret)
-		goto out;
+		return ret;
 
 	nid = memory_add_physaddr_to_nid(phys_addr);
 	ret = __add_memory(nid, phys_addr,


