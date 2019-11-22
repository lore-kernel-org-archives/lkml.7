Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD7DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A43020708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574422047;
	bh=NRLAl6V12SzZIvNvM/58GkrMfGcZ5KGi5UFCtt3HtR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sz8dbxCLXOOSXM3v8sUa7piNw3zLYXbOB2vk1AmLkHE0mZI0fuAeyV8EgSusoj8RF
	 Q/bdx4CMHWZPIxuylMJpD6/tfzxR/NQTr5bpFWeqhhrCBvFDzi9S409/dpkAmvuQhP
	 mNe06Gkv+Tw6dmrJ1Yc/ADhmqAS+if+yTHW88Gsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfKVKco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:32:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbfKVKcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:32:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4B9820714;
        Fri, 22 Nov 2019 10:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418762;
        bh=NRLAl6V12SzZIvNvM/58GkrMfGcZ5KGi5UFCtt3HtR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvZ76YWHk9fFNmmJLfNok5UEohb/qzt0RV+PKSFgy19SFKMzyjs652BWN366JJlwv
         5rx4DHrE2i9NiRTIpPXYNBOyoFQQXZUGEOTEKPpmlpBCJqoVLlOa3eCycrRXSYm9xC
         UBkCgco0pHh8eOq1/eJTK+j8b6jWqXJZ2gFTaidw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 044/159] nvmem: core: return error code instead of NULL from nvmem_device_get
Date:   Fri, 22 Nov 2019 11:27:15 +0100
Message-Id: <20191122100737.184105147@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
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
index 931cc33e46f02..5d6d1bb4f1106 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -457,7 +457,7 @@ static struct nvmem_device *nvmem_find(const char *name)
 	d = bus_find_device(&nvmem_bus_type, NULL, (void *)name, nvmem_match);
 
 	if (!d)
-		return NULL;
+		return ERR_PTR(-ENOENT);
 
 	return to_nvmem_device(d);
 }
-- 
2.20.1



