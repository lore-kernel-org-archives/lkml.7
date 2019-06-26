Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8798CC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549E320645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F39j0DFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfFZD3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:29:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44887 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZD3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:29:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so509695pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 20:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3Bk3HSDpfvFkfZOSH4U92ucBAW0uikex4TEJcoU8cZg=;
        b=F39j0DFbpORjG7U99JjjGnvYO8DvfbbYS/uHEhc53PXtyhGTgmUdMcYhoA4AQvABgI
         EsmUj0eatmyCEidyKK/IaBJQnS6bz4pr089jcIExUOc4vkqY7f+WvswvZK6RYzizXSR9
         O8t/0J3Fv9ndpNEg6teipkCTCOF9MZyfhN3bnBJK9yVyhkdLnPm4fPGtXsPqgKOUM0Tr
         c3pnzLcqMBoqM/bJfcmosPZvLgIE4B+N25nSTAfwFOFFjp00Uo7Tpi9bJsvcBzWpUXCb
         uFmdn5H5Uj8MQjikkkzeEwSByJMZRFiEJj30QQ/DWAgmmmPhvqrhkny1zE03XFxPoBkS
         xGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Bk3HSDpfvFkfZOSH4U92ucBAW0uikex4TEJcoU8cZg=;
        b=knu4dR510EUilfK8lKqS//7njp86Mj5l8PKVE10zuNi9Q0oD1HIx/0xaAErbVIoP5h
         4KQqJaENZgXgPVwta1nP6Jo6QG5g8qu428zwo0ppeOniWGqbvTSzP4aLnUVhylzwnHgf
         Z5hyfG1F+l/6DhFUfSmpN8V/T9ZQZt+ps1DUG1nl0hDHMIhqVrUgNSuDFYhyDpAaH62G
         PP3YkwVuCiRtrhXxKs0w42g0TiCMnVr9BPoA+kmjX1IN80Bc3cLn/WlUaWG2NKA81YZ8
         cyIBR+306WA2jjnrNC6Px3RQvI9PG8wdNeAou02x/PqRGjJQTlcDaHaKvtfHdd5KfNM0
         7Xcw==
X-Gm-Message-State: APjAAAVULp0tSkcuI0cvEheIuTD3NarSyuFt7z+xCSznSPc8aH7q5fQ6
        5fRyVmYqV43pfmDNg9TZPis=
X-Google-Smtp-Source: APXvYqyi4Bt3ir6rU+TWNnN36A9pN8xg7s2JYPqJdArgPXkkE4o/jlC79rPGT33ctNm4inqrk9UVDA==
X-Received: by 2002:a17:90a:20a2:: with SMTP id f31mr1696212pjg.90.1561519754149;
        Tue, 25 Jun 2019 20:29:14 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id l2sm14563306pgs.33.2019.06.25.20.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 20:29:13 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH RESEND] staging: erofs: remove unsupported ->datamode check in fill_inline_data()
Date:   Wed, 26 Jun 2019 11:28:31 +0800
Message-Id: <20190626032831.7252-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Already check if ->datamode is supported in read_inode(), no need to check
again in the next fill_inline_data() only called by fill_inode().

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/staging/erofs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index e51348f..d6e1e16 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -129,8 +129,6 @@ static int fill_inline_data(struct inode *inode, void *data,
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 	const int mode = vi->datamode;
 
-	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
-
 	/* should be inode inline C */
 	if (mode != EROFS_INODE_LAYOUT_INLINE)
 		return 0;
-- 
1.9.1

