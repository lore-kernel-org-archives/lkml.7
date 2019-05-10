Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D371C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4181E217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XeAFnHRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfEJSN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:13:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41591 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfEJSN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:13:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id f12so1167543plt.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+cojE6T8V5ImSjp0mytrz09qkONdmVExdwfw6/pUjGc=;
        b=XeAFnHRBBr343EevnSOiaR1bEMCHTqALQpIAEPJNwf909qly8FahmCyfUZeUX1OWnI
         1GPrjTDzR1qCUCaSCA7dBSmBED6uVd52YvYcxiu1gnBVQr3MnW39/sLtGqrQPQft8wKI
         mvGujMeNftojXQjMhWAz0MH/R+mi4kT2vXYC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+cojE6T8V5ImSjp0mytrz09qkONdmVExdwfw6/pUjGc=;
        b=qgX1Xs6jqN+sEUI20DCQ4SVfiIW8CH2qGiREZMuBnq0T6pyPkjljNOsPasV2Z32EMy
         9wdtf+xaoh5JmyXjdHszu349lXu2GG8Q8Yxnug3maIR2YHWls715VcR6af9UiTTQkhLY
         KvkJKoxDjMTK+K6vy3IxqtQCTXXbQ1szq6p/0dQO3tZRf0dQWvbVbKXdw1pAYvB6i+Ql
         byOXOIlV53FQPYKoZNI15SYVTeRfKMs60qzSTm5YRZhiPAI3a1Br0ylj/e33YE78D8oK
         ZnlnT2IejCx39vhQsogNHDXlhp6BdLae8dScds9O6y0jOxGC/Hew0dFy62sz60sBEbkb
         /Fzg==
X-Gm-Message-State: APjAAAXofFxFnfMOBgnn4cB1B8S2LHEE4E/MR2+F2nlbKl3UUaY0S6QI
        VFM4xRDlUxq/AVlvKmZ2JEAvuA==
X-Google-Smtp-Source: APXvYqy1va4lBAS5EQUovZMTSaUTDacYI7cW8OQovdmDm+fuRXV2/h038u0QUOGHRT91YxzwxGcG7g==
X-Received: by 2002:a17:902:868b:: with SMTP id g11mr15001069plo.273.1557512008726;
        Fri, 10 May 2019 11:13:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g71sm17169365pgc.41.2019.05.10.11.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 11:13:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH] soc: qcom: cmd-db: Mark more things const
Date:   Fri, 10 May 2019 11:13:27 -0700
Message-Id: <20190510181327.121666-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing that cmd db returns is ever non-const, so mark cmd_db_header and
rsc_offset const so that we don't try to modify the database
inadvertently.

Cc: Mahesh Sivasubramanian <msivasub@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/cmd-db.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index c701b3b010f1..7d67cbb52b97 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -99,7 +99,7 @@ static bool cmd_db_magic_matches(const struct cmd_db_header *header)
 	return memcmp(magic, CMD_DB_MAGIC, ARRAY_SIZE(CMD_DB_MAGIC)) == 0;
 }
 
-static struct cmd_db_header *cmd_db_header;
+static const struct cmd_db_header *cmd_db_header;
 
 static inline const void *rsc_to_entry_header(const struct rsc_hdr *hdr)
 {
@@ -108,7 +108,7 @@ static inline const void *rsc_to_entry_header(const struct rsc_hdr *hdr)
 	return cmd_db_header->data + offset;
 }
 
-static inline void *
+static inline const void *
 rsc_offset(const struct rsc_hdr *hdr, const struct entry_header *ent)
 {
 	u16 offset = le16_to_cpu(hdr->data_offset);

base-commit: e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd
-- 
Sent by a computer through tubes

