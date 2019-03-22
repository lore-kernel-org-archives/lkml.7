Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8FBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E90C2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255833;
	bh=OgNgUCgHLmYsUBx5/s1Zp8TcaynYkC7sWFJf2rDZEzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hw4LlvpWFRqNxuQHp+uPufwp+f+nyMKtpxtXi1/G+zRfcqzAxaFx9LIQftaqXqozG
	 kVAe0dstxUlW21OZpP4/aIJ4tI7tJJLNQhRgQp9wT8lD5IUQs4QMqjkLcSf2vZUHpY
	 sBp3QjreQ18dR4c27yn92x1O7CWivJP6q9SqMqqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbfCVL5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733162AbfCVL5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08B3320850;
        Fri, 22 Mar 2019 11:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255824;
        bh=OgNgUCgHLmYsUBx5/s1Zp8TcaynYkC7sWFJf2rDZEzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3zATvDQKOSso6+StL99lQ4E4Yj4qgTm9Fy5pWw5ZZhxLFio6V+6cRAJcKfuSL351
         nAnPt4N9h5hqO0DRCbNg7XHy7YDXsaAtEwhCBFE6sAnxSQnSX0PUVt2aqv5gN56w52
         rq21bHiB9/9K6tSFiZ34CdewrVUcIX8wxPkP1ZZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.19 009/280] mei: bus: move hw module get/put to probe/release
Date:   Fri, 22 Mar 2019 12:12:42 +0100
Message-Id: <20190322111306.838066085@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit b5958faa34e2f99f3475ad89c52d98dfea079d33 upstream.

Fix unbalanced module reference counting during internal reset, which
prevents the drivers unloading.
Tracking mei_me/txe modules on mei client bus via
mei_cldev_enable/disable is error prone due to possible internal
reset flow, where clients are disconnected underneath.
Moving reference counting to probe and release of mei bus client
driver solves this issue in simplest way, as each client provides only
a single connection to a client bus driver.

Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/bus.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -541,17 +541,9 @@ int mei_cldev_enable(struct mei_cl_devic
 		goto out;
 	}
 
-	if (!mei_cl_bus_module_get(cldev)) {
-		dev_err(&cldev->dev, "get hw module failed");
-		ret = -ENODEV;
-		goto out;
-	}
-
 	ret = mei_cl_connect(cl, cldev->me_cl, NULL);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&cldev->dev, "cannot connect\n");
-		mei_cl_bus_module_put(cldev);
-	}
 
 out:
 	mutex_unlock(&bus->device_lock);
@@ -614,7 +606,6 @@ int mei_cldev_disable(struct mei_cl_devi
 	if (err < 0)
 		dev_err(bus->dev, "Could not disconnect from the ME client\n");
 
-	mei_cl_bus_module_put(cldev);
 out:
 	/* Flush queues and remove any pending read */
 	mei_cl_flush_queues(cl, NULL);
@@ -725,9 +716,16 @@ static int mei_cl_device_probe(struct de
 	if (!id)
 		return -ENODEV;
 
+	if (!mei_cl_bus_module_get(cldev)) {
+		dev_err(&cldev->dev, "get hw module failed");
+		return -ENODEV;
+	}
+
 	ret = cldrv->probe(cldev, id);
-	if (ret)
+	if (ret) {
+		mei_cl_bus_module_put(cldev);
 		return ret;
+	}
 
 	__module_get(THIS_MODULE);
 	return 0;
@@ -755,6 +753,7 @@ static int mei_cl_device_remove(struct d
 
 	mei_cldev_unregister_callbacks(cldev);
 
+	mei_cl_bus_module_put(cldev);
 	module_put(THIS_MODULE);
 	dev->driver = NULL;
 	return ret;


