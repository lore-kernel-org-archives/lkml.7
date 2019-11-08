Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34955FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34BF21D82
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213629;
	bh=v1prjkhELBhwKJpCCsadHkv68GhTa67gCjrparn07S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ke8M/XFafRv7ZBvhtKQ5L6YVOeAj2VqM7PhIoiPFRkWFfLa+ALuuicDB/2GpdqXAC
	 nSyV5R4kKH0STRYQLCcIvyqb6wcDtZS4LgTVlfeYplS84c55yTbn84vG5upCT+kW3T
	 O0S60JXK/8teGor9gQyaa+WABDgcbOuUARYYXRpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391483AbfKHLrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391445AbfKHLqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:46:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D163D2245A;
        Fri,  8 Nov 2019 11:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213609;
        bh=v1prjkhELBhwKJpCCsadHkv68GhTa67gCjrparn07S0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cLu3RjxR0l7uVAG7HO6imnDe3EdpaUGP2ljlXR4eLNi9fllKHjR55bNQkUJVgyzOq
         JUoqDQ70bcPmYQlUCsJKz1FBtX3noD27OF4K99xQL5yoKUnZsEytcOlBhhAf6PWilB
         HM/6GyNfx5Oeu53v/ShChiSXTtZ7GWBYyidXqrZE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 46/64] nvmem: core: return error code instead of NULL from nvmem_device_get
Date:   Fri,  8 Nov 2019 06:45:27 -0500
Message-Id: <20191108114545.15351-46-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

