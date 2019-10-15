Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07689ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1365205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9mfq/KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbfJOPp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:45:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43469 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfJOPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:45:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id r9so18479150edl.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VmiRcRHmz8DDVB2cq0v7r6/X0JPNcG46yUc4K+zEiys=;
        b=E9mfq/KOFVE0GO0x3b0UZZ1JezhxnKyhaIzvNd3sSr4Gbk3H+JJLK7YLD46aGZCwHk
         0yXSRBXCRg0JFm3f65XtnG4n5KBuRuhOlhhVEh39Moad4HjLxOnqYsbuq3ZDpHQGu2Sq
         /K3OsUMx7veVmqT7mP1Haa8gTLk77WVE4S+y/eB562wtPDMb2FTEBzTkpfhq3jygXnKX
         n+vXIu5J8sxv0BmrxfG24w2TArWPh2dnvx8xY3IEeWZV+M6+nScSsxK0zMOCP/eXmnjq
         kgEzw5GxhefB6Vv1bi0BiUBNKEwhYXhAVNe5Phz/7vIGRZOxPzf6vn7zElYHHmqNqsiI
         koJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VmiRcRHmz8DDVB2cq0v7r6/X0JPNcG46yUc4K+zEiys=;
        b=YzQPdzJfYa2NR3IsAqkCB2rhfLf5fltIDoASrJ+JX2PSHNjQv61E5kZkD5zHfEMukl
         rdYPO+41famFRQwoZALpWgrS6xhLaF0mHp8S+jGRc4h6iA97UZm49AkyOttcAKYAjITA
         h9rcNjgNg+QC8KpCzU6Y2TTulPpSY6gej6qEmoehm+1/NOXLT06zzkbTsXB6K9HWBEPE
         xxF7baNEG+FC3VQAuwJ+9PDoPRCVyjFi8o+8YE0WP5wy4rrnjGCrwgUqSBfIL8FEXzCJ
         oK57cx5GH9Xit+cXM24sIVVqeevN/Ka3dy6/t4Ysri+ZK4iPgJZrW2P9qhIW/8/oW2CE
         iAog==
X-Gm-Message-State: APjAAAWrRICkr898EZgjRS4H9q1WAQm9xD43D2ReV8wv6rccTPMowQWg
        GpF9kwc4n3HlS9VV5ZnEV5VuvWKv
X-Google-Smtp-Source: APXvYqwJje6PpKAjIIPrG8T3cNgpwAEubyG9qZshvloANoppnP9GolA5+D50+LSdpYInZJ3Le6bePg==
X-Received: by 2002:a17:906:8391:: with SMTP id p17mr33623378ejx.216.1571154350730;
        Tue, 15 Oct 2019 08:45:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id nq1sm2807787ejb.75.2019.10.15.08.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:45:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8188eu: remove blank lines
Date:   Tue, 15 Oct 2019 17:45:35 +0200
Message-Id: <20191015154535.27979-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015154535.27979-1-straube.linux@gmail.com>
References: <20191015154535.27979-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove blank lines to reduce whitespace and improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 1e261ff8f0a0..af8a79ce8736 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -749,11 +749,9 @@ void HTOnAssocRsp(struct adapter *padapter)
 	 * AMPDU_para [4:2]:Min MPDU Start Spacing
 	 */
 	max_ampdu_len = pmlmeinfo->HT_caps.ampdu_params_info & 0x03;
-
 	min_mpdu_spacing = (pmlmeinfo->HT_caps.ampdu_params_info & 0x1c) >> 2;
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, &min_mpdu_spacing);
-
 	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, &max_ampdu_len);
 }
 
-- 
2.23.0

