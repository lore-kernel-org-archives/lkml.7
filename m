Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742DAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4516C2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257383;
	bh=cWP5r6xf+eYjzbJK7hoj8evmv52jaraeDZaDLHi38FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iKQ+b4lo8Qubj7n2NqtBlz/uI/aXGKvwkAYgYZ+b8rhVWVUzVpbllEedwxE+1IBqW
	 cOek9sHFTErPrnFyT7Sf5yaOaWS5xNnoItetIkND47NzfvVEMH2bLIEZyAFo34VfNV
	 uBQzdYmG9rL5X5r1ATyz7CWRQxcmK2BoSsmafX4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391093AbfCVMXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390731AbfCVMW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:22:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94A732192C;
        Fri, 22 Mar 2019 12:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257376;
        bh=cWP5r6xf+eYjzbJK7hoj8evmv52jaraeDZaDLHi38FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGK6F3GhNWfXOq3r7hgEmC+1eYsF2jjgODNJdeB1w0xszV+5GPhhLFhSeOY+8Tilq
         Q0pNE/zJI7TexwDT4wi69FDo1YjOSOV/5II1NCS/qTcV3OOlw4EIWVhPv4xr4cUAW4
         QNY2MLtzSCDgcP3hLLXbsXPWDHqI5SoYw01/rfn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick French <naf@ou.edu>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Stylinski <kungfujesus06@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.0 213/238] media: lgdt330x: fix lock status reporting
Date:   Fri, 22 Mar 2019 12:17:12 +0100
Message-Id: <20190322111310.838477645@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: French, Nicholas A <naf@ou.edu>

commit 1b4fd9de6ec7f3722c2b3e08cc5ad171c11f93be upstream.

A typo in code cleanup commit db9c1007bc07 ("media: lgdt330x: do
some cleanups at status logic") broke the FE_HAS_LOCK reporting
for 3303 chips by inadvertently modifying the register mask.

The broken lock status is critial as it prevents video capture
cards from reporting signal strength, scanning for channels,
and capturing video.

Fix regression by reverting mask change.

Cc: stable@vger.kernel.org # Kernel 4.17+
Fixes: db9c1007bc07 ("media: lgdt330x: do some cleanups at status logic")
Signed-off-by: Nick French <naf@ou.edu>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Adam Stylinski <kungfujesus06@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/dvb-frontends/lgdt330x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb-frontends/lgdt330x.c
+++ b/drivers/media/dvb-frontends/lgdt330x.c
@@ -783,7 +783,7 @@ static int lgdt3303_read_status(struct d
 
 		if ((buf[0] & 0x02) == 0x00)
 			*status |= FE_HAS_SYNC;
-		if ((buf[0] & 0xfd) == 0x01)
+		if ((buf[0] & 0x01) == 0x01)
 			*status |= FE_HAS_VITERBI | FE_HAS_LOCK;
 		break;
 	default:


