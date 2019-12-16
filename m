Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F178C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D10207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521551;
	bh=klIdzkzvFKDWvvLxvjoRckTHmAjYSgP6WS1tO3GbRjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rIr0M8LByClZrvNyPO0iElYOOJ3eeHc5i+26MjChnRMmXQ16+qQK4dFrB+Me4aGIX
	 8mvK/Pwb/HDRBy4dc47DpK+7GdPsICYQ0kqWtp/4rGxOdv+5/viPJFQ3bUdWvYjJDN
	 bcBT2qNXi3g2GV3CBMXW+97Xp6hXE8tppuhDtWy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfLPSDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:03:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbfLPSDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:03:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4116207FF;
        Mon, 16 Dec 2019 18:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519431;
        bh=klIdzkzvFKDWvvLxvjoRckTHmAjYSgP6WS1tO3GbRjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9lzD2/VE5skrv5Rf5XcPY9l8Dq8lc0EmdstVAUZ292EKHE3TyugjVBHoY0z+hPnB
         jmCoc1TeEI5aD60lkaHV0HIdCO24UxY0zfOz8z7woLOas3mgyuDTFXsAs/8g5CXimk
         mPHqosOT3nbBAyrmprw9gwNcI5isHUW8U3dhyLmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matti Aaltonen <matti.j.aaltonen@nokia.com>,
        Johan Hovold <johan@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 4.19 064/140] media: radio: wl1273: fix interrupt masking on release
Date:   Mon, 16 Dec 2019 18:48:52 +0100
Message-Id: <20191216174805.217646045@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 1091eb830627625dcf79958d99353c2391f41708 upstream.

If a process is interrupted while accessing the radio device and the
core lock is contended, release() could return early and fail to update
the interrupt mask.

Note that the return value of the v4l2 release file operation is
ignored.

Fixes: 87d1a50ce451 ("[media] V4L2: WL1273 FM Radio: TI WL1273 FM radio driver")
Cc: stable <stable@vger.kernel.org>     # 2.6.38
Cc: Matti Aaltonen <matti.j.aaltonen@nokia.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/radio/radio-wl1273.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/media/radio/radio-wl1273.c
+++ b/drivers/media/radio/radio-wl1273.c
@@ -1156,8 +1156,7 @@ static int wl1273_fm_fops_release(struct
 	if (radio->rds_users > 0) {
 		radio->rds_users--;
 		if (radio->rds_users == 0) {
-			if (mutex_lock_interruptible(&core->lock))
-				return -EINTR;
+			mutex_lock(&core->lock);
 
 			radio->irq_flags &= ~WL1273_RDS_EVENT;
 


