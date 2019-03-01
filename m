Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3CDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8CC2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbfCAPNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:13:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:41688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727952AbfCAPNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:13:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5733AD05;
        Fri,  1 Mar 2019 15:13:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6AAD51E13E2; Fri,  1 Mar 2019 16:13:00 +0100 (CET)
Date:   Fri, 1 Mar 2019 16:13:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Fanotify changes for v5.1-rc1
Message-ID: <20190301151300.GB15758@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.1-rc1

to get support for fanotify directory events and changes to make waiting
for fanotify permission event response killable.

Top of the tree is b51905798195. The full shortlog is:

Amir Goldstein (17):
      fsnotify: annotate directory entry modification events
      fsnotify: remove dirent events from FS_EVENTS_POSS_ON_CHILD mask
      fsnotify: send all event types to super block marks
      fsnotify: move mask out of struct fsnotify_event
      fanotify: rename struct fanotify_{,perm_}event_info
      fanotify: open code fill_event_metadata()
      fanotify: encode file identifier for FAN_REPORT_FID
      fanotify: copy event fid info to user
      fanotify: enable FAN_REPORT_FID init flag
      fanotify: cache fsid in fsnotify_mark_connector
      vfs: add vfs_get_fsid() helper
      fanotify: use vfs_get_fsid() helper instead of vfs_statfs()
      fsnotify: report FS_ISDIR flag with MOVE_SELF and DELETE_SELF events
      fanotify: check FS_ISDIR flag instead of d_is_dir()
      fanotify: support events with data type FSNOTIFY_EVENT_INODE
      fanotify: add support for create/attrib/move/delete events
      fanotify: report FAN_ONDIR to listener with FAN_REPORT_FID

Jan Kara (8):
      fanotify: Select EXPORTFS
      fanotify: Fold dequeue_event() into process_access_response()
      fanotify: Move locking inside get_one_event()
      fsnotify: Create function to remove event from notification list
      fanotify: Simplify cleaning of access_list
      fanotify: Track permission event state
      fanotify: Use interruptible wait when waiting for permission events
      fanotify: Make waits for fanotify events only killable

The diffstat is

 fs/notify/fanotify/Kconfig           |   1 +
 fs/notify/fanotify/fanotify.c        | 267 +++++++++++++++++++++----
 fs/notify/fanotify/fanotify.h        | 116 +++++++++--
 fs/notify/fanotify/fanotify_user.c   | 373 ++++++++++++++++++++++++-----------
 fs/notify/fsnotify.c                 |  15 +-
 fs/notify/inotify/inotify.h          |   1 +
 fs/notify/inotify/inotify_fsnotify.c |  18 +-
 fs/notify/inotify/inotify_user.c     |   5 +-
 fs/notify/mark.c                     |  42 +++-
 fs/notify/notification.c             |  42 ++--
 fs/statfs.c                          |  14 ++
 include/linux/fanotify.h             |  26 ++-
 include/linux/fsnotify.h             |  73 +++++--
 include/linux/fsnotify_backend.h     |  67 ++++---
 include/linux/statfs.h               |   3 +
 include/uapi/linux/fanotify.h        |  29 +++
 16 files changed, 828 insertions(+), 264 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
