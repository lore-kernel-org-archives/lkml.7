Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184DCC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F89217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639676;
	bh=jS/P740gJJTg5cpG7dqJ6n30Sc3YXWhZeWXnKtrOqsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vkJP9Ym1PmYFB0A7hKVKhjab+UqHCgxh9HeETr4vcpnE7C/4KelGWXdMwSeYlgKF8
	 nfNINhsiphxGgJmzmn/if0/iE2XfAp8jIH3nOxxmUsjddx264JYAUKMZvYfRoAc89N
	 dFDSm+AWlK/NlTF9lmRS5jl5A4YIkNNqKYy8PFN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391681AbfEWT1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:27:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391660AbfEWT1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:27:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D7272054F;
        Thu, 23 May 2019 19:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639670;
        bh=jS/P740gJJTg5cpG7dqJ6n30Sc3YXWhZeWXnKtrOqsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKnFdmqiz5YQFtbHziK9CgRk6nVU6Y0B82m68wWH4DToJ0v7xIPUABq+4yDP7FVqE
         m36nWDpWxykWZeIkZpbZkgaI04vnGU0UKqcZ/duWACFvg6emesrs9BVfTjnEUd5cc4
         85mgMM9mO/GLdQOVx4eTos2n6PAL7QvVHJb0OiGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.1 051/122] media: imx: csi: Allow unknown nearest upstream entities
Date:   Thu, 23 May 2019 21:06:13 +0200
Message-Id: <20190523181711.473950999@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Longerbeam <slongerbeam@gmail.com>

commit 904371f90b2c0c749a5ab75478c129a4682ac3d8 upstream.

On i.MX6, the nearest upstream entity to the CSI can only be the
CSI video muxes or the Synopsys DW MIPI CSI-2 receiver.

However the i.MX53 has no CSI video muxes or a MIPI CSI-2 receiver.
So allow for the nearest upstream entity to the CSI to be something
other than those.

Fixes: bf3cfaa712e5c ("media: staging/imx: get CSI bus type from nearest
upstream entity")

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/media/imx/imx-media-csi.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -154,9 +154,10 @@ static inline bool requires_passthrough(
 /*
  * Parses the fwnode endpoint from the source pad of the entity
  * connected to this CSI. This will either be the entity directly
- * upstream from the CSI-2 receiver, or directly upstream from the
- * video mux. The endpoint is needed to determine the bus type and
- * bus config coming into the CSI.
+ * upstream from the CSI-2 receiver, directly upstream from the
+ * video mux, or directly upstream from the CSI itself. The endpoint
+ * is needed to determine the bus type and bus config coming into
+ * the CSI.
  */
 static int csi_get_upstream_endpoint(struct csi_priv *priv,
 				     struct v4l2_fwnode_endpoint *ep)
@@ -172,7 +173,8 @@ static int csi_get_upstream_endpoint(str
 	if (!priv->src_sd)
 		return -EPIPE;
 
-	src = &priv->src_sd->entity;
+	sd = priv->src_sd;
+	src = &sd->entity;
 
 	if (src->function == MEDIA_ENT_F_VID_MUX) {
 		/*
@@ -186,6 +188,14 @@ static int csi_get_upstream_endpoint(str
 			src = &sd->entity;
 	}
 
+	/*
+	 * If the source is neither the video mux nor the CSI-2 receiver,
+	 * get the source pad directly upstream from CSI itself.
+	 */
+	if (src->function != MEDIA_ENT_F_VID_MUX &&
+	    sd->grp_id != IMX_MEDIA_GRP_ID_CSI2)
+		src = &priv->sd.entity;
+
 	/* get source pad of entity directly upstream from src */
 	pad = imx_media_find_upstream_pad(priv->md, src, 0);
 	if (IS_ERR(pad))


