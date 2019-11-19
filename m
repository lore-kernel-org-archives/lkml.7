Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCBCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A212621783
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141578;
	bh=UVs0BQCbS7l7vr5KRG0CBnk8B8+YWO9XidSyUtzdbGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CjiX8Pv0HpjrYnIQDJWy9KwBDKsVwwNGwmTmDAg6vFCNiJxGfPChPYgvxIVMvzWym
	 gb2O3ZKFk+MlzNt1/Y8BzYX3xlpn72NnOod/ORasMUvkmnuChLd/1hVKVnlR5KmDBr
	 Czk+N8ZFeNjHz+7SqZ2xeWKU1snRc45JKB4DtQDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfKSFc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:32:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbfKSFcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:32:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42A9F21783;
        Tue, 19 Nov 2019 05:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141574;
        bh=UVs0BQCbS7l7vr5KRG0CBnk8B8+YWO9XidSyUtzdbGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEiXGqY3qOQA0wrGiRflfQbjYLtWEM6inFY5WCDinad8bNvH6RklwZCAEMpmbD8xs
         HOUbUn3iDGOrbqiCt/mwMskc0WqDcE2EmF4Ku22KaM2v+OF7fOhsDIRbNoefZmYeFZ
         YgkRy+x3LPFF0qRhcZ3WNv9BNzA1GBmWvDFBuuBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 207/422] soc: qcom: apr: Avoid string overflow
Date:   Tue, 19 Nov 2019 06:16:44 +0100
Message-Id: <20191119051412.003391715@linuxfoundation.org>
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

From: Niklas Cassel <niklas.cassel@linaro.org>

[ Upstream commit 4fadb26574cb74e5de079dd384f25f44f4fb3ec3 ]

'adev->name' is used as a NUL-terminated string, but using strncpy() with the
length equal to the buffer size may result in lack of the termination:

In function 'apr_add_device',
    inlined from 'of_register_apr_devices' at drivers//soc/qcom/apr.c:264:7,
    inlined from 'apr_probe' at drivers//soc/qcom/apr.c:290:2:
drivers//soc/qcom/apr.c:222:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
   strncpy(adev->name, np->name, APR_NAME_SIZE);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This changes it to use the safer strscpy() instead.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/apr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 57af8a5373325..ee9197f5aae96 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -219,9 +219,9 @@ static int apr_add_device(struct device *dev, struct device_node *np,
 	adev->domain_id = id->domain_id;
 	adev->version = id->svc_version;
 	if (np)
-		strncpy(adev->name, np->name, APR_NAME_SIZE);
+		strscpy(adev->name, np->name, APR_NAME_SIZE);
 	else
-		strncpy(adev->name, id->name, APR_NAME_SIZE);
+		strscpy(adev->name, id->name, APR_NAME_SIZE);
 
 	dev_set_name(&adev->dev, "aprsvc:%s:%x:%x", adev->name,
 		     id->domain_id, id->svc_id);
-- 
2.20.1



