Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1777A2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368596;
	bh=KS49ZRQXFQhsf3hD5VUKYfYlK87+W2Kb8wM8JpGowVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GQU/+ddbily7PqSJFGXOoa2dFnqzLlXe/BjY0r+55AiD45DsavqWi7lb/6xD/Tpi2
	 5jEC+GvHeiOO7BR3BHjK3ZXFsInTmcazTyF8pPqL5ra5VMzlrrjo3aoOc6el7G0TF7
	 CrJLavDMZ2aL+3+kX4d58XQAXlWZlxLDTkIQU/sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbfDDJDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731719AbfDDJDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:03:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1036A2177E;
        Thu,  4 Apr 2019 09:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368589;
        bh=KS49ZRQXFQhsf3hD5VUKYfYlK87+W2Kb8wM8JpGowVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ygN4/WIQ9ZstrNc1wiZykqF3b/LTv6p6bKzPP1yW1wAzKw6AwADkcj5mOTitbiPwt
         4Lw48IkfdYENRVdxQ9qsaPsLqllmFXCj88Q0K22m99lglqKX4jDN0TX5KVtrgnOxUx
         P/2rhuIvNR1qHvuP/HMmthEzwDymsoBX5Ci5c218=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 079/187] drm/amd/display: Clear stream->mode_changed after commit
Date:   Thu,  4 Apr 2019 10:46:56 +0200
Message-Id: <20190404084606.751762291@linuxfoundation.org>
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
index 9045e6fa0780..bb0cda727605 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -958,6 +958,9 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	/* pplib is notified if disp_num changed */
 	dc->hwss.set_bandwidth(dc, context, true);
 
+	for (i = 0; i < context->stream_count; i++)
+		context->streams[i]->mode_changed = false;
+
 	dc_release_state(dc->current_state);
 
 	dc->current_state = context;
-- 
2.19.1



