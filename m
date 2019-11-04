Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6E6CA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DD7222C7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfKDBpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:45:47 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39690 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728519AbfKDBpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:45:47 -0500
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41jjCj025708
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:45:45 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41jeeq019296
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:45:45 -0500
Received: by mail-qt1-f199.google.com with SMTP id h39so17394672qth.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 17:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=RKwtkBIAams4QpcFBs9xpUD62iCs2qKNfP05u/piSu4=;
        b=AO5gdnl6/n1fU/tF4RotQF3QLLmFHS8R9RaqsMET+7CT1jDKHAqOJeUsarOF1nUV4B
         retU206P85k+sOQwb3ETEFdOIRliK5viea9RPQlDHx2wLiQqUp2dmOtZsFDd+W+hWnex
         t15QwNLjnVZ9x3fvlOKKhgWvY2e2zLZJ8XpFLe2perDo5q4jVrE/EbJmrVUQjbrQ3G1w
         iXLiux2DYsALiQv0ae21eR/iKK8KCg51g8fpIdXXPdGZrjVOoJH1S5lzZWQhCIGtocr1
         PkxASnNdde0CL7HgaRwBgp+4wtRpCFKfeuSTT8vLIsFIYg1VPyGlQ4ave7XvsHTIwzKi
         mL9A==
X-Gm-Message-State: APjAAAV5TMT/xRH0G8QRBk/CL3sFCom/XBX5m2cstz4lcJt//gUR/+CW
        +4tFnOIRhdHBTXrQ55OSNTuYHIy6AoufgZ7Az+QWZIHn9wOCWaSPyFGMJsnd6Izzuvz6RgXmrsm
        Q1Yf3J5enuCD7PXX53QLSuY6NlIBvFe8kVzY=
X-Received: by 2002:a37:4d88:: with SMTP id a130mr14181907qkb.28.1572831940633;
        Sun, 03 Nov 2019 17:45:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzRNhCq1LyO5YV8hnPJUKHf4l41tnhvU4mUKxlg/F79Zm3mhjkpCGchHCc3XPJ/nQRA2xMtoA==
X-Received: by 2002:a37:4d88:: with SMTP id a130mr14181892qkb.28.1572831940271;
        Sun, 03 Nov 2019 17:45:40 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 17:45:39 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] staging: exfat: Clean up return codes, revisited
Date:   Sun,  3 Nov 2019 20:44:56 -0500
Message-Id: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rest of the conversion from internal error numbers to the
standard values used in the rest of the kernel.

Patch 10/10 is logically separate, merging multiple #defines
into one place in errno.h.  It's included in the series because
it depends on patch 1/10.

Valdis Kletnieks (10):
  staging: exfat: Clean up return codes - FFS_FORMATERR
  staging: exfat: Clean up return codes - FFS_MEDIAERR
  staging: exfat: Clean up return codes - FFS_EOF
  staging: exfat: Clean up return codes - FFS_INVALIDFID
  staging: exfat: Clean up return codes - FFS_ERROR
  staging: exfat: Clean up return codes - remove unused codes
  staging: exfat: Clean up return codes - FFS_SUCCESS
  staging: exfat: Collapse redundant return code translations
  staging: exfat: Correct return code
  errno.h: Provide EFSCORRUPTED for everybody

 drivers/staging/exfat/exfat.h        |  14 --
 drivers/staging/exfat/exfat_blkdev.c |  18 +-
 drivers/staging/exfat/exfat_cache.c  |   4 +-
 drivers/staging/exfat/exfat_core.c   | 202 +++++++++---------
 drivers/staging/exfat/exfat_super.c  | 293 +++++++++++----------------
 fs/erofs/internal.h                  |   2 -
 fs/ext4/ext4.h                       |   1 -
 fs/f2fs/f2fs.h                       |   1 -
 fs/xfs/xfs_linux.h                   |   1 -
 include/linux/jbd2.h                 |   1 -
 include/uapi/asm-generic/errno.h     |   1 +
 11 files changed, 228 insertions(+), 310 deletions(-)

-- 
2.24.0.rc1

