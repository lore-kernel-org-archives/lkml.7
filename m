Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55724C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227052184C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1g6PiII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfGCPd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:33:28 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:52601 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfGCPd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:33:27 -0400
Received: by mail-vs1-f73.google.com with SMTP id g189so84149vsc.19
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 08:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/6bGHYyTFS2kttBBEjE3ja94SSfbSSxkJ0m3sfLvbLw=;
        b=d1g6PiIIpFcSBKhxLW3TWAoUq5UUCQsATCOVnwBRhz9/DsRsQ+xuaKrbjWo6HTjFof
         KOu3qqTOz/u+lec6BcwCxvSeBVunH9TXhDw7o3rhYAVLrJ56qHWPOZ0RKz2mbTS/V3nZ
         9UO9kxCq8Zya6zrmOQku4WgYGtMXaJCdsRKm7TqCN2GSwFlNXkO20igq4WB181zqOWFE
         NK/S0HBVtjNnQMJuHUnIcAHI5/Oc5g9gSVRQph9LckzC6FysJMxmjPrIC172wYrrFQi1
         3B64QHwv8VfK6TQ+XYw6Yd5rRZOBDw0MuDo7wRq9rJ0lF9g3MHM0eTrEVR8RY+gburuH
         K2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/6bGHYyTFS2kttBBEjE3ja94SSfbSSxkJ0m3sfLvbLw=;
        b=cGmi4u8J4oPWpLFD6czIs1277ykrWcW+IR471o4aKuCST+T8R1n6MjO/vDTHUKSJQo
         nsn2dB0APijShfOBLn4o2fELYUDK6BNhfzZcYONikyS93n1TqXtfQTx278MJxuYt00Uf
         RJ4l/1HbuG/6cZpZHgUMD7JeWN6/aCcSuIel8w5KFDaCe96qXZN1jRzPI6Bg85mi9WKv
         GP8U5GZWE2gzS8dw+ocfBsoOFAXaZIC7DOQc359kCAcv1EUB4qHf5pTUghlXYbmnUA8L
         m7fpgNYmqp2VrlwYOeOcmRCD0EXIqSAuM3icmHeaWeaeII5PfoQnGd9X9GwoCGmAZI4b
         L4lQ==
X-Gm-Message-State: APjAAAW3o3PYyXO4TMfrXcR50OXRhQ8Jy3/QrHkKZmwWN2DvdsgMLgPj
        PedrAmjqlZhAxS+5RywUCteR3+hG1lKTpy4=
X-Google-Smtp-Source: APXvYqzrwdQGhOseYcg6xIM5JSFjAPspBRD77M05eXm8kqyCNWugf7glng5Xz6BJwUhoi80Y+lROqLL9UM9h8Y4=
X-Received: by 2002:ac5:c5a8:: with SMTP id f8mr4107446vkl.80.1562168006316;
 Wed, 03 Jul 2019 08:33:26 -0700 (PDT)
Date:   Wed,  3 Jul 2019 23:33:20 +0800
Message-Id: <20190703153320.203523-1-oceanchen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3] f2fs: avoid out-of-range memory access
From:   Ocean Chen <oceanchen@google.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     oceanchen@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_off might over 512 due to fs corrupt and should
be checked before being used.
Use ENTRIES_IN_SUM to protect invalid memory access.

--
v2:
- fix typo
v3:
- check blk_off before being used
--
Signed-off-by: Ocean Chen <oceanchen@google.com>
---
 fs/f2fs/segment.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8dee063c833f..c3eae3239345 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3401,6 +3401,9 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 		if (seg_i->alloc_type == SSR)
 			blk_off = sbi->blocks_per_seg;
 
+                if (blk_off >= ENTRIES_IN_SUM)
+                  return -EFAULT;
+
 		for (j = 0; j < blk_off; j++) {
 			struct f2fs_summary *s;
 			s = (struct f2fs_summary *)(kaddr + offset);
-- 
2.22.0.410.gd8fdbe21b5-goog

