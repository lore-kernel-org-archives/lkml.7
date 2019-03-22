Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4936C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A7720830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256688;
	bh=zIlraMoxsv+SbzTh/sL22uIkqlf98E3EPBWLm7Hllvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WMJR9fYkgV+JtQkYXo+FpNkhoFAJqD+eIPTyYyVZtnkVO5vfCjdNo05XNmxsdOq8N
	 7zLLW6ZohVXMSXJlL8ywbsHx1BBFQ6jpL+sHiLWO0jnce8wnGkcA1OxM8E9+tJz/lv
	 4GnRwhmhtW1+Pai3/krWhHpA6LWZ/daQ01Rr0GIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389203AbfCVML1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389493AbfCVMLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:11:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12EE82082C;
        Fri, 22 Mar 2019 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256679;
        bh=zIlraMoxsv+SbzTh/sL22uIkqlf98E3EPBWLm7Hllvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IG/nO0pY8OGwSOyBrJzvoLhckwhwT9ZCHrqbdxuVqPHlY2vMFkck9dSgXEGaCBWTN
         bMNJIpbysRnOkM2i9OtHHN3ZW2kKN4eAfannxxnZHuIAyYDI+sX/yH+ep74Qul11Mw
         0xADK2EF3M7NfaY8x1emrR2ZBP4C07hksvj0bJ2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 268/280] media: imx: csi: Stop upstream before disabling IDMA channel
Date:   Fri, 22 Mar 2019 12:17:01 +0100
Message-Id: <20190322111345.484199391@linuxfoundation.org>
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

From: Steve Longerbeam <slongerbeam@gmail.com>

commit 4bc1ab41eee9d02ad2483bf8f51a7b72e3504eba upstream.

Move upstream stream off to just after receiving the last EOF completion
and disabling the CSI (and thus before disabling the IDMA channel) in
csi_stop(). For symmetry also move upstream stream on to beginning of
csi_start().

Doing this makes csi_s_stream() more symmetric with prp_s_stream() which
will require the same change to fix a hard lockup.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Cc: stable@vger.kernel.org	# for 4.13 and up
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/media/imx/imx-media-csi.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -722,10 +722,16 @@ static int csi_start(struct csi_priv *pr
 
 	output_fi = &priv->frame_interval[priv->active_output_pad];
 
+	/* start upstream */
+	ret = v4l2_subdev_call(priv->src_sd, video, s_stream, 1);
+	ret = (ret && ret != -ENOIOCTLCMD) ? ret : 0;
+	if (ret)
+		return ret;
+
 	if (priv->dest == IPU_CSI_DEST_IDMAC) {
 		ret = csi_idmac_start(priv);
 		if (ret)
-			return ret;
+			goto stop_upstream;
 	}
 
 	ret = csi_setup(priv);
@@ -753,6 +759,8 @@ fim_off:
 idmac_stop:
 	if (priv->dest == IPU_CSI_DEST_IDMAC)
 		csi_idmac_stop(priv);
+stop_upstream:
+	v4l2_subdev_call(priv->src_sd, video, s_stream, 0);
 	return ret;
 }
 
@@ -768,6 +776,9 @@ static void csi_stop(struct csi_priv *pr
 	 */
 	ipu_csi_disable(priv->csi);
 
+	/* stop upstream */
+	v4l2_subdev_call(priv->src_sd, video, s_stream, 0);
+
 	if (priv->dest == IPU_CSI_DEST_IDMAC) {
 		csi_idmac_stop(priv);
 
@@ -935,23 +946,13 @@ static int csi_s_stream(struct v4l2_subd
 		goto update_count;
 
 	if (enable) {
-		/* upstream must be started first, before starting CSI */
-		ret = v4l2_subdev_call(priv->src_sd, video, s_stream, 1);
-		ret = (ret && ret != -ENOIOCTLCMD) ? ret : 0;
-		if (ret)
-			goto out;
-
 		dev_dbg(priv->dev, "stream ON\n");
 		ret = csi_start(priv);
-		if (ret) {
-			v4l2_subdev_call(priv->src_sd, video, s_stream, 0);
+		if (ret)
 			goto out;
-		}
 	} else {
 		dev_dbg(priv->dev, "stream OFF\n");
-		/* CSI must be stopped first, then stop upstream */
 		csi_stop(priv);
-		v4l2_subdev_call(priv->src_sd, video, s_stream, 0);
 	}
 
 update_count:


