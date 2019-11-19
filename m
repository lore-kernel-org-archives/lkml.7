Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D07C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA0E206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141641;
	bh=tU1uL0kgHbeIfHi2VXruJE3ZdOm5oSbiBE7SyjAQ0hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mTdCREptHtmSMYXYmuoBSUhag3Pq7GlobZI8gkXBVz+9IA2OqeyaagNwx4RG5acSm
	 RqU+ScgbG6yp5NbQcGQMa+t/Ndq6Gg+JfxZ2JV5XtEM5TnPeKBhqGcPxjH0W5eTzpa
	 6lI8RY7tSy/1gJqdfxAZjacRSMeNGFMrJpFAETFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfKSFeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:34:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbfKSFd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:33:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A00D1206EC;
        Tue, 19 Nov 2019 05:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141636;
        bh=tU1uL0kgHbeIfHi2VXruJE3ZdOm5oSbiBE7SyjAQ0hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7kesEVqZYerwY76senzfHpws9cTcWPJuhLCCKafRKluQGPAGUmDgW5KKVsmcwLRZ
         5Rbtr4R5LdqNTmjR5ePW/+M8V0Dri/JKB7a839JI+ITN66qKIQ/jPVjjltD155l3KH
         KlDFoLjFS7ftHjpLQbzHzG3Fj5TSMmnYewYjTH8Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 188/422] nvmem: core: return error code instead of NULL from nvmem_device_get
Date:   Tue, 19 Nov 2019 06:16:25 +0100
Message-Id: <20191119051410.688562851@linuxfoundation.org>
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



