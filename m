Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5844C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E82E215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119582;
	bh=3TBPpUvQrXT/SFyjnF4LAeHputJ0ewAoJYd6bGHXiIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0KX/6Lq34Fr+dUQgiwT4gPxhZrmqESXKqoAGOCPNZ3UzKzfTXWSS1RbbPVIMJ2Z5l
	 2xOQtbxpnoGzVWgwesiBPHRyNj/Iae2NOgkjYJJQ6CG3Jp9pEjVaNCttd9ZXpv5vKy
	 DYvfbP968PmoyUeXSumLvrcEyW2RpX0Pfk403if4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389744AbfJCQTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389717AbfJCQTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:19:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D766B215EA;
        Thu,  3 Oct 2019 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119574;
        bh=3TBPpUvQrXT/SFyjnF4LAeHputJ0ewAoJYd6bGHXiIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opHqMHoGSgcWXEjhSgyF5l8L8vYeEXV/r8CBCB4O91B+SBfvbMig/rbEhZOhRLnJn
         bTLl9v5CgfbGs+IO9ZyYKCtq1SNXlSI5DTFAWL+RdlQ66VSqL8gVG/6x3cQsaPoUJe
         JRQ8K40lqXeo5v1BwkwUZPG3WOhKfmksOpU1ntdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 077/211] media: omap3isp: Dont set streaming state on random subdevs
Date:   Thu,  3 Oct 2019 17:52:23 +0200
Message-Id: <20191003154505.193234880@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 7ef57be07ac146e70535747797ef4aee0f06e9f9 ]

The streaming state should be set to the first upstream sub-device only,
not everywhere, for a sub-device driver itself knows how to best control
the streaming state of its own upstream sub-devices.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/omap3isp/isp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index 432bc7fbedc99..addd03b517481 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -722,6 +722,10 @@ static int isp_pipeline_enable(struct isp_pipeline *pipe,
 					s_stream, mode);
 			pipe->do_propagation = true;
 		}
+
+		/* Stop at the first external sub-device. */
+		if (subdev->dev != isp->dev)
+			break;
 	}
 
 	return 0;
@@ -836,6 +840,10 @@ static int isp_pipeline_disable(struct isp_pipeline *pipe)
 						      &subdev->entity);
 			failure = -ETIMEDOUT;
 		}
+
+		/* Stop at the first external sub-device. */
+		if (subdev->dev != isp->dev)
+			break;
 	}
 
 	return failure;
-- 
2.20.1



