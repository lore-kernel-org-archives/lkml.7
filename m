Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667C8C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBC9212F5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfD0PdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:33:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60620 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726580AbfD0PPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:10 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0000zG-Mx; Sat, 27 Apr 2019 16:15:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004OR-BA; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Icenowy Zheng" <icenowy@aosc.io>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.851263549@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 011/202] USB: storage: don't insert sane sense for
 SPC3+ when bad sense specified
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Icenowy Zheng <icenowy@aosc.io>

commit c5603d2fdb424849360fe7e3f8c1befc97571b8c upstream.

Currently the code will set US_FL_SANE_SENSE flag unconditionally if
device claims SPC3+, however we should allow US_FL_BAD_SENSE flag to
prevent this behavior, because SMI SM3350 UFS-USB bridge controller,
which claims SPC4, will show strange behavior with 96-byte sense
(put the chip into a wrong state that cannot read/write anything).

Check the presence of US_FL_BAD_SENSE when assuming US_FL_SANE_SENSE on
SPC4+ devices.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/storage/scsiglue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -223,8 +223,12 @@ static int slave_configure(struct scsi_d
 		if (!(us->fflags & US_FL_NEEDS_CAP16))
 			sdev->try_rc_10_first = 1;
 
-		/* assume SPC3 or latter devices support sense size > 18 */
-		if (sdev->scsi_level > SCSI_SPC_2)
+		/*
+		 * assume SPC3 or latter devices support sense size > 18
+		 * unless US_FL_BAD_SENSE quirk is specified.
+		 */
+		if (sdev->scsi_level > SCSI_SPC_2 &&
+		    !(us->fflags & US_FL_BAD_SENSE))
 			us->fflags |= US_FL_SANE_SENSE;
 
 		/* USB-IDE bridges tend to report SK = 0x04 (Non-recoverable

