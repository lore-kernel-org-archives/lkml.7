Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EC6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FCA2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBR54Z9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfD2QBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:01:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35311 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfD2QBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:01:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so5289629plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rPf+Jg9gkUTB3UU7vbrJ21JITxZ048x6tuDHzRVFfOM=;
        b=IBR54Z9leOSJOoz0krDwbSwvuKCEsLcMS1x+CJIriQ/b+KZcKHLbDTSd6mXnP8BmDK
         8IyMS+KsjdDurLlCaV5yzpzFMprUn2tSgjZRr3Re3TeEiKJcgzeNVZ7dsMH38LnD1YDx
         x8yhr7ZPYa4Gxv2PR4w42VlN8ylCY0ExzCrRYK+gINKwXYkgYnlCK9fiwsGE1pXhXBh9
         WjlvGEhOrnZ7Heu0x5VkBbTcv99egOXqwxucL4wyACyMSrZ2Bp/ZkBiPtZYKdVQXfEVr
         4EYhtppU/D8reOG9JrzzUp8alISqqKB/8EXQShpnO5n0pALSpQQlca1J5MQW0nbcrPt3
         VPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rPf+Jg9gkUTB3UU7vbrJ21JITxZ048x6tuDHzRVFfOM=;
        b=Q5f01jwNLgRGxRUc4pcgmVVljqYnLjRH0jV1Evuo8tDMbpEtYvSoxRs3Q4aX/1zfiR
         FbCpGrhVmY9tffqmAKEiLfVc4flCeqrzjEv4Z0UtkkvvFTzjYMhNDi1bsMPH2ZHHFB12
         RK9VwkMn8Wt8ET24f7L5JfGgrK0CQsL6FA7A1KB1ojoIksx9W6HZpa6fYVzcsEoUiWBx
         2/KhJN7OttIEpZur17e2XnIOeGAuH3zWSPJHl7Bw9YNuBE/CZIdvaXdbZDOqzMA/mSQ2
         dLV5MCpn2QUn90A7YxLVShttvjzavTV4MwfvZk1VgkVS+iEOJBpIjE8gLHrQwsEllZja
         3iwQ==
X-Gm-Message-State: APjAAAW2rQVqAzPLJhuq2Dhcbth+wxxJtPhmwzRwdaoN7/luClwwolJJ
        Bajh8KQr4at/jvrKeJurOho=
X-Google-Smtp-Source: APXvYqwZ+NE3AuT1tjwRUxhJET5X/ePxcDnTFesOqzdpklno+d+pvi8HaUHfAGZHALy4yPR+GM4rFQ==
X-Received: by 2002:a17:902:8f88:: with SMTP id z8mr56305861plo.54.1556553683204;
        Mon, 29 Apr 2019 09:01:23 -0700 (PDT)
Received: from localhost.localdomain ([49.206.11.135])
        by smtp.gmail.com with ESMTPSA id j20sm48034979pfn.84.2019.04.29.09.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 09:01:22 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        quytelda@tamalin.org, colin.king@canonical.com,
        hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v4] staging: rtl8723bs: Fix checkpatch.pl warnings
Date:   Mon, 29 Apr 2019 21:30:45 +0530
Message-Id: <20190429160045.13110-1-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426131249.16198-1-bnvandana@gmail.com>
References: <20190426131249.16198-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves coding style brace warning and constant on right warning.
WARNING: Comparisons should place the constant on the right side of the test
WARNING: braces {} are not necessary for single statement blocks
CHECK: Comparison to NULL could be written "!pbuf"

Signed-off-by: Vandana BN <bnvandana@gmail.com>
------
 v2- Edited commit message and subject
 v3- Edited commit message
 v4- changed NULL check to use !pbuf
------
---
 drivers/staging/rtl8723bs/core/rtw_debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 0de1e12a676e..9f8446ccf771 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -1425,9 +1425,8 @@ int proc_get_btcoex_info(struct seq_file *m, void *v)
 	padapter = (struct adapter *)rtw_netdev_priv(dev);
 
 	pbuf = rtw_zmalloc(bufsize);
-	if (NULL == pbuf) {
+	if (!pbuf)
 		return -ENOMEM;
-	}
 
 	rtw_btcoex_DisplayBtCoexInfo(padapter, pbuf, bufsize);
 
-- 
2.17.1

