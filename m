Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDB1C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943B8207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420534;
	bh=GTMVDaXzuzU2Vu00XLlOwXvvEsFSRCcG11kDpNM1lzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DPQ+dY+O9jcn8XAxHnqubIitbNVhyFS9WykCdo1lpp9xkqhNl7hotzdImZC6TxePd
	 ZH+UG1wfB+A5a/tnHM5vtHweVCo9srchxkJlsZTFWkw7q19ylqQ9Teh+WE5K+HyKM8
	 UKo+plxe9NswDzB6uaQUIDYPhplYYgLbzepAGEEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfKVLCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:02:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731241AbfKVLCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:02:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 245032075B;
        Fri, 22 Nov 2019 11:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420522;
        bh=GTMVDaXzuzU2Vu00XLlOwXvvEsFSRCcG11kDpNM1lzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcsgfTUgtCiBfmAOtsrhR8N5XHfap5gBMTiFgf+kpWLXIwqpDSqrAIeBqPDazeLKU
         5Wuq1DMWgBHjMZfAdH4d6ZtKE3RnOug/pbbGCGTOpNAqvLqPnG6X75cvkKkBnH0aGL
         1wxWFCWWBbZhrT00CfoB/Kql+Pv8KGAxJelt86PY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 136/220] remoteproc: Check for NULL firmwares in sysfs interface
Date:   Fri, 22 Nov 2019 11:28:21 +0100
Message-Id: <20191122100922.594417540@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

[ Upstream commit faeadbb64094757150a8c2a3175ca418dbdd472c ]

The remoteproc framework provides a sysfs file 'firmware'
for modifying the firmware image name from userspace. Add
an additional check to ensure NULL firmwares are errored
out right away, rather than getting a delayed error while
requesting a firmware during the start of a remoteproc
later on.

Tested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/remoteproc_sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 47be411400e56..3a4c3d7cafca3 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -48,6 +48,11 @@ static ssize_t firmware_store(struct device *dev,
 	}
 
 	len = strcspn(buf, "\n");
+	if (!len) {
+		dev_err(dev, "can't provide a NULL firmware\n");
+		err = -EINVAL;
+		goto out;
+	}
 
 	p = kstrndup(buf, len, GFP_KERNEL);
 	if (!p) {
-- 
2.20.1



