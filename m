Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03EBC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA2B208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077951;
	bh=BBUTOnmzbk679WZo0LdMjfkFx6maVge5rDaTs4qGywU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MuYdAaHd4fQlXi0rj3XtqYCDIvBoYkiCG+JTKLQqxSMJtg1xRGCrkkukwYgZyOSQr
	 s8raNOXuc45uDa6EiK5A9xnHvy4HkmNrSnRFnceCuIwT8olEaRQm1qAteOUHpO4uL2
	 dPuscdgxFZhyI3crva+ujfJtLIZSwyv+L2c9dmDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbfLKPZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:25:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732734AbfLKPZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:25:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA213208C3;
        Wed, 11 Dec 2019 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077947;
        bh=BBUTOnmzbk679WZo0LdMjfkFx6maVge5rDaTs4qGywU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cex+7JipgkkLZq2lmh0kW58r75noTOTc/N9KtMxCLrwZvvxi+jJsRa3q+o6zGN9un
         LOcYYBGmQrGNPdbgk2tZDzyXraPynL3AZ69ukx+QpgdI2uHoExGa8IB4as+/0vr+1v
         RvN/fAxiFL5I8XK0r+YNV1rdP7t+3QRXYOiJnzK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helen Koike <helen.koike@collabora.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 194/243] media: vimc: fix start stream when link is disabled
Date:   Wed, 11 Dec 2019 16:05:56 +0100
Message-Id: <20191211150352.274427125@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Fornazier <helen.koike@collabora.com>

[ Upstream commit e159b6074c82fe31b79aad672e02fa204dbbc6d8 ]

If link is disabled, media_entity_remote_pad returns NULL, causing a
NULL pointer deference.
Ignore links that are not enabled instead.

Signed-off-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vimc/vimc-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/vimc/vimc-common.c b/drivers/media/platform/vimc/vimc-common.c
index 204aa6f554e4d..fa8435ac2b1ae 100644
--- a/drivers/media/platform/vimc/vimc-common.c
+++ b/drivers/media/platform/vimc/vimc-common.c
@@ -241,6 +241,8 @@ int vimc_pipeline_s_stream(struct media_entity *ent, int enable)
 
 		/* Start the stream in the subdevice direct connected */
 		pad = media_entity_remote_pad(&ent->pads[i]);
+		if (!pad)
+			continue;
 
 		if (!is_media_entity_v4l2_subdev(pad->entity))
 			return -EINVAL;
-- 
2.20.1



