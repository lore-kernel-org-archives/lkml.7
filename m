Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAEFC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB384217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WG5zQnUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389816AbfDRRmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:42:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36000 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388301AbfDRRmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:42:05 -0400
Received: from zn.tnic (p200300EC2F112E00A8B56675B85BD571.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:a8b5:6675:b85b:d571])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D6B51EC021C;
        Thu, 18 Apr 2019 19:42:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555609324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=qhTZu2DrEhyQYCQDoX9DIrBQOZ9IImjuYGCUac04frs=;
        b=WG5zQnUn3MkREXuU6gGyd3Z4di6wlxqgAPgSfK1RzgyT4YS5zFi3LNazEvvjYo7DMJH4A9
        lSYBRmMxhLW7cv+wKEZ4C6ahtjVQXklPOa06IO9SifLljTMmyEnlxJi+T9oVYHY4uQ0puP
        3ttAMc2DUPBi8ZF5VDNM6IwDyV/1eWM=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: Clarify which counterparts to use to device_add()
Date:   Thu, 18 Apr 2019 19:41:56 +0200
Message-Id: <20190418174156.11926-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

It is not absolutely clear from the docs how the cleanup path after
device_add() should look like so spell it out explicitly.

No functional changes, just documentation.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/base/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4aeaa0c92bda..fd7511e04e62 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1999,6 +1999,11 @@ static int device_private_init(struct device *dev)
  * NOTE: _Never_ directly free @dev after calling this function, even
  * if it returned an error! Always use put_device() to give up your
  * reference instead.
+ *
+ * Rule of thumb is: if device_add() succeeds, you should call
+ * device_del() when you want to get rid of it. If device_add() has
+ * *not* succeeded, use *only* put_device() to drop the reference
+ * count.
  */
 int device_add(struct device *dev)
 {
-- 
2.21.0

