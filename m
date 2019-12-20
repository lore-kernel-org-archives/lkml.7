Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01214C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A71227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hyderabad.bits-pilani.ac.in header.i=@hyderabad.bits-pilani.ac.in header.b="I37Cxop3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfLTFNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 00:13:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46648 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfLTFNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:13:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id y14so4536697pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 21:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hyderabad.bits-pilani.ac.in; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AN2HMEtlZTloepEi5WkVWopj4fyZSohv3ayMSlIeay4=;
        b=I37Cxop3XVLom5KaUjtRT9nkiC3GmgyAAzNglVIapUz6MdJhlDwYh21m/P3IqS+4rE
         iSPINhKy9V3y8EL7JU/eNypehC+3SkBUzQiB5mIQ9Iis+wTH8oh9kQ3YkYXDfE6/sPMn
         FiOF1HYBfjiUtYMY7Xe8d127uBPBTCK57TE2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AN2HMEtlZTloepEi5WkVWopj4fyZSohv3ayMSlIeay4=;
        b=bT7zHnUzoPPPUQiHWUy9WGrOTo15Xi+oYRCcpd+MjU9CL1Mnpl01dsSWaRntl9BKQq
         XYveZpoEXYGz5Am+VeTTAsLbrqRpjQvM02kzDiwQ29BuZVCuZs1M6a3P8YbLReqXFl2q
         9yZFc1rMnuDaKj5xv4AtG18HJLV1Ehz6VCkQmlzEj5K010uGYLU8FRBgV8invE/r426R
         wPAMY7V1CKN/PzyqKbzzl/4VvWrxX5Yd4nDLxdRDZyqaHXCjxgAUiLQQpJlFZn4dnJbc
         GLbL/Gz2IezUgKvTUSJNiExnTs7KxIf69bgXY6XvZHT6xgjqbWeV0S5Lc1Z20J1DHTll
         DTDw==
X-Gm-Message-State: APjAAAWShSzi/pmqigvhDWMJ3V3BYb5GcXkwFd39NkZvFFGq+sW5rSlj
        yq5htV9CVAIiqnrakQqStilFDw==
X-Google-Smtp-Source: APXvYqyFC7v9pOL0HKiSr0GhKQ8OZP5IbpItcaRPoMZU59n7C9qkC0YYaTU1HZuHWXyxOQNOHwUSrA==
X-Received: by 2002:aa7:81cc:: with SMTP id c12mr14012804pfn.143.1576818830384;
        Thu, 19 Dec 2019 21:13:50 -0800 (PST)
Received: from localhost.localdomain ([106.210.66.249])
        by smtp.googlemail.com with ESMTPSA id r37sm7409264pjb.7.2019.12.19.21.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 21:13:49 -0800 (PST)
From:   Simran Sandhu <f20171454@hyderabad.bits-pilani.ac.in>
To:     nsaenzjulienne@suse.de
Cc:     gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, tiwai@suse.de,
        wahrenst@gmx.net, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Staging: vc04_services: Fix checkpatch.pl error
Date:   Fri, 20 Dec 2019 10:44:14 +0530
Message-Id: <20191220051414.6484-1-f20171454@hyderabad.bits-pilani.ac.in>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CHECKPATH ERROR: Alignment should match open parenthesis was fixed by entroducing tabs and spaces on the location
drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:349

Signed-off-by: Simran Sandhu <f20171454@hyderabad.bits-pilani.ac.in>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 33485184a98a..c3ce6796abce 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -346,7 +346,7 @@ int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, const char *name,
 			&snd_bcm2835_playback_ops);
 
 	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
-		chip->card->dev, 128 * 1024, 128 * 1024);
+				       chip->card->dev, 128 * 1024, 128 * 1024);
 
 	if (spdif)
 		chip->pcm_spdif = pcm;
-- 
2.17.1

