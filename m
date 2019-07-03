Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ECEC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E945C218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7YVlDmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfGCNQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:16:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45040 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCNQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:16:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so1263627pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+DvB3Z+H1GYKj8AUreOK5oVTkIn9VwzomvbKcoPU7M0=;
        b=I7YVlDmZck+Tz7oVlsoA1F/uJBXDtgCn7w25CoYRBrSR/hRo6EBAXNjCd/8UIcTpVh
         3gvKljVSh+jIDTqy9jaxlcPjZPC+3iZR924eS11tPDloELvlqMDqdnzMlVUC99UwHQZw
         FgotRx940/2D3JIGndd5QZAmWeTkIg6cv6ecwhnEuKKxO3F4OvtMKtAKelU2mAgr9WwP
         4M05g4Pl16VU7Fm6MLUFgaDA/H/T5HEOhP8Z2FmOLwyQopmKnDa7Jct8DMzM19/y9X/n
         67E0G3+r2UW+yoxxcpDroQsuAGDtxbGkMPDcUgVGSZ1v5fR3dqUQO86yxfU12i+HHhKB
         k79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+DvB3Z+H1GYKj8AUreOK5oVTkIn9VwzomvbKcoPU7M0=;
        b=mOvWU3DdgD2KFdyNCWdyhsrNMxXwj0ngDVLP7+LPozxBkiDBclxampby2zOWZE3ROf
         1x3/C+AFvaJ626ac+v1iCyq+VlVXGphTarRWovimjlYorGMJdLWCb14Sm4vfDB07qPga
         Lpf14nwuNlkks9tdbGFiIsH0lEt49Zrkx1bgOI8m/XlncSIRojnFfYwpCZu168DBzhAd
         BoAc2Uo7mDzLeiji/NPOZelIijLTIcpio1hlzSS4WcNY8jUXgeYiqWG2Y8fG9fPxNCx2
         IzSmogR2iQIsKHmoNifKqyH68TEQqXqc8rHUj7EXt3H4yVfZLcAe7d1cuKHvLuDPQJEx
         zeEQ==
X-Gm-Message-State: APjAAAVQ5sxqPjP7rpcBCOMQ3xZyiagYrHdkmWj5SofsUkZRHn4oz2CH
        WKK0gAVO0Ab78Vrrryg47fw=
X-Google-Smtp-Source: APXvYqwY43S72HiZd9bHbRflG5xXbDKfAbwZfeUec36qytcDuAxXOZlBTnU3fgM8zH8KViMm/QEXng==
X-Received: by 2002:a65:6245:: with SMTP id q5mr36338154pgv.394.1562159806312;
        Wed, 03 Jul 2019 06:16:46 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 5sm2573207pfh.109.2019.07.03.06.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:16:45 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 18/30] pcmcia: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:16:38 +0800
Message-Id: <20190703131638.25501-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/pcmcia/cistpl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index abd029945cc8..eff91726f121 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -414,14 +414,13 @@ int pcmcia_replace_cis(struct pcmcia_socket *s,
 	}
 	mutex_lock(&s->ops_mutex);
 	kfree(s->fake_cis);
-	s->fake_cis = kmalloc(len, GFP_KERNEL);
+	s->fake_cis = kmemdup(data, len, GFP_KERNEL);
 	if (s->fake_cis == NULL) {
 		dev_warn(&s->dev, "no memory to replace CIS\n");
 		mutex_unlock(&s->ops_mutex);
 		return -ENOMEM;
 	}
 	s->fake_cis_len = len;
-	memcpy(s->fake_cis, data, len);
 	dev_info(&s->dev, "Using replacement CIS\n");
 	mutex_unlock(&s->ops_mutex);
 	return 0;
-- 
2.11.0

