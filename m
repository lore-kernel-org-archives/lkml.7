Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20520C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47E62083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256637;
	bh=gAzmrWlt6+LJ8/3892nTQVub6xIMwpOAOfzZuSUuEQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bwKUCB3c866DQnyKTsGRo8iSxnzIvYexlzlwbiRiGPPmlZJYhoZVUBIpc3XUMngMr
	 goX/uX8QzcAkmdmV5UgHWgUQ9ge9/QtdddJ7+cJk+DaO9z2jS3Ezo4wuYzkPVkIrO6
	 pn8Z8nIEzTgrRpmg/Qm/101vRdogvAK5QLbD3yuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbfCVMKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733086AbfCVMKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:10:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A73020830;
        Fri, 22 Mar 2019 12:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256632;
        bh=gAzmrWlt6+LJ8/3892nTQVub6xIMwpOAOfzZuSUuEQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNJpMyF/oVY0glUY9RuoOsKTaeCD5gJmLoxGGDclBQQcBmdtqD8q+TQpApeqdWNdn
         vinwcGWPk0PTPHI363SBVIqLxTvHR+MGAGU5aZpZng25syAXWMGjDmevCLi7Nk4JZR
         abLimkz6XfvEPw+uj5y4CUMVFJf8gNTw+n0Lagr8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 4.19 272/280] drm/amd/display: dont call dm_pp_ function from an fpu block
Date:   Fri, 22 Mar 2019 12:17:05 +0100
Message-Id: <20190322111346.363130576@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

From: Harry Wentland <harry.wentland@amd.com>

commit 59d3191f14dc18881fec1172c7096b7863622803 upstream.

Powerplay functions called from dm_pp_* functions tend to do a
mutex_lock which isn't safe to do inside a kernel_fpu_begin/end block as
those will disable/enable preemption.

Rearrange the dm_pp_get_clock_levels_by_type_with_voltage calls to make
sure they happen outside of kernel_fpu_begin/end.

Cc: stable@vger.kernel.org
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -1347,12 +1347,12 @@ void dcn_bw_update_from_pplib(struct dc
 	struct dm_pp_clock_levels_with_voltage fclks = {0}, dcfclks = {0};
 	bool res;
 
-	kernel_fpu_begin();
-
 	/* TODO: This is not the proper way to obtain fabric_and_dram_bandwidth, should be min(fclk, memclk) */
 	res = dm_pp_get_clock_levels_by_type_with_voltage(
 			ctx, DM_PP_CLOCK_TYPE_FCLK, &fclks);
 
+	kernel_fpu_begin();
+
 	if (res)
 		res = verify_clock_values(&fclks);
 
@@ -1371,9 +1371,13 @@ void dcn_bw_update_from_pplib(struct dc
 	} else
 		BREAK_TO_DEBUGGER();
 
+	kernel_fpu_end();
+
 	res = dm_pp_get_clock_levels_by_type_with_voltage(
 			ctx, DM_PP_CLOCK_TYPE_DCFCLK, &dcfclks);
 
+	kernel_fpu_begin();
+
 	if (res)
 		res = verify_clock_values(&dcfclks);
 


