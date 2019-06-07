Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E122C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719CD2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Lzpi5dzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfFGHen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:34:43 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:46676 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbfFGHen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:34:43 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id E63BA2E0956;
        Fri,  7 Jun 2019 10:34:39 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 8jMNhgmr0x-YdlWYwfU;
        Fri, 07 Jun 2019 10:34:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1559892879; bh=5kesgdWUa0hLxgoOBvcgPl+MIKlLt888PUPzHfbM6p8=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=Lzpi5dzsewQhOK0gOHC1Gx8dArYgcfGZKxruSqTxxzdygp2KFIeos70tGQSvLhfGd
         15yVAAb/7Htn87viV6HKctJHuLAgncvqQLhSqoUUw2Nsa1FEMXwGnbQaHx8sMYsBep
         W7Yd9b23ZK8Vqi3ft9zN7E9U2d79mkFRl36Ywd+0=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:b19a:10ab:8629:85d9])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id C8fJwnqGf6-YdYqLFJv;
        Fri, 07 Jun 2019 10:34:39 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] drivers/ata: print trim features at device initialization
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Fri, 07 Jun 2019 10:34:39 +0300
Message-ID: <155989287898.1506.14253954112551051148.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print trim status once at ata device initialization in form:

ataX.YZ: trim: <supported|blacklisted>, queued: <no|yes|blacklisted>, zero_after_trim: <no|yes|maybe>

Full example:

  ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
  ata1.00: NCQ Send/Recv Log not supported
  ata1.00: ATA-9: SAMSUNG MZ7GE900HMHP-000DX, EXT03Y3Q, max UDMA/133
  ata1.00: 1758174768 sectors, multi 16: LBA48 NCQ (depth 32), AA
  ata1.00: trim: supported, queued: no, zero_after_trim: maybe
  ata1.00: NCQ Send/Recv Log not supported
  ata1.00: configured for UDMA/133
  scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG MZ7GE900 3Y3Q PQ: 0 ANSI: 5
  sd 0:0:0:0: [sda] 1758174768 512-byte logical blocks: (900 GB/838 GiB)
  sd 0:0:0:0: Attached scsi generic sg0 type 0
  sd 0:0:0:0: [sda] Write Protect is off
  sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
  sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
   sda: sda1 sda2
  sd 0:0:0:0: [sda] Attached SCSI disk

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/ata/libata-core.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index aaa57e0c809d..6ff33e79cfc2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2617,6 +2617,34 @@ int ata_dev_configure(struct ata_device *dev)
 			}
 		}
 
+		if (print_info && ata_id_has_trim(id)) {
+			const char *trim_status;
+			const char *trim_queued;
+			const char *trim_zero;
+
+			if (dev->horkage & ATA_HORKAGE_NOTRIM)
+				trim_status = "backlisted";
+			else
+				trim_status = "supported";
+
+			if (!ata_fpdma_dsm_supported(dev))
+				trim_queued = "no";
+			else if (dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM)
+				trim_queued = "backlisted";
+			else
+				trim_queued = "yes";
+
+			if (!ata_id_has_zero_after_trim(id))
+				trim_zero = "no";
+			else if (dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM)
+				trim_zero = "yes";
+			else
+				trim_zero = "maybe";
+
+			ata_dev_info(dev, "trim: %s, queued: %s, zero_after_trim: %s\n",
+				     trim_status, trim_queued, trim_zero);
+		}
+
 		/* Check and mark DevSlp capability. Get DevSlp timing variables
 		 * from SATA Settings page of Identify Device Data Log.
 		 */

