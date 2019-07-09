Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A420C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FEF2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MegNdfGA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mDqk2MwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfGIUsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:48:01 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53384 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbfGIUsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:48:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1F2858EE247;
        Tue,  9 Jul 2019 13:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562705281;
        bh=cl1VPpg+tE6NRDAJ6sisoPfZ3T9/bMTEpZCT+ZTqjJc=;
        h=Subject:From:To:Cc:Date:From;
        b=MegNdfGA3SvvZh446bhGGZaUxQmFUQggx6+Dxj+RSpeNhLR5H5tjBI7H3iCzCQy13
         oJyV0EjkIWdbAXkHFouZjszWPg8jBN03WA13ell5wn3Qkr73y1plnwZID5OhDUZQhP
         iEe8y50Vdd9v/L4MB1zXHzb6hVrOVhlLZaBe5eh4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id apuTNqBS8u9E; Tue,  9 Jul 2019 13:48:00 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9A6F08EE15F;
        Tue,  9 Jul 2019 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562705280;
        bh=cl1VPpg+tE6NRDAJ6sisoPfZ3T9/bMTEpZCT+ZTqjJc=;
        h=Subject:From:To:Cc:Date:From;
        b=mDqk2MwAfI/9jdWDm0ngV7FB4/RcAOpjpydTeA7YygRnE8zuiBawM13xNTvO6jNQj
         vzJbLtmY+3xU5m+OlyhfKAiJRaG7tJ3PxW/+/rMIDzqOBEmb9pmy4nGR1i5OaqzQap
         8CdXNyYugNF6AcGv+HUpIxsG22FhaOXUCh/oKwBk=
Message-ID: <1562705278.30003.8.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI topic updates for the 5.2+ merge window: sg
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Jul 2019 13:47:58 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This topic branch covers a fundamental change in how our sg lists are
allocated to make mq more efficient by reducing the size of the
preallocated sg list.  This necessitates a large number of driver
changes because the previous guarantee that if a driver specified
SG_ALL as the size of its scatter list, it would get a non-chained list
and didn't need to bother with scatterlist iterators is now broken and
every driver *must* use scatterlist iterators.

This was broken out as a separate topic because we need to convert all
the drivers before pulling the trigger and unconverted drivers kept
being found, plus the odd bug, necessitating a rebase.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-sg

The short changelog is:

Finn Thain (2):
      scsi: NCR5380: use sg helper to iterate over scatterlist
      scsi: aha152x: use sg helper to iterate over scatterlist

Ming Lei (19):
      scsi: core: don't preallocate small SGL in case of NO_SG_CHAIN
      scsi: lib/sg_pool.c: clear 'first_chunk' in case of no preallocation
      scsi: core: avoid preallocating big SGL for data
      scsi: core: avoid preallocating big SGL for protection information
      scsi: lib/sg_pool.c: improve APIs for allocating sg pool
      scsi: esp: use sg helper to iterate over scatterlist
      scsi: wd33c93: use sg helper to iterate over scatterlist
      scsi: ppa: use sg helper to iterate over scatterlist
      scsi: pcmcia: nsp_cs: use sg helper to iterate over scatterlist
      scsi: imm: use sg helper to iterate over scatterlist
      scsi: s390: zfcp_fc: use sg helper to iterate over scatterlist
      scsi: staging: unisys: visorhba: use sg helper to iterate over scatterlist
      scsi: usb: image: microtek: use sg helper to iterate over scatterlist
      scsi: pmcraid: use sg helper to iterate over scatterlist
      scsi: ipr: use sg helper to iterate over scatterlist
      scsi: mvumi: use sg helper to iterate over scatterlist
      scsi: lpfc: use sg helper to iterate over scatterlist
      scsi: advansys: use sg helper to iterate over scatterlist
      scsi: vmw_pscsi: use sg helper to iterate over scatterlist

And the diffstat:

 drivers/nvme/host/fc.c                          |  7 ++--
 drivers/nvme/host/rdma.c                        |  7 ++--
 drivers/nvme/target/loop.c                      |  4 +--
 drivers/s390/scsi/zfcp_fc.c                     |  4 +--
 drivers/scsi/NCR5380.c                          | 41 ++++++++++------------
 drivers/scsi/advansys.c                         |  2 +-
 drivers/scsi/aha152x.c                          | 46 ++++++++++++-------------
 drivers/scsi/esp_scsi.c                         | 20 +++++++----
 drivers/scsi/esp_scsi.h                         |  2 ++
 drivers/scsi/imm.c                              |  2 +-
 drivers/scsi/ipr.c                              | 29 +++++++++-------
 drivers/scsi/lpfc/lpfc_nvmet.c                  |  3 +-
 drivers/scsi/mvumi.c                            | 11 +++---
 drivers/scsi/pcmcia/nsp_cs.c                    |  4 +--
 drivers/scsi/pmcraid.c                          | 14 ++++----
 drivers/scsi/ppa.c                              |  2 +-
 drivers/scsi/scsi_lib.c                         | 35 ++++++++++++++-----
 drivers/scsi/vmw_pvscsi.c                       |  2 +-
 drivers/scsi/wd33c93.c                          |  2 +-
 drivers/staging/unisys/visorhba/visorhba_main.c |  9 +++--
 drivers/usb/image/microtek.c                    | 20 +++++------
 drivers/usb/image/microtek.h                    |  2 +-
 include/linux/scatterlist.h                     | 11 +++---
 lib/scatterlist.c                               | 36 ++++++++++++-------
 lib/sg_pool.c                                   | 39 +++++++++++++++------
 net/sunrpc/xprtrdma/svc_rdma_rw.c               |  5 +--

James

