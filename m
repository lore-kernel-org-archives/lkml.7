Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A415C04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C876E2087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S1pCUHGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfEQVJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:09:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40372 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfEQVJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:09:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id g69so3873486plb.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6yMhbjOdJrtk0xQ+i6AZwRL1Zy3R9rye9qItwhZgYoY=;
        b=S1pCUHGutY6vLzoeCG8u5Yqz3ySgTf/kdPKzMam30sIRpcZRxsjF+zlAGx/fIrTFIp
         c1UKcK4gDiWA9vZQFvW6iGNpJB4zv13dQ3EW4iO5pTUV0W8VgSG3ubSdD6/d6/DzUQ31
         EpISSdtYpdScNDbFpu1KySJGBw2Fj5UhNbs1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6yMhbjOdJrtk0xQ+i6AZwRL1Zy3R9rye9qItwhZgYoY=;
        b=pt+e9CQjVjEFwUe9ueKNSn0a70uIMbDacGVTHsUhmSQ7JuTsu7jLq/rHu+FgNWT6QY
         h/ubHHpBSWlEAKeaXcrOSD3Tq7yuq0K63ALxKNsCDj+wfssQGepiZIT5L3ZwPl69p7bW
         0IzX1jNISeVnnnRMer0jIwPmllo+ahHWgMiDLwLjv/MxHp0F8EzXJ/Te6XxT2beoQizo
         CJTnossfBHIaX87LdnsLmPEqPOFOZDjAcibgKnkWAHh5LnNSTLdOSQeEF5oVJh10BgFL
         alwPcR8RiVBPLFGyw2pHagexQZYKbps4g4d29p9t1qhvNcH5duDFKRqdMNZQ0ldczaY9
         IzOA==
X-Gm-Message-State: APjAAAUwHASo24A+DK6A5U7MAFs2gr0SeDa8sdnzQyUrGMTo8zwuqLaj
        J5+zM0pqJsMFyz84M6avr6gvjw==
X-Google-Smtp-Source: APXvYqxwpbLICdYAwGQqNce4bs0ykKfJr2vw7HkbP2gvufSFs/2dDJFK4zwTSIAgWKa7ah5VPW4rIg==
X-Received: by 2002:a17:902:201:: with SMTP id 1mr14372173plc.263.1558127367509;
        Fri, 17 May 2019 14:09:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q142sm7890448pfc.27.2019.05.17.14.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:09:27 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Ian Jackson <ian.jackson@citrix.com>,
        Julien Grall <julien.grall@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>
Subject: [PATCH 3/3] firmware: qcom_scm: Fix some typos in docs and printks
Date:   Fri, 17 May 2019 14:09:23 -0700
Message-Id: <20190517210923.202131-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <23774.56553.445601.436491@mariner.uk.xensource.com>
References: <23774.56553.445601.436491@mariner.uk.xensource.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some words are misspelled and we put a full stop after a return value
integer. Fix these things up so it doesn't look so odd.

Cc: Ian Jackson <ian.jackson@citrix.com>
Cc: Julien Grall <julien.grall@arm.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/qcom_scm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 153f13f72bac..e300cc272847 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -435,11 +435,11 @@ EXPORT_SYMBOL(qcom_scm_set_remote_state);
  * @mem_sz:   size of the region.
  * @srcvm:    vmid for current set of owners, each set bit in
  *            flag indicate a unique owner
- * @newvm:    array having new owners and corrsponding permission
+ * @newvm:    array having new owners and corresponding permission
  *            flags
  * @dest_cnt: number of owners in next set.
  *
- * Return negative errno on failure, 0 on success, with @srcvm updated.
+ * Return negative errno on failure or 0 on success with @srcvm updated.
  */
 int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 			unsigned int *srcvm,
@@ -502,7 +502,7 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 	dma_free_coherent(__scm->dev, ptr_sz, ptr, ptr_dma);
 	if (ret) {
 		dev_err(__scm->dev,
-			"Assign memory protection call failed %d.\n", ret);
+			"Assign memory protection call failed %d\n", ret);
 		return -EINVAL;
 	}
 
-- 
Sent by a computer through tubes

