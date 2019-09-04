Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923D8C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6120D206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620668;
	bh=PzqeueoE6W0jH8ZAn7V6GTCB6qOAVp98CDXFEjW9JAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TTIQ1oWR1oFAppk5QdZHMN109ZeS3os1p0ZfXlLaZC8SNiNJpONAwZ/o8LFN8XB+3
	 XHAJBPcsymLPXKJLnIAQLYI7E68uK+IZ8Q8qSo6i5X9S95aX0JNySIMnvnNp9Ik2Ug
	 lrFRVluLBjx81SxEy+6F++9j7B9tZ7J2PIO+uB/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389684AbfIDSLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390218AbfIDSLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:11:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0632222CEA;
        Wed,  4 Sep 2019 18:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620662;
        bh=PzqeueoE6W0jH8ZAn7V6GTCB6qOAVp98CDXFEjW9JAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUo6hFHWNKXQd2RtseXwmYEFj2xniTBA1LxGssKa8q4tP5k3YfjFfibGFCAtr7ojY
         HkyF56amqfOv0ElGR7pZlX7hHALsODMifZqZw25paeKOzBbyj76VVcKlPlXPEvr5hd
         l8JmWXxr+g1dv7AS9+yHa9jJxERCh1VfTO9yVksM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 047/143] drm/bridge: tfp410: fix memleak in get_modes()
Date:   Wed,  4 Sep 2019 19:53:10 +0200
Message-Id: <20190904175315.910263027@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c08f99c39083ab55a9c93b3e93cef48711294dad ]

We don't free the edid blob allocated by the call to drm_get_edid(),
causing a memleak. Fix this by calling kfree(edid) at the end of the
get_modes().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190610135739.6077-1-tomi.valkeinen@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 3a8af9978ebdf..791f164bdadc8 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -66,7 +66,12 @@ static int tfp410_get_modes(struct drm_connector *connector)
 
 	drm_connector_update_edid_property(connector, edid);
 
-	return drm_add_edid_modes(connector, edid);
+	ret = drm_add_edid_modes(connector, edid);
+
+	kfree(edid);
+
+	return ret;
+
 fallback:
 	/* No EDID, fallback on the XGA standard modes */
 	ret = drm_add_modes_noedid(connector, 1920, 1200);
-- 
2.20.1



