Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560BAC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87DE2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="bUaTQmhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfFGHee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:34:34 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:59376 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbfFGHee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:34:34 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E72182E0AF1;
        Fri,  7 Jun 2019 10:34:30 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id CrueRdWKQS-YUOexwmw;
        Fri, 07 Jun 2019 10:34:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1559892870; bh=hIxHkhsRKJhTFSv6sxT6gpvOPkCywFWid6mF4RBVF4w=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=bUaTQmhTO2YrwyoavpCCKH1bPQmaYbtkg//7Jl7wIDoilLXcD1o6XIX+VoGeO4q/G
         pDz1CoXtN9aUwTpp1BKO0lNTxNozZWpzxJamUMY/q2daYvccLMRtskp5yZJbXctcEb
         IeSQtt+CgUa5F7yoVv5nGKVQsuG8zSDX4mo1NTCo=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:b19a:10ab:8629:85d9])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id YBLwBguXM6-YUeaTPmH;
        Fri, 07 Jun 2019 10:34:30 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] drivers/ata: remove flood "Enabling discard_zeroes_data"
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Fri, 07 Jun 2019 10:34:29 +0300
Message-ID: <155989286981.1471.16344793966539115439.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing this at each SCSI READ_CAPACITY command is too verbose.

Flag "discard_zeroes_data" is deprecated since commit 48920ff2a5a9
("block: remove the discard_zeroes_data flag").

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/ata/libata-scsi.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 391ac0503dc0..a475e94944b7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2735,10 +2735,8 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 			rbuf[14] |= 0x80; /* LBPME */
 
 			if (ata_id_has_zero_after_trim(args->id) &&
-			    dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM) {
-				ata_dev_info(dev, "Enabling discard_zeroes_data\n");
+			    dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM)
 				rbuf[14] |= 0x40; /* LBPRZ */
-			}
 		}
 		if (ata_id_zoned_cap(args->id) ||
 		    args->dev->class == ATA_DEV_ZAC)

