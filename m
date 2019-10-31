Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6539DCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D2920873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfJaJ7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:59:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:34214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727130AbfJaJ7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:59:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50999B181;
        Thu, 31 Oct 2019 09:59:48 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        linux-ide@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v2 -resend 4/4] ata: sata_mv, avoid trigerrable BUG_ON
Date:   Thu, 31 Oct 2019 10:59:46 +0100
Message-Id: <20191031095946.7070-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031095946.7070-1-jslaby@suse.cz>
References: <20191031095946.7070-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several reports that the BUG_ON on unsupported command in
mv_qc_prep can be triggered under some circumstances:
https://bugzilla.suse.com/show_bug.cgi?id=1110252
https://serverfault.com/questions/888897/raid-problems-after-power-outage
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1652185
https://bugs.centos.org/view.php?id=14998

Let sata_mv handle the failure gracefully: warn about that incl. the
failed command number and return an AC_ERR_INVALID error. We can do that
now thanks to the previous patch.

Remove also the long-standing FIXME.

[v2] use %.2x as commands are defined as hexa.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
---
 drivers/ata/sata_mv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 5d5c8936a590..277f11909fc1 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2098,12 +2098,10 @@ static enum ata_completion_errors mv_qc_prep(struct ata_queued_cmd *qc)
 		 * non-NCQ mode are: [RW] STREAM DMA and W DMA FUA EXT, none
 		 * of which are defined/used by Linux.  If we get here, this
 		 * driver needs work.
-		 *
-		 * FIXME: modify libata to give qc_prep a return value and
-		 * return error here.
 		 */
-		BUG_ON(tf->command);
-		break;
+		ata_port_err(ap, "%s: unsupported command: %.2x\n", __func__,
+				tf->command);
+		return AC_ERR_INVALID;
 	}
 	mv_crqb_pack_cmd(cw++, tf->nsect, ATA_REG_NSECT, 0);
 	mv_crqb_pack_cmd(cw++, tf->hob_lbal, ATA_REG_LBAL, 0);
-- 
2.23.0

