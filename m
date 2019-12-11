Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2871C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9694920637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9i6wuik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLKVSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:18:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbfLKVSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576099084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1gkHAV6AkdXG94RN9Oij+HZ41qo1cez84ILH4J7NqOk=;
        b=K9i6wuikcNLVc8b5rdQgvLCVsWR/RSB3Kp4tEpXp+Mf4nQn6R8WSVmlLR+lm2f++m8l/eE
        Y5ubjEIaqZI0HIXaLQMrEWSvQhitXxt0Yuk3AHyvvq+aR0gfWinWj+k8eBv+PKl8Dx8v+R
        q800ZZAusEc9NTHZ42s4TqwmNinbTSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-TDBzj13RNbGsMxE6IW3x0Q-1; Wed, 11 Dec 2019 16:18:01 -0500
X-MC-Unique: TDBzj13RNbGsMxE6IW3x0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C32791005502;
        Wed, 11 Dec 2019 21:17:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 639875DA2C;
        Wed, 11 Dec 2019 21:17:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        jsbillings@jsbillings.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Miscellaneous fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11742.1576099077.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 11 Dec 2019 21:17:57 +0000
Message-ID: <11743.1576099077@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you pull these fixes for AFS plus one patch to make debugging easier:

 (1) Fix how addresses are matched to server records.  This is currently
     incorrect which means cache invalidation callbacks from the server
     don't necessarily get delivered correctly.  This causes stale data an=
d
     metadata to be seen under some circumstances.

 (2) Make the dynamic root superblock R/W so that rpm/dnf can reapply the
     SELinux label to it when upgrading the Fedora filesystem-afs package.
     If the filesystem is R/O, this fails and the upgrade fails.

     It might be better in future to allow setxattr from an LSM to bypass
     the R/O protections, if only for pseudo-filesystems.

 (3) Fix the parsing of mountpoint strings.  The mountpoint object has to
     have a terminal dot, whereas the source/device string passed to mount
     should not.  This confuses type-forcing suffix detection leading to
     the wrong volume variant being mounted.

 (4) Make lookups in the dynamic root superblock for creation events (such
     as mkdir) fail with EOPNOTSUPP rather than something like EEXIST.  Th=
e
     dynamic root only allows implicit creation by the ->lookup() method -
     and only if the target cell exists.

 (5) Fix the looking up of an AFS superblock to include the cell in the
     matching key - otherwise all volumes with the same ID number are
     treated as the same thing, irrespective of which cell they're in.

 (6) Show the volume name of each volume in the volume records displayed i=
n
     /proc/net/afs/<cell>/volumes.  This proved useful in debugging (5) as
     it provides a way to map the volume IDs to names, where the names are
     what appear in /proc/mounts.

Patch (6) can be dropped and deferred to the next merge window if you'd
prefer as it's not strictly a fix.

David
---
The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35=
a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20191211

for you to fetch changes up to 50559800b76a7a2a46da303100da639536261808:

  afs: Show volume name in /proc/net/afs/<cell>/volumes (2019-12-11 17:48:=
20 +0000)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (5):
      afs: Fix SELinux setting security label on /afs
      afs: Fix mountpoint parsing
      afs: Fix creation calls in the dynamic root to fail with EOPNOTSUPP
      afs: Fix missing cell comparison in afs_test_super()
      afs: Show volume name in /proc/net/afs/<cell>/volumes

Marc Dionne (1):
      afs: Fix afs_find_server lookups for ipv4 peers

 fs/afs/dynroot.c |  3 +++
 fs/afs/mntpt.c   |  6 ++++--
 fs/afs/proc.c    |  7 ++++---
 fs/afs/server.c  | 21 ++++++++-------------
 fs/afs/super.c   |  2 +-
 5 files changed, 20 insertions(+), 19 deletions(-)

