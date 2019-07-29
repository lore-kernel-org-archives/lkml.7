Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2893C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3367217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428947;
	bh=G65mtQ9TaQSShLzvl+hKMv4/rU9GifJgKQgXHhXgXD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NGLZpluPKQKg3mCHZXzI8ORbHSmjYM6/7lS2qgcpHWjM7sncCC0h0XJ/kzwf6lbN7
	 dCaEQkCgBEtuE9okKHteU/PpiEBSuU1tKISFXLj1OyVCqoSe8Ju+d2DGTqCqarzQ+0
	 rPoonozF/VLaaV44FeHk3cLQRsr+xJ5Hhqjh1Ado=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbfG2Tfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbfG2Tfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:35:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2561C217D4;
        Mon, 29 Jul 2019 19:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428939;
        bh=G65mtQ9TaQSShLzvl+hKMv4/rU9GifJgKQgXHhXgXD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dw8z936XlyXTcRO5jTpfZfiBG79gKLA7j8ltcUg9KGx2bTEM1aUd7Zh4RlWE3mmbK
         Ue3dsEw0CFIhZ2V6zIGcPP59i9G2evmAgNRs9Mhv2YVWdOzEmtf2hXTnbum4SGXCfN
         hfzTFXxnfAw+vpVCtztL+2elJDHXsbHr3Bzdh/jA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gen Zhang <blackgod016574@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 227/293] drm/edid: Fix a missing-check bug in drm_load_edid_firmware()
Date:   Mon, 29 Jul 2019 21:21:58 +0200
Message-Id: <20190729190841.890464443@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9f1f1a2dab38d4ce87a13565cf4dc1b73bef3a5f ]

In drm_load_edid_firmware(), fwstr is allocated by kstrdup(). And fwstr
is dereferenced in the following codes. However, memory allocation
functions such as kstrdup() may fail and returns NULL. Dereferencing
this null pointer may cause the kernel go wrong. Thus we should check
this kstrdup() operation.
Further, if kstrdup() returns NULL, we should return ERR_PTR(-ENOMEM) to
the caller site.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190524023222.GA5302@zhanggen-UX430UQ
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_edid_load.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid_load.c b/drivers/gpu/drm/drm_edid_load.c
index 1c0495acf341..06656acea420 100644
--- a/drivers/gpu/drm/drm_edid_load.c
+++ b/drivers/gpu/drm/drm_edid_load.c
@@ -274,6 +274,8 @@ struct edid *drm_load_edid_firmware(struct drm_connector *connector)
 	 * the last one found one as a fallback.
 	 */
 	fwstr = kstrdup(edid_firmware, GFP_KERNEL);
+	if (!fwstr)
+		return ERR_PTR(-ENOMEM);
 	edidstr = fwstr;
 
 	while ((edidname = strsep(&edidstr, ","))) {
-- 
2.20.1



