Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35610C43141
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017CE20672
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141725;
	bh=t3smQKcjjFBjbreDgVg9JggXSHRt1WbmMzRz6EoMzU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lDmO0oOvNWyE5QGmaYPH4r5u7v8jpv+pIA9Ht4y6VDJEfuLnqx5LfZJOs2r2Rpc9z
	 U99bMht4Lnvj8Wy+1xtvI4mQuTvfLK/QWs9CY2MooyAZzJrBt671bhyuM/V0vTbtN7
	 Ibk5yhykyLbcCOzWIfcO3crL/JXGguQbFVqvCHuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfKSFfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfKSFfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:35:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07488206EC;
        Tue, 19 Nov 2019 05:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141718;
        bh=t3smQKcjjFBjbreDgVg9JggXSHRt1WbmMzRz6EoMzU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Od9lUSxn5mGOAJyeYDj3HQnEYHk0IRmolf99ko5HhV94BXg+I+l2IPno8lLymmRJ8
         glYCRjutcCy8ixZOmeF+V9UE3E3BFCOb1BzSvbT3OILsaHEf0s8kyF4WSJ1hz6y79B
         DRCKrfpw96ZkXeC7QCQYNiSRlv1EXJ/B8DUOdbsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 256/422] ipmi: fix return value of ipmi_set_my_LUN
Date:   Tue, 19 Nov 2019 06:17:33 +0100
Message-Id: <20191119051415.576556883@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



