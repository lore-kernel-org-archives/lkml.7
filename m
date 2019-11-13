Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264E6C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95BC222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611628;
	bh=8xNOoACWH3K2CUyjJCpoBhrHykxp+H3DVrmXt4ZVvNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vzqagMsNA6gFrkqYZd0nG0Ufafkn7TFKGDMuaAySpISB2FYGQg33/8MLQTtfbzgQ/
	 +VbnvS+YUhmEOpr9IWehWgxeRxiz8k+05VxJkIXLwF0Di0JeYvGcuj74905Q5aBHn7
	 gVANBQ4iw9cPsuEcPep5u8ovp0B7R0lzS00gBt8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfKMCU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:20:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbfKMByc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:54:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5EB222CD;
        Wed, 13 Nov 2019 01:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610071;
        bh=8xNOoACWH3K2CUyjJCpoBhrHykxp+H3DVrmXt4ZVvNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNs1MPhNN9HgucHAddXGYtRHm3njOh3B2HgPpnHqZAh5vlew3mFjkftkM9O32KTyN
         vW/OPY4rWePQVGTySZW5FiFdDcrLtYVVBFKiNhlNQIxS/KN+OiiRpuWwz/IUgce3tA
         DOKHyVUHBIxRXmC+CrU2CCJdVyEtwaI4AhMI2/gQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.19 150/209] media: cx18: Don't check for address of video_dev
Date:   Tue, 12 Nov 2019 20:49:26 -0500
Message-Id: <20191113015025.9685-150-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit eb1ca9a428fdc3f98be4898f6cd8bcb803878619 ]

Clang warns that the address of a pointer will always evaluated as true
in a boolean context.

drivers/media/pci/cx18/cx18-driver.c:1255:23: warning: address of
'cx->streams[i].video_dev' will always evaluate to 'true'
[-Wpointer-bool-conversion]
                if (&cx->streams[i].video_dev)
                ~~   ~~~~~~~~~~~~~~~^~~~~~~~~
1 warning generated.

Check whether v4l2_dev is null, not the address, so that the statement
doesn't fire all the time. This check has been present since 2009,
introduced by commit 21a278b85d3c ("V4L/DVB (11619): cx18: Simplify the
work handler for outgoing mailbox commands")

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx18/cx18-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
index 0c389a3fb4e5f..e64f9093cd6d3 100644
--- a/drivers/media/pci/cx18/cx18-driver.c
+++ b/drivers/media/pci/cx18/cx18-driver.c
@@ -1252,7 +1252,7 @@ static void cx18_cancel_out_work_orders(struct cx18 *cx)
 {
 	int i;
 	for (i = 0; i < CX18_MAX_STREAMS; i++)
-		if (&cx->streams[i].video_dev)
+		if (cx->streams[i].video_dev.v4l2_dev)
 			cancel_work_sync(&cx->streams[i].out_work_order);
 }
 
-- 
2.20.1

