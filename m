Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED06CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED4C2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfCTOuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:50:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbfCTOt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:49:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4A48285B1;
        Wed, 20 Mar 2019 14:49:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-47.rdu2.redhat.com [10.10.120.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6EA4608AC;
        Wed, 20 Mar 2019 14:49:57 +0000 (UTC)
Subject: [RFC PATCH] ceph: Convert to fs_context
From:   David Howells <dhowells@redhat.com>
To:     ceph-devel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 20 Mar 2019 14:49:56 +0000
Message-ID: <155309339693.2324.9941108136967815885.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 20 Mar 2019 14:49:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch that converts ceph to use the new fs_context struct.  There
may be prerequisite commits in the branch detailed below.

The patch extends use of the parser infrastructure into libceph and rdb as
there's a shared parser.

This can be found in the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=mount-api-viro

Thanks,
David
---
David Howells (1):
      ceph: Convert to fs_context


 drivers/block/rbd.c             |  362 +++++++++++---------
 fs/ceph/cache.c                 |    9 -
 fs/ceph/cache.h                 |    2 
 fs/ceph/super.c                 |  697 +++++++++++++++++++--------------------
 fs/ceph/super.h                 |    1 
 fs/fs_context.c                 |    2 
 fs/fs_parser.c                  |    2 
 include/linux/ceph/ceph_debug.h |    1 
 include/linux/ceph/libceph.h    |   17 +
 net/ceph/ceph_common.c          |  410 ++++++++++-------------
 10 files changed, 726 insertions(+), 777 deletions(-)

