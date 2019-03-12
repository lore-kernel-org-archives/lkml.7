Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ED5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F120214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfCLOUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:20:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:58428 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfCLOUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:20:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B520B644;
        Tue, 12 Mar 2019 14:20:21 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v2 0/2] fix quota subdir mounts
Date:   Tue, 12 Mar 2019 14:20:17 +0000
Message-Id: <20190312142019.30936-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As recently reported in the ceph-users mailing-list[1], the kernel client
behaves differently from the fuse client regarding mounting subdirs where
quotas are in effect.  I've also created a bug to track this issue[2].

The following patches are a possible way of fixing this issue.  The
performance impact should be close to zero if the mount is done in the
CephFS root inode.  When we're mounting subdirs, we may have extra
queries to the MDSs, depending on how many extra realms we'll need to
loop through.

Changes since v1:

- Loop to free mdsc->quotarealms_inodes_list list was moved further down
  where it's not possible to race with insertions.  This way there's no need
  to hold the spinlock anymore.

- Clarified comments regarding the get_quota_realm function 'retry'
  parameter, both in the function itself and in function
  ceph_quota_is_same_realm, where that param is set to 'false'

- Distinguish between 'realm->inode is NULL' and igrab failures, both in
  get_quota_realm and check_quota_exceeded

Changes since RFC:

The 1st patch hasn't been changed since the initial RFC.  The 2nd patch
has been refactored to include the following changes:

- Zheng Yan's suggestions, i.e, move inode references from the realms to
  ceph_mds_client instance

- It now also handles other cases where an MDS lookup may need to be
  performed:
  * statfs when there are quotas
  * renames, to forbid cross-quota renames

[1] http://lists.ceph.com/pipermail/ceph-users-ceph.com/2019-February/033357.html
[2] https://tracker.ceph.com/issues/38482

Cheers,
--
Luís

Luis Henriques (2):
  ceph: factor out ceph_lookup_inode()
  ceph: quota: fix quota subdir mounts

 fs/ceph/export.c     |  14 +++++-
 fs/ceph/mds_client.c |  15 ++++++
 fs/ceph/mds_client.h |   2 +
 fs/ceph/quota.c      | 106 +++++++++++++++++++++++++++++++++++++++----
 fs/ceph/super.h      |   3 ++
 5 files changed, 129 insertions(+), 11 deletions(-)

