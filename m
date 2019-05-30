Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B26EC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46F0259FD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191294;
	bh=Wa7TcyT+ufSchs5dR12KCtbsY23wB+eK/kdXfxO7PYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MXqKxOqi2uOOvRI4ZnuTgccdFXwu/4udax9alOu9Ac8ezOHNSDw+9pr4News3anfU
	 AseN+QC4EfZe272rXyloXqKgfbq/jC+ZsJDNuzEFVnM2BDJ1TPAAn68Fv0h9KDpp+e
	 yTWhHeATPe4j6TOg9OExrw7O71QPo8NLHhUtYUGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbfE3Eld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbfE3DMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:25 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F3A24526;
        Thu, 30 May 2019 03:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185944;
        bh=Wa7TcyT+ufSchs5dR12KCtbsY23wB+eK/kdXfxO7PYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQyGkdbSrOtLj8wdzfMifK06uuQhv/kiojTU81fHRwyB6rgrQkDfRTFouprC8VtFs
         TVA1CBl1NkjB13A0pkGx2cu5LLUEvR5W31VH6btVQOsHL9G4kNxu8xFgk7D1OVZmFZ
         1WLEQlO5GarxF6GTgdLPyS2IFUjKsC99efg9KaGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Helen Koike <helen.koike@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 353/405] media: vimc: stream: fix thread state before sleep
Date:   Wed, 29 May 2019 20:05:51 -0700
Message-Id: <20190530030558.513663402@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
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



