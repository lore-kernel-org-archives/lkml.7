Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5818BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2410924B2E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187209;
	bh=Wa7TcyT+ufSchs5dR12KCtbsY23wB+eK/kdXfxO7PYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bJJVMYB2l7B2rOj5fjVdSaE5Q6ORE3HPfdGYUxLvxQrETPmxY4ALnbagucr16YZcK
	 Fe7kZ/dGrdunnxPQNeRwnEPW9EajJA4j4rveTg+lTZbKmD+zMSwQJ+wlis1RToGiV/
	 H/4gThFR2QKMm07POFFNe/So5blMueLZnWq5MlCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbfE3D2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbfE3DT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:19:59 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B39024818;
        Thu, 30 May 2019 03:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186398;
        bh=Wa7TcyT+ufSchs5dR12KCtbsY23wB+eK/kdXfxO7PYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nl4WkIo3jpJBfxfHYt5fPWWc9TRxlOuYKRg0nsXvq1SjWTtHUkcg72UX/rEpmcNqw
         9Gr3RCc+GO3aYmooB4TXcr+Kv7FM4vYfGo3dOxd/ssdTUh4qZLCOkc39QThqRXYjTL
         5rc5FQLT3lICxG92sNk6RFGvM/ZK/B3FRM+3MrMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Helen Koike <helen.koike@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 179/193] media: vimc: stream: fix thread state before sleep
Date:   Wed, 29 May 2019 20:07:13 -0700
Message-Id: <20190530030512.532737234@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2978a505aaa981b279ef359f74ba93d25098e0a0 ]

The state TASK_UNINTERRUPTIBLE should be set just before
schedule_timeout() call, so it knows the sleep mode it should enter.
There is no point in setting TASK_UNINTERRUPTIBLE at the initialization
of the thread as schedule_timeout() will set the state back to
TASK_RUNNING.

This fixes a warning in __might_sleep() call, as it's expecting the
task to be in TASK_RUNNING state just before changing the state to
a sleeping state.

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vimc/vimc-streamer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vimc/vimc-streamer.c b/drivers/media/platform/vimc/vimc-streamer.c
index fcc897fb247bc..392754c18046c 100644
--- a/drivers/media/platform/vimc/vimc-streamer.c
+++ b/drivers/media/platform/vimc/vimc-streamer.c
@@ -120,7 +120,6 @@ static int vimc_streamer_thread(void *data)
 	int i;
 
 	set_freezable();
-	set_current_state(TASK_UNINTERRUPTIBLE);
 
 	for (;;) {
 		try_to_freeze();
@@ -137,6 +136,7 @@ static int vimc_streamer_thread(void *data)
 				break;
 		}
 		//wait for 60hz
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(HZ / 60);
 	}
 
-- 
2.20.1



