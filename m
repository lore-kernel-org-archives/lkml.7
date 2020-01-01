Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADFBC2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D247F207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgAAS01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 13:26:27 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:13083
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727254AbgAAS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:26:26 -0500
X-IronPort-AV: E=Sophos;i="5.69,382,1571695200"; 
   d="scan'208";a="334542273"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 01 Jan 2020 19:26:24 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] ALSA: ml403-ac97cr: use resource_size
Date:   Wed,  1 Jan 2020 18:49:42 +0100
Message-Id: <1577900990-8588-3-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
References: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use resource_size rather than a verbose computation on
the end and start fields.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

<smpl>
@@ struct resource *ptr; @@
- ((ptr->end) - (ptr->start) + 1)
+ resource_size(ptr)
</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/drivers/ml403-ac97cr.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 4e6042e652f0..9de5caaf6047 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -1100,9 +1100,7 @@ snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
 	PDEBUG(INIT_INFO, "Trying to reserve resources now ...\n");
 	resource = platform_get_resource(pfdev, IORESOURCE_MEM, 0);
 	/* get "port" */
-	ml403_ac97cr->port = ioremap(resource->start,
-					     (resource->end) -
-					     (resource->start) + 1);
+	ml403_ac97cr->port = ioremap(resource->start, resource_size(resource));
 	if (ml403_ac97cr->port == NULL) {
 		snd_printk(KERN_ERR SND_ML403_AC97CR_DRIVER ": "
 			   "unable to remap memory region (%pR)\n",

