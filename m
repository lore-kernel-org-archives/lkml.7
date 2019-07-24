Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598E8C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287EC2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999309;
	bh=CtAqa9gAcg0NHvH/08mOU6QiU66YuoyzkZv05qCc68Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z4WKOIWh9IAsboHaMUlPb8CPjzuqyIotb7cxBg9ZVy1hRlpQjUYarJZC+d+EjOwOA
	 XURI4RnQqIgxEAAfKRQyWbRPL44XGTelUX1kCBihOXOP4JCyd+DWYHV2qMh/E5M9X1
	 JNVnWV90YGZDCZaLLKSDWbSZ5RnPn5bUU0mr8RKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392054AbfGXUPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404327AbfGXTyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:54:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE33D2147A;
        Wed, 24 Jul 2019 19:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998062;
        bh=CtAqa9gAcg0NHvH/08mOU6QiU66YuoyzkZv05qCc68Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/vYi6F9jqxWkYWG6MvrFgrBEeKqo8dVTdPe4sT2wxK+t+Nz6CbaIHqWe9NRjupor
         USFFa8hjLqtqWIYO+ljVhGhB8sMM+KHJlxOcnayrwQgdwbmkLnvrEtFNMLsJGKXVbx
         uvfCKUSlf68Tt8Gaa1LSTPeqXNFUVwrz0B3IcxuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.1 233/371] scsi: sd_zbc: Fix compilation warning
Date:   Wed, 24 Jul 2019 21:19:45 +0200
Message-Id: <20190724191742.043230362@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

commit 0cdc58580b37a160fac4b884266b8b7cb096f539 upstream.

kbuild test robot gets the following compilation warning using gcc 7.4
cross compilation for c6x (GCC_VERSION=7.4.0 make.cross ARCH=c6x).

   In file included from include/asm-generic/bug.h:18:0,
                    from arch/c6x/include/asm/bug.h:12,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/current.h:5,
                    from ./arch/c6x/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/blkdev.h:5,
                    from drivers//scsi/sd_zbc.c:11:
   drivers//scsi/sd_zbc.c: In function 'sd_zbc_read_zones':
>> include/linux/kernel.h:62:48: warning: 'zone_blocks' may be used
   uninitialized in this function [-Wmaybe-uninitialized]
    #define __round_mask(x, y) ((__typeof__(x))((y)-1))
                                                   ^
   drivers//scsi/sd_zbc.c:464:6: note: 'zone_blocks' was declared here
     u32 zone_blocks;
         ^~~~~~~~~~~

This is a false-positive report. The variable zone_blocks is always
initialized in sd_zbc_check_zones() before use. It is not initialized
only and only if sd_zbc_check_zones() fails.

Avoid this warning by initializing the zone_blocks variable to 0.

Fixes: 5f832a395859 ("scsi: sd_zbc: Fix sd_zbc_check_zones() error checks")
Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd_zbc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -431,7 +431,7 @@ int sd_zbc_read_zones(struct scsi_disk *
 {
 	struct gendisk *disk = sdkp->disk;
 	unsigned int nr_zones;
-	u32 zone_blocks;
+	u32 zone_blocks = 0;
 	int ret;
 
 	if (!sd_is_zoned(sdkp))


