Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E3BC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8A820659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6YA+GrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfLETJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:09:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44229 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbfLETJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575572969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KMSt1fsmGsnUyD3THB0TYricfW4Ly8DVOePbhwwALGg=;
        b=T6YA+GrMYUkH3t4RhMPpzFtfPb0KMX8wsZzMlCY6yTFySQhEbnshfuvuTvB8EnTlgLxWQJ
        0SarfoYzCXYH+UWlLpAbpEGXtJX2mR3H3hlfL99dW4D+h1CokDWNtifeA4knjEiXDja/Gr
        T8s08MFtUJ7GRzNcCQIRGk/3HFLBDJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-jGkiYA4RNLefmEkpwXdxyg-1; Thu, 05 Dec 2019 14:09:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 162B8DB60;
        Thu,  5 Dec 2019 19:09:22 +0000 (UTC)
Received: from max.com (ovpn-205-78.brq.redhat.com [10.40.205.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48CF8600D1;
        Thu,  5 Dec 2019 19:09:18 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [GIT PULL] GFS2 changes for the 5.5 merge window
Date:   Thu,  5 Dec 2019 20:09:15 +0100
Message-Id: <20191205190915.5468-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: jGkiYA4RNLefmEkpwXdxyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please consider pulling the following gfs2 changes?

Thanks a lot,
Andreas

The following changes since commit d5798141fd54cea074c3429d5803f6c41ade0ca8=
:

  gfs2: Fix initialisation of args for remount (2019-10-30 12:16:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gf=
s2-for-5.5

for you to fetch changes up to ade48088937f53fe0467162177726176813b9564:

  gfs2: Don't write log headers after file system withdraw (2019-11-21 11:3=
7:41 +0100)

----------------------------------------------------------------
GFS2 changes for this merge window:

Bob's extensive filesystem withdrawal and recovery testing:
- Don't write log headers after file system withdraw
- clean up iopen glock mess in gfs2_create_inode
- Close timing window with GLF_INVALIDATE_IN_PROGRESS
- Abort gfs2_freeze if io error is seen
- Don't loop forever in gfs2_freeze if withdrawn
- fix infinite loop in gfs2_ail1_flush on io error
- Introduce function gfs2_withdrawn
- fix glock reference problem in gfs2_trans_remove_revoke

Filesystems with a block size smaller than the page size:
- Fix end-of-file handling in gfs2_page_mkwrite
- Improve mmap write vs. punch_hole consistency

Other:
- Remove active journal side effect from gfs2_write_log_header
- Multi-block allocations in gfs2_page_mkwrite

Minor cleanups and coding style fixes:
- Remove duplicate call from gfs2_create_inode
- make gfs2_log_shutdown static
- make gfs2_fs_parameters static
- Some whitespace cleanups
- removed unnecessary semicolon

----------------------------------------------------------------
Aliasgar Surti (1):
      gfs2: removed unnecessary semicolon

Andreas Gruenbacher (6):
      gfs2: Some whitespace cleanups
      gfs2: Improve mmap write vs. punch_hole consistency
      gfs2: Multi-block allocations in gfs2_page_mkwrite
      gfs2: Fix end-of-file handling in gfs2_page_mkwrite
      gfs2: Remove active journal side effect from gfs2_write_log_header
      gfs2: Remove duplicate call from gfs2_create_inode

Ben Dooks (Codethink) (1):
      gfs2: make gfs2_fs_parameters static

Bob Peterson (9):
      gfs2: make gfs2_log_shutdown static
      gfs2: fix glock reference problem in gfs2_trans_remove_revoke
      gfs2: Introduce function gfs2_withdrawn
      gfs2: fix infinite loop in gfs2_ail1_flush on io error
      gfs2: Don't loop forever in gfs2_freeze if withdrawn
      gfs2: Abort gfs2_freeze if io error is seen
      gfs2: Close timing window with GLF_INVALIDATE_IN_PROGRESS
      gfs2: clean up iopen glock mess in gfs2_create_inode
      gfs2: Don't write log headers after file system withdraw

 fs/gfs2/aops.c       |  6 +++---
 fs/gfs2/bmap.c       | 11 +++++++++--
 fs/gfs2/file.c       | 56 ++++++++++++++++++++++++++++++++----------------=
----
 fs/gfs2/glock.c      | 16 ++++++++++-----
 fs/gfs2/glops.c      |  4 ++--
 fs/gfs2/inode.c      | 16 +++++++--------
 fs/gfs2/log.c        | 25 +++++++++++++++++++----
 fs/gfs2/log.h        |  2 +-
 fs/gfs2/lops.c       | 34 +++++++++++++++----------------
 fs/gfs2/lops.h       |  3 ++-
 fs/gfs2/meta_io.c    |  6 +++---
 fs/gfs2/ops_fstype.c |  5 ++---
 fs/gfs2/quota.c      |  4 ++--
 fs/gfs2/recovery.c   |  8 +++++---
 fs/gfs2/super.c      | 33 ++++++++++++++++++-------------
 fs/gfs2/sys.c        |  2 +-
 fs/gfs2/trans.c      |  2 ++
 fs/gfs2/util.c       |  2 +-
 fs/gfs2/util.h       |  9 +++++++++
 19 files changed, 152 insertions(+), 92 deletions(-)

