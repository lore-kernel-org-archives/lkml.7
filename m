Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F266AC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31812166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Govk6wKP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Ap7c/bGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfEQOos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 10:44:48 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51706 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728383AbfEQOor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 10:44:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3F3348EE109;
        Fri, 17 May 2019 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1558104287;
        bh=mcGx8l0bpynSMpo+hvq3Qr/3Kc5R0q0JO60PNFBW7Ro=;
        h=Subject:From:To:Cc:Date:From;
        b=Govk6wKPd9UXKjmaYRzfEntHmEJSD6zqMedacsDS3ZvwtLj3JVZ9c3Ptzu4EFrRZ/
         m4gCyTd0F+Eu2Ff+ZY1V4S1gtz1e7Orst/napXZrlL7gIvSnIZkoHwaYhLYLoSL9Xp
         SOEA8StC8v+A19RXxls9kGFCT5GzQ8z+5O0e7YWs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5nHc9zmrHS6O; Fri, 17 May 2019 07:44:47 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 53EF88EE0D5;
        Fri, 17 May 2019 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1558104286;
        bh=mcGx8l0bpynSMpo+hvq3Qr/3Kc5R0q0JO60PNFBW7Ro=;
        h=Subject:From:To:Cc:Date:From;
        b=Ap7c/bGPpqo8aQa19MOOsVoyTwFx1xEDW2Cj3SWMWTCkLd1m9Erqp5EC8fWBVs1t0
         Y66bcHDDKqwxXYMBbSdf8kieTTeUFzAdTMQ2K3k4A0nyXd0SzZxrRgwcmzdvOMmsax
         M6hYYwJjjbR+LorNzDXqgh9wvmDRVd0cBBTP7x8I=
Message-ID: <1558104285.3050.8.camel@HansenPartnership.com>
Subject: [GIT PULL] final round of SCSI updates for the 5.1+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 17 May 2019 07:44:45 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the final round of mostly small fixes in our initial
submit.  The fix for the read only regressions is the most extensive
change and also intrudes outside of SCSI because the partition and read
only handling is mostly in block.  The specific problem is the
inability to distinguish between devices marked read only by the
administrator and devices that come up read only but switch to
read/write once they are ready to receive data.  Without the fix these
devices are currently forced to stay read only causing regressions in
the enterprise.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Colin Ian King (1):
      scsi: bnx2fc: fix incorrect cast to u64 on shift operation

Erwan Velu (1):
      scsi: smartpqi: Reporting unhandled SCSI errors

James Smart (4):
      scsi: lpfc: Update lpfc version to 12.2.0.2
      scsi: lpfc: add check for loss of ndlp when sending RRQ
      scsi: lpfc: correct rcu unlock issue in lpfc_nvme_info_show
      scsi: lpfc: resolve lockdep warnings

Martin K. Petersen (1):
      scsi: sd: block: Fix regressions in read-only block device handling

Quinn Tran (1):
      scsi: qla2xxx: Add cleanup for PCI EEH recovery

YueHaibing (3):
      scsi: myrs: Fix uninitialized variable
      scsi: qedi: remove set but not used variables 'cdev' and 'udev'
      scsi: qedi: remove memset/memcpy to nfunc and use func instead

And the diffstat:

 block/blk-core.c                      |   2 +-
 block/genhd.c                         |  34 ++++--
 block/ioctl.c                         |   4 +
 block/partition-generic.c             |   7 +-
 drivers/scsi/bnx2fc/bnx2fc_hwi.c      |   2 +-
 drivers/scsi/lpfc/lpfc_attr.c         |  37 +++---
 drivers/scsi/lpfc/lpfc_els.c          |   5 +-
 drivers/scsi/lpfc/lpfc_sli.c          |  84 ++++++++-----
 drivers/scsi/lpfc/lpfc_version.h      |   2 +-
 drivers/scsi/myrs.c                   |   2 +-
 drivers/scsi/qedi/qedi_dbg.c          |  32 ++---
 drivers/scsi/qedi/qedi_iscsi.c        |   4 -
 drivers/scsi/qla2xxx/qla_os.c         | 221 +++++++++++++---------------------
 drivers/scsi/sd.c                     |   4 +-
 drivers/scsi/smartpqi/smartpqi_init.c |  23 ++--
 include/linux/genhd.h                 |  11 +-
 16 files changed, 230 insertions(+), 244 deletions(-)

James

