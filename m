Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90B8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8832064A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211790;
	bh=SdgeleUwGEEy+z0NNe6GfPZ8rgoZzZqSWIh5LtBgLFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F4YfyrnuO9VE09BtNhgP6PpfslCAndbB/5mPBu0Rvc+pziLgLNKQy43ZCcuhxjKTy
	 WsbtfL18Hi6pv9r00ef242N1Ca6oRFWpCOOpD9WGDGxQ4qk0sqPhbdJC52Nj6iFC88
	 uxOMiVZoJlb1FvXrD3/CtWi1eXujuK1XWnmuRfe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbfJ0V3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731576AbfJ0VTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:19:55 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95DD205C9;
        Sun, 27 Oct 2019 21:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211195;
        bh=SdgeleUwGEEy+z0NNe6GfPZ8rgoZzZqSWIh5LtBgLFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+b/bublo+LjieoUSum4KMaBw91at99qZhKHWR2QgnHsqXm/ZkBVOhjvhSZNgZJxG
         VWc84cylV4fakgi8gowRWhIB3bup4FInKDHcHxacWJLiZ7aU0GowuPNzu+hVFt6kHz
         HlxZtqh3/mJEe5zQMueuDosyYYXV9DKrQC1izb8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Ivan Topolsky <doktor.yak@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 065/197] md/raid0: fix warning message for parameter default_layout
Date:   Sun, 27 Oct 2019 21:59:43 +0100
Message-Id: <20191027203355.169486992@linuxfoundation.org>
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
index 297bbc0f41f05..c3445d2cedb9d 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -151,7 +151,7 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
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



