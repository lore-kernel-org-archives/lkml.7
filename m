Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F582C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3F121900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257412;
	bh=ut48cEiWhOE+//stqXG37Vi0xKd12pPH2T0g2u2MT5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AgRznyxhmvSNytk7U7snvQWmcAPji30T2EukIPSiVYvMhk5RCf8Skd6Sc3+zSU+5s
	 qsze7t2jjgPzzHi8bOVsRbnnxsB7xOsY4gOHGmzatTB0K1vOOEyIVvo/gdNvAIVYPB
	 BsKtKdGrFFQodAgpdB7He2VCBN7gyVsl6XNW7ngE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391137AbfCVMXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390680AbfCVMX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:23:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 647C6218B0;
        Fri, 22 Mar 2019 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257405;
        bh=ut48cEiWhOE+//stqXG37Vi0xKd12pPH2T0g2u2MT5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WM5c4rLa8XUlbW0OA5GbGROj9SQhjEgDeULwzuBqhoK4ty4JzB3hL1tq7PggNdiRZ
         FU9HaRs8rWkHVJzYpiopHjAoOMBcKoCC0BoOnAOGIcDx3yTgOkJ3twg10zClr3MKf1
         CbbLXf3bBtUV/1n4fdOBoDWhY2buXiDlQe+28xtg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.0 221/238] drm/radeon/evergreen_cs: fix missing break in switch statement
Date:   Fri, 22 Mar 2019 12:17:20 +0100
Message-Id: <20190322111311.357580593@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit cc5034a5d293dd620484d1d836aa16c6764a1c8c upstream.

Add missing break statement in order to prevent the code from falling
through to case CB_TARGET_MASK.

This bug was found thanks to the ongoing efforts to enable
-Wimplicit-fallthrough.

Fixes: dd220a00e8bd ("drm/radeon/kms: add support for streamout v7")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/evergreen_cs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -1299,6 +1299,7 @@ static int evergreen_cs_handle_reg(struc
 			return -EINVAL;
 		}
 		ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
+		break;
 	case CB_TARGET_MASK:
 		track->cb_target_mask = radeon_get_ib_value(p, idx);
 		track->cb_dirty = true;


