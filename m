Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B501C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66887216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946693;
	bh=CBgd7xi3Ai8eCnUNKbO38SUCBBHWDgb0XXYEoNLAykA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RwC80Os/P/HT8u6H1quQhOcyZo42PBvSBL6f0X8FN1dYoRb9rYDdy3EXDoygVVJhy
	 yXIijl1Wen1E6Tv4D5K5abZq7LMaRpDcClA0BczCYU/dVVUUKQ6yC6ExI8SI7S+v7x
	 WjswOZWz+IU3abpge1R1irAHMaWuqpvfOili05/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfIHMow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729904AbfIHMos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:44:48 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7266216C8;
        Sun,  8 Sep 2019 12:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946688;
        bh=CBgd7xi3Ai8eCnUNKbO38SUCBBHWDgb0XXYEoNLAykA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UnDePMFckLign7/Wc0Uy2JVGiHayQunlApIfP6d6t4d6DquVMN/BtdjcoDawCAkiL
         zpTfs7xTWa82upPcbN9FqV03H/exRbdpWvIqM+HUOi1usDc/gxVqKhx+tB15R+N9ti
         C/iWOMcoOH2ly8fLVTVKhWP2km3h4pWFC5B5yc+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 06/26] cxgb4: fix a memory leak bug
Date:   Sun,  8 Sep 2019 13:41:45 +0100
Message-Id: <20190908121058.681724248@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121057.216802689@linuxfoundation.org>
References: <20190908121057.216802689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c554336efa9bbc28d6ec14efbee3c7d63c61a34f ]

In blocked_fl_write(), 't' is not deallocated if bitmap_parse_user() fails,
leading to a memory leak bug. To fix this issue, free t before returning
the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
index 20455d082cb80..61c55621b9589 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
@@ -2781,8 +2781,10 @@ static ssize_t blocked_fl_write(struct file *filp, const char __user *ubuf,
 		return -ENOMEM;
 
 	err = bitmap_parse_user(ubuf, count, t, adap->sge.egr_sz);
-	if (err)
+	if (err) {
+		kvfree(t);
 		return err;
+	}
 
 	bitmap_copy(adap->sge.blocked_fl, t, adap->sge.egr_sz);
 	t4_free_mem(t);
-- 
2.20.1



