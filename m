Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67BAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5F020707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419063;
	bh=NGvcGUUb/zX84EsKjg1TLdH6Al2JKVLtjEr2dAXuSVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R7Mq1XpwqZInMmzXYgmNAucPVlnW/ZtYDkhLH79eiEYB8fgaOqEcYRRtOWQSfpzHf
	 TSG4d/tuoFmny0MNdiP4xkLit+mjzMEKuIwKjw7Xcb2cidA8kAAF3mkmr80RlnCmbg
	 Ncxj9rhBAitsC+l5UM3YcS1GSNeP3YsaqBILNGEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKVKhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:37:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfKVKhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:37:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B4220707;
        Fri, 22 Nov 2019 10:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419059;
        bh=NGvcGUUb/zX84EsKjg1TLdH6Al2JKVLtjEr2dAXuSVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KcsfveKXsU0EO0zYbckJdmrlr/ALbQZ1P5D8CFYu6QyXutEMcxkLTOin92QaFV6YC
         auFiROkptBm1cepOcv7H03NAJAoROg7SZ+hRccalHkH00J6Pmggka6U28Ws+1fAVxB
         0u8s6Y6xoanUn6qfL3KvJmzqNYmlPgzFhyvl9YIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Peter Malone <peter.malone@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Mathieu Malaterre <malat@debian.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 143/159] fbdev: sbuslib: integer overflow in sbusfb_ioctl_helper()
Date:   Fri, 22 Nov 2019 11:28:54 +0100
Message-Id: <20191122100838.403706593@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit e5017716adb8aa5c01c52386c1b7470101ffe9c5 ]

The "index + count" addition can overflow.  Both come directly from the
user.  This bug leads to an information leak.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Peter Malone <peter.malone@gmail.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sbuslib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
index b425718925c01..52e161dbd2047 100644
--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -170,7 +170,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 		    get_user(ublue, &c->blue))
 			return -EFAULT;
 
-		if (index + count > cmap->len)
+		if (index > cmap->len || count > cmap->len - index)
 			return -EINVAL;
 
 		for (i = 0; i < count; i++) {
-- 
2.20.1



