Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A378C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D2A207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640605;
	bh=UTz8xAFQTx41k8diGA/HtQkDJBcUFQ9otGZxlUVZmbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IsniEdyVfyRuBeISALVZ9bXlfIGE2DVjbfmyNKaJPJ74B753WPgZkQpMU6PMb4Ejy
	 3DydAtdv4HXqoHybI3xj/Jy3so64eCbvpT/Fh60ahMR/7IZzji0PQiDE5T1yE4u0cS
	 15lVRWL1E9P1DYvq33AMOX0tgxqSuUnuvLkbL3MA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfL2RaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbfL2RaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:30:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83B8920409;
        Sun, 29 Dec 2019 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640601;
        bh=UTz8xAFQTx41k8diGA/HtQkDJBcUFQ9otGZxlUVZmbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2RjiKl/9uJEq9v+s0js1ezycm74rEFrsMcBGVFjYcBI8ItTmJTVAxp3LT0jtUnyKC
         42GLcclPgJYxIiVWNp6QjzsUXCryHeEhfBt8sbMLMYeLNZqoAcLBPXtQouVhNiwVAJ
         M0fIMGv5dijRe53z9XuKFb2+xp9drsvGJnVtyrrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/219] media: cx88: Fix some error handling path in cx8800_initdev()
Date:   Sun, 29 Dec 2019 18:17:45 +0100
Message-Id: <20191229162516.158448363@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit e1444e9b0424c70def6352580762d660af50e03f ]

A call to 'pci_disable_device()' is missing in the error handling path.
In some cases, a call to 'free_irq()' may also be missing.

Reorder the error handling path, add some new labels and fix the 2 issues
mentionned above.

This way, the error handling path in more in line with 'cx8800_finidev()'
(i.e. the remove function)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx88/cx88-video.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/cx88/cx88-video.c b/drivers/media/pci/cx88/cx88-video.c
index 7b113bad70d2..248fb3b6833c 100644
--- a/drivers/media/pci/cx88/cx88-video.c
+++ b/drivers/media/pci/cx88/cx88-video.c
@@ -1312,7 +1312,7 @@ static int cx8800_initdev(struct pci_dev *pci_dev,
 	core = cx88_core_get(dev->pci);
 	if (!core) {
 		err = -EINVAL;
-		goto fail_free;
+		goto fail_disable;
 	}
 	dev->core = core;
 
@@ -1358,7 +1358,7 @@ static int cx8800_initdev(struct pci_dev *pci_dev,
 				       cc->step, cc->default_value);
 		if (!vc) {
 			err = core->audio_hdl.error;
-			goto fail_core;
+			goto fail_irq;
 		}
 		vc->priv = (void *)cc;
 	}
@@ -1372,7 +1372,7 @@ static int cx8800_initdev(struct pci_dev *pci_dev,
 				       cc->step, cc->default_value);
 		if (!vc) {
 			err = core->video_hdl.error;
-			goto fail_core;
+			goto fail_irq;
 		}
 		vc->priv = (void *)cc;
 		if (vc->id == V4L2_CID_CHROMA_AGC)
@@ -1535,11 +1535,14 @@ static int cx8800_initdev(struct pci_dev *pci_dev,
 
 fail_unreg:
 	cx8800_unregister_video(dev);
-	free_irq(pci_dev->irq, dev);
 	mutex_unlock(&core->lock);
+fail_irq:
+	free_irq(pci_dev->irq, dev);
 fail_core:
 	core->v4ldev = NULL;
 	cx88_core_put(core, dev->pci);
+fail_disable:
+	pci_disable_device(pci_dev);
 fail_free:
 	kfree(dev);
 	return err;
-- 
2.20.1



