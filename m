Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE32DC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950CB24108
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189870;
	bh=bp0ei9CW8GOV5s+gfcafVPBBEVYM5qxBTDtOvGL7eX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b5kXdgAsUNGhcx6GDVSyF0/mFl1DQVcySMzm1HPvOGx3J/qpwFzIMYVi4+hAvwbtM
	 SA2k/X0okKnNTm74dTVKgeqXAZ8ilBAGPKF8aMXHI9TH2mKQec+zAbS+PrvM3XTZQy
	 HG0TEUEYvOWHXDksIIswpQKgFSA/nj6Saue5oF/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfE3ERt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730399AbfE3DPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:38 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C883F2458A;
        Thu, 30 May 2019 03:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186137;
        bh=bp0ei9CW8GOV5s+gfcafVPBBEVYM5qxBTDtOvGL7eX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVxTzALfJ1I+MtP6vrCT6F4EIFjR5Sci/2NJ5qjNkjvhqz5YCavUzHAd2IRN554eb
         VAiaRPvxQdPRFdDqkjZPu6EMmyq+tFcT+1wt5lT0cJ8C5t/IPjCd9O6apSkPeImgz5
         6Vt3X3VmznV5API7ivMI3YcIzIZfVO+j+u/4ArvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 262/346] thunderbolt: Fix to check the return value of kmemdup
Date:   Wed, 29 May 2019 20:05:35 -0700
Message-Id: <20190530030554.246485121@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fd21b79e541e4666c938a344f3ad2df74b4f5120 ]

uuid in add_switch is allocted via kmemdup which can fail. The patch
logs the error and cleans up the allocated memory for switch.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/icm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index e3fc920af6825..8b7f9131e9d12 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -473,6 +473,11 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
 		goto out;
 
 	sw->uuid = kmemdup(uuid, sizeof(*uuid), GFP_KERNEL);
+	if (!sw->uuid) {
+		tb_sw_warn(sw, "cannot allocate memory for switch\n");
+		tb_switch_put(sw);
+		goto out;
+	}
 	sw->connection_id = connection_id;
 	sw->connection_key = connection_key;
 	sw->link = link;
-- 
2.20.1



