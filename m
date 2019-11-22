Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B3FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF8020672
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421934;
	bh=+kJ46tdBc7iKTbz5siqHX//KIp/joBunnPlMC3HRQM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LutMNciSX6lDiaUVGYBt53FEvDdOGSSp9sxPa/krIM2c1PmPkxf+0dQq+gpOcf0Wc
	 S2wC9kULCUbgZBuUl3ZPiIIbUF6UczJa+91KcIJCrdUwJ0MydER22okrMmR8BXpiFg
	 dyD0S+Dks11f+K7QnG/oGOct+mkQkvSPdn2xYkF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfKVKgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:36:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbfKVKgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:36:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A48ED20708;
        Fri, 22 Nov 2019 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418962;
        bh=+kJ46tdBc7iKTbz5siqHX//KIp/joBunnPlMC3HRQM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnlPx13WujUCpUksGdRrP+RZKtTekwfGBF0a9h+DTuC3C7hAp0Z7MBcJ3cLwsS7n3
         1qtql3EN15GSAa0mBvYf9EApfdyRkMEiNnNtL7EVX9lwBfigfwWJL425D5ygyrwM28
         sOoK8x7AnxdPhB6tMskrLMCe2tvSb0rE+tx//hb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krishna Ram Prakash R <krp@gtux.in>,
        Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 110/159] libata: have ata_scsi_rw_xlat() fail invalid passthrough requests
Date:   Fri, 22 Nov 2019 11:28:21 +0100
Message-Id: <20191122100827.633136905@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit 2d7271501720038381d45fb3dcbe4831228fc8cc upstream.

For passthrough requests, libata-scsi takes what the user passes in
as gospel. This can be problematic if the user fills in the CDB
incorrectly. One example of that is in request sizes. For read/write
commands, the CDB contains fields describing the transfer length of
the request. These should match with the SG_IO header fields, but
libata-scsi currently does no validation of that.

Check that the number of blocks in the CDB for passthrough requests
matches what was mapped into the request. If the CDB asks for more
data then the validated SG_IO header fields, error it.

Reported-by: Krishna Ram Prakash R <krp@gtux.in>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-scsi.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1654,6 +1654,21 @@ nothing_to_do:
 	return 1;
 }
 
+static bool ata_check_nblocks(struct scsi_cmnd *scmd, u32 n_blocks)
+{
+	struct request *rq = scmd->request;
+	u32 req_blocks;
+
+	if (!blk_rq_is_passthrough(rq))
+		return true;
+
+	req_blocks = blk_rq_bytes(rq) / scmd->device->sector_size;
+	if (n_blocks > req_blocks)
+		return false;
+
+	return true;
+}
+
 /**
  *	ata_scsi_rw_xlat - Translate SCSI r/w command into an ATA one
  *	@qc: Storage for translated ATA taskfile
@@ -1693,6 +1708,8 @@ static unsigned int ata_scsi_rw_xlat(str
 		scsi_10_lba_len(cdb, &block, &n_block);
 		if (cdb[1] & (1 << 3))
 			tf_flags |= ATA_TFLAG_FUA;
+		if (!ata_check_nblocks(scmd, n_block))
+			goto invalid_fld;
 		break;
 	case READ_6:
 	case WRITE_6:
@@ -1705,6 +1722,8 @@ static unsigned int ata_scsi_rw_xlat(str
 		 */
 		if (!n_block)
 			n_block = 256;
+		if (!ata_check_nblocks(scmd, n_block))
+			goto invalid_fld;
 		break;
 	case READ_16:
 	case WRITE_16:
@@ -1713,6 +1732,8 @@ static unsigned int ata_scsi_rw_xlat(str
 		scsi_16_lba_len(cdb, &block, &n_block);
 		if (cdb[1] & (1 << 3))
 			tf_flags |= ATA_TFLAG_FUA;
+		if (!ata_check_nblocks(scmd, n_block))
+			goto invalid_fld;
 		break;
 	default:
 		DPRINTK("no-byte command\n");


