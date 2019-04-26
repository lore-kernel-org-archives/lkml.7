Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C11C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB91B20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfDZSwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:52:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41132 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDZSwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:52:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hK5x1-0005dL-1i; Fri, 26 Apr 2019 18:51:59 +0000
Date:   Fri, 26 Apr 2019 19:51:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, gregkh@linuxfoundation.org, tj@kernel.org,
        jack@suse.cz, amir73il@gmail.com, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com, rafael@kernel.org
Subject: Re: [PATCH 0/5] vfs: track the dentry name length in name_snapshot
Message-ID: <20190426185158.GB2217@ZenIV.linux.org.uk>
References: <20190426182847.25088-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426182847.25088-1-jlayton@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 02:28:42PM -0400, Jeff Layton wrote:
> name_snapshot will snapshot the current contents of a dentry's name for
> later consumption. Several of those users end up needing to do a strlen
> on the resulting string later. We already have that info in the original
> dentry though, so we can do this a bit more efficiently by stuffing the
> name length into the name_snapshot as well.
> 
> This is not well tested, but it built and booted. Do we have a testsuite
> that exercises the fsnotify code, in particular?

FWIW, my variant sits in vfs.git@work.dcache.

> Jeff Layton (5):
>   dcache: track the length of the string in struct name_snapshot
>   fsnotify: have fsnotify_move take a struct qstr instead of a string
>   fsnotify: have fsnotify() take a qstr instead of a string
>   fsnotify: change ->handle_event and send_to_group to take a qstr
>   audit: fix audit_compare_dname_path to take a qstr
> 
>  fs/dcache.c                          | 11 +++++++----
>  fs/debugfs/inode.c                   |  2 +-
>  fs/kernfs/file.c                     |  6 ++++--
>  fs/namei.c                           |  4 ++--
>  fs/notify/dnotify/dnotify.c          |  2 +-
>  fs/notify/fanotify/fanotify.c        |  2 +-
>  fs/notify/fsnotify.c                 |  8 ++++----
>  fs/notify/inotify/inotify.h          |  2 +-
>  fs/notify/inotify/inotify_fsnotify.c |  6 +++---
>  fs/overlayfs/export.c                |  2 +-
>  include/linux/dcache.h               |  2 +-
>  include/linux/fsnotify.h             | 17 ++++++++---------
>  include/linux/fsnotify_backend.h     |  6 +++---
>  kernel/audit.h                       |  3 ++-
>  kernel/audit_fsnotify.c              |  5 +++--
>  kernel/audit_tree.c                  |  2 +-
>  kernel/audit_watch.c                 |  4 ++--
>  kernel/auditfilter.c                 |  7 ++++---
>  kernel/auditsc.c                     |  7 +++----
>  19 files changed, 52 insertions(+), 46 deletions(-)

 fs/dcache.c                          | 14 ++++++--------
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
 include/linux/fsnotify.h             | 10 +++++-----
 include/linux/fsnotify_backend.h     |  6 +++---
 kernel/audit.h                       |  2 +-
 kernel/audit_fsnotify.c              |  2 +-
 kernel/audit_tree.c                  |  2 +-
 kernel/audit_watch.c                 |  4 ++--
 kernel/auditfilter.c                 |  6 +++---
 kernel/auditsc.c                     |  4 ++--
 19 files changed, 43 insertions(+), 43 deletions(-)

here...
