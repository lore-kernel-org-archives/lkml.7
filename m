Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA37C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84EF218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697052;
	bh=qv0kulbhoW1t2kZ9x0JtcOuqZ0b2dtS8hxMB6oS1WbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s7OMcOVoMkyuFXApYlLyHoLm9gBjf4unYr0EHpGtGYXk1cTMmvR6Qt+4rwtWA7Eyp
	 1GGsdtxyN1XmsG3X/5QQhVQ2mi5mg/gIqlxec2AMCaK6+Cv0kxxa8oVWoLfSbRTvqy
	 x1FLfyqbIo8AOzUbZnrRkTjalCry9+kY+YElhJNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbfJJIoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388871AbfJJIoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:44:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9A33218AC;
        Thu, 10 Oct 2019 08:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697048;
        bh=qv0kulbhoW1t2kZ9x0JtcOuqZ0b2dtS8hxMB6oS1WbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGdOZxCH3B+Gpo8E2+2+Iz0CXE2oN2A5javNDMaeDNx4Ces9N6RwunJY8DtlmCCJC
         9LLLdjMHtxlUNlGCEJvi3wlZbrWag5F3/qZEUyiao7lJkfEq/0d+7q4TIQfoYen86i
         zsHr2huV/2dD8R5oBBucZpV9K9F/k/h4Iyq4uerE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 148/148] libnvdimm: prevent nvdimm from requesting key when security is disabled
Date:   Thu, 10 Oct 2019 10:36:49 +0200
Message-Id: <20191010083621.227581588@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit 674f31a352da5e9f621f757b9a89262f486533a0 ]

Current implementation attempts to request keys from the keyring even when
security is not enabled. Change behavior so when security is disabled it
will skip key request.

Error messages seen when no keys are installed and libnvdimm is loaded:

    request-key[4598]: Cannot find command to construct key 661489677
    request-key[4606]: Cannot find command to construct key 34713726

Cc: stable@vger.kernel.org
Fixes: 4c6926a23b76 ("acpi/nfit, libnvdimm: Add unlock of nvdimm support for Intel DIMMs")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/156934642272.30222.5230162488753445916.stgit@djiang5-desk3.ch.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/security.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index a570f2263a424..5b7ea93edb935 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -177,6 +177,10 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
 			|| nvdimm->sec.state < 0)
 		return -EIO;
 
+	/* No need to go further if security is disabled */
+	if (nvdimm->sec.state == NVDIMM_SECURITY_DISABLED)
+		return 0;
+
 	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
 		dev_dbg(dev, "Security operation in progress.\n");
 		return -EBUSY;
-- 
2.20.1



