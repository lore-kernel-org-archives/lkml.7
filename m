Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02B9C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB672173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfGSOcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 10:32:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:41186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727717AbfGSOcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:32:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36936AFF1;
        Fri, 19 Jul 2019 14:32:24 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 0/4] Sleeping functions in invalid context bug fixes
Date:   Fri, 19 Jul 2019 15:32:18 +0100
Message-Id: <20190719143222.16058-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sending three "sleeping function called from invalid context" bug
fixes that I had on my TODO for a while.  All of them are ceph_buffer_put
related, and all the fixes follow the same pattern: delay the operation
until the ci->i_ceph_lock is released.

The first patch simply allows ceph_buffer_put to receive a NULL buffer so
that the NULL check doesn't need to be performed in all the other patches.
IOW, it's not really required, just convenient.

(Note: maybe these patches should all be tagged for stable.)

Luis Henriques (4):
  libceph: allow ceph_buffer_put() to receive a NULL ceph_buffer
  ceph: fix buffer free while holding i_ceph_lock in __ceph_setxattr()
  ceph: fix buffer free while holding i_ceph_lock in
    __ceph_build_xattrs_blob()
  ceph: fix buffer free while holding i_ceph_lock in fill_inode()

 fs/ceph/caps.c              |  5 ++++-
 fs/ceph/inode.c             |  7 ++++---
 fs/ceph/snap.c              |  4 +++-
 fs/ceph/super.h             |  2 +-
 fs/ceph/xattr.c             | 19 ++++++++++++++-----
 include/linux/ceph/buffer.h |  3 ++-
 6 files changed, 28 insertions(+), 12 deletions(-)

