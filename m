Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD69C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62A620684
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521438;
	bh=jA44QCIhfUGgFcdIpEBSy+fLut9ArALwt49l6lBca3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LdQIdLLkP5WbryQnLS/1cXzq3ihRxdqNo0FLhnHHh2LRD3ZL0MjwAjAqEwu7u03j7
	 0Qb3+w2AzvqQQSmTSpnqkhUG8+lRX6iTmZ0zWyG/b8onAoAo9Uzzmi4N9SzGjSDH7V
	 l+tMMiO/Ovc6yeK45QBGLDVNb0Brj+dFxQiX7Fg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfLPShR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:37:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbfLPSG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:06:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 883552072B;
        Mon, 16 Dec 2019 18:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519587;
        bh=jA44QCIhfUGgFcdIpEBSy+fLut9ArALwt49l6lBca3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKNxZ3jLFjuOE3aQdgQzdgD3mGtTeYZXYqdIBVRGlslM8BdZoBpu2z0HpzkBglbd/
         JxM4rsdXpvl4BJmgJfNMBmbMqNBlEVu2mODFUQH1g9je0mGNTx/JStFSrpBIf4REOD
         RX3hQ9xbbf3cX5NBTsZyepYcTZhiILK5lrVFfKww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helen Koike <helen.koike@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 126/140] media: vimc: fix component match compare
Date:   Mon, 16 Dec 2019 18:49:54 +0100
Message-Id: <20191216174825.133286225@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

[ Upstream commit ee1c71a8e1456ab53fe667281d855849edf26a4d ]

If the system has other devices being registered in the component
framework, the compare function will be called with a device that
doesn't belong to vimc.
This device is not necessarily a platform_device, nor have a
platform_data (which causes a NULL pointer dereference error) and if it
does have a pdata, it is not necessarily type of struct vimc_platform_data.
So casting to any of these types is wrong.

Instead of expecting a given pdev with a given pdata, just expect for
the device it self. vimc-core is the one who creates them, we know in
advance exactly which object to expect in the match.

Fixes: 4a29b7090749 ("[media] vimc: Subdevices as modules")

Signed-off-by: Helen Koike <helen.koike@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Tested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vimc/vimc-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-core.c b/drivers/media/platform/vimc/vimc-core.c
index 27db8835c2410..8548fa93bcf65 100644
--- a/drivers/media/platform/vimc/vimc-core.c
+++ b/drivers/media/platform/vimc/vimc-core.c
@@ -243,10 +243,7 @@ static void vimc_comp_unbind(struct device *master)
 
 static int vimc_comp_compare(struct device *comp, void *data)
 {
-	const struct platform_device *pdev = to_platform_device(comp);
-	const char *name = data;
-
-	return !strcmp(pdev->dev.platform_data, name);
+	return comp == data;
 }
 
 static struct component_match *vimc_add_subdevs(struct vimc_device *vimc)
@@ -276,7 +273,7 @@ static struct component_match *vimc_add_subdevs(struct vimc_device *vimc)
 		}
 
 		component_match_add(&vimc->pdev.dev, &match, vimc_comp_compare,
-				    (void *)vimc->pipe_cfg->ents[i].name);
+				    &vimc->subdevs[i]->dev);
 	}
 
 	return match;
-- 
2.20.1



