Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDA0C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F193204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428182;
	bh=gB4rxXtmZhaQAk8GNiRvnotbYsWheyhY6t08SUjxvUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vqHmo9oeDXLDOHpVyYx+f1lfd0CBHuVYhW0wV3aid7db05Ooud9WO0SveqMBp2mNR
	 nBW/1J+SaT+y9GLpP3Rq7r37JC6QRayyMBfINPYA2cejVkP63mkAU0WS9GVvdImgnL
	 vifNZZGtIoD27W6Y8Of7aeujxN33qhNOfVQdQBMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfEIS4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729174AbfEISzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:55:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90104204FD;
        Thu,  9 May 2019 18:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428108;
        bh=gB4rxXtmZhaQAk8GNiRvnotbYsWheyhY6t08SUjxvUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zrsiV788cMIlCtq9S9M5BysuEDUz5aL2u4S0NLOjyOO9ijNJDGBK+l2Rv3GE3oK2u
         xjhbbmouUwWVDKFSSdWvUA771HHSvgT6Qrfygq6oEyRjCaWueVA36fknc6zb3wxVnf
         PynUw7NiGU/hXRfLnJzyEhWD0jkg+c5RFsERp4TQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Christian Gromm <christian.gromm@microchip.com>
Subject: [PATCH 5.1 06/30] staging: most: sound: pass correct device when creating a sound card
Date:   Thu,  9 May 2019 20:42:38 +0200
Message-Id: <20190509181252.039168954@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181250.417203112@linuxfoundation.org>
References: <20190509181250.417203112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Gromm <christian.gromm@microchip.com>

commit 98592c1faca82a9024a64e4ecead68b19f81c299 upstream.

This patch fixes the usage of the wrong struct device when calling
function snd_card_new.

Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: Christian Gromm <christian.gromm@microchip.com>
Fixes: 69c90cf1b2fa ("staging: most: sound: call snd_card_new with struct device")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/most/sound/sound.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/most/sound/sound.c
+++ b/drivers/staging/most/sound/sound.c
@@ -622,7 +622,7 @@ static int audio_probe_channel(struct mo
 	INIT_LIST_HEAD(&adpt->dev_list);
 	iface->priv = adpt;
 	list_add_tail(&adpt->list, &adpt_list);
-	ret = snd_card_new(&iface->dev, -1, "INIC", THIS_MODULE,
+	ret = snd_card_new(iface->driver_dev, -1, "INIC", THIS_MODULE,
 			   sizeof(*channel), &adpt->card);
 	if (ret < 0)
 		goto err_free_adpt;


