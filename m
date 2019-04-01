Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EF72070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139957;
	bh=75oQRojAWiCzcFUtpejatkvkUK7JvLdHttq6z+E6+Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JSbnZBZ5JofptU1qllSctlBPQPMZmmsBHMjv68sxJQWef3pOcH83D76q7su8MlXhQ
	 lcwPywh+hF1dPz017OS6YNkZ3P33FdviNV65qvRLtIKA0M9p4kpBVHlhEy8pi67tJZ
	 H6MxlEdS81HdznO8ghNp189tDkK1atra9uZ5UJsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbfDARcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733232AbfDARcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EF4D2171F;
        Mon,  1 Apr 2019 17:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139952;
        bh=75oQRojAWiCzcFUtpejatkvkUK7JvLdHttq6z+E6+Zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/03qVxiFAIEffuMuyGwxRE4Z6JWEvJmlL/Sb4NW64x4EhIo7+K5LwuSsqaCnvFVo
         XShdqDjjo8w7Y+uaX3AN3HxKyUSJ+FrMUClDPJ71+EHviZHhyae/MAYXiv6nz6EUCi
         h8Hem73IHO6cwJjxHEETVcmUJA2CkJO8tYAvPfD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurent Fert <laurent.fert@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 062/131] stm class: Fix unlocking braino in the error path
Date:   Mon,  1 Apr 2019 19:02:12 +0200
Message-Id: <20190401170057.457540125@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1810f2c44817c74ca3d05d1e3981e3a2e2ceb6f5 ]

If an illegal attempt is made to unlink stm source device from an
stm device, the stm device's link spinlock mistakenly remains locked.
While this really shouldn't happen (there's a warning in place), the
locking should remain in order so that we can still recover from this
situation if it indeed does happen.

This patch unifies the unlocking in the exit path of
__stm_source_link_drop() to fix this.

Reported-by: Laurent Fert <laurent.fert@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/stm/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index e4fa583b57a6..d4deac108578 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -817,10 +817,8 @@ static void __stm_source_link_drop(struct stm_source_device *src,
 	spin_lock(&stm->link_lock);
 	spin_lock(&src->link_lock);
 	link = srcu_dereference_check(src->link, &stm_source_srcu, 1);
-	if (WARN_ON_ONCE(link != stm)) {
-		spin_unlock(&src->link_lock);
-		return;
-	}
+	if (WARN_ON_ONCE(link != stm))
+		goto unlock;
 
 	stm_output_free(link, &src->output);
 	list_del_init(&src->link_entry);
@@ -828,6 +826,7 @@ static void __stm_source_link_drop(struct stm_source_device *src,
 	stm_put_device(link);
 	rcu_assign_pointer(src->link, NULL);
 
+unlock:
 	spin_unlock(&src->link_lock);
 	spin_unlock(&stm->link_lock);
 }
-- 
2.19.1



