Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F4FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F9A2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfDLPdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:33:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbfDLPde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:33:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE7EC308CEAA;
        Fri, 12 Apr 2019 15:33:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAFDE6092F;
        Fri, 12 Apr 2019 15:33:33 +0000 (UTC)
Subject: [PATCH net 0/6] rxrpc: Fixes
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Apr 2019 16:33:33 +0100
Message-ID: <155508321298.11035.7196100250886302901.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 12 Apr 2019 15:33:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a collection of fixes for rxrpc:

 (1) rxrpc_error_report() needs to call sock_error() to clear the error
     code from the UDP transport socket, lest it be unexpectedly revisited
     on the next kernel_sendmsg() call.  This has been causing all sorts of
     weird effects in AFS as the effects have typically been felt by the
     wrong RxRPC call.

 (2) Allow a kernel user of AF_RXRPC to easily detect if an rxrpc call has
     completed.

 (3) Allow errors incurred by attempting to transmit data through the UDP
     socket to get back up the stack to AFS.

 (4) Make AFS use (2) to abort the synchronous-mode call waiting loop if
     the rxrpc-level call completed.

 (5) Add a missing tracepoint case for tracing abort reception.

 (6) Fix detection and handling of out-of-order ACKs.

For the patch series:

Tested-by: Jonathan Billings <jsbillin@umich.edu>


The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	rxrpc-fixes-20190412

and can also be found on the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David
---
David Howells (1):
      rxrpc: Trace received connection aborts

Jeffrey Altman (1):
      rxrpc: Fix detection of out of order acks

Marc Dionne (4):
      rxrpc: Clear socket error
      rxrpc: Make rxrpc_kernel_check_life() indicate if call completed
      rxrpc: Allow errors to be returned from rxrpc_queue_packet()
      afs: Check for rxrpc call completion in wait loop


 Documentation/networking/rxrpc.txt |   16 +++++++++-------
 fs/afs/rxrpc.c                     |   24 +++++++++++++++++-------
 include/net/af_rxrpc.h             |    4 +++-
 net/rxrpc/af_rxrpc.c               |   14 +++++++++-----
 net/rxrpc/ar-internal.h            |    1 +
 net/rxrpc/conn_event.c             |   11 +++++++----
 net/rxrpc/input.c                  |   18 ++++++++++++------
 net/rxrpc/peer_event.c             |    5 +++++
 net/rxrpc/sendmsg.c                |   21 ++++++++++++---------
 9 files changed, 75 insertions(+), 39 deletions(-)

