Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEC4218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfCOXHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:07:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfCOXHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:07:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 905D53001AD1;
        Fri, 15 Mar 2019 22:59:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45BA5183FA;
        Fri, 15 Mar 2019 22:59:21 +0000 (UTC)
Subject: [PATCH 00/10] AFS fixes
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Jonathan Billings <jsbillings@jsbillings.org>,
        Jonathan Billings <jsbillin@umich.edu>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Mar 2019 22:59:20 +0000
Message-ID: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 15 Mar 2019 22:59:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a set of bits and fixes for AFS to improve the life of desktop
applications such as firefox.  It makes the following improvements:

 (1) Allows fine-grained locking, as required by firefox and sqlite, with
     the caveat that you can't get a partial write lock on a file if you
     first get a partial read lock on it as the AFS protocol only supports
     whole-file locks.

     At some point I need to look at emulating OpenAFS's behaviour whereby
     all partial locks are just granted.

 (2) Makes processes requesting locks actually wait to get a lock where we
     have an appropriate server lock, but there's a conflicting server
     lock.

 (3) Makes locks appear in /proc/locks.

 (4) Handles asynchronous file lock RPC operation failure on files that get
     deleted whilst the lock is being extended or released.

 (5) Implements silly-rename so that locked files that are in use continue
     to exist if they get released or unlinked.

 (6) Lock expiry is now based on the time the set- or extend-lock reply is
     seen (packet timestamp) rather than by the time at which we've done
     processing the operation (wallclock time).

It also adds/modifies tracepoints to log:

 (1) File locking operations and events.

 (2) Directory content reload.

 (3) Silly rename.

 (4) Lookups.

 (5) Mounts (get_tree).

 (6) The afs_make_fs_call tracepoint is split to give two new variants that
     allow one or two names to be included in the log (such as the filename
     given to FS.MakeDir).

 (7) The afs_edit_dir tracepoint is given a larger name and this is
     surrounded by quotes when displayed.

This also provides a more comprehensive data dump in the event that a
directory content check fails.

The patches can be found here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git
	tag afs-fixes-20190315

David
---
David Howells (10):
      afs: Split wait from afs_make_call()
      afs: Calculate lock extend timer from set/extend reply reception
      afs: Fix AFS file locking to allow fine grained locks
      afs: Further fix file locking
      afs: Add file locking tracepoints
      afs: Improve dir check failure reports
      afs: Handle lock rpc ops failing on a file that got deleted
      afs: Add directory reload tracepoint
      afs: Implement sillyrename for unlink and rename
      afs: Add more tracepoints


 fs/afs/Makefile            |    1 
 fs/afs/dir.c               |  161 +++++++++++-
 fs/afs/dir_silly.c         |  239 ++++++++++++++++++
 fs/afs/flock.c             |  569 +++++++++++++++++++++++++++-----------------
 fs/afs/fs_probe.c          |   13 +
 fs/afs/fsclient.c          |   92 +++++--
 fs/afs/inode.c             |    2 
 fs/afs/internal.h          |   25 ++
 fs/afs/rxrpc.c             |   33 +--
 fs/afs/super.c             |    5 
 fs/afs/vl_probe.c          |   14 +
 fs/afs/vlclient.c          |   26 +-
 fs/afs/yfsclient.c         |   72 ++++--
 include/linux/fs.h         |    1 
 include/trace/events/afs.h |  348 +++++++++++++++++++++++++++
 15 files changed, 1258 insertions(+), 343 deletions(-)
 create mode 100644 fs/afs/dir_silly.c

