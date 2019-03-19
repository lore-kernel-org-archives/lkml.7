Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B08C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D122077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfCSQX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:23:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfCSQXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:23:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9711C8763A;
        Tue, 19 Mar 2019 16:23:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-47.rdu2.redhat.com [10.10.120.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A01C60C7F;
        Tue, 19 Mar 2019 16:23:23 +0000 (UTC)
Subject: [RFC PATCH 0/4] fuse: Convert to fs_context
From:   David Howells <dhowells@redhat.com>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, anprice@redhat.com
Date:   Tue, 19 Mar 2019 16:23:23 +0000
Message-ID: <155301260319.7556.1326405089184672936.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 19 Mar 2019 16:23:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miklós,

Here's a set of patches that convert fuse to use mount API:

 (1) Provide a replacement for mount_bdev() that takes an fs_context to
     specify the parameters.

     I also put a block device pointer and block device file mode into the
     fs_context struct for use in the sget_fc() test and set functions.

 (2) Improve handling of fd-type parameters.

 (3) Convert fuse to implement the mount API interface.

 (4) Move as much of the subtype parameter handling into the fuse driver as
     possible.

These are on top of:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=mount-api-viro

Thanks,
David
---
David Howells (4):
      vfs: Create fs_context-aware mount_bdev() replacement
      vfs: Make fs_parse() handle fs_param_is_fd-type params better
      fuse: Convert to mount API
      fuse: Move the subtype parameter into fuse


 fs/fs_context.c            |   14 --
 fs/fs_parser.c             |   15 ++
 fs/fuse/inode.c            |  289 +++++++++++++++++++++++++-------------------
 fs/super.c                 |  111 ++++++++++++++++-
 include/linux/fs_context.h |    7 +
 5 files changed, 291 insertions(+), 145 deletions(-)

