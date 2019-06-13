Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965ECC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B069208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442073;
	bh=Q9uG9TijeqznwzAyRj4c59Zw+iKYFG9CMGH4OdKPW+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RwJ+V7ZNw3dd2NOfpGJHP+7MIGjKrUz8zsxatsT2gx14NVj1E2v0iWu+xQOc+NN33
	 dubjibuJAltDLMLhS1Z39NaUCcXkOdJ+UQHKGp4SxA8CrvYfbWgm16kYPdumvtOP7y
	 x7U4gqJiREEJvbWp6YJaOkLjXeuTOHHcn0tih6iA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbfFMQHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731301AbfFMIp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:45:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C96CD21743;
        Thu, 13 Jun 2019 08:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415527;
        bh=Q9uG9TijeqznwzAyRj4c59Zw+iKYFG9CMGH4OdKPW+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkmxgnlxVUJWKQ78xyW5oVHuL/NZ20GeIsStnqU57tqya7biBs25Sb3nkAbGuyCs7
         xz0xiFPzraST0KDb1BlZSK0ZzA+Ol5C1La4VOUnIwMKxyrev8TQbyeexFb8yJC1FWG
         05b3Pq+keH8dP3SORkcaOHYerMFPOzbEcTeSwCpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 032/155] drm/nouveau/kms/gf119-gp10x: push HeadSetControlOutputResource() mthd when encoders change
Date:   Thu, 13 Jun 2019 10:32:24 +0200
Message-Id: <20190613075654.788007417@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a0b694d0af21c9993d1a39a75fd814bd48bf7eb4 ]

HW has error checks in place which check that pixel depth is explicitly
provided on DP, while HDMI has a "default" setting that we use.

In multi-display configurations with identical modelines, but different
protocols (HDMI + DP, in this case), it was possible for the DP head to
get swapped to the head which previously drove the HDMI output, without
updating HeadSetControlOutputResource(), triggering the error check and
hanging the core update.

Reported-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv50/head.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/nouveau/dispnv50/head.c
index 2e7a0c347ddb..8efb778a3b20 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
@@ -306,7 +306,7 @@ nv50_head_atomic_check(struct drm_crtc *crtc, struct drm_crtc_state *state)
 			asyh->set.or = head->func->or != NULL;
 		}
 
-		if (asyh->state.mode_changed)
+		if (asyh->state.mode_changed || asyh->state.connectors_changed)
 			nv50_head_atomic_check_mode(head, asyh);
 
 		if (asyh->state.color_mgmt_changed ||
-- 
2.20.1



