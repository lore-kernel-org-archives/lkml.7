Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EBCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D1821904
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139931;
	bh=ZumLN7bwEFBVn9Ncj9uA97GlaSgNwSM7Cv/9klWOzms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PxvXXoNiOCCu6XeXmSnnJTI+sFI8iZDsFHYSgB5PA0O8SmiTRJFqSyHUsfox+x5VJ
	 QTvV1lvsbb2tfVPJRlCTgFF/gdhqCKlvw9NFKQWJzkG7RFOLDN4jU8zHSTo0LtYCVJ
	 fZkeT+fF3aYqTp+kyf7ZcgI9doam/UcgmPJVFvTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbfDARcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733169AbfDARcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 387CA21900;
        Mon,  1 Apr 2019 17:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139927;
        bh=ZumLN7bwEFBVn9Ncj9uA97GlaSgNwSM7Cv/9klWOzms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JcQq+UY1MBs2PtAfzF7RHLrNC/WwI5OSzunmZnZB1VF+bf7SOQnkXB3UaDTxhWfSv
         P/4ipAlB1gDN6/OHNghwmD6FjkCinTMfkUfLH5VVM6TtX5WT5Ov1qt9lTOdWPRmnYo
         i79W0g3z58Y8no7hC8KGEZjNo2ZS0mJPWoqeA880=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rabin Vincent <rabin@rab.in>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 056/131] coresight: release reference taken by bus_find_device()
Date:   Mon,  1 Apr 2019 19:02:06 +0200
Message-Id: <20190401170057.034616557@linuxfoundation.org>
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

[ Upstream commit f2dfab3568fc32afeac8b698481e80e7ab2dc658 ]

The reference count taken by function bus_find_device() needs
to be released if a child device is found, something this patch
is adding.

Reported-by: Rabin Vincent <rabin@rab.in>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index a7d1edbf3340..5e2a2a5ad601 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -573,6 +573,8 @@ static void coresight_fixup_device_conns(struct coresight_device *csdev)
 
 		if (dev) {
 			conn->child_dev = to_coresight_device(dev);
+			/* and put reference from 'bus_find_device()' */
+			put_device(dev);
 		} else {
 			csdev->orphan = true;
 			conn->child_dev = NULL;
-- 
2.19.1



