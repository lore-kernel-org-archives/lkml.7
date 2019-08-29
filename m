Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27315C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E377B20578
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103057;
	bh=em3tqHdWgAqd9Ik7eTSlUEpP6WoxfX3uzGf4z8ov/qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZuKu0vn2XPP7eI08XQAQ+DcMZpJXpp0faKzcka3hV0a+x9Pe+L/SQ/3+zl8wK31Q3
	 NpkzFbk5/1CAelBRRXkcgxmnx+DC3gBATJTxVf4qfakbPIUy3o7iVWd6quxL9X7AjI
	 pC0K2N+P1Ef8ZUXE95tXhIXVsGwU08BBEG7aVyy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfH2SQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729753AbfH2SQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:16:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B91F2339E;
        Thu, 29 Aug 2019 18:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102586;
        bh=em3tqHdWgAqd9Ik7eTSlUEpP6WoxfX3uzGf4z8ov/qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvngjxqvGG9+qe/QrLqnLpKQFcS4FF6Dc2ay/4stHKY+OiUIeklGSLaXOriRroZh0
         9s3NjNRsCkKQFexSFRZOAVDrGB5KfvgEfBQctjR210xPDx3usmMWwvpeqQ5ZkQOLrh
         t19x+Xb7Uc3MCDhupCHQTaAPODnDiruyHNgsSvUY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 27/45] wimax/i2400m: fix a memory leak bug
Date:   Thu, 29 Aug 2019 14:15:27 -0400
Message-Id: <20190829181547.8280-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181547.8280-1-sashal@kernel.org>
References: <20190829181547.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 44ef3a03252844a8753479b0cea7f29e4a804bdc ]

In i2400m_barker_db_init(), 'options_orig' is allocated through kstrdup()
to hold the original command line options. Then, the options are parsed.
However, if an error occurs during the parsing process, 'options_orig' is
not deallocated, leading to a memory leak bug. To fix this issue, free
'options_orig' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wimax/i2400m/fw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wimax/i2400m/fw.c b/drivers/net/wimax/i2400m/fw.c
index e9fc168bb7345..489cba9b284d1 100644
--- a/drivers/net/wimax/i2400m/fw.c
+++ b/drivers/net/wimax/i2400m/fw.c
@@ -351,13 +351,15 @@ int i2400m_barker_db_init(const char *_options)
 			}
 			result = i2400m_barker_db_add(barker);
 			if (result < 0)
-				goto error_add;
+				goto error_parse_add;
 		}
 		kfree(options_orig);
 	}
 	return 0;
 
+error_parse_add:
 error_parse:
+	kfree(options_orig);
 error_add:
 	kfree(i2400m_barker_db);
 	return result;
-- 
2.20.1

