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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05737C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6EB205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE10eCHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfFZKj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:39:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38876 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZKj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:39:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id g4so1222826plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MQ9/uWGOCU6xhcJrjFrAp9D/DzotiwWryJhU2sg3dXk=;
        b=jE10eCHUEAtvgZ94+vzcssYMO6mjwEBNyQyS+979T7V9H88qMRlbM80AALrr4PL7wH
         rN819o1exHNmFlXu6lKk5huqMmX25BQjPANXDQP3CqO115DTSItqtIIM+GlhUvJeJM4r
         Gh6hFKstZvm6Uq50/GjK9JmC/elmcYbePclzDX+j5AvGfUDAjt/8yL2eXwAx9St6tqQr
         gfqWMtfSZEyYrgrjqG/Mru4BLY/83hPufoyrajO724AHU9zgMjmLkdqHYvumvHTCWNKd
         vZZJwRPGkChzW6iHZvaqkeEqI88Ge6P5ak0ReP7ZL+iyU4Rt3SUsoqLxhC8HsenwNKu3
         m3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MQ9/uWGOCU6xhcJrjFrAp9D/DzotiwWryJhU2sg3dXk=;
        b=NBvTV/SqN2uJCyuwC0AfgTpGh5A7kx3bF+zXpFLci8URsGCnRyxi6e+JzQUKhfhEhd
         C4tXF1OvJS4VdVywWtRj/MWw5fcVztOpk1y6hjX+SY/nlEKMYr3HXw8cTRVxdteNl/tD
         X/NrYO4c0aJj49cAVoZKcjuAU/w3qcCTyPDn0yKVL1mkDrOXpMjs1vl829DiGZHRuDA0
         EosaBzfDG92zpkRSD1sHEU1uLk6XCQn4ookCPUl7OUetibT0kDqDq4KnNaiYKMmpCrSk
         pXS33EDnZQiRHSdHBwxpM/eGwiq2Grz5hol5fOvTZeCgPFzQXTnlSKcjWzQMXoq86OIR
         jbRQ==
X-Gm-Message-State: APjAAAWsNx78Ld4KJ/EYiofevUhlvR2XHoZUPS3CwhWQZznVQl+ID6xj
        LK2gBZhbsyNyXECikaMdXpw=
X-Google-Smtp-Source: APXvYqwu8/FNRhg68Nb2ZF2ohaD+QcYRJVvaXt1TRS6mrgnz8RwmTp+ic/QQpLHJzCrhlbheGAJdFA==
X-Received: by 2002:a17:902:246:: with SMTP id 64mr4519837plc.311.1561545598410;
        Wed, 26 Jun 2019 03:39:58 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id x7sm18584969pfa.125.2019.06.26.03.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 03:39:57 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH RESEND] staging: erofs: remove unsupported ->datamode check in fill_inline_data()
Date:   Wed, 26 Jun 2019 18:39:36 +0800
Message-Id: <20190626103936.9064-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Already check if ->datamode is supported in read_inode(), no need to check
again in the next fill_inline_data() only called by fill_inode().

Signed-off-by: Yue Hu <huyue2@yulong.com>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
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

