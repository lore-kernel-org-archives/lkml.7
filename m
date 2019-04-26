Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133A1C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D2220B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556303332;
	bh=OIOZkRSK3EEbkIHFsd6WIC61v5qOMoxLgz5qbe+RnS0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wczOA9q1slS2az1Qim4xzW9P/n8jecBx9u7pYSF+wDT0rKNUeNVTjnEL24oMfZwZE
	 kr2Z3EqYFlwzbxmIlh3WOPfViflcIo8wgeMl8yWOOKXS83MjG7/6hkk/iv41flyNZH
	 0kf8Vyy63uFfKXkcBtaQWtZIOogW2Y0zQQ0WaL/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfDZS2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfDZS2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:28:51 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CE142077B;
        Fri, 26 Apr 2019 18:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556303330;
        bh=OIOZkRSK3EEbkIHFsd6WIC61v5qOMoxLgz5qbe+RnS0=;
        h=From:To:Cc:Subject:Date:From;
        b=B4QJ7uc5hkRyZHwvzioiQvptXlOTeT6ZQ6+IaE7Co69HyTziPgKm6lPyBznq3UNhL
         tP0d1oItpJ3Y9lYxo6TBnbYiUAQyHBssqlY3RPbHLT5XNvsE1+SGloCUR4End0Zrc0
         bnCfv8eJtBzg4DSlav04Up41rEFT/WJ6sxmZ7/xI=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, gregkh@linuxfoundation.org, tj@kernel.org,
        jack@suse.cz, amir73il@gmail.com, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com, rafael@kernel.org
Subject: [PATCH 0/5] vfs: track the dentry name length in name_snapshot
Date:   Fri, 26 Apr 2019 14:28:42 -0400
Message-Id: <20190426182847.25088-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

name_snapshot will snapshot the current contents of a dentry's name for
later consumption. Several of those users end up needing to do a strlen
on the resulting string later. We already have that info in the original
dentry though, so we can do this a bit more efficiently by stuffing the
name length into the name_snapshot as well.

This is not well tested, but it built and booted. Do we have a testsuite
that exercises the fsnotify code, in particular?

Jeff Layton (5):
  dcache: track the length of the string in struct name_snapshot
  fsnotify: have fsnotify_move take a struct qstr instead of a string
  fsnotify: have fsnotify() take a qstr instead of a string
  fsnotify: change ->handle_event and send_to_group to take a qstr
  audit: fix audit_compare_dname_path to take a qstr

 fs/dcache.c                          | 11 +++++++----
 fs/debugfs/inode.c                   |  2 +-
 fs/kernfs/file.c                     |  6 ++++--
 fs/namei.c                           |  4 ++--
 fs/notify/dnotify/dnotify.c          |  2 +-
 fs/notify/fanotify/fanotify.c        |  2 +-
 fs/notify/fsnotify.c                 |  8 ++++----
 fs/notify/inotify/inotify.h          |  2 +-
 fs/notify/inotify/inotify_fsnotify.c |  6 +++---
 fs/overlayfs/export.c                |  2 +-
 include/linux/dcache.h               |  2 +-
 include/linux/fsnotify.h             | 17 ++++++++---------
 include/linux/fsnotify_backend.h     |  6 +++---
 kernel/audit.h                       |  3 ++-
 kernel/audit_fsnotify.c              |  5 +++--
 kernel/audit_tree.c                  |  2 +-
 kernel/audit_watch.c                 |  4 ++--
 kernel/auditfilter.c                 |  7 ++++---
 kernel/auditsc.c                     |  7 +++----
 19 files changed, 52 insertions(+), 46 deletions(-)

-- 
2.20.1

