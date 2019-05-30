Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EBBC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFF9252C0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189925;
	bh=NY+bzGCLjPOwmO4DfrTLzjvI0VS/oC+/ExlyrjN8xHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L/dniLQEmFE9gLL6vPeIheafNj6xPuaPd23xRWiNfT0A0T6ZH8320+M5NcT9yv3hh
	 EfPv+C24RfEtjOiDWWyA1VMRMUPJmPQOESfS3G0lg57dU/1QjvvVwFvbQRv6QoXKVJ
	 eLCyNbaQss0wjxpwuG4WJwNrrZpPkNZG7krenqNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbfE3ESp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730315AbfE3DPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:30 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D91D2455E;
        Thu, 30 May 2019 03:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186129;
        bh=NY+bzGCLjPOwmO4DfrTLzjvI0VS/oC+/ExlyrjN8xHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x++qiUaA/9UkmeKR7ThZT+67XF7Gz7HWeqaluXoVQPwogsfwD/Jt17zv4tSzjvfN+
         dAUGjhgrXTbq2paazQs2zCNGnDsw+PgJrrj6glVP6Y6QFh1eyJ/iXHOVUe2NdfhuD6
         TA0IFuS3f8KD2Yg6fwu0GGcp4Jvv46RxRInrWAnA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 291/346] thunderbolt: property: Fix a NULL pointer dereference
Date:   Wed, 29 May 2019 20:06:04 -0700
Message-Id: <20190530030555.620140321@linuxfoundation.org>
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

[ Upstream commit 106204b56f60abf1bead7dceb88f2be3e34433da ]

In case kzalloc fails, the fix releases resources and returns
-ENOMEM to avoid the NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/property.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index ead18c532b53d..8c077c4f3b5b2 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -548,6 +548,11 @@ int tb_property_add_data(struct tb_property_dir *parent, const char *key,
 
 	property->length = size / 4;
 	property->value.data = kzalloc(size, GFP_KERNEL);
+	if (!property->value.data) {
+		kfree(property);
+		return -ENOMEM;
+	}
+
 	memcpy(property->value.data, buf, buflen);
 
 	list_add_tail(&property->list, &parent->properties);
-- 
2.20.1



