Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3560C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35FC20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfCQOZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 10:25:42 -0400
Received: from nautica.notk.org ([91.121.71.147]:44165 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfCQOZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 10:25:42 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id E3D10C009; Sun, 17 Mar 2019 15:25:39 +0100 (CET)
Date:   Sun, 17 Mar 2019 15:25:24 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [GIT PULL] 9p updates for 5.1
Message-ID: <20190317142524.GA5136@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a 9p update for 5.1; there honestly hasn't been much.

The memory leak fix has been commited rather recently because it was
sent fairly late, but it's simple enough that four days in -next should
be enough (that's why I waited till the last minute to send, sorry for
that - feel free to pick for rc2 if that makes a difference)


The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://github.com/martinetd/linux tags/9p-for-5.1

for you to fetch changes up to bb06c388fa20ae24cfe80c52488de718a7e3a53f:

  9p/net: fix memory leak in p9_client_create (2019-03-13 11:50:04
  +0100)

----------------------------------------------------------------
Pull request for inlusion in 5.1

Two fixes (leak on invalid mount argument and possible deadlock on
i_size update on 32bit smp) and a fall-through warning cleanup

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      9p: mark expected switch fall-through

Hou Tao (1):
      9p: use inode->i_lock to protect i_size_write() under 32-bit

zhengbin (1):
      9p/net: fix memory leak in p9_client_create

 fs/9p/v9fs_vfs.h       | 23 +++++++++++++++++++++--
 fs/9p/vfs_file.c       |  6 +++++-
 fs/9p/vfs_inode.c      | 23 +++++++++++------------
 fs/9p/vfs_inode_dotl.c | 27 ++++++++++++++-------------
 fs/9p/vfs_super.c      |  4 ++--
 net/9p/client.c        |  2 +-
 net/9p/trans_xen.c     |  2 +-
 7 files changed, 55 insertions(+), 32 deletions(-)
