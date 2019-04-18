Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB678C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCE32183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388332AbfDRJRe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:17:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfDRJRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:17:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE2BB3086224;
        Thu, 18 Apr 2019 09:17:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F92F5D9C5;
        Thu, 18 Apr 2019 09:17:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26448.1555579052.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 18 Apr 2019 10:17:32 +0100
Message-ID: <26449.1555579052@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 18 Apr 2019 09:17:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you pull these afs fixes please?  There are five:

 (1) Stop using the deprecated get_seconds().

 (2) Don't make tracepoint strings const as the section they go in isn't
     read-only.

 (3) Differentiate failure due to unmarshalling from other failure cases -
     we shouldn't abort with RXGEN_CC/SS_UNMARSHAL if it's not due to
     unmarshalling.

 (4) Add a missing unlock_page().

 (5) Fix the interaction between receiving a notification from a server
     that it has invalidated all outstanding callback promises and a client
     call that we're in the middle of making that will get a new promise.

Tested-by: Jonathan Billings <jsbillin@umich.edu>

Thanks,
David
---
The following changes since commit ed0de45a1008991fdaa27a0152befcb74d126a8b:

  ipv4: recompile ip options in ipv4_link_failure (2019-04-12 17:23:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20190413

for you to fetch changes up to eeba1e9cf31d064284dd1fa7bd6cfe01395bd03d:

  afs: Fix in-progess ops to ignore server-level callback invalidation (2019-04-13 08:37:37 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
Andi Kleen (1):
      afs: Avoid section confusion in CM_NAME

Arnd Bergmann (1):
      afs: avoid deprecated get_seconds()

David Howells (2):
      afs: Differentiate abort due to unmarshalling from other errors
      afs: Fix in-progess ops to ignore server-level callback invalidation

Marc Dionne (1):
      afs: Unlock pages for __pagevec_release()

 fs/afs/callback.c  | 3 +--
 fs/afs/cmservice.c | 2 +-
 fs/afs/inode.c     | 4 +---
 fs/afs/internal.h  | 4 +---
 fs/afs/rxrpc.c     | 6 +++++-
 fs/afs/server.c    | 1 -
 fs/afs/write.c     | 1 +
 7 files changed, 10 insertions(+), 11 deletions(-)
