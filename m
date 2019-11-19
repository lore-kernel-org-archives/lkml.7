Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B72EC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA0720721
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142742;
	bh=FTJPCXRcxDMOJSToYEtqeq6c2U9ZZgf1fojkXraSZa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hpmXBWLSLuJWoP4/qTk++bAcpoeFXGp4ojdobnIV8U++005lBJhNK39TCdX982tvf
	 SqFBFeNoWISI4JVQvs7nmNq/92v2b9zopkusB30CJrxWYyntaTMdZrQnsM3Bn7MCbL
	 vDmSvO6mEzvD95pMYf++0uGEDsKBL0xgGVjEvDB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbfKSFwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:52:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731891AbfKSFwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:52:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858F0208C3;
        Tue, 19 Nov 2019 05:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142735;
        bh=FTJPCXRcxDMOJSToYEtqeq6c2U9ZZgf1fojkXraSZa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/Ydts1o9jUZITUswJvzjTTXqz4S/v8aDg+ncPqKyIYnbwzLtp6FxVY7y08xaHdE1
         lo45WiFTDUCH2ADm9K5kyh96Z89+bz9AffVtPFF9syf91GZoblCHr2zE1L7jWQquQg
         aU8oyt+mBWLhzXyeYSI4KvvVs7PL9bw1PciqJu2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 183/239] usb: gadget: uvc: configfs: Drop leaked references to config items
Date:   Tue, 19 Nov 2019 06:19:43 +0100
Message-Id: <20191119051334.808680118@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 86f3daed59bceb4fa7981d85e89f63ebbae1d561 ]

Some of the .allow_link() and .drop_link() operations implementations
call config_group_find_item() and then leak the reference to the
returned item. Fix this by dropping those references where needed.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/uvc_configfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 844cb738bafd0..fc604439b25a1 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -543,6 +543,7 @@ static int uvcg_control_class_allow_link(struct config_item *src,
 unlock:
 	mutex_unlock(&opts->lock);
 out:
+	config_item_put(header);
 	mutex_unlock(su_mutex);
 	return ret;
 }
@@ -578,6 +579,7 @@ static void uvcg_control_class_drop_link(struct config_item *src,
 unlock:
 	mutex_unlock(&opts->lock);
 out:
+	config_item_put(header);
 	mutex_unlock(su_mutex);
 }
 
@@ -2037,6 +2039,7 @@ static int uvcg_streaming_class_allow_link(struct config_item *src,
 unlock:
 	mutex_unlock(&opts->lock);
 out:
+	config_item_put(header);
 	mutex_unlock(su_mutex);
 	return ret;
 }
@@ -2077,6 +2080,7 @@ static void uvcg_streaming_class_drop_link(struct config_item *src,
 unlock:
 	mutex_unlock(&opts->lock);
 out:
+	config_item_put(header);
 	mutex_unlock(su_mutex);
 }
 
-- 
2.20.1



