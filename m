Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9001C31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5A82187F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gb4iGaYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfFSRWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:22:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34261 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfFSRWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:22:22 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so392080iot.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4I5Ty62o91Pugxcg1FTgTnvgf8oL/T0SugxfMdF360=;
        b=gb4iGaYnPJYNqGfAxkP3X1NyZrCyL5DKEUxf/+boDKefd2UjG+qdworr0YK1ObtumN
         6uLmt1ytGOjQmAyYXv5eWn2+e/wwvBH4V0YZ02cusIrDbo9JldyQ2tukswmk+W03TQCZ
         3fJ2x8pKx2vhpksYet+kdD7iF28u6Vzn2HBLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4I5Ty62o91Pugxcg1FTgTnvgf8oL/T0SugxfMdF360=;
        b=nqRn8/7/LPtSqWgbWNWukukn+JnqaWc+vAcjUGaOsXyfpomFvIgVyF5GmyagUlm5aS
         8tc9f0vhqJkTbFtcwdiTG2/sAwTExodsxyYZVYrfeHGgIAnT7SCM2BEK1GweGwf1PCNW
         1I0d21IfW6LLr7tnf3dxluOD2ugKwvtZXTopzKc1c7JfGogLpyDymNkEoQs9lQGLajHO
         CznQrhU8I0NYs36s7T/nWfD1DHDPE5HZqI2UMrH7b5U0qh2gAMuayaHcfNLtEw/5vUhp
         ABp2YrwxR9/hv4Mgdm+dvZDy2D/4zQ09Tq3QFTXU9E1JQvRvQD1rGT+YMi/CPES1ISJf
         uSKw==
X-Gm-Message-State: APjAAAW1MxVvGOxmMoFv4rqCXfzX0NMJzkdxFxoa83XmTkUMx+fGVFYo
        1W9raBOX4IokuPEfOwm8VNP998EQhU4=
X-Google-Smtp-Source: APXvYqweh9cE0ZdyorzDcYNOiMgH/757F101nec4Tfciidd/HUUM94okf25BnwroKGtoHIwyBfvbEQ==
X-Received: by 2002:a02:ce37:: with SMTP id v23mr11907871jar.2.1560964940961;
        Wed, 19 Jun 2019 10:22:20 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id z26sm16377581ioi.85.2019.06.19.10.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 10:22:20 -0700 (PDT)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>
Subject: [PATCH 0/3] Add dirty range scoping to jbd2
Date:   Wed, 19 Jun 2019 11:21:53 -0600
Message-Id: <20190619172156.105508-1-zwisler@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes the issue I described here:

https://www.spinics.net/lists/linux-block/msg38274.html

Essentially the issue is that journal_finish_inode_data_buffers() operates
on the entire address space of each of the inodes associated with a given
journal entry.  This means that if we have an inode where we are constantly
appending dirty pages we can end up waiting for an indefinite amount of
time in journal_finish_inode_data_buffers().

This series improves this situation in ext4 by scoping each of the inode
dirty ranges associated with a given transaction.  Other users of jbd2
which don't (yet?) take advantage of this scoping (ocfs2) will continue to
have the old behavior.

Ross Zwisler (3):
  mm: add filemap_fdatawait_range_keep_errors()
  jbd2: introduce jbd2_inode dirty range scoping
  ext4: use jbd2_inode dirty range scoping

 fs/ext4/ext4_jbd2.h   | 12 +++++------
 fs/ext4/inode.c       | 13 +++++++++---
 fs/ext4/move_extent.c |  3 ++-
 fs/jbd2/commit.c      | 26 +++++++++++++++++------
 fs/jbd2/journal.c     |  2 ++
 fs/jbd2/transaction.c | 49 ++++++++++++++++++++++++-------------------
 include/linux/fs.h    |  2 ++
 include/linux/jbd2.h  | 22 +++++++++++++++++++
 mm/filemap.c          | 22 +++++++++++++++++++
 9 files changed, 114 insertions(+), 37 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

