Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC02AC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8C620717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380679;
	bh=OoFd6LHIGfcy+8FuV5qUsgVRuSFH1j4po4DWiHEIOVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JhdGiGPVJ0Kpt9aA2sQikuTmMqArdNDOXfqHjznIgRCGCogI3+vR/BxfR6nGu+0zp
	 5GIa3VysVIhnwL4miQHCIzHOKf7dHZJpa9tO2wtLodT8sLurGhFv2rhQW3/tpV110I
	 kUsNEWm1eEUXDc8ptVEKGvaRHM7+1vOTD9Mxcn1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390135AbfIMNR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390122AbfIMNRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:17:53 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8EAF20717;
        Fri, 13 Sep 2019 13:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380672;
        bh=OoFd6LHIGfcy+8FuV5qUsgVRuSFH1j4po4DWiHEIOVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vaK14gbPyH+5XpmIWxfKar1ky+R1Nnr+EON9PRBjWIE3EhgCFmywi5mGV6XksBQV3
         c6sIgvQmfHNKhl2Yik8A1blYsrS7GlDZ5Mh5znCyhfP7lyGdFrcoOJRrKYhsdGJPEA
         AQBUTz7xzCPuHtoaxYy7ND6jHw8+INbtHNdKL1KU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 117/190] media: i2c: tda1997x: select V4L2_FWNODE
Date:   Fri, 13 Sep 2019 14:06:12 +0100
Message-Id: <20190913130609.164200975@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5f2efda71c09b12012053f457fac7692f268b72c ]

Building tda1997x fails now unless V4L2_FWNODE is selected:

drivers/media/i2c/tda1997x.o: in function `tda1997x_parse_dt'
undefined reference to `v4l2_fwnode_endpoint_parse'

While at it, also sort the selections alphabetically

Fixes: 9ac0038db9a7 ("media: i2c: Add TDA1997x HDMI receiver driver")

Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
Cc: stable@vger.kernel.org # v4.17+
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 63c9ac2c6a5ff..8b1ae1d6680b7 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -60,8 +60,9 @@ config VIDEO_TDA1997X
 	tristate "NXP TDA1997x HDMI receiver"
 	depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API
 	depends on SND_SOC
-	select SND_PCM
 	select HDMI
+	select SND_PCM
+	select V4L2_FWNODE
 	---help---
 	  V4L2 subdevice driver for the NXP TDA1997x HDMI receivers.
 
-- 
2.20.1



