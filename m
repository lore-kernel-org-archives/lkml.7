Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9765CC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6BF205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDI5YLs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfF0Rkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:40:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38065 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0Rkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:40:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so1589674pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0rd+HHwEwaFufPm/nP19OVluyAAMUA/lKkxxOcMsviQ=;
        b=YDI5YLs0MDw+5WnC5dScCDqD8cdNwyhpn4OfEq4jtGKwL7cpMof53L78nNvefoIj0S
         q2O7J0OHEWEOXpmHnrSRibKOIpo2JKe+AYcMPehgNhoTXm/qyf5bIK2ondC7Pm8ncpYD
         JTi+veZe174b94PAFWYAKeMdqrwfivnbx4zOXaEPaMEpeEpKY89YDBV12ZWHp707C1Oo
         i+ApKtpEmNMnsFADA6zn6CKsPPKbDYpXXJwVQEdzvCsXo2asGO38jJat/71m7hXEcbi7
         mYiFEFJ4FEQ4g8Yja2Fgd1zpS9Vg6mTuujYUmN1Jb05ZQsRVwKOcKKfFFwDXttI0xd0n
         d1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0rd+HHwEwaFufPm/nP19OVluyAAMUA/lKkxxOcMsviQ=;
        b=E5bRuyKsWXzUjqsuCypbbQf91ajrMYs2usTddSngV6WOLoIGUZUO6y+LFFOyk5Guw9
         IlDHAEvg/QDkXJwUWNmgc/M1KCzNlgTiiLEj0CKypNXdsgACGUasBi/b/Y6fmqSWaM78
         wzbRgOAzAj8JNSpdYvvI9Vb0tSNuJZS6mGWs/ZH6cdq+rrbZeeDt2Aq0QfBxL8ZDUuyp
         c7Gz/75it+HTUkOSeDG1nFE9sxShwqpXLfJy/h42s0p/CxFC6NcoYMqyKjk7oSnReHCO
         /mkh1ZNay37GSQvy6j0rUWVaR3GQfrh0CStGXMOpVwkw7y6uo8ha7AYvOAskdtIM/of3
         BjIA==
X-Gm-Message-State: APjAAAVtmvD6BZCNCXp3Q/Iul5z7H4aK5+00N0RXegnmUxgy2/NOV0bz
        mMEdawtz2Qc6h1P5ZcIQrsE=
X-Google-Smtp-Source: APXvYqx1B7pQmsqNqBPVklS2ZtuYp7+4DyC+DMSm/2VK7gB8UQ9GrRmoKNHr9sntE72Df0G0UDXtzA==
X-Received: by 2002:a63:e018:: with SMTP id e24mr4796653pgh.361.1561657246389;
        Thu, 27 Jun 2019 10:40:46 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id t5sm2567412pgh.46.2019.06.27.10.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:40:45 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 42/87] sound: oss: replace kmalloc + memset with kzalloc
Date:   Fri, 28 Jun 2019 01:40:28 +0800
Message-Id: <20190627174029.4125-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc + memset(0) -> kzalloc

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 sound/core/seq/oss/seq_oss_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
index 6dc94efc19c9..6e8020d4368a 100644
--- a/sound/core/seq/oss/seq_oss_init.c
+++ b/sound/core/seq/oss/seq_oss_init.c
@@ -66,7 +66,7 @@ snd_seq_oss_create_client(void)
 	struct snd_seq_port_info *port;
 	struct snd_seq_port_callback port_callback;
 
-	port = kmalloc(sizeof(*port), GFP_KERNEL);
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port) {
 		rc = -ENOMEM;
 		goto __error;
@@ -81,7 +81,6 @@ snd_seq_oss_create_client(void)
 	system_client = rc;
 
 	/* create annoucement receiver port */
-	memset(port, 0, sizeof(*port));
 	strcpy(port->name, "Receiver");
 	port->addr.client = system_client;
 	port->capability = SNDRV_SEQ_PORT_CAP_WRITE; /* receive only */
-- 
2.11.0

