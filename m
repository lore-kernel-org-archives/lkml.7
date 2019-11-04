Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E649CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11155217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905247;
	bh=c1WbYc7+1DaUk7tz5oVMf3z3M5NgNPMbvxSbncKOJaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D9VlrTOE4VXhDgtLQPCU0PLB6Gd1I+5IG2jZA4Fzu5pcdxzVcvDyZIC0XGNPq3+Pv
	 xHGeMMKDRp4nj+365cH4PfK4WdQI52DV45I97cWeiiq0VJutyD45lUULnez2ioMwKv
	 T+pTy5+LHgBs04Tt89SkykKHxZNSMmsRdDgr2i08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390120AbfKDWHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390095AbfKDWHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:07:24 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DCE020650;
        Mon,  4 Nov 2019 22:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905243;
        bh=c1WbYc7+1DaUk7tz5oVMf3z3M5NgNPMbvxSbncKOJaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5r/RXYYjbt5r0MPPGSvq7RbP6sgZahLXnENcrsl4bCUN2/GvVzuM7uzc3JeB2r+d
         MbBK+ssNkM9vCSn1pfHcywsXoKBxByzZdkYKsPFkfHQJ0z8UAsRD8HBTwCpZKEeBgu
         GFTXWMdZwtoiURfG4hdYg+kZjZHxfsFo+ZaJjwGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 077/163] virt: vbox: fix memory leak in hgcm_call_preprocess_linaddr
Date:   Mon,  4 Nov 2019 22:44:27 +0100
Message-Id: <20191104212145.823138060@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit e0b0cb9388642c104838fac100a4af32745621e2 ]

In hgcm_call_preprocess_linaddr memory is allocated for bounce_buf but
is not released if copy_form_user fails. In order to prevent memory leak
in case of failure, the assignment to bounce_buf_ret is moved before the
error check. This way the allocated bounce_buf will be released by the
caller.

Fixes: 579db9d45cb4 ("virt: Add vboxguest VMMDEV communication code")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20190930204223.3660-1-navid.emamdoost@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virt/vboxguest/vboxguest_utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
index 75fd140b02ff8..43c391626a000 100644
--- a/drivers/virt/vboxguest/vboxguest_utils.c
+++ b/drivers/virt/vboxguest/vboxguest_utils.c
@@ -220,6 +220,8 @@ static int hgcm_call_preprocess_linaddr(
 	if (!bounce_buf)
 		return -ENOMEM;
 
+	*bounce_buf_ret = bounce_buf;
+
 	if (copy_in) {
 		ret = copy_from_user(bounce_buf, (void __user *)buf, len);
 		if (ret)
@@ -228,7 +230,6 @@ static int hgcm_call_preprocess_linaddr(
 		memset(bounce_buf, 0, len);
 	}
 
-	*bounce_buf_ret = bounce_buf;
 	hgcm_call_add_pagelist_size(bounce_buf, len, extra);
 	return 0;
 }
-- 
2.20.1



