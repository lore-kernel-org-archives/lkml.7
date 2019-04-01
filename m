Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C7AC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B9D21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139929;
	bh=DRh1HNKX75O4iozuJw8h54/gG6TIDSAa7ZCPqrxSTUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o3DW8lJJfi4n60+JpzcemVLLbYLlSpZHJbDCRYPsfS3+4G21vIEi3/WpFz32WlN78
	 OgO6MrAgl7lqJ4TOaR0AwDuK5gV9/PWSENd+k+S85RvPTtQ79c5XxSzeEXv9mf3iW6
	 o+9Dr0n+GR9driu8dEvLVmUiLlWU4Fd2ZIVMIjek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfDARcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732911AbfDARcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6863A208E4;
        Mon,  1 Apr 2019 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139924;
        bh=DRh1HNKX75O4iozuJw8h54/gG6TIDSAa7ZCPqrxSTUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=maQH+PMZorop1FLQkVxGM83GjtVFhG2DYaEO9K49zAXVhYf8mqVZGtl93vMSseKnh
         bsOPsljvNPsLiBNB2DEFOJfSc/fT4bqS5YvHGIKO26KgBlhbwqjBDD3kEHGoK1UOlY
         lQhVHRo85G7EhUZXVxym98xGnECW5vbvnopesfw4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rabin Vincent <rabin@rab.in>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 055/131] coresight: coresight_unregister() function cleanup
Date:   Mon,  1 Apr 2019 19:02:05 +0200
Message-Id: <20190401170056.918393080@linuxfoundation.org>
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

[ Upstream commit fae54158792aec705620bdc3938d342879204f0c ]

In its current form the code never frees csdev->refcnt allocated
in coresight_register().  There is also a problem with csdev->conns
that is freed before device_unregister() rather than in the device
release function.

This patch addresses both issues by moving kfree(csdev->conns) to
coresight_device_release() and freeing csdev->refcnt, also in
the same function.

Reported-by: Rabin Vincent <rabin@rab.in>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 84fc60318f79..a7d1edbf3340 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -484,6 +484,8 @@ static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
+	kfree(csdev->conns);
+	kfree(csdev->refcnt);
 	kfree(csdev);
 }
 
@@ -716,7 +718,6 @@ EXPORT_SYMBOL_GPL(coresight_register);
 
 void coresight_unregister(struct coresight_device *csdev)
 {
-	kfree(csdev->conns);
 	device_unregister(&csdev->dev);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);
-- 
2.19.1



