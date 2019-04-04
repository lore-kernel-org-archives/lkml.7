Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C7AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83C820855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370078;
	bh=RyPAYLCDRTHGFp8/S1KELiPG6Y0CEfqoyVoGj5rCUN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uYkEBndnoO6UW4autmmW50KCqkRsZoYSYbneBOoX9sO50r5K4S4dlOjFR4nZKqq6P
	 xmebEhkNKtp+jj/Yf7uW2+LICmICLQUULuNLtDw6+ExCAq/bCso7/eCpTdVt53bqLh
	 ADy7+xyGcaKMxmbUIAl1vHTu8plFDok0mHmEY1ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbfDDJ14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733068AbfDDJMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:12:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D33B820652;
        Thu,  4 Apr 2019 09:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369127;
        bh=RyPAYLCDRTHGFp8/S1KELiPG6Y0CEfqoyVoGj5rCUN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WEds87sIVjIMzNoml/MYs+wkx/kWJyzXIOQDo8WGsv3mWOctWEMLldKRullEIfTBO
         at7tKyVGwjIWL3bdzLTpEmErk7l1sMnsy9phi1CslfP5CvwK5aWjft7tZlpXt2iH1V
         9nOgrx9u4s7JwEnFxg4+aOsjZUShu6WODEYPn4Gk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 107/246] drm/amd/display: Clear stream->mode_changed after commit
Date:   Thu,  4 Apr 2019 10:46:47 +0200
Message-Id: <20190404084622.894529386@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d8d2f174bcc2c26c3485c70e0c6fe22b27bce739 ]

[Why]
The stream->mode_changed flag can persist in the following sequence
of atomic commits:

Commit 1:
Enable CRTC0 (mode_changed = true), Enable CRTC1 (mode_changed = true)

Commit 2:
Disable CRTC1 (mode_changed = false)

In this sequence we want to keep the exiting CRTC0 but it's not in the
atomic state for the commit since it hasn't been modified. In this case
the stream->mode_changed flag persists as true and we don't re-program
the planes for the existing stream.

[How]
The flag needs to be cleared and it makes the most sense to do it within
DC after the state has been committed. Nothing following dc_commit_state
should think that the stream's mode has changed.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Acked-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5fd52094d459..1f92e7e8e3d3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1078,6 +1078,9 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	/* pplib is notified if disp_num changed */
 	dc->hwss.optimize_bandwidth(dc, context);
 
+	for (i = 0; i < context->stream_count; i++)
+		context->streams[i]->mode_changed = false;
+
 	dc_release_state(dc->current_state);
 
 	dc->current_state = context;
-- 
2.19.1



