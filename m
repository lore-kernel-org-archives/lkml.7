Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD24C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1317214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="QIGxcr0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfCLEjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 00:39:51 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:41396 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfCLEju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 00:39:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id D5EDB9DD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:39:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id seC6SzdMbgY4 for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 23:39:48 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id AB2709CC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 23:39:48 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id p143so899336iod.19
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 21:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CjRuBsTPxOSNjGTsK1VobIY7FzAvfFeIc8QwTDAuL4Q=;
        b=QIGxcr0uW/vlEvdgJ1yLDQPxwUPZgHh0gbyEiyB0Ly5SHEjTd2qMz8pxpGGLplLEVT
         /mKMlRKR4uJ++vNyG4gIh1qiYrKDR5ZYcHXEDJnF9TGcKQXkHCdWu5nnPBr1cyQLZMax
         M8BgyQlml5HxoysxHuTltkakRkWA4AUW554ExjJoFjZsclxzMYC/IrwUC6Y0vkwzc7bA
         ub7lsFROfcngGejz628Q15PZ7Ul8vvDHtWh6R0I99BSw1htrM8ePoH4DjOdaavTtwPBg
         mclQ0A8FkClzbFZ8+njfbXPkOownZLjS4SUQ5gD5o5JwHS+PbNyJTHQHGOqvG6OogNcw
         SrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CjRuBsTPxOSNjGTsK1VobIY7FzAvfFeIc8QwTDAuL4Q=;
        b=GY51cGRB3rjGWax+R0owpdhBGDioNDOGZ/xi9GoIrjJ8HqNJs5onDZ4D6JbZG7LBoQ
         3jYv/lgPPZaiDRvE0c8rDiwF68JwzdhGjEXSO+fnewEjZd0nzYtPIKfmMuedIJEBIrBI
         RZR+a7+DiEFAtvjK2a8TYpYIqHzfG7t/HkLscClkxZ8Ah/tK+lPUKTkgGrS0+iQEYHON
         i32p3KwYY2yWvxN8j8ierkhAyTF6PKBFUE+kCnXJK2tKLt0xXF53JpJFmZuuk/0PTENF
         c3/fYdG7Ufs9svn94Hk07HUhfZmXsX7eFv+1rcAN+5Qp2qV84l/EyKbfkB2uoS+Xm12b
         iQDg==
X-Gm-Message-State: APjAAAWbk/EO9/S18RZkUNzzJ7QWNh+QWIm+mSq+PWNtRtcw6N6HuBVF
        T6v5bsmQ8t2QGN84ZPtVtlsOokfIugpRT3wp/ysDD/XGI9X+kTXBQhiEO/asv/M2dTOOWzCv035
        YisFWGAbTxH4VQaOLGsrtDJgyk6CA
X-Received: by 2002:a24:2847:: with SMTP id h68mr895143ith.82.1552365588261;
        Mon, 11 Mar 2019 21:39:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqykaFubQmtG1am3j9NH2GUFQBME4vgBHar8hqOKQ98fhQ2Lv4IGc1wVOxBKYgIPhPW13s+Cow==
X-Received: by 2002:a24:2847:: with SMTP id h68mr895130ith.82.1552365587953;
        Mon, 11 Mar 2019 21:39:47 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id v141sm269580ita.18.2019.03.11.21.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 21:39:46 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: brcm80211: fix missing checks for kmemdup
Date:   Mon, 11 Mar 2019 23:39:27 -0500
Message-Id: <20190312043929.727-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case kmemdup fails, the fix sets conn_info->req_ie_len to zero
to avoid buffer overflows.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index e92f6351bd22..5d9a3c35fef5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5464,6 +5464,8 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 		conn_info->req_ie =
 		    kmemdup(cfg->extra_buf, conn_info->req_ie_len,
 			    GFP_KERNEL);
+		if (!conn_info->req_ie)
+			conn_info->req_ie_len = 0;
 	} else {
 		conn_info->req_ie_len = 0;
 		conn_info->req_ie = NULL;
@@ -5480,6 +5482,8 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 		conn_info->resp_ie =
 		    kmemdup(cfg->extra_buf, conn_info->resp_ie_len,
 			    GFP_KERNEL);
+		if (!conn_info->resp_ie)
+			conn_info->req_ie_len = 0;
 	} else {
 		conn_info->resp_ie_len = 0;
 		conn_info->resp_ie = NULL;
-- 
2.17.1

