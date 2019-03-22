Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2E1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D149820850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255772;
	bh=CbZh/J1RAUhTsnjU0qfYQiZOObREr5BYnslLU20AkHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p01gagV5s71UUPrVXRGlEz0l3B1Jupd1oiZ45VKwBYhZYGDJfUBfVY0Pry3GOMhLl
	 2wP0SWJQHwLTuE6aENFBwygtDJ44fdzVWn9J5ia5ejuoV0On2owyMgQZZrzMYpGJpp
	 KRPPq3zsCdrX878kIUamPKJwV1BVxwggmgjVqk74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733211AbfCVL4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732770AbfCVL4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:56:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 125F220850;
        Fri, 22 Mar 2019 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255764;
        bh=CbZh/J1RAUhTsnjU0qfYQiZOObREr5BYnslLU20AkHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8hjtl2v6M2WWW0zjcmPCR/cHBMuEQvxYtkSOZU5j9Pw3EbHXkdwcLdZaMVbZKb9V
         F6k5MRpWLe0t9QHkEVIGzX9cNRxXH2ifJ7WzrKAGxnph61tfLwFQA/3tiz537/a56b
         rvjmLzEGTLc4+ikSTAPFdvmPAKDi5Lxk9iRmshDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.14 174/183] media: imx: csi: Disable CSI immediately after last EOF
Date:   Fri, 22 Mar 2019 12:16:42 +0100
Message-Id: <20190322111254.504396249@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -538,7 +538,7 @@ out_put_ipu:
 	return ret;
 }
 
-static void csi_idmac_stop(struct csi_priv *priv)
+static void csi_idmac_wait_last_eof(struct csi_priv *priv)
 {
 	unsigned long flags;
 	int ret;
@@ -555,7 +555,10 @@ static void csi_idmac_stop(struct csi_pr
 		&priv->last_eof_comp, msecs_to_jiffies(IMX_MEDIA_EOF_TIMEOUT));
 	if (ret == 0)
 		v4l2_warn(&priv->sd, "wait last EOF timeout\n");
+}
 
+static void csi_idmac_stop(struct csi_priv *priv)
+{
 	devm_free_irq(priv->dev, priv->eof_irq, priv);
 	devm_free_irq(priv->dev, priv->nfb4eof_irq, priv);
 
@@ -681,6 +684,16 @@ idmac_stop:
 
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
 
@@ -688,8 +701,6 @@ static void csi_stop(struct csi_priv *pr
 		if (priv->fim)
 			imx_media_fim_set_stream(priv->fim, NULL, false);
 	}
-
-	ipu_csi_disable(priv->csi);
 }
 
 static const struct csi_skip_desc csi_skip[12] = {


