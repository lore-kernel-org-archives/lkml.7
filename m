Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905A8C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6D9248BA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186385;
	bh=nee2vrOmQ4okfHpD3mzELlBwcqL/4NjdOs0zA3n8Yhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LXoJ+hs2rZ+7o5/63gCMPzJeEvM4bMKWkSYydijWqXTB2cs2FKa/sl5+Q9M6ozm/j
	 t2KIyUaHjhUsQ6+3DYfWIu8BMa7VDhNvBqEWl1YKDjG6+7s7xDsWmal/9wh2M+M419
	 e7BZ6LTnnmLiTsm4TA3nfisSnBLA8rBcDlU8byTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbfE3DTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbfE3DPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:37 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ED69245A7;
        Thu, 30 May 2019 03:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186137;
        bh=nee2vrOmQ4okfHpD3mzELlBwcqL/4NjdOs0zA3n8Yhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLnjZAIc5gutyWgK/uUVQexZ2IJymBSuomMw2OKndpNr+Xf+X5a5gH5ZvnQdceEgV
         7nS9q7/rYsolAnaPSK+aD5XANHxDcS7GCBDj4gamHKUyTM5O5VwHTjGSUkNWES+5Wl
         vxz0F5iOD3p/shQBQUp5WYAFhY8R0a3KptITbxeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 261/346] thunderbolt: property: Fix a missing check of kzalloc
Date:   Wed, 29 May 2019 20:05:34 -0700
Message-Id: <20190530030554.195072630@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6183d5a51866f3acdeeb66b75e87d44025b01a55 ]

No check is enforced for the return value of kzalloc,
which may lead to NULL-pointer dereference.

The patch fixes this issue.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/property.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index b2f0d6386ceea..ead18c532b53d 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -578,7 +578,12 @@ int tb_property_add_text(struct tb_property_dir *parent, const char *key,
 		return -ENOMEM;
 
 	property->length = size / 4;
-	property->value.data = kzalloc(size, GFP_KERNEL);
+	property->value.text = kzalloc(size, GFP_KERNEL);
+	if (!property->value.text) {
+		kfree(property);
+		return -ENOMEM;
+	}
+
 	strcpy(property->value.text, text);
 
 	list_add_tail(&property->list, &parent->properties);
-- 
2.20.1



