Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE86C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DBB2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257555;
	bh=Zyr4aSbEDROwoHBJ0w4OtgtinoYGGS7+bNQY43t3+B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SHUvGya99xW0vw+qLScRhCXXlzg4BnSAXR+SWoex8YH3YT07m5lQetqSamkuRjKPq
	 zIdZuI+dAKR01Tlwrf06bNCHLpv2Izi9cmxGo+t+ESpIrOWeK6uk3eX3Isr/LMsvCv
	 tcgEW0AOtmmjWnVqRt1SZUc7fEQPubhXOESxLfrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403755AbfCVMXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391101AbfCVMXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:23:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16D7D218B0;
        Fri, 22 Mar 2019 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257389;
        bh=Zyr4aSbEDROwoHBJ0w4OtgtinoYGGS7+bNQY43t3+B4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxA6GBl6BuxmNaho+UAQs6fW6rXHlsbnUYaNXoWD+R8EqicYPsDo+FycsKubHpKt6
         iktRCTSVPvBl/c0//Q8bXf/u9Dlu46nGgZWSvI9CX4qmUkf2KB6dN6Hc+Haq10FVrp
         DHZdkYN6V73uoDFHeSDuIcVdKI7SWQznv+IJD2EI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Fabio Estevam <festevam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.0 217/238] media: imx-csi: Input connections to CSI should be optional
Date:   Fri, 22 Mar 2019 12:17:16 +0100
Message-Id: <20190322111311.081904080@linuxfoundation.org>
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

commit 337e90ed028643c7acdfd0d31e3224d05ca03d66 upstream.

Some imx platforms do not have fwnode connections to all CSI input
ports, and should not be treated as an error. This includes the
imx6q SabreAuto, which has no connections to ipu1_csi1 and ipu2_csi0.
Return -ENOTCONN in imx_csi_parse_endpoint() so that v4l2-fwnode
endpoint parsing will not treat an unconnected CSI input port as
an error.

Fixes: c893500a16baf ("media: imx: csi: Register a subdev notifier")

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Tim Harvey <tharvey@gateworks.com>
Cc: stable@vger.kernel.org
Tested-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/media/imx/imx-media-csi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1787,7 +1787,7 @@ static int imx_csi_parse_endpoint(struct
 				  struct v4l2_fwnode_endpoint *vep,
 				  struct v4l2_async_subdev *asd)
 {
-	return fwnode_device_is_available(asd->match.fwnode) ? 0 : -EINVAL;
+	return fwnode_device_is_available(asd->match.fwnode) ? 0 : -ENOTCONN;
 }
 
 static int imx_csi_async_register(struct csi_priv *priv)


