Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F298C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AFE2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495042;
	bh=Lqhqryb78B7k7zekpbzy+H9JJH5FFlViKcIlItaGoIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fz+tZOybZq61RbjCjZWcv7mxHG4BVuoPg/Pj/0XHqib4AKI8AWL7IRoX35U7BMinh
	 gxg4jCdIUVLnXedHp2n+/z3BoAZiukFxahRBjX1LJvIwS00uOtiCi2pUxPXlILS7j0
	 ROXi/7ThDtv4adSpAWrwNuV6UHLeHhmh7kFfwoYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392165AbfHVRak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404623AbfHVR0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:26:08 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68BA2341B;
        Thu, 22 Aug 2019 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494768;
        bh=Lqhqryb78B7k7zekpbzy+H9JJH5FFlViKcIlItaGoIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkKaI8NTWaWspYsRJ+ep4IVsRkuJ8zvvied7RS9hGRVE33Z8AECnNsZYUyMQ5lfD5
         UyPnGq9yZtS2gemPNQ1u6RFAmpT9tOQwx9ZTusQhjQZfh2K8G+2uqJ1youc7F8Pkck
         V4xDfyeq9xzVGFmvt0xOZNtthsBHIK6CDlPJVI4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 4.19 71/85] Input: psmouse - fix build error of multiple definition
Date:   Thu, 22 Aug 2019 10:19:44 -0700
Message-Id: <20190822171734.247155329@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

commit 49e6979e7e92cf496105b5636f1df0ac17c159c0 upstream.

trackpoint_detect() should be static inline while
CONFIG_MOUSE_PS2_TRACKPOINT is not set, otherwise, we build fails:

drivers/input/mouse/alps.o: In function `trackpoint_detect':
alps.c:(.text+0x8e00): multiple definition of `trackpoint_detect'
drivers/input/mouse/psmouse-base.o:psmouse-base.c:(.text+0x1b50): first defined here

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 55e3d9224b60 ("Input: psmouse - allow disabing certain protocol extensions")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/trackpoint.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/input/mouse/trackpoint.h
+++ b/drivers/input/mouse/trackpoint.h
@@ -161,7 +161,8 @@ struct trackpoint_data {
 #ifdef CONFIG_MOUSE_PS2_TRACKPOINT
 int trackpoint_detect(struct psmouse *psmouse, bool set_properties);
 #else
-inline int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
+static inline int trackpoint_detect(struct psmouse *psmouse,
+				    bool set_properties)
 {
 	return -ENOSYS;
 }


