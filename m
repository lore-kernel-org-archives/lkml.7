Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8AEC606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21F120838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfGJJbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:31:34 -0400
Received: from relay.sw.ru ([185.231.240.75]:56410 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfGJJb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:31:26 -0400
Received: from [10.94.4.83] (helo=finist-ce7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <khorenko@virtuozzo.com>)
        id 1hl8wV-0003b5-Bg; Wed, 10 Jul 2019 12:31:15 +0300
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Prasad B Munirathnam <prasad.munirathnam@microsemi.com>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "Andrey Jr . Melnikov" <temnota.am@gmail.com>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: [PATCH v2 0/2] aacraid: Host adapter Adaptec 6405 constantly resets under high io load
Date:   Wed, 10 Jul 2019 12:31:11 +0300
Message-Id: <20190710093113.27936-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <2a6f5cc2-40cb-647c-003d-aae594d05062@virtuozzo.com>
References: <2a6f5cc2-40cb-647c-003d-aae594d05062@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem description:
====================
A node with Adaptec 6405 controller, latest BIOS V5.3-0[19204]
A lot of disks attached to the controller.
Simple test: running mkfs.ext4 on many disks on the same controller in
parallel
(mkfs is not important here, any serious io load triggers controller aborts)

Results:
* no problems (controller resets) with kernels prior to
  395e5df79a95 ("scsi: aacraid: Remove reference to Series-9")

* latest ms kernel v5.2-rc6-15-g249155c20f9b - mkfs processes are in D state,
  lot of complains in logs like:

  [  654.894633] aacraid: Host adapter abort request.
  aacraid: Outstanding commands on (0,1,43,0):
  [  699.441034] aacraid: Host adapter abort request.
  aacraid: Outstanding commands on (0,1,40,0):
  [  699.442950] aacraid: Host adapter reset request. SCSI hang ?
  [  714.457428] aacraid: Host adapter reset request. SCSI hang ?
  ...
  [  759.514759] aacraid: Host adapter reset request. SCSI hang ?
  [  759.514869] aacraid 0000:03:00.0: outstanding cmd: midlevel-0
  [  759.514870] aacraid 0000:03:00.0: outstanding cmd: lowlevel-0
  [  759.514872] aacraid 0000:03:00.0: outstanding cmd: error handler-498
  [  759.514873] aacraid 0000:03:00.0: outstanding cmd: firmware-471
  [  759.514875] aacraid 0000:03:00.0: outstanding cmd: kernel-60
  [  759.514912] aacraid 0000:03:00.0: Controller reset type is 3
  [  759.515013] aacraid 0000:03:00.0: Issuing IOP reset
  [  850.296705] aacraid 0000:03:00.0: IOP reset succeeded

Same complains on Ubuntu kernel 4.15.0-50-generic:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1777586

Controller:
===========
03:00.0 RAID bus controller: Adaptec Series 6 - 6G SAS/PCIe 2 (rev 01)
         Subsystem: Adaptec Series 6 - ASR-6405 - 4 internal 6G SAS ports

Test:
=====
# cat dev.list
/dev/sdq1
/dev/sde1
/dev/sds1
/dev/sdb1
/dev/sdk1
/dev/sdaj1
/dev/sdaf1
/dev/sdd1
/dev/sdac1
/dev/sdai1
/dev/sdz1
/dev/sdj1
/dev/sdy1
/dev/sdn1
/dev/sdae1
/dev/sdg1
/dev/sdi1
/dev/sdc1
/dev/sdf1
/dev/sdl1
/dev/sda1
/dev/sdab1
/dev/sdr1
/dev/sdo1
/dev/sdah1
/dev/sdm1
/dev/sdt1
/dev/sdp1
/dev/sdad1
/dev/sdh1

===========================================
# cat run_mkfs.sh
#!/bin/bash

while read i; do
   mkfs.ext4 $i -q -E lazy_itable_init=1 -O uninit_bg -m 0 &
done

=================================
# cat dev.list | ./run_mkfs.sh

The issue is 100% reproducible.

i've bisected to the culprit patch, it's
395e5df79a95 ("scsi: aacraid: Remove reference to Series-9")

it changes arc ctrl checks for Series-6 controllers
and i've checked that resurrection of original logic in arc ctrl checks
eliminates controller hangs/resets.

Konstantin Khorenko (2):
  Revert "scsi: aacraid: Remove reference to Series-9"
  scsi: aacraid: Remove references to Series-9 (only)

 drivers/scsi/aacraid/aacraid.h  | 11 -----------
 drivers/scsi/aacraid/comminit.c | 15 +++++++++++----
 drivers/scsi/aacraid/commsup.c  |  4 +++-
 drivers/scsi/aacraid/linit.c    |  8 +++++---
 4 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.15.1

