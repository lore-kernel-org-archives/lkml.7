Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7811C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9134D218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfCOXlo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:41:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfCOXlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:41:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBB943089ED5;
        Fri, 15 Mar 2019 23:41:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D3181001DC9;
        Fri, 15 Mar 2019 23:41:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFS fixes and other bits
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12245.1552693296.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 15 Mar 2019 23:41:36 +0000
Message-ID: <12246.1552693296@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 15 Mar 2019 23:41:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a set of fixes and other bits for AFS to improve the life of desktop
applications such as firefox.  It makes the following improvements/fixes:

 (1) Fix file locking to allow fine-grained locking, as required by firefox
     and sqlite, with the caveat that you can't get a partial write lock on
     a file if you first get a partial read lock on it as the AFS protocol
     only supports whole-file locks.

     [At some point I need to look at how best to emulate OpenAFS's
     behaviour whereby all partial locks are just granted without reference
     to the kernel lock - maybe with some sort of mount parameter to enable
     it.]

 (2) Fix the way the server lock, once obtained, is distributed to the
     local processes waiting for it, thereby making sure they wait if they
     can't be immediately granted a local lock.

 (3) Fix the nonappearance of afs locks in /proc/locks.

 (4) Fix the handling of asynchronous file lock RPC operation failure on
     files that get deleted whilst the lock is being extended or released.

 (5) Implement silly-rename.

 (6) Fix the file lock expiry calculation to be based on the time the set-
     or extend-lock reply is seen (packet timestamp) rather than by the
     time at which we've done processing the operation (wallclock time) to
     allow for delays in processing.

 (7) Split the synchronous wait out of the client call dispatcher to make
     it possible to convert synchronous calls into async calls in the event
     of a signal.

The series also:

 (1) Adds/modifies a number of tracepoints, mostly related to file locking
     and silly rename.

 (2) Provides a more comprehensive data dump in the event that a directory
     content check fails.

David
---
The following changes since commit ebc551f2b8f905eca0e25c476c1e5c098cd92103:

  Merge tag 'nfsd-5.1' of git://linux-nfs.org/~bfields/linux (2019-03-12 15:06:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20190315

for you to fetch changes up to 78cf74c367eb608e8a15167da5aeae2c8abed902:

  afs: Add more tracepoints (2019-03-15 22:06:31 +0000)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
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

 fs/afs/Makefile            |   1 +
 fs/afs/dir.c               | 161 +++++++++++--
 fs/afs/dir_silly.c         | 239 +++++++++++++++++++
 fs/afs/flock.c             | 569 +++++++++++++++++++++++++++------------------
 fs/afs/fs_probe.c          |  13 +-
 fs/afs/fsclient.c          |  92 +++++---
 fs/afs/inode.c             |   2 +
 fs/afs/internal.h          |  25 +-
 fs/afs/rxrpc.c             |  33 ++-
 fs/afs/super.c             |   5 +-
 fs/afs/vl_probe.c          |  14 +-
 fs/afs/vlclient.c          |  26 ++-
 fs/afs/yfsclient.c         |  72 ++++--
 include/linux/fs.h         |   1 +
 include/trace/events/afs.h | 348 ++++++++++++++++++++++++++-
 15 files changed, 1258 insertions(+), 343 deletions(-)
 create mode 100644 fs/afs/dir_silly.c

