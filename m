Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE353C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF9C2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368829;
	bh=vSt3M3YXWkrgabKgx1LG/SgLsaLATUHWXcZt3/Mo5EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rNv+KriRJgDpfu0pF81x8tqqsPmmNg9cNcB3tB5NxNkADNvKHSULWkekgk10Ee0Tu
	 LJNQuiX1+w/d+8KS/up9U1Yo/Tx8ylDlf+iVE7c8xSVSxb7LrtAEcrYTiEwYpnUR+y
	 2YlUExQf/tdCyOBRQE6TIqlO9IyH6s/AxExGi1B0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbfDDJHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732441AbfDDJHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:07:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE33621741;
        Thu,  4 Apr 2019 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368823;
        bh=vSt3M3YXWkrgabKgx1LG/SgLsaLATUHWXcZt3/Mo5EQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7p91In55/6zDFTEBY/9Y4oflpH6PAL/2653BOXD7uUjw/Dj27MYpXZ0qLLc+Rbwo
         HY0nKIP/pdJ6zSY8RUoUwXtjkmf9PfjyRYrWv4AIzoEhDUQtStHQ0922tmJd8WPwV2
         KwBI1PWUM9ULGmOfqfWE+tG/L8Q78EEOzR2e+vnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 167/187] media: rcar-vin: Allow independent VIN link enablement
Date:   Thu,  4 Apr 2019 10:48:24 +0200
Message-Id: <20190404084610.950421775@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c5ff0edb8e2270a75935c73217fb0de1abd2d910 ]

There is a block of code in rvin_group_link_notify() that prevents
enabling a link to a VIN node if any entity in the media graph is
in use. This prevents enabling a VIN link even if there is an in-use
entity somewhere in the graph that is independent of the link's
pipeline.

For example, the code block will prevent enabling a link from
the first rcar-csi2 receiver to a VIN node even if there is an
enabled link somewhere far upstream on the second independent
rcar-csi2 receiver pipeline.

If this code block is meant to prevent modifying a link if any entity
in the graph is actively involved in streaming (because modifying
the CHSEL register fields can disrupt any/all running streams), then
the entities stream counts should be checked rather than the use counts.

(There is already such a check in __media_entity_setup_link() that verifies
the stream_count of the link's source and sink entities are both zero,
but that is insufficient, since there should be no running streams in
the entire graph).

Modify the code block to check the entity stream_count instead of the
use_count (and elaborate on the comment). VIN node links can now be
enabled even if there are other independent in-use entities that are
not streaming.

Fixes: c0cc5aef31 ("media: rcar-vin: add link notify for Gen3")

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar-vin/rcar-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
index ce09799976ef..e1085e3ab3cc 100644
--- a/drivers/media/platform/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/rcar-vin/rcar-core.c
@@ -131,9 +131,13 @@ static int rvin_group_link_notify(struct media_link *link, u32 flags,
 	    !is_media_entity_v4l2_video_device(link->sink->entity))
 		return 0;
 
-	/* If any entity is in use don't allow link changes. */
+	/*
+	 * Don't allow link changes if any entity in the graph is
+	 * streaming, modifying the CHSEL register fields can disrupt
+	 * running streams.
+	 */
 	media_device_for_each_entity(entity, &group->mdev)
-		if (entity->use_count)
+		if (entity->stream_count)
 			return -EBUSY;
 
 	mutex_lock(&group->lock);
-- 
2.19.1



