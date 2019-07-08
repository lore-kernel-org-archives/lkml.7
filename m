Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD796C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36DE20651
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sKLUcW+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfGHEfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 00:35:05 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:43822 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfGHEfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 00:35:05 -0400
Received: by mail-qt1-f202.google.com with SMTP id e14so5992625qtq.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 21:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZXGmwA+XeENkAYd5ftaFanywmvtOLCwWOeTzJrEs5Ic=;
        b=sKLUcW+1AVvD4gurjkaUeKr3T3h+1Ce/zVIQuwkXpjtLjl5Lu6U98TWRFj3lYeAPVn
         88/uzOSxmYlvCTjRXWoKzf28dtWHwwBSj98/yd3x/vwbPRD71mJyF2VC5k2Cgv6kZSzi
         kVrDeNiy3xnjrissfSeVPEHPcrO0nh+FcH4z3p53prykjMbt8H5xkIZifHoxSrsBDX3X
         yVNN8P85FYgnhgnR10ON8tV4JkT8vrP7kaJU3TUBmoJA5sG7AIuukJrDnKEKpZhd+LmK
         fwMj+FCCkexrg68AOKq8lqUD6la4/0W+VpR+my+KLuCG4mt0kFJUxB5lJ98rCi0OdlN3
         lt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZXGmwA+XeENkAYd5ftaFanywmvtOLCwWOeTzJrEs5Ic=;
        b=CQHgM52byfWFlTu/mAiFFYkULLTjPrXXb4NVlZoPPMri27NUwou9gpMi9clHnmK71/
         R/P1fk98AYJnayB3xZLf/OspkGEf/H49Eez8w1TTN1sfT0PeglT+WFgWYKCB8l4UoG+5
         fI7sV/SckfR0V+Q/MPTT/yrMRjPFdVq1kmSCH/EYdJSIT4UCGnbvFVvzR5hKW1uJGFzt
         e6Z1aazU/Cw5/hRGjc78DVo4Hp5HGxbWgO/mOEonI4u9kj7r9inxBoHv+ZtIrO4mEQOO
         3TnznfVLDo6LiVvG2Xv8hMR40dKovEpx83D8KTDgpnxjcxI7iWk5wRY1bWHK7wm+ECLs
         rO2A==
X-Gm-Message-State: APjAAAXbaFfMtxRyj0kUbmZJowgRRu9VsyX3V+Y7dlYsvicB5xHXC+u3
        CnjH9MXkZNJVZLqgSRESSszHiqiUyehGgeo=
X-Google-Smtp-Source: APXvYqzxmwyW7+9NChV4+1X0v1CXImtnFbHy/0ZLto0TjMjM8rtoUvRfouj5xppedFpXjkwtCOzh0qJ5l2M4SUc=
X-Received: by 2002:a0c:ae24:: with SMTP id y33mr13364324qvc.106.1562560504076;
 Sun, 07 Jul 2019 21:35:04 -0700 (PDT)
Date:   Mon,  8 Jul 2019 12:34:56 +0800
Message-Id: <20190708043456.24935-1-oceanchen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4] f2fs: avoid out-of-range memory access
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

blkoff_off might over 512 due to fs corrupt or security
vulnerability. That should be checked before being using.

Use ENTRIES_IN_SUM to protect invalid value in cur_data_blkoff.

Signed-off-by: Ocean Chen <oceanchen@google.com>
---
 fs/f2fs/segment.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8dee063c833f..ac824f6632b6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3393,6 +3393,11 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 		seg_i = CURSEG_I(sbi, i);
 		segno = le32_to_cpu(ckpt->cur_data_segno[i]);
 		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
+		if (blk_off > ENTRIES_IN_SUM) {
+			f2fs_bug_on(sbi, 1);
+			f2fs_put_page(page, 1);
+			return -EFAULT;
+		}
 		seg_i->next_segno = segno;
 		reset_curseg(sbi, i, 0);
 		seg_i->alloc_type = ckpt->alloc_type[i];
-- 
2.22.0.410.gd8fdbe21b5-goog

