Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15502C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D966E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495677;
	bh=xOV+gfsvhKxuTMaRavsJgT56mMrub52ODkJUQy0F564=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MTtcKz5HKnKuxStkgJElq7ja3U6FYXI2wGpEyaekSMQz5PvoS38qgd2CFUMOH5Cgi
	 6wl0Rau11JIl/t8gAJr96KkxqOLL7J1WBNXeai2IlSI+FtbUxk3p0FqErYtla4MB6c
	 o+domXiFTL3J3sFivhWrnuzSdpMmIK095V90jbmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405128AbfHVRlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391775AbfHVRX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:23:59 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BE023400;
        Thu, 22 Aug 2019 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494638;
        bh=xOV+gfsvhKxuTMaRavsJgT56mMrub52ODkJUQy0F564=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bz6LeGy/LIi/w7Ejw+5xFIIqu7ZHuPbiJLAcm4kbJJhkYD3mxZeiqQKnnyFGHBbxA
         m0B6KN7TvWkr5soTUi2xJPktAnn2fk0BZMJD7uH5WUsPIbLcaCOM09S9f49VEaKpwy
         2irGwtRBZtst8ruW7EF04n8AlbVnupHSkcLVR8g8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 072/103] libata: zpodd: Fix small read overflow in zpodd_get_mech_type()
Date:   Thu, 22 Aug 2019 10:19:00 -0700
Message-Id: <20190822171731.819218616@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 71d6c505b4d9e6f76586350450e785e3d452b346 ]

Jeffrin reported a KASAN issue:

  BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
  Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149
  ...
  The buggy address belongs to the variable:
    cdb.48319+0x0/0x40

Much like commit 18c9a99bce2a ("libata: zpodd: small read overflow in
eject_tray()"), this fixes a cdb[] buffer length, this time in
zpodd_get_mech_type():

We read from the cdb[] buffer in ata_exec_internal_sg(). It has to be
ATAPI_CDB_LEN (16) bytes long, but this buffer is only 12 bytes.

Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Fixes: afe759511808c ("libata: identify and init ZPODD devices")
Link: https://lore.kernel.org/lkml/201907181423.E808958@keescook/
Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-zpodd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 7017a81d53cf2..083856272e92a 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -55,7 +55,7 @@ static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
 	unsigned int ret;
 	struct rm_feature_desc *desc;
 	struct ata_taskfile tf;
-	static const char cdb[] = {  GPCMD_GET_CONFIGURATION,
+	static const char cdb[ATAPI_CDB_LEN] = {  GPCMD_GET_CONFIGURATION,
 			2,      /* only 1 feature descriptor requested */
 			0, 3,   /* 3, removable medium feature */
 			0, 0, 0,/* reserved */
-- 
2.20.1



