Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C98C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBB8214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbfHHFvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 01:51:09 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44456 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730969AbfHHFvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:51:08 -0400
Received: by mail-yw1-f65.google.com with SMTP id l79so33452548ywe.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 22:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AXLTKpmnboGNtrfg+DmdekyXKJkeWsR7+WNv3PWE/bM=;
        b=uMM74YFs2pn431woWqsHjrz+umgCye3PnD14rvVvBGZO8f2HxtMhMsIx47nkD+Qq0d
         At4JKSXS8gHDKGzP7ZLwlIphW0J80DCd8xOuo+1VlnuooGbqEcwiHpb0G+6ZeFJKQe9R
         hObsAok+JEy9iy770XED/+1KllOIpA8oAnWhtuz//nkf5XMEXW6hHal3yK5Tgv3AI/lz
         AQXsf3wDwEpKP/lj8awMOr3h3GI7ZCLYa8UUXkQmXLtCqS7eoFd2SWOXkSYRucuTK97V
         pHQS0BFFZ2ag20awPd/TsWlzVyO0Cd+1H8NSLZiNZD/9PbwRnoEAfRLpmd/vqpftqFvh
         byNA==
X-Gm-Message-State: APjAAAXg9HXaJSjT+xshAg+lGA4bmGqv/hluMOUATe/gI+KO2x3B3NiQ
        P5C6D0csFGWo0tfFT0fbc+lHvXI7Z6U=
X-Google-Smtp-Source: APXvYqy04G9o5K9YSoY8D/Ys2fE3n/lh1gBpDYtzN1RRi/4fpOtXuOscLdRgaSUPvQnaasDNLm+h8Q==
X-Received: by 2002:a81:6288:: with SMTP id w130mr8042384ywb.343.1565243467745;
        Wed, 07 Aug 2019 22:51:07 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id q35sm1080020ywa.69.2019.08.07.22.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Aug 2019 22:51:06 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org (moderated list:FIREWIRE AUDIO DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: firewire: fix a memory leak bug
Date:   Thu,  8 Aug 2019 00:50:58 -0500
Message-Id: <1565243458-2771-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In iso_packets_buffer_init(), 'b->packets' is allocated through
kmalloc_array(). Then, the aligned packet size is checked. If it is
larger than PAGE_SIZE, -EINVAL will be returned to indicate the error.
However, the allocated 'b->packets' is not deallocated on this path,
leading to a memory leak.

To fix the above issue, free 'b->packets' before returning the error code.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/firewire/packets-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/packets-buffer.c b/sound/firewire/packets-buffer.c
index 0d35359..0ecafd0 100644
--- a/sound/firewire/packets-buffer.c
+++ b/sound/firewire/packets-buffer.c
@@ -37,7 +37,7 @@ int iso_packets_buffer_init(struct iso_packets_buffer *b, struct fw_unit *unit,
 	packets_per_page = PAGE_SIZE / packet_size;
 	if (WARN_ON(!packets_per_page)) {
 		err = -EINVAL;
-		goto error;
+		goto err_packets;
 	}
 	pages = DIV_ROUND_UP(count, packets_per_page);
 
-- 
2.7.4

