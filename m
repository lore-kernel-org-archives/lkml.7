Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC69CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4FE20872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437419;
	bh=c1WbYc7+1DaUk7tz5oVMf3z3M5NgNPMbvxSbncKOJaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UjHGw4Vbwuk2yJO1N1W/a40F96r8SWlGGF7r4E7peAm4RuHlggRyx/6kUjAOma0jR
	 h9RhOF/LyAI+NPguxmHR69tWCkoNRPtGnzIfdpGQIHXfgJM6TXWuhlc+liiYvOadKJ
	 QkcGoYCNpE1hunQ7TXBmB4qcfCp6por7fhOgW+rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405360AbfJRWXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729419AbfJRWFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:05:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A58D22459;
        Fri, 18 Oct 2019 22:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436316;
        bh=c1WbYc7+1DaUk7tz5oVMf3z3M5NgNPMbvxSbncKOJaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtGZ0CLCeos4fmToUieEPTIyfdvoSUyORncso4DpbgK5O/BciV0F2NzIK7HkBcaeP
         Tsst6eRCKz9Ug3Al5BvoXqxVn8w3jQhynn4FuNNpSo6lb5eAP1jRHy4OxbrwAFn29M
         1jCt7m09ProMAx3G8+wAIfha+CCE6flkyRpIPoi4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 84/89] virt: vbox: fix memory leak in hgcm_call_preprocess_linaddr
Date:   Fri, 18 Oct 2019 18:03:19 -0400
Message-Id: <20191018220324.8165-84-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

