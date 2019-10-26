Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F7BCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877822070B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096563;
	bh=jqZFpikfJbMsGU/bG7ztRjCnMW9m9ycSR09ThwTCulM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gQy1CWl0Hixas6Z0KhbWT6Mf17sRksaOm7bSOY7mk0MbJ1zIuDAPBeWA4opQYPdIP
	 lUUxSKxrrVq11YNYxwdnv6YaKtN/vuoPtWfx5O4ycqryyRDF8DWaCa5ag7bc6KlAnS
	 xan1hGkTpAPYrExcBqsjtZ626ZINcT9wS2kA0c5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfJZN3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728638AbfJZNU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:20:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21E9021D7F;
        Sat, 26 Oct 2019 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096028;
        bh=jqZFpikfJbMsGU/bG7ztRjCnMW9m9ycSR09ThwTCulM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNpFQpAkcUDRBq6aoXPhpB1WM2jGK8fGpmlN0ixvGbtOO25ADig/1/hXm14Ctsusp
         EHewpDE9CioLO6ZXMr/aXZvXqCSbgSD/TLZjfa7ULLP0tm5qOa6gXQ1k287mfrcLjl
         FoI3UJ0HxHdBM8e37p2XPG7WDfzWsvA4xBMhCDCY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 39/59] vhost/test: stop device before reset
Date:   Sat, 26 Oct 2019 09:18:50 -0400
Message-Id: <20191026131910.3435-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131910.3435-1-sashal@kernel.org>
References: <20191026131910.3435-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>

[ Upstream commit 245cdd9fbd396483d501db83047116e2530f245f ]

When device stop was moved out of reset, test device wasn't updated to
stop before reset, this resulted in a use after free.  Fix by invoking
stop appropriately.

Fixes: b211616d7125 ("vhost: move -net specific code out")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index a9be2d8e98df7..55090d9f9de0d 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -162,6 +162,7 @@ static int vhost_test_release(struct inode *inode, struct file *f)
 
 	vhost_test_stop(n, &private);
 	vhost_test_flush(n);
+	vhost_dev_stop(&n->dev);
 	vhost_dev_cleanup(&n->dev);
 	/* We do an extra flush before freeing memory,
 	 * since jobs can re-queue themselves. */
@@ -238,6 +239,7 @@ static long vhost_test_reset_owner(struct vhost_test *n)
 	}
 	vhost_test_stop(n, &priv);
 	vhost_test_flush(n);
+	vhost_dev_stop(&n->dev);
 	vhost_dev_reset_owner(&n->dev, umem);
 done:
 	mutex_unlock(&n->dev.mutex);
-- 
2.20.1

