Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A394C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C912087F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiG6p+L5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfDULsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 07:48:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45849 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDULsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 07:48:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so4585076pgk.12;
        Sun, 21 Apr 2019 04:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h25SF50tyXVax+xbR9rwt5N9iky28EFEb4s4IWQ/1P0=;
        b=oiG6p+L54Wro6phc+iiwvLShxIKHLoOq+V0jzo8HmPfC7ztQ8vyn55gkLq68S/JPzO
         ziapPZd4mgXxBNhSL3ZGfIbmD3/MJBw7wH+JMohEvahInk+Uyw88Cz5ej28/5pExBbWD
         pZ/968dUokRtdMCRc7HB1VaIJfYvagbmKjm9nQBuH7nsmpxq7ofcIY6A9NWAPFcvQjrl
         F59MwDKsYYQkS4k1mqeWBOgO+pLDE0AeydbAQSk9tdEaLOUW+AgXEw3EOO5eSoJ0OKzH
         AjnD++b7OzQ4W9B7JI39riki3ykcvzgND0LSGujdTT/KZnCQpBgJEgFhabKjPY9xZktd
         zPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h25SF50tyXVax+xbR9rwt5N9iky28EFEb4s4IWQ/1P0=;
        b=Jluo3f+w5/OhI1qC8qfBRUJjHW/IdmJAiHvVXZ/aj0FJ6cv6lef4IDJyP+ufLwBbdc
         LWGjSdoEDSh01SOVFUwyGgIgMrLDsKip7LB9anIU8pdXkqW59uW7DdcfUSBtQBsIKQ79
         N2n8FhLZMPM9EMqQN8BiGy113uZbMhSBzwuvI6tiTI9F/74T0BHj80tCALtgNXwI/ZEu
         lHZ5ZYjALm87l1L6SVyEFHb2M7TAp2SL99ZYAKvXo0w0RyTvBg6HMNIaW3ouharQdQdH
         9TtzkpSf3C7S2FaBO/iInWuHUvujVakI91f9IQT+AwV64q2ovLfZYc1gxtsa1C131mBs
         8Cpg==
X-Gm-Message-State: APjAAAX/o9DZfSnTbcDjIdMpzW6tgXorCiBO0JdzEcw1Dc6o6bbGChTw
        RE5tEAsLvMNkJNsrdRWHa8U=
X-Google-Smtp-Source: APXvYqy4euE0GEmW/Ht1Z3r7m0Veg/rXtlLMrGSzmNcIhYD/vcICr3xyf9JKJFCqgeoPO7TZS7uP/g==
X-Received: by 2002:a63:4620:: with SMTP id t32mr13261697pga.363.1555847298833;
        Sun, 21 Apr 2019 04:48:18 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id d187sm11316673pgc.43.2019.04.21.04.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 04:48:18 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Joerg Reuter <jreuter@yaina.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/06] net: ax25: fix misuse of %x
Date:   Sun, 21 Apr 2019 19:48:06 +0800
Message-Id: <20190421114806.20450-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p or %px rather than
cast to long type and printed with %8.8lx.
Change %8.8lx to %p to print the pointer.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 net/ax25/af_ax25.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 5d01edf..90c2831 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1888,8 +1888,8 @@ static int ax25_info_show(struct seq_file *seq, void *v)
 	 * magic dev src_addr dest_addr,digi1,digi2,.. st vs vr va t1 t1 t2 t2 t3 t3 idle idle n2 n2 rtt window paclen Snd-Q Rcv-Q inode
 	 */
 
-	seq_printf(seq, "%8.8lx %s %s%s ",
-		   (long) ax25,
+	seq_printf(seq, "%p %s %s%s ",
+		   ax25,
 		   ax25->ax25_dev == NULL? "???" : ax25->ax25_dev->dev->name,
 		   ax2asc(buf, &ax25->source_addr),
 		   ax25->iamdigi? "*":"");
-- 
2.11.0

