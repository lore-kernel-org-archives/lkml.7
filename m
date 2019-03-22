Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA78C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C25F2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257376;
	bh=pGKTugbWZrGldnIT/AIVmu0h3JfoiuCYFfBYUhVDcDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QfCxmtyyz8GfE7XcUptSu4yunfMFEkwzPHqahbgxjh3uXvpnMrijSyKNDI0uGnvX+
	 XqYYKgpftEQ66i+EfOWdm3rXWpsA6tg5NpJecg4VRVfCCDdEg2qEeEgcHXQgHftFRB
	 wlhwsTT0p6mMTd+Z2/hMfv4XhAC+qz9D82T9cSZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391071AbfCVMWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390852AbfCVMWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:22:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 724AE2054F;
        Fri, 22 Mar 2019 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257372;
        bh=pGKTugbWZrGldnIT/AIVmu0h3JfoiuCYFfBYUhVDcDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HskMJtrAmNFrjRwdcx1TqrDVbfliu2Jb6h3GZxUXdtNRH38whywL3JoN8wPNZWPR0
         464DrwPuTiL271cBMogI5MMb64DpvldAzrUlPQvG9zs7sW09Q/5IEmbHLIFTslNhI0
         JCifcJWetd/gV7UVmKFM1UGHpGeoIUNyqpO3G3yc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.0 212/238] media: imx: prpencvf: Stop upstream before disabling IDMA channel
Date:   Fri, 22 Mar 2019 12:17:11 +0100
Message-Id: <20190322111310.772674681@linuxfoundation.org>
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

commit a19c22677377b87e4354f7306f46ad99bc982a9f upstream.

Upstream must be stopped immediately after receiving the last EOF and
before disabling the IDMA channel. This can be accomplished by moving
upstream stream off to just after receiving the last EOF completion in
prp_stop(). For symmetry also move upstream stream on to end of
prp_start().

This fixes a complete system hard lockup on the SabreAuto when streaming
from the ADV7180, by repeatedly sending a stream off immediately followed
by stream on:

while true; do v4l2-ctl  -d1 --stream-mmap --stream-count=3; done

Eventually this either causes the system lockup or EOF timeouts at all
subsequent stream on, until a system reset.

The lockup occurs when disabling the IDMA channel at stream off. Stopping
the video data stream entering the IDMA channel before disabling the
channel itself appears to be a reliable fix for the hard lockup.

Fixes: f0d9c8924e2c3 ("[media] media: imx: Add IC subdev drivers")

Reported-by: Gaël PORTAY <gael.portay@collabora.com>
Tested-by: Gaël PORTAY <gael.portay@collabora.com>
Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Cc: stable@vger.kernel.org	# for 4.13 and up
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/media/imx/imx-ic-prpencvf.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -680,12 +680,23 @@ static int prp_start(struct prp_priv *pr
 		goto out_free_nfb4eof_irq;
 	}
 
+	/* start upstream */
+	ret = v4l2_subdev_call(priv->src_sd, video, s_stream, 1);
+	ret = (ret && ret != -ENOIOCTLCMD) ? ret : 0;
+	if (ret) {
+		v4l2_err(&ic_priv->sd,
+			 "upstream stream on failed: %d\n", ret);
+		goto out_free_eof_irq;
+	}
+
 	/* start the EOF timeout timer */
 	mod_timer(&priv->eof_timeout_timer,
 		  jiffies + msecs_to_jiffies(IMX_MEDIA_EOF_TIMEOUT));
 
 	return 0;
 
+out_free_eof_irq:
+	devm_free_irq(ic_priv->dev, priv->eof_irq, priv);
 out_free_nfb4eof_irq:
 	devm_free_irq(ic_priv->dev, priv->nfb4eof_irq, priv);
 out_unsetup:
@@ -717,6 +728,12 @@ static void prp_stop(struct prp_priv *pr
 	if (ret == 0)
 		v4l2_warn(&ic_priv->sd, "wait last EOF timeout\n");
 
+	/* stop upstream */
+	ret = v4l2_subdev_call(priv->src_sd, video, s_stream, 0);
+	if (ret && ret != -ENOIOCTLCMD)
+		v4l2_warn(&ic_priv->sd,
+			  "upstream stream off failed: %d\n", ret);
+
 	devm_free_irq(ic_priv->dev, priv->eof_irq, priv);
 	devm_free_irq(ic_priv->dev, priv->nfb4eof_irq, priv);
 
@@ -1148,15 +1165,6 @@ static int prp_s_stream(struct v4l2_subd
 	if (ret)
 		goto out;
 
-	/* start/stop upstream */
-	ret = v4l2_subdev_call(priv->src_sd, video, s_stream, enable);
-	ret = (ret && ret != -ENOIOCTLCMD) ? ret : 0;
-	if (ret) {
-		if (enable)
-			prp_stop(priv);
-		goto out;
-	}
-
 update_count:
 	priv->stream_count += enable ? 1 : -1;
 	if (priv->stream_count < 0)


