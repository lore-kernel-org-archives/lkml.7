Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70ECC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA4020679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441451;
	bh=vHSQZIwXtZosShzoxpKcKbWrLhesbOIeQYP0cPMcoSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hiQzo13Z9le4KlHpqRLqPzgQuNPxIFDILk75XqHoykJCDhJOiJ7T6PZKyDBXerwvG
	 M1vYSwVFoxAmiK467/QoZTk9ylf0JhWrHOSoe9l61V8V19aClCfqJ+gGdE9AOWr6fr
	 LOIV46i75C38QNyRU+rrwwdW4XTmA2ZlNvamRvmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390496AbfFMP5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:57:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731509AbfFMIur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:50:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF009206BA;
        Thu, 13 Jun 2019 08:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415846;
        bh=vHSQZIwXtZosShzoxpKcKbWrLhesbOIeQYP0cPMcoSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBe8Nu7z7xW/it7W2+WPNvkGtHctw7XvY48OTFdDG1QiUUqoGRij7bteD9sFmmQiU
         utrXwSMHU1mKz7Z0JP34spQoUqHs9R6pQ+BO6lKcDxFBtsKhbwLh4zZvp7ikrff6o6
         4rsES6HmK3RB48fzxAmIP1nyAeqcEdBe8F7uoW60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 143/155] media: v4l2-fwnode: Defaults may not override endpoint configuration in firmware
Date:   Thu, 13 Jun 2019 10:34:15 +0200
Message-Id: <20190613075701.021874674@linuxfoundation.org>
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

[ Upstream commit 9d3863736a267068a0ae67c6695af8770ef330b7 ]

The lack of defaults provided by the caller to
v4l2_fwnode_endpoint_parse() signals the use of the default lane mapping.
The default lane mapping must not be used however if the firmmare contains
the lane mapping. Disable the default lane mapping in that case, and
improve the debug messages telling of the use of the defaults.

This was missed previously since the default mapping will only unsed in
this case if the bus type is set, and no driver did both while still
needing the lane mapping configuration.

Fixes: b4357d21d674 ("media: v4l: fwnode: Support default CSI-2 lane mapping for drivers")

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 7495f8323147..ccefa55813ad 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -163,7 +163,7 @@ static int v4l2_fwnode_endpoint_parse_csi2_bus(struct fwnode_handle *fwnode,
 		}
 
 		if (use_default_lane_mapping)
-			pr_debug("using default lane mapping\n");
+			pr_debug("no lane mapping given, using defaults\n");
 	}
 
 	rval = fwnode_property_read_u32_array(fwnode, "data-lanes", NULL, 0);
@@ -175,6 +175,10 @@ static int v4l2_fwnode_endpoint_parse_csi2_bus(struct fwnode_handle *fwnode,
 					       num_data_lanes);
 
 		have_data_lanes = true;
+		if (use_default_lane_mapping) {
+			pr_debug("data-lanes property exists; disabling default mapping\n");
+			use_default_lane_mapping = false;
+		}
 	}
 
 	for (i = 0; i < num_data_lanes; i++) {
-- 
2.20.1



