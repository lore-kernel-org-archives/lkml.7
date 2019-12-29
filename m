Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BF4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6D422525
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641716;
	bh=NPabPQxlAlRgLta9Wp5g+qVUkDV7fJuVhnyOopc1cYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FX877Mh2gpP+0frrJL/hAgSSLzRaocQLYi1kPa9BbiPTCRfarAGwZtSisiZ7zTA8Y
	 1w1CP1E6+4Wyw702cYYwSza9cUHEMKBfA/RPUNCgXV4M86KbLnQz+62zhKRPmkn75g
	 Ci+Q8cnfNj1ZHQlFHpzQiwziJSVBnMYTUpAbc0xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfL2Rse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:48:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731474AbfL2Rsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:48:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 903A221744;
        Sun, 29 Dec 2019 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641711;
        bh=NPabPQxlAlRgLta9Wp5g+qVUkDV7fJuVhnyOopc1cYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pCJduSrFwOT4PNcq3+cRUvB3l0ttSJqR6eXU16DVlUAvCU+ALmu9v9GHk6/H2dwR5
         5Qz23YqCg8oQ3BRr+95eAgldm2gLuZ7sycHu4xsaZUa0IVHu7f46Ky97ZIhg2cf+0S
         qqxWwYpBaJLZOpgc0V8KWh3vXS83iXkBXGubws2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benoit Parrot <bparrot@ti.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 178/434] media: ov5640: Make 2592x1944 mode only available at 15 fps
Date:   Sun, 29 Dec 2019 18:23:51 +0100
Message-Id: <20191229172713.635485703@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benoit Parrot <bparrot@ti.com>

[ Upstream commit 981e445454531c9d5ac5d3fa8c0f1bd55262d001 ]

The sensor data sheet clearly state that 2592x1944 only works at 15 fps
make sure we don't try to miss configure the pll out of acceptable
range.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5640.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 500d9bbff10b..18dd2d717088 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1611,6 +1611,11 @@ ov5640_find_mode(struct ov5640_dev *sensor, enum ov5640_frame_rate fr,
 	    !(mode->hact == 640 && mode->vact == 480))
 		return NULL;
 
+	/* 2592x1944 only works at 15fps max */
+	if ((mode->hact == 2592 && mode->vact == 1944) &&
+	    fr > OV5640_15_FPS)
+		return NULL;
+
 	return mode;
 }
 
-- 
2.20.1



