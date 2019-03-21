Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D2FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A43E218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbfCULrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:47:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfCULrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:47:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 559B988AB5;
        Thu, 21 Mar 2019 11:47:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0F605D9C5;
        Thu, 21 Mar 2019 11:47:32 +0000 (UTC)
Subject: [RFC PATCH 0/8] Convert mount_single-using filesystems to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Colin Cross <ccross@android.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tony Luck <tony.luck@intel.com>, Jeremy Kerr <jk@ozlabs.org>,
        Kees Cook <keescook@chromium.org>, linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Thu, 21 Mar 2019 11:47:32 +0000
Message-ID: <155316885201.29437.3428987891437242750.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 21 Mar 2019 11:47:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

Here's a set of patches that converts the mount_single()-using filesystems
to use the new fs_context struct.  There may be prerequisite commits in the
branch detailed below.

 (1) Add a new keying to vfs_get_super() that indicates that
     ->reconfigure() should be called instead of (*fill_super)() if the
     superblock already exists.

 (2) Convert debugfs.

 (3) Convert tracefs.

 (4) Convert pstore.

 (5) Fix a bug in hypfs.

 (6) Convert hypfs.

 (7) Convert spufs.

 (8) Kill off mount_single().

These can be found in the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=mount-api-viro

Thanks,
David
---
David Howells (8):
      vfs: Add a single-or-reconfig keying to vfs_get_super()
      vfs: Convert debugfs to fs_context
      vfs: Convert tracefs to fs_context
      vfs: Convert pstore to fs_context
      hypfs: Fix error number left in struct pointer member
      vfs: Convert hypfs to fs_context
      vfs: Convert spufs to fs_context
      vfs: Kill off mount_single()


 Documentation/filesystems/vfs.txt         |    4 -
 arch/powerpc/platforms/cell/spufs/inode.c |  207 ++++++++++++++++-------------
 arch/s390/hypfs/inode.c                   |  137 +++++++++++--------
 fs/debugfs/inode.c                        |  186 ++++++++++++--------------
 fs/pstore/inode.c                         |  110 ++++++++++-----
 fs/super.c                                |   73 ++--------
 fs/tracefs/inode.c                        |  180 ++++++++++++-------------
 include/linux/fs.h                        |    3 
 include/linux/fs_context.h                |    1 
 9 files changed, 446 insertions(+), 455 deletions(-)

