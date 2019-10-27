Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0721CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E0E2064A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210446;
	bh=3p+USwtJUTtC3toj8T7Yn7zw6NH0GsG2ccFhvAY7IXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NWbhHgHbDGJRb7IrS7zQtZZyEAw6uygFZqdBuHocTvZVr514ApI4AjF0/5M426EEa
	 8sgjsrqFaqh0By7FRFBe3lPWFyUKdwV/J04EB6t/C7EDa7P9OriVfZ/uwrEZxjEAby
	 vspoIthktMEHdL+B82xkRzPiWR5BLbc+0C31sSx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfJ0VHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbfJ0VHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:07:20 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214A9214AF;
        Sun, 27 Oct 2019 21:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210439;
        bh=3p+USwtJUTtC3toj8T7Yn7zw6NH0GsG2ccFhvAY7IXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPP5thdod2y3opZO/jGJD2D4I0/gEcqVgWveKO/HhgpZX/hlSjdAeGmrmlhCJMVkJ
         Fa2kROfHOatN+CSRUo3NRq0Tcvg3+ilchHCs8GvkLEmvvOaVqc3Rh1JAg28mEekpPw
         +HyjyV7mn9RbQaZtMXGejoH+sgilHBCvUSJRzGKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Ivan Topolsky <doktor.yak@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 016/119] md/raid0: fix warning message for parameter default_layout
Date:   Sun, 27 Oct 2019 21:59:53 +0100
Message-Id: <20191027203304.506871460@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

[ Upstream commit 3874d73e06c9b9dc15de0b7382fc223986d75571 ]

The message should match the parameter, i.e. raid0.default_layout.

Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout confusion.")
Cc: NeilBrown <neilb@suse.de>
Reported-by: Ivan Topolsky <doktor.yak@gmail.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 28fb717217706..449c4dd060fcd 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -158,7 +158,7 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
 	} else {
 		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_layout setting\n",
 		       mdname(mddev));
-		pr_err("md/raid0: please set raid.default_layout to 1 or 2\n");
+		pr_err("md/raid0: please set raid0.default_layout to 1 or 2\n");
 		err = -ENOTSUPP;
 		goto abort;
 	}
-- 
2.20.1



