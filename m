Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF79C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CC32173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419315;
	bh=vJ8w4htedC/8htY4DtU+SOcmX6ujTSuRQKyw1FvnSsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wG971J1enaB12NL3jZtTRO+6lSpRi2D/TSVm70mXw5qwAUMNrCPmRG1h86lCj3q7U
	 FsTX9WnEtElrxcUtWLGViiEFP22uD/Hg8AurKJPal4bkfGuAU+o88GSTCzIhLtg2sr
	 Ait/W2BqfkZ+alcGtDjbFF7zKVKGjCuJ5/SMsLIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390782AbfGRDIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390239AbfGRDI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:08:28 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05A5120818;
        Thu, 18 Jul 2019 03:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419308;
        bh=vJ8w4htedC/8htY4DtU+SOcmX6ujTSuRQKyw1FvnSsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFoS0k3csc+3b0CRYfixFxuXX62oG7Q3h8LRCAhfdjrASvwfteh1I0eBkAfgigDsq
         Sfkp2fbkMeptsGHEC9D/iagR+1AiQpQdmUAzki48AjJO9muqNwo7TiaBD+8GhbrXA5
         JYq2z+eYNW2OncdGsWvAThM6GMKv9LPkj3NdwuNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Sean Paul <seanpaul@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 45/47] drm/udl: Replace drm_dev_unref with drm_dev_put
Date:   Thu, 18 Jul 2019 12:01:59 +0900
Message-Id: <20190718030052.562190741@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030045.780672747@linuxfoundation.org>
References: <20190718030045.780672747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ac3b35f11a06964f5fe7f6ea9a190a28a7994704 upstream.

This patch unifies the naming of DRM functions for reference counting
of struct drm_device. The resulting code is more aligned with the rest
of the Linux kernel interfaces.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20180926120212.25359-1-tzimmermann@suse.de
Signed-off-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/udl/udl_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 54e767bd5ddb..bd4f0b88bbd7 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -95,7 +95,7 @@ static int udl_usb_probe(struct usb_interface *interface,
 	return 0;
 
 err_free:
-	drm_dev_unref(dev);
+	drm_dev_put(dev);
 	return r;
 }
 
-- 
2.20.1



