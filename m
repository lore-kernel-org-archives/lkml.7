Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C292BC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934392186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbfHHFPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 01:15:36 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36466 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfHHFPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:15:36 -0400
Received: by mail-yw1-f66.google.com with SMTP id x67so32107239ywd.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 22:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zqjm4Ms2LWPF2JxoVedKSLuooEVD3FC/Jr22qU9ttc0=;
        b=OQmCdnT060VnjE2zspyMIDxNBbqt1c8DeP+zRRbmyjBmVqzI4NNh5Z1pdjnhHib5yN
         feYHU+Le59Z8DtAZw+0XdKYbHGhxlqiYWYdwo+AnYF8OITbAdMJWORtwwnVqqs6AGvla
         OjtbBnMK0ozG4wUaTABkWD7OivoTEERpC2e5hxVEq6gn3EAqplkHA6Cm4PVR6mNaoKYb
         /nwMYonjfVHY85fkLzsLGPYQWb8ufAcrhCiNlKcEMcndRw14kQqd8SkUGIYideHAWk3W
         /7gNxgD6H++Je5r7zvIxkqd6O9os9HA3dzuE34R1+AX/zWlxmJ3m1MA70kF2WhrvF5Cq
         n2MQ==
X-Gm-Message-State: APjAAAWYpMlo90ODLAv84rIdcERYaO4ay6ZrDoAnkxDmMKEJZv7GX1/Q
        fyTxsy+2MJIV+SJDpRY3AF4=
X-Google-Smtp-Source: APXvYqz08Zg+vgGovvm4k352MtWnv23Tf4vN81JusC7DQRnlND+8TfbEZkvXgCbk83qqGwiPPM57FA==
X-Received: by 2002:a81:33cd:: with SMTP id z196mr7990265ywz.213.1565241335327;
        Wed, 07 Aug 2019 22:15:35 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id v141sm20845902ywe.66.2019.08.07.22.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Aug 2019 22:15:34 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] sound: fix a memory leak bug
Date:   Thu,  8 Aug 2019 00:15:21 -0500
Message-Id: <1565241321-2418-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sound_insert_unit(), the controlling structure 's' is allocated through
kmalloc(). Then it is added to the sound driver list by invoking
__sound_insert_unit(). Later on, if __register_chrdev() fails, 's' is
removed from the list through __sound_remove_unit(). If 'index' is not less
than 0, -EBUSY is returned to indicate the error. However, 's' is not
deallocated on this execution path, leading to a memory leak bug.

To fix the above issue, free 's' before -EBUSY is returned.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/sound_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index b730d97..90d118c 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -275,7 +275,8 @@ static int sound_insert_unit(struct sound_unit **list, const struct file_operati
 				goto retry;
 			}
 			spin_unlock(&sound_loader_lock);
-			return -EBUSY;
+			r = -EBUSY;
+			goto fail;
 		}
 	}
 
-- 
2.7.4

