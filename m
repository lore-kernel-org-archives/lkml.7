Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E3CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6742192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257398;
	bh=mbK8+AvJcxF1FtoCS16tff0yxCjzLE3TlpWQaEKQmbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p+SmGOF9R6gOuhaIrNpl8zcLn3HgZLGPcfaZIaD60LHQKV0tD2VGy0421zek6nolj
	 FEIUA2yKxmUH7/aBpEm36KK9+BVGsA5gwzOlf5ieHAFgwtkpKaXlNRFcx55pbHCrAb
	 fHlX5SHkwYixv2Jh6o65QmtPf3y4IBv0lRJEmLs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391114AbfCVMXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390560AbfCVMXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:23:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03A62054F;
        Fri, 22 Mar 2019 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257392;
        bh=mbK8+AvJcxF1FtoCS16tff0yxCjzLE3TlpWQaEKQmbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTfbUiNlyBYvIyDp7Mdm2eec0pAx09p3EVCmteQZbFJtx2OOe1UK1rOIjtL9I9gOd
         qMHhp00qJAHtdaeOIK35SWB5nH9XwTXpAwIA7bJdu45+cDFRXUSmFXcizWrTRd/Yxv
         PwxAgRjP9qFPlooxYkCuMVIgkT5dw4VLflO45eAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.0 218/238] media: imx: csi: Disable CSI immediately after last EOF
Date:   Fri, 22 Mar 2019 12:17:17 +0100
Message-Id: <20190322111311.135316839@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve Longerbeam <slongerbeam@gmail.com>

commit 2e0fe66e0a136252f4d89dbbccdcb26deb867eb8 upstream.

Disable the CSI immediately after receiving the last EOF before stream
off (and thus before disabling the IDMA channel). Do this by moving the
wait for EOF completion into a new function csi_idmac_wait_last_eof().

This fixes a complete system hard lockup on the SabreAuto when streaming
from the ADV7180, by repeatedly sending a stream off immediately followed
by stream on:

while true; do v4l2-ctl  -d4 --stream-mmap --stream-count=3; done

Eventually this either causes the system lockup or EOF timeouts at all
subsequent stream on, until a system reset.

The lockup occurs when disabling the IDMA channel at stream off. Disabling
the CSI before disabling the IDMA channel appears to be a reliable fix for
the hard lockup.

Fixes: 4a34ec8e470cb ("[media] media: imx: Add CSI subdev driver")

Reported-by: Gaël PORTAY <gael.portay@collabora.com>
Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Cc: stable@vger.kernel.org	# for 4.13 and up
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/media/imx/imx-media-csi.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -629,7 +629,7 @@ out_put_ipu:
 	return ret;
 }
 
-static void csi_idmac_stop(struct csi_priv *priv)
+static void csi_idmac_wait_last_eof(struct csi_priv *priv)
 {
 	unsigned long flags;
 	int ret;
@@ -646,7 +646,10 @@ static void csi_idmac_stop(struct csi_pr
 		&priv->last_eof_comp, msecs_to_jiffies(IMX_MEDIA_EOF_TIMEOUT));
 	if (ret == 0)
 		v4l2_warn(&priv->sd, "wait last EOF timeout\n");
+}
 
+static void csi_idmac_stop(struct csi_priv *priv)
+{
 	devm_free_irq(priv->dev, priv->eof_irq, priv);
 	devm_free_irq(priv->dev, priv->nfb4eof_irq, priv);
 
@@ -758,6 +761,16 @@ idmac_stop:
 
 static void csi_stop(struct csi_priv *priv)
 {
+	if (priv->dest == IPU_CSI_DEST_IDMAC)
+		csi_idmac_wait_last_eof(priv);
+
+	/*
+	 * Disable the CSI asap, after syncing with the last EOF.
+	 * Doing so after the IDMA channel is disabled has shown to
+	 * create hard system-wide hangs.
+	 */
+	ipu_csi_disable(priv->csi);
+
 	if (priv->dest == IPU_CSI_DEST_IDMAC) {
 		csi_idmac_stop(priv);
 
@@ -765,8 +778,6 @@ static void csi_stop(struct csi_priv *pr
 		if (priv->fim)
 			imx_media_fim_set_stream(priv->fim, NULL, false);
 	}
-
-	ipu_csi_disable(priv->csi);
 }
 
 static const struct csi_skip_desc csi_skip[12] = {


