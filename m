Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A406C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC048222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781778;
	bh=DXRwfcdkeourfhTF/yaOngZc4nLdbMz9SJBOFGWLNRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sshuBH1DFWdbTnPrxSZmE1EEjwojES+5+9yJMLK7rQsfvz0TGTxMlEojdg23fWLTh
	 rKIflJMBmqxCQBSLVS/pBKk2hvAlEGrP0Glrph3UqOdYXtLxoKxG12PhnSoLcZ1PVj
	 lYweeYZlcDt3NoaILN9Ud02JrMaiRUlAeYqGNIBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfLSS4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:56:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730785AbfLSS4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:56:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 303BE206EC;
        Thu, 19 Dec 2019 18:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781771;
        bh=DXRwfcdkeourfhTF/yaOngZc4nLdbMz9SJBOFGWLNRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ypV6kO4eBTkU9RRhH92+Rl8d9Xdp/p+qJOOLvJ6Qx9d16Z23IrlsVzhpgjNkSWu9o
         hwR/nawdpsYO6pW+HXfC3xBngjyAPSKl8Trh4IJjCOgeiBsto4CPsiIGIkARXCbgV7
         tWkzwlmPoHHm9WV9GK1SReVQ/xfM48Cg9CGFld2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 72/80] drm/amd/display: re-enable wait in pipelock, but add timeout
Date:   Thu, 19 Dec 2019 19:35:04 +0100
Message-Id: <20191219183143.088145146@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 627f75d18910b287472593a4a2c41de9a386f5a2 upstream.

Removing this causes hangs in some games, so re-add it, but add
a timeout so we don't hang while switching flip types.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=205169
Bug: https://bugs.freedesktop.org/show_bug.cgi?id=112266
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1103,6 +1103,25 @@ void dcn20_pipe_control_lock(
 	if (pipe->plane_state != NULL)
 		flip_immediate = pipe->plane_state->flip_immediate;
 
+	if (flip_immediate && lock) {
+		const int TIMEOUT_FOR_FLIP_PENDING = 100000;
+		int i;
+
+		for (i = 0; i < TIMEOUT_FOR_FLIP_PENDING; ++i) {
+			if (!pipe->plane_res.hubp->funcs->hubp_is_flip_pending(pipe->plane_res.hubp))
+				break;
+			udelay(1);
+		}
+
+		if (pipe->bottom_pipe != NULL) {
+			for (i = 0; i < TIMEOUT_FOR_FLIP_PENDING; ++i) {
+				if (!pipe->bottom_pipe->plane_res.hubp->funcs->hubp_is_flip_pending(pipe->bottom_pipe->plane_res.hubp))
+					break;
+				udelay(1);
+			}
+		}
+	}
+
 	/* In flip immediate and pipe splitting case, we need to use GSL
 	 * for synchronization. Only do setup on locking and on flip type change.
 	 */


