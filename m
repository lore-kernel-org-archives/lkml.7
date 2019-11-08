Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E03C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9545D222C5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213316;
	bh=tU1uL0kgHbeIfHi2VXruJE3ZdOm5oSbiBE7SyjAQ0hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=urhCjIn21rGkcsWW1oNBOAKVRQyKPb4o+VKYA9EtaOVHZqCtQQH86Eqah65QWPd+L
	 51Zxyzye1W3FiC6UxvBvMBUPC+wn9YhXg5l9JM7RQtoctvkxURLinIESQaYUL4ZErE
	 ebG/mw57BENUmtnsgKIdfzzLJW3rDuIqmeuYkSig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKHLlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:41:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732994AbfKHLlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0469222C6;
        Fri,  8 Nov 2019 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213309;
        bh=tU1uL0kgHbeIfHi2VXruJE3ZdOm5oSbiBE7SyjAQ0hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KafMaqE9Zrdr+Z0NlbvDfdu7xOaQ+Ol19uBqyYv1XCbLsbuJm2/8j7tmZDYg1CMzL
         97W1Bs8ZacO0P1iXNCNQt/XPYQclHf8Rq48P0e3SsL1k7PynmLzpjUsIqg0rruVVmU
         tjy8o+dNdSg2DO7eP3+Mqt7xealX7i7vYYKQbr80=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 157/205] nvmem: core: return error code instead of NULL from nvmem_device_get
Date:   Fri,  8 Nov 2019 06:37:04 -0500
Message-Id: <20191108113752.12502-157-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
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
index d32eba11c000f..30c040786fde2 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -692,7 +692,7 @@ static struct nvmem_device *nvmem_find(const char *name)
 	d = bus_find_device_by_name(&nvmem_bus_type, NULL, name);
 
 	if (!d)
-		return NULL;
+		return ERR_PTR(-ENOENT);
 
 	return to_nvmem_device(d);
 }
-- 
2.20.1

