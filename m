Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982D4C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687CC2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509951;
	bh=zMn6S17+mdkJMuVd2nBPRzwcFgccNxk5NbIjJ5mgM+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AtVZlLmHa/2th6fm1/WBzv2vrijquTDdH6h/iVmmJTh/WOHfsdsj32urQVDNB1UK1
	 NOHy+467fRC31CgOYO8AGFs0BoJ+GIt7UzgwNI3psPSQzojEz4uMpOtVPeNd27ZuWC
	 MfoGrbcx/YoN/59WwUGUsk6Y1PILvTQE1G8EDOGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389645AbfGSETK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389113AbfGSENQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:13:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2B521872;
        Fri, 19 Jul 2019 04:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509595;
        bh=zMn6S17+mdkJMuVd2nBPRzwcFgccNxk5NbIjJ5mgM+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8xgRdAsQ6iIkZqOJWXn3qdhg/AFkxd0xHp9+cwrxZ+9xdYUWaswsQF/N9QAPlfqH
         GnkQ3Lwraib/DEW3muDLYBj6A8piBFp1J/9AudHrphQv3FU3iDoHgI3w6LZfTvfIIw
         8QDi/k8H2MJzdZfqeZhB0RYXSnvzUCWtQBpwCOl4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 07/45] drm/bridge: tc358767: read display_props in get_modes()
Date:   Fri, 19 Jul 2019 00:12:26 -0400
Message-Id: <20190719041304.18849-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041304.18849-1-sashal@kernel.org>
References: <20190719041304.18849-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 3231573065ad4f4ecc5c9147b24f29f846dc0c2f ]

We need to know the link bandwidth to filter out modes we cannot
support, so we need to have read the display props before doing the
filtering.

To ensure we have up to date display props, call tc_get_display_props()
in the beginning of tc_connector_get_modes().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190528082747.3631-22-tomi.valkeinen@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index fa3f2f039a74..80993a8734e0 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1153,6 +1153,13 @@ static int tc_connector_get_modes(struct drm_connector *connector)
 	struct tc_data *tc = connector_to_tc(connector);
 	struct edid *edid;
 	unsigned int count;
+	int ret;
+
+	ret = tc_get_display_props(tc);
+	if (ret < 0) {
+		dev_err(tc->dev, "failed to read display props: %d\n", ret);
+		return 0;
+	}
 
 	if (tc->panel && tc->panel->funcs && tc->panel->funcs->get_modes) {
 		count = tc->panel->funcs->get_modes(tc->panel);
-- 
2.20.1

