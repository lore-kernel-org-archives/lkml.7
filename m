Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBFCC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D8820854
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355817;
	bh=t3smQKcjjFBjbreDgVg9JggXSHRt1WbmMzRz6EoMzU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XMGEUd4KM2+rZU2QgnDBpvQRL8kOKDLB56g7+mUG94t+d7hrgQc8Ik3GWXsrsL6bz
	 Il82kLIJdsuIDBkidTlxAyzPHu4aHANGj9SIGjL2VX2mcp76BBwENZ9AizxeTk38J9
	 oI+zb+xXU7MT4Ho8vye/hAMhhJfYAPfPiJaNfU3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfKJDQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:16:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfKJCkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:40:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DB2021019;
        Sun, 10 Nov 2019 02:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353638;
        bh=t3smQKcjjFBjbreDgVg9JggXSHRt1WbmMzRz6EoMzU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPPN1/wsZjB3i942wFJSZQjIdspbwFmKeQ4L25zvJ5zK/oLg40Jjqq5sHzjM1QT7i
         zqfoQwuAFackYSeWGaqGuMbQLE4USZJRMc9BnpYiEQ0Ey6yVgdR6ifDR1ZDkyftBJc
         Q8+1tvNR11Gd2BZPnnScqB9hV822YNsPnwQEEYHk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 022/191] ipmi: fix return value of ipmi_set_my_LUN
Date:   Sat,  9 Nov 2019 21:37:24 -0500
Message-Id: <20191110024013.29782-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 060e8fb53fe3455568982d10ab8c3dd605565049 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/char/ipmi/ipmi_msghandler.c: In function 'ipmi_set_my_LUN':
drivers/char/ipmi/ipmi_msghandler.c:1335:13: warning:
 variable 'rv' set but not used [-Wunused-but-set-variable]
  int index, rv = 0;

'rv' should be the correct return value.

Fixes: 048f7c3e352e ("ipmi: Properly release srcu locks on error conditions")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 3fb297b5fb176..84c17f936c09c 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -1365,7 +1365,7 @@ int ipmi_set_my_LUN(struct ipmi_user *user,
 	}
 	release_ipmi_user(user, index);
 
-	return 0;
+	return rv;
 }
 EXPORT_SYMBOL(ipmi_set_my_LUN);
 
-- 
2.20.1

