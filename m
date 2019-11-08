Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B830BFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8619C207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214264;
	bh=+tsNtYF+z2Lyp9tPCd2Dr0PqAGfSfurgQujhAXNneP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fyAv2WL0h9tn9vNn77W8LBPYRDeNXfJWjD9ZulQ0F6af6E4Ver3HlgbtBoCASEacl
	 xkayb4r6OQq62pG91sy566mvGmiTeo0RCRqkHRLB1wSLjMn3rjYlGSF/FlrcYid6Kq
	 snfoHcucUIeVUW4w6KSoIhoeklobatJsRxa8rKsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390687AbfKHL5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:57:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390999AbfKHLpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:45:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0224A222C5;
        Fri,  8 Nov 2019 11:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213501;
        bh=+tsNtYF+z2Lyp9tPCd2Dr0PqAGfSfurgQujhAXNneP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kjA6NXjQrSqtmXs+4lsRmkylE8AytpjGmK30728qeFnRuRJCIe5grggi00wM99rS/
         gLbnzEGh9MyAB1s3vB1pCK03LPteAF/7LL/JtZ0ONj7QlAKD1OGDJdkjOvWuY0CtFN
         5D79t2v7hme0T/73hBLNWcLTAbKk+DrqdOGilN2A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 078/103] nvmem: core: return error code instead of NULL from nvmem_device_get
Date:   Fri,  8 Nov 2019 06:42:43 -0500
Message-Id: <20191108114310.14363-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
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
index b414d9d207d45..08b171731664e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -617,7 +617,7 @@ static struct nvmem_device *nvmem_find(const char *name)
 	d = bus_find_device(&nvmem_bus_type, NULL, (void *)name, nvmem_match);
 
 	if (!d)
-		return NULL;
+		return ERR_PTR(-ENOENT);
 
 	return to_nvmem_device(d);
 }
-- 
2.20.1

