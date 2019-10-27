Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E377CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F313208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211326;
	bh=ReglJFEYFZJHDzlpCC3pzyMEJOdfKYqm49G+LpI+siY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZEKcwirZ5Qlh7d7EExa1ILUY7uHPoq0gxMs1EJ8vZBA1tujwIk5xhlBLanT94beHk
	 00dK1aVbDzJess5qjhJhsm4RmaM/MFIjGUMoslAYS56eJCsdxCjjD0oMSP0UCBt1fC
	 qOCCZWhWrohxlgJWdYDsOpdlTMi2LfGyTyABp2kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbfJ0VWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732053AbfJ0VWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:22:01 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDC282070B;
        Sun, 27 Oct 2019 21:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211321;
        bh=ReglJFEYFZJHDzlpCC3pzyMEJOdfKYqm49G+LpI+siY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSSIxS/2aLYb2Moboa2+wiFHNeMW435BcVxCgBHpv5eqDlbPHHhlyuphmXY2SpNQg
         YRMWPJH/iP9LuKEBVEiKKo/PMGwRQ9Kz/y3H6CmN+jK0HDqH5V1XrCAY04wG07uHHk
         r11bb9CJ9vOGdPPdhsbmouosG9os4ia3qbbzDBHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.3 110/197] scsi: sd: Ignore a failure to sync cache due to lack of authorization
Date:   Sun, 27 Oct 2019 22:00:28 +0100
Message-Id: <20191027203357.686595342@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 21e3d6c81179bbdfa279efc8de456c34b814cfd2 upstream.

I've got a report about a UAS drive enclosure reporting back Sense: Logical
unit access not authorized if the drive it holds is password protected.
While the drive is obviously unusable in that state as a mass storage
device, it still exists as a sd device and when the system is asked to
perform a suspend of the drive, it will be sent a SYNCHRONIZE CACHE. If
that fails due to password protection, the error must be ignored.

Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190903101840.16483-1-oneukum@suse.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1655,7 +1655,8 @@ static int sd_sync_cache(struct scsi_dis
 		/* we need to evaluate the error return  */
 		if (scsi_sense_valid(sshdr) &&
 			(sshdr->asc == 0x3a ||	/* medium not present */
-			 sshdr->asc == 0x20))	/* invalid command */
+			 sshdr->asc == 0x20 ||	/* invalid command */
+			 (sshdr->asc == 0x74 && sshdr->ascq == 0x71)))	/* drive is password locked */
 				/* this is no error here */
 				return 0;
 


