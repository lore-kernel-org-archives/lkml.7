Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F997C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E43E243B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbbGY86H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfE3AxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 20:53:08 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:37686 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfE3AxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 20:53:08 -0400
Received: by mail-yw1-f73.google.com with SMTP id j68so3937914ywj.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 17:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=p0enTo1paGhtTCzKrRxNViLV0NJbbGkfixUzKcvFAIM=;
        b=fbbGY86HQAvMyuGABmIV5PWAqyAjKpNYQPTVcYsDDwLMglTCo/RHkGXEHGjlPQlO1i
         1maBy1XlB8ZPwQF1a4O65dbNcWKaebodjcj8l91tKo7tj7lfzms/LmWum3fYAkSCF9+a
         1MduZ6NgfZ4J4RsrcjHMnjmUA/OLn/1xplY3+eg6JF39R9cjdd0UM4lb5tbyKLyN2Flw
         Imwh+pgUv75Np9AyNwYEWKPBO/FRJRrzAlqLSYPGQ2W1XvDlp+vOaZzMVcUBsMuVa0aF
         UhUtZx1Rwvk2/6sFkV3HlEKjNDlqDECo3ImPqfc4klHFAG5mtBhfs4Gt4xbiOYfl1x3s
         9mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=p0enTo1paGhtTCzKrRxNViLV0NJbbGkfixUzKcvFAIM=;
        b=LbTranNk64Xv2s2+6Hd9wHSNf0u4aI9F9mKAcn+jGM2wenrfebqgcXpV4KZbtiXqTJ
         ry1kKYIzuSnQYP/ikCzPDRPeHFaURMP7ntf5TfK6mEhnok5mxIuU42zzI1Tu2youRBfn
         GoKZJ5TyOcCQXr77VAsnSvH49RWcQNP/hjqlWEnJdZ4UL8Rv/Iw+4BLOAAo9fMj/c6Yo
         SFey52g6gpFtmsJE6bRdp0zM8Zn6ijW/d2pUm9GlSOT0BWwk2DoHh5c/tUE8UvSwHXwm
         IsgvYO7bnGlZFCrPypJ7Vh5bJjmYLPzRo9L79xfU2CmLaSDnxV60GLp42HY7DOVeIEhq
         KjJw==
X-Gm-Message-State: APjAAAVvMkHcm1EvUIc5EqsPR/g/ksAYIk1ZVZMT6jHAK1zlVnXRpQOP
        QSWgj7Lg9BxrcVQBKbJlAQ8sLQZdcGg=
X-Google-Smtp-Source: APXvYqzWm35RV29MwLeQluK9gcDBYwAUwpZj3MTGP+M+S2CQ5CrRwwOROjnO+bcTCPD25gcsaXKtfsvXOEM=
X-Received: by 2002:a25:4050:: with SMTP id n77mr310800yba.77.1559177587174;
 Wed, 29 May 2019 17:53:07 -0700 (PDT)
Date:   Wed, 29 May 2019 17:49:02 -0700
Message-Id: <20190530004906.261170-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v3 0/4] F2FS Checkpointing without GC, related fixes
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch adjusts the default allowable holes for checkpointing, and
the next two patches fix underflow issues related to inc_valid_block_count
and inc_valid_node_count. The final one adds a new feature for
checkpointing where the user can specify an acceptable amount of space to
lose access to up front in checkpointing=disable mode instead of requiring
garbage collection.

There is still a question around what to do when the current reserved
space is less than reserved. As it stands, when a block is deleted, if it
was an old block, the space is not actually given back, and is marked as
unusable. But current reserve may still rise towards reserve, which would
make freeing one block result in a net loss of one block, as opposed to no
change. Reserved and unusable serve the same function, so it may make
sense to just handle it as max(current_reserved, unusable), which
effectively removes the double counting. I'm leaving that until later.

Changes from v2:
Adjust threshold for initial unusable blocks
Patches to fix underflows
Added option to set a block limit in addition to a percent for initial
unusable space

Daniel Rosenberg (4):
  f2fs: Lower threshold for disable_cp_again
  f2fs: Fix root reserved on remount
  f2fs: Fix accounting for unusable blocks
  f2fs: Add option to limit required GC for checkpoint=disable

 Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++
 Documentation/filesystems/f2fs.txt      | 19 +++++++-
 fs/f2fs/f2fs.h                          | 22 ++++++---
 fs/f2fs/segment.c                       | 21 +++++++--
 fs/f2fs/super.c                         | 62 ++++++++++++++++---------
 fs/f2fs/sysfs.c                         | 16 +++++++
 6 files changed, 115 insertions(+), 33 deletions(-)

-- 
2.22.0.rc1.257.g3120a18244-goog

