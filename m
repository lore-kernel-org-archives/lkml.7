Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EE0C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24848206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfD0Pcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:32:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60702 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbfD0PPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:12 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0000zB-0u; Sat, 27 Apr 2019 16:15:10 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004P9-IY; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gabriel Krisman Bertazi" <krisman@linux.vnet.ibm.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.238780757@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 020/202] sd: Clear PS bit before Mode Select.
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

From: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>

commit 2c5d16d6a9e7218e57b716e4fd9d77c776d21471 upstream.

According to SPC-4, in a Mode Select, the PS bit in Mode Pages is
reserved and must be set to 0 by the driver.  In the sd implementation,
function cache_type_store does a Mode Sense, which might set the PS bit
on the read buffer, followed by a Mode Select, which receives the same
buffer, without explicitly clearing the PS bit.  So, in cases where
target supports saving the Mode Page to a non-volatile location, we end
up doing a Mode Select with the PS bit set, which could cause an illegal
request error if the target is checking this.

This was observed on a new firmware change, which was subsequently
reverted, but this changes sd.c to be more compliant with SPC-4.

This patch clears the PS bit in the buffer returned by Mode Select,
right before it is used in the Mode Select command.

Signed-off-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/sd.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -192,6 +192,7 @@ cache_type_store(struct device *dev, str
 	buffer_data[2] &= ~0x05;
 	buffer_data[2] |= wce << 2 | rcd;
 	sp = buffer_data[0] & 0x80 ? 1 : 0;
+	buffer_data[0] &= ~0x80;
 
 	if (scsi_mode_select(sdp, 1, sp, 8, buffer_data, len, SD_TIMEOUT,
 			     SD_MAX_RETRIES, &data, &sshdr)) {

