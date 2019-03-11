Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B27C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3935A2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Pf6rZ2+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfCKHcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:32:41 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:56274 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfCKHck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:32:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 0FBF7965
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:32:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pz8d2AMwrX7p for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 02:32:38 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id D2A7A976
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:32:38 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id 68so3500819iov.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CM+4RBks3zB8YoMv1kToRz9kjid3SKHwPTdosXxlMMQ=;
        b=Pf6rZ2+wVJl1u83ZrPv8+Y3fPITKkQJu83onS0XZJvTGeVhuummygSfhZYoXaVYga8
         eDFM1LC+ARoVcaCwnaXP6ZCqcDGM27Aw/jRMRbOvxnI3XwF0ECQCmji5uBME5nPFeJmS
         ezr77Y8xpH9cbWKkoX9D5XogZCQ0viG8cjZfUrZTMATBMKKSASbU7MtJ+j/2zJlHBze4
         uaJ1ouvMnCSnlL0oNZUPkKzOI2RNrIgl2ZjK/YhqNcO6h9eOCoeIDcLag8aO8vz+bXtE
         veQF04ExJGlT3z2rnUM9iO5TQHwGFxeFVHY2zUG4xo7piF/lU41bcce9yRqIp2WHAGrR
         iC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CM+4RBks3zB8YoMv1kToRz9kjid3SKHwPTdosXxlMMQ=;
        b=OLzr11YWJfRJfOtji4GxjAeZgm4uLqMEJHp/UyNoM93PWTyyqwhZaCFqjgsvrXsi1p
         7IXUYZe3b46x+hV4oqJfCJIEHYw8JP7fIa7zl/TOi2OhvAq8Mj5E3XVjGmHx2asREi1m
         th+umQa6cytGU8BkBiSUndP1wD3ZLDrO9DF4UfIierCAOx5gMzKnMRCZm6Aah13X6aXl
         MNiDCH8LBSkepNG1KXkojAU/YfOVfKdLZ34lzRMajHR3AN1FYeQp7of1T6bUxZdUW3b8
         ZxpqU+ql/GxbWCAAIssvsLyvYuP49/5mv6DrKgsdfeVlMrrGGsKK9PPBoW0Z3M368iMf
         4UjQ==
X-Gm-Message-State: APjAAAWuODz1wgpkQ18oKgJYpyfjvKxK55TYKP/y8/oCb9Bzm89bwlHB
        I1dlSrq5rAoJaTQM6raQTr/8yw3FcXThPg4hHWL+gi4asmHJfKCHf8/O0nk6XmvIPeHmxCooivt
        rGOEBoLGoU4HXWM6c3wrLbviUZsgY
X-Received: by 2002:a5d:848b:: with SMTP id t11mr14549777iom.270.1552289558379;
        Mon, 11 Mar 2019 00:32:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy2IlAuIJDZJ4VVzbYlX0bdyI2uAAPSg7dw5V/E9C3/RZPFfmhxbtJNnhBtgejDrY2IdxUfbw==
X-Received: by 2002:a5d:848b:: with SMTP id t11mr14549767iom.270.1552289558135;
        Mon, 11 Mar 2019 00:32:38 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id q2sm359638ioh.4.2019.03.11.00.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 00:32:37 -0700 (PDT)
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
Subject: [PATCH] net: brcm80211: fix potential NULL pointer dereferences
Date:   Mon, 11 Mar 2019 02:32:30 -0500
Message-Id: <20190311073232.30807-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case kmemdup fails, the fix returns -ENOMEM to avoid NULL
pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index e92f6351bd22..d903a45e7b68 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5464,6 +5464,9 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 		conn_info->req_ie =
 		    kmemdup(cfg->extra_buf, conn_info->req_ie_len,
 			    GFP_KERNEL);
+		if (!conn_info->req_ie)
+			return -ENOMEM;
+
 	} else {
 		conn_info->req_ie_len = 0;
 		conn_info->req_ie = NULL;
@@ -5480,6 +5483,8 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 		conn_info->resp_ie =
 		    kmemdup(cfg->extra_buf, conn_info->resp_ie_len,
 			    GFP_KERNEL);
+		if (!conn_info->resp_ie)
+			return -ENOMEM;
 	} else {
 		conn_info->resp_ie_len = 0;
 		conn_info->resp_ie = NULL;
-- 
2.17.1

