Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E272FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA17214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096366;
	bh=3p+USwtJUTtC3toj8T7Yn7zw6NH0GsG2ccFhvAY7IXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T9ajGYFJnu+pq8Q4kus+tL5MeD2wd8XoDhBYqOVoH3ayeiP5m1+Y9QL8u0xuIV1a0
	 xjjvC2EM6yrvyXGQIgKMZ6xQ34uvi6ipYoGXOl7GK0AdFfIRgxi73827MwUJvoVz+z
	 V/Lwab++p+i0rKWo9DwTloiX1mu3kACw+g3MsGOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfJZNWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729286AbfJZNWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:22:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE66214DA;
        Sat, 26 Oct 2019 13:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096122;
        bh=3p+USwtJUTtC3toj8T7Yn7zw6NH0GsG2ccFhvAY7IXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ikBB86cNWegeuvgQmKfpMybQDwtbwPL0joiiwq0do4vJvwJJH7DhAmgvSbqLDDa+e
         pVNjbO1LT84AuPvbFMLtk/massytk1t3JDSAwcarPKfhd6jPEtPU3665R3ixmojHFz
         UZqE3cnJmHJadgOvSv2hncuxkOiIXtXJVQMtf718=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>, NeilBrown <neilb@suse.de>,
        Ivan Topolsky <doktor.yak@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 26/33] md/raid0: fix warning message for parameter default_layout
Date:   Sat, 26 Oct 2019 09:21:03 -0400
Message-Id: <20191026132110.4026-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026132110.4026-1-sashal@kernel.org>
References: <20191026132110.4026-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

