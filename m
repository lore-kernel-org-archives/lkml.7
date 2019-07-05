Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428B0C468AA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231232133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfGEVpn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 17:45:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfGEVpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 17:45:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F5C9307D84D;
        Fri,  5 Jul 2019 21:45:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-9.rdu2.redhat.com [10.10.120.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FFE918958;
        Fri,  5 Jul 2019 21:45:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, jmorris@namei.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Miscellany for 5.3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29484.1562363139.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 05 Jul 2019 22:45:39 +0100
Message-ID: <29485.1562363139@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 05 Jul 2019 21:45:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a set of minor changes for AFS for the next merge window:

 (1) Remove an unnecessary check in afs_unlink().

 (2) Add a tracepoint for tracking callback management.

 (3) Add a tracepoint for afs_server object usage.

 (4) Use struct_size().

 (5) Add mappings for AFS UAE abort codes to Linux error codes, using
     symbolic names rather than hex numbers in the .c file.

David
---
The following changes since commit 2cd42d19cffa0ec3dfb57b1b3e1a07a9bf4ed80a:

  afs: Fix setting of i_blocks (2019-06-20 18:12:02 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-next-20190628

for you to fetch changes up to 1eda8bab70ca7d353b4e865140eaec06fedbf871:

  afs: Add support for the UAE error table (2019-06-28 18:37:53 +0100)

----------------------------------------------------------------
AFS development

----------------------------------------------------------------
David Howells (4):
      afs: afs_unlink() doesn't need to check dentry->d_inode
      afs: Add some callback management tracepoints
      afs: Trace afs_server usage
      afs: Add support for the UAE error table

Zhengyuan Liu (1):
      fs/afs: use struct_size() in kzalloc()

 fs/afs/callback.c          |  20 ++++---
 fs/afs/cmservice.c         |   5 +-
 fs/afs/dir.c               |  21 ++++----
 fs/afs/file.c              |   6 +--
 fs/afs/fsclient.c          |   2 +-
 fs/afs/inode.c             |  17 +++---
 fs/afs/internal.h          |  18 +++----
 fs/afs/misc.c              |  48 +++++++----------
 fs/afs/protocol_uae.h      | 132 +++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/rxrpc.c             |   2 +-
 fs/afs/server.c            |  39 +++++++++++---
 fs/afs/server_list.c       |   6 ++-
 fs/afs/write.c             |   3 +-
 include/trace/events/afs.h | 132 +++++++++++++++++++++++++++++++++++++++++++++
 14 files changed, 369 insertions(+), 82 deletions(-)
 create mode 100644 fs/afs/protocol_uae.h

