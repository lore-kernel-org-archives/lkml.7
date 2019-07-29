Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC075C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810152070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428457;
	bh=6FcBgwCB5UyM7ZPScu2a0X9HOdI7+y5nBgg4KT1PRxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jqOLSO0Ih6ooXUzYRbttalk5Mr2GkNgpVRoWSczstse3DRwvTQu0B/93YfTmNaVyR
	 ON88ULmoiXC2m/2hm37mlZAkUHOMFC5xKqb4wJxz0hb6ds3RThJARV6OfBgJDdbVFX
	 RVuGkcyBP6Fn1TGaPHcUjTcsdIvtx9qzD3EQDwTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfG2T1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbfG2T1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:27:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8652621655;
        Mon, 29 Jul 2019 19:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428450;
        bh=6FcBgwCB5UyM7ZPScu2a0X9HOdI7+y5nBgg4KT1PRxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1CD6M6IHbQrtcL/yM6FwjNHCm3f0K0euVYnZrUY9Tt4Zs9FdYD5D2AGAAYAePHmAK
         qhtgek0Cu7SyDpaBS3Qm4zwNWQ/i3b6wr4V5nGTE/yg6MFv7U/JgtW1LL3Xuce5zhz
         zVAlG3/LlbOmWEzTA0OoKeFH4n5UePcAJQ8TAnPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 080/293] libata: dont request sense data on !ZAC ATA devices
Date:   Mon, 29 Jul 2019 21:19:31 +0200
Message-Id: <20190729190830.742783855@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ca156e006add67e4beea7896be395160735e09b0 ]

ZAC support added sense data requesting on error for both ZAC and ATA
devices. This seems to cause erratic error handling behaviors on some
SSDs where the device reports sense data availability and then
delivers the wrong content making EH take the wrong actions.  The
failure mode was sporadic on a LITE-ON ssd and couldn't be reliably
reproduced.

There is no value in requesting sense data from non-ZAC ATA devices
while there's a significant risk of introducing EH misbehaviors which
are difficult to reproduce and fix.  Let's do the sense data dancing
only for ZAC devices.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Tested-by: Masato Suzuki <masato.suzuki@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-eh.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2651c81d1edf..c398be4b1797 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1535,7 +1535,7 @@ static int ata_eh_read_log_10h(struct ata_device *dev,
 	tf->hob_lbah = buf[10];
 	tf->nsect = buf[12];
 	tf->hob_nsect = buf[13];
-	if (ata_id_has_ncq_autosense(dev->id))
+	if (dev->class == ATA_DEV_ZAC && ata_id_has_ncq_autosense(dev->id))
 		tf->auxiliary = buf[14] << 16 | buf[15] << 8 | buf[16];
 
 	return 0;
@@ -1784,7 +1784,8 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 	memcpy(&qc->result_tf, &tf, sizeof(tf));
 	qc->result_tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
 	qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
-	if ((qc->result_tf.command & ATA_SENSE) || qc->result_tf.auxiliary) {
+	if (dev->class == ATA_DEV_ZAC &&
+	    ((qc->result_tf.command & ATA_SENSE) || qc->result_tf.auxiliary)) {
 		char sense_key, asc, ascq;
 
 		sense_key = (qc->result_tf.auxiliary >> 16) & 0xff;
@@ -1838,10 +1839,11 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 	}
 
 	switch (qc->dev->class) {
-	case ATA_DEV_ATA:
 	case ATA_DEV_ZAC:
 		if (stat & ATA_SENSE)
 			ata_eh_request_sense(qc, qc->scsicmd);
+		/* fall through */
+	case ATA_DEV_ATA:
 		if (err & ATA_ICRC)
 			qc->err_mask |= AC_ERR_ATA_BUS;
 		if (err & (ATA_UNC | ATA_AMNF))
-- 
2.20.1



