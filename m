Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032FBC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE20A20715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419297;
	bh=v1prjkhELBhwKJpCCsadHkv68GhTa67gCjrparn07S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CKuXP4Dm5muDCMBsjGTn5EQxZBU27YiP4a7s1WphcuZ5+5cALIuuyFzXmAU2Wdfzc
	 +vDOCjNb3k9r0rZAwNx+Xv1A0IAHzKeBPtcaWC49s9k/WlpYwO2lgjmgVAfEALt6Rn
	 r6s+g+9In9dk91IFDg3ACTgBEwyNkKBJ+qAMOR9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKVKlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbfKVKlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:41:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C09220637;
        Fri, 22 Nov 2019 10:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419294;
        bh=v1prjkhELBhwKJpCCsadHkv68GhTa67gCjrparn07S0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9mT53RiOiKR4tQRBGHu6brsOHF2UrgUEcSo5/qBljnsGt38kzJt5SmsETgRlyHe3
         hoM+d4HZM/TPVr8/BZmltGAHxA6kzDOxmsTD8/QTGPQkvZ5WepSNbmWRj1Ek8HxFmq
         E3K8veGjysQxDrN9buQ/1a3wyZ/PnIGheMoSl0bc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 061/222] nvmem: core: return error code instead of NULL from nvmem_device_get
Date:   Fri, 22 Nov 2019 11:26:41 +0100
Message-Id: <20191122100859.001421740@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit ca6ac25cecf0e740d7cc8e03e0ebbf8acbeca3df ]

nvmem_device_get() should return ERR_PTR() on error or valid pointer
on success, but one of the code path seems to return NULL, so fix it.

Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9ca24e4d5d49c..2a0c5f3b0e509 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -609,7 +609,7 @@ static struct nvmem_device *nvmem_find(const char *name)
 	d = bus_find_device(&nvmem_bus_type, NULL, (void *)name, nvmem_match);
 
 	if (!d)
-		return NULL;
+		return ERR_PTR(-ENOENT);
 
 	return to_nvmem_device(d);
 }
-- 
2.20.1



