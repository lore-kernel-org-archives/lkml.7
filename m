Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30E5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A437A21726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbfHVNKm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:10:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbfHVNKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:10:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00F3C36955;
        Thu, 22 Aug 2019 13:10:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A98DB5D772;
        Thu, 22 Aug 2019 13:10:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        yuehaibing@huawei.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32267.1566479439.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 22 Aug 2019 14:10:39 +0100
Message-ID: <32268.1566479439@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 22 Aug 2019 13:10:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are three fixes for afs:

 (1) Fix a cell record leak due to the default error not being cleared.

 (2) Fix an oops in tracepoint due to a pointer that may contain an error.

 (3) Fix the ACL storage op for YFS where the wrong op definition is being
     used.  By luck, this only actually affects the information appearing
     in traces.

David
---
The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20190822

for you to fetch changes up to 7533be858f5b9a036b9f91556a3ed70786abca8e:

  afs: use correct afs_call_type in yfs_fs_store_opaque_acl2 (2019-08-22 13:33:27 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (1):
      afs: Fix leak in afs_lookup_cell_rcu()

Marc Dionne (1):
      afs: Fix possible oops in afs_lookup trace event

YueHaibing (1):
      afs: use correct afs_call_type in yfs_fs_store_opaque_acl2

 fs/afs/cell.c      | 4 ++++
 fs/afs/dir.c       | 3 ++-
 fs/afs/yfsclient.c | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)
