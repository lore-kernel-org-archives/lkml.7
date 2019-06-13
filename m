Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DC8C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527AF20679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441939;
	bh=Jq0JqMHJvXFx8ZChVTZwuwvn2uI3AkZCp2W+XRv0lQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rEJjesXwZbWfdJVgNgzXjfkKzVz7D9FMel+/LvPHiyPCcE855EO9RtISHGVgZlZkW
	 lIomHG06ZcM68JrY68vABAmzBySVnkxWTBQSxzDvVaibapTKRILkrqTCZ6gzCHGypf
	 Hwc4Z4buJNMmxnYaBm9KgabqAylJt7MTZ+Gq5KKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbfFMQFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731336AbfFMIq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:46:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DD42147A;
        Thu, 13 Jun 2019 08:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415586;
        bh=Jq0JqMHJvXFx8ZChVTZwuwvn2uI3AkZCp2W+XRv0lQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x4DAJ2dOElvltN9PCBt4mIqWVuWHPWzEM4XWRpplbYoej0HSFnk0KdWhAs6h2XvVi
         Xh8zPLTgLW4MAIcIB9g5/ihJcmQi/kfjFbS1X6uaeveFMEpEHdISUmGagWd8Be5QiO
         SZXNAB1XomVls4livLV1pMogwScVbwV9MF3CXwLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 055/155] media: atmel: atmel-isc: fix asd memory allocation
Date:   Thu, 13 Jun 2019 10:32:47 +0200
Message-Id: <20190613075656.195251339@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1e4e25c4959c10728fbfcc6a286f9503d32dfe02 ]

The subsystem will free the asd memory on notifier cleanup, if the asd is
added to the notifier.
However the memory is freed using kfree.
Thus, we cannot allocate the asd using devm_*
This can lead to crashes and problems.
To test this issue, just return an error at probe, but cleanup the
notifier beforehand.

Fixes: 106267444f ("[media] atmel-isc: add the Image Sensor Controller code")

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
index 50178968b8a6..5b0e96bd8c7e 100644
--- a/drivers/media/platform/atmel/atmel-isc.c
+++ b/drivers/media/platform/atmel/atmel-isc.c
@@ -2065,8 +2065,11 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
 			break;
 		}
 
-		subdev_entity->asd = devm_kzalloc(dev,
-				     sizeof(*subdev_entity->asd), GFP_KERNEL);
+		/* asd will be freed by the subsystem once it's added to the
+		 * notifier list
+		 */
+		subdev_entity->asd = kzalloc(sizeof(*subdev_entity->asd),
+					     GFP_KERNEL);
 		if (!subdev_entity->asd) {
 			of_node_put(rem);
 			ret = -ENOMEM;
@@ -2210,6 +2213,7 @@ static int atmel_isc_probe(struct platform_device *pdev)
 						     subdev_entity->asd);
 		if (ret) {
 			fwnode_handle_put(subdev_entity->asd->match.fwnode);
+			kfree(subdev_entity->asd);
 			goto cleanup_subdev;
 		}
 
-- 
2.20.1



