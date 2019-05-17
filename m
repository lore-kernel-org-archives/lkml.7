Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CC0C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90482166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PYP/b3+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfEQQsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:48:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35962 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfEQQr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:47:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so3610399plr.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O42F5A4GX0eA84yy8Ef+AkKPQRwJmwFWVhtyExm+PVY=;
        b=PYP/b3+x4BUW2tXl5EeWPVhQ2Ydr9f0XlD8JFJZdeKuWGUm9x2gBEwCIanOv3mBLby
         T3lJRIqhz+aMnbrOABRtKWxma2+WZvjeN4x+PFt3loQXcwqG8h15GMZTzENSWae+cGEi
         HfbFUHK/8IaOWGApHdEcikH6nKx9xsnyyafPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O42F5A4GX0eA84yy8Ef+AkKPQRwJmwFWVhtyExm+PVY=;
        b=QSk/vzvOiJ8XCOTsTMnZeXNKAoNLMRIsN1ObXNRjInYLhYbWyVnnQh/PI3rCXEA2QS
         w2Rz+ZoQbCr4nruy51CDbpqFcRDbBYyrF16wxM8VyLsJfOKY9iXm5PoNi7UGpNU7jm64
         BiwwjW0JAMGPQZ6HMDv64EpXjeBs5ioPNyQw53z6NqgpwXaHQXXyAMy8gdobq3oOUjdK
         qwDhnqnKR8msxEsDD3+zblN3Z302PbEmpPmNVcKULjqXHmbf+i6mFxGOvTUOPqAHAXWH
         4q4qP9KL4cHW2l6OpJFSPlrHe4NE8OXcooxWnhTF+pMdfO5HRrGeKjcdXQ1mnkUv895+
         jc5g==
X-Gm-Message-State: APjAAAUxBOiEusbGEw1kelVhwZb/CSxe2arw8uSFWniUlLlko9AffkCW
        cULJ2a8k/hgACrGP5bc1T/1if2YDU4aQQw==
X-Google-Smtp-Source: APXvYqz5grEEF0O5CgARwN/Kl3T5APmZtPmXKSBTqLDuepRs1NbjLFpphhsqHJa3rK39CAOOKrQTJA==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr57741397plp.118.1558111675502;
        Fri, 17 May 2019 09:47:55 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l141sm12229810pfd.24.2019.05.17.09.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 09:47:55 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC/PATCH 5/5] soc: qcom: cmd-db: Map with read-only mappings
Date:   Fri, 17 May 2019 09:47:46 -0700
Message-Id: <20190517164746.110786-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190517164746.110786-1-swboyd@chromium.org>
References: <20190517164746.110786-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command DB is read-only already to the kernel because everything is
const marked once we map it. Let's go one step further and try to map
the memory as read-only in the page tables. This should make it harder
for random code to corrupt the database and change the contents.

Cc: Evan Green <evgreen@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/cmd-db.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 10a34d26b753..6365e8260282 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -240,7 +240,8 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 
-	cmd_db_header = devm_memremap_reserved_mem(&pdev->dev, MEMREMAP_WB);
+	cmd_db_header = devm_memremap_reserved_mem(&pdev->dev,
+						   MEMREMAP_RO | MEMREMAP_WB);
 	if (IS_ERR(cmd_db_header)) {
 		ret = PTR_ERR(cmd_db_header);
 		cmd_db_header = NULL;
-- 
Sent by a computer through tubes

