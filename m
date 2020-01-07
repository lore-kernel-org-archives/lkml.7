Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E097DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CC120678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431676;
	bh=+7HNKpmb+eFtvWyjVyXi+WtRWV+xXqbI+prde13+/jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OvYli7XDOv1q3mMzFR+gkQGm6CxNnyepQL6pCZ7w9TBf7Ia58g7ecRdaOQ7Jq8DQo
	 ym5xrX17Lql9+38N5NwMhiBGqQ8gmXUPn0HuWj2Scs6jNa00+lCVTqAQs3nWQ5/Ve4
	 aXqdUMu2YMQvrRG2KBeaCS/AF3vur+bKeuDKr/5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgAGVJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:09:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbgAGVJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:09:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE5E2077B;
        Tue,  7 Jan 2020 21:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431340;
        bh=+7HNKpmb+eFtvWyjVyXi+WtRWV+xXqbI+prde13+/jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UM9cFRxFlECz0ByT0y1r1X0JL5jOXuRach3UG6BSKeDSUIkKtqpnsmUwSceAT8TRG
         d86cResq6hsM68Jx7N4DgBnhaNUz1R+p9Uw0946TN8oPf2u+zHSB1XTz0yFBbcdp1N
         +alnDoRErv6Dg1cTgUlDyLrvm8lRiJzphUx5AQZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Durrant <pdurrant@amazon.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 17/74] xen-blkback: prevent premature module unload
Date:   Tue,  7 Jan 2020 21:54:42 +0100
Message-Id: <20200107205147.834754123@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
References: <20200107205135.369001641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Durrant <pdurrant@amazon.com>

[ Upstream commit fa2ac657f9783f0891b2935490afe9a7fd29d3fa ]

Objects allocated by xen_blkif_alloc come from the 'blkif_cache' kmem
cache. This cache is destoyed when xen-blkif is unloaded so it is
necessary to wait for the deferred free routine used for such objects to
complete. This necessity was missed in commit 14855954f636 "xen-blkback:
allow module to be cleanly unloaded". This patch fixes the problem by
taking/releasing extra module references in xen_blkif_alloc/free()
respectively.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/xen-blkback/xenbus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index ed4e80779124..e9fa4a1fc791 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -178,6 +178,15 @@ static struct xen_blkif *xen_blkif_alloc(domid_t domid)
 	blkif->domid = domid;
 	atomic_set(&blkif->refcnt, 1);
 	init_completion(&blkif->drain_complete);
+
+	/*
+	 * Because freeing back to the cache may be deferred, it is not
+	 * safe to unload the module (and hence destroy the cache) until
+	 * this has completed. To prevent premature unloading, take an
+	 * extra module reference here and release only when the object
+	 * has been freed back to the cache.
+	 */
+	__module_get(THIS_MODULE);
 	INIT_WORK(&blkif->free_work, xen_blkif_deferred_free);
 
 	return blkif;
@@ -327,6 +336,7 @@ static void xen_blkif_free(struct xen_blkif *blkif)
 
 	/* Make sure everything is drained before shutting down */
 	kmem_cache_free(xen_blkif_cachep, blkif);
+	module_put(THIS_MODULE);
 }
 
 int __init xen_blkif_interface_init(void)
-- 
2.20.1



