Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE743ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C569921848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbfJPU50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:57:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbfJPU50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:57:26 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F2AD90C99
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 20:57:25 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id g62so24986525qkb.20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBQ7gpZ68XC9yJUIRmvhGT9ykcxZ7LBo1PQ5kgI2O8M=;
        b=S4De6Oa5OgFUzmnq30HT3mmfdV05lkM6/XqkRL+zZlk1uODmw1UoRDzNKWamUgJ7KP
         IqQSvIbZ6SQGNcq9QVpZmAifN2LuOZsCHx6migsECtGsjUDvu9mWbgf/G9GT0IyF43gh
         1wZx5KYwSaYqmnoJnYWbnGDduiMKLQfE2ukNCXPNANFD7l/NPndp7OtdaY7vmhCa0On7
         YwPzeRWkpeN4E7yiFDrpiVLef/eyG/OAWjHysBufBAL7Z47eztMyj8GhR1zXOUBDfLb/
         w+9MWIEVCQ/8OUnEP6nv+EIwmnrmPrAjecsayb4c9qzaOrh7JY8EG9ZfBiK+QYYeFZtR
         jOUA==
X-Gm-Message-State: APjAAAW8a/4uaHXlpuZgmRURJkLT1ZOX1gd2WK6uV0/VeBPyYq/upcRr
        7xbnOaE2B04FQNeGo68bScMJhhlYMRIWrPuonbEfeIiscczjBKPEoYJq7O6K15bgxRQ4pRrgU69
        89KDc5+z/RL17olMewPOdPd52
X-Received: by 2002:a0c:eda9:: with SMTP id h9mr30849qvr.125.1571259444743;
        Wed, 16 Oct 2019 13:57:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtZQ1p9uv2sCQ5sckBZmJmAmvdBRNeFuMdkuR0mLRWv2XsHKm8h8LAyLgrLZlCxrCo9UBhpQ==
X-Received: by 2002:a0c:eda9:: with SMTP id h9mr30831qvr.125.1571259444351;
        Wed, 16 Oct 2019 13:57:24 -0700 (PDT)
Received: from labbott-redhat.redhat.com (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id 16sm26966qkj.59.2019.10.16.13.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:57:23 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolas Waisman <nico@semmle.com>
Subject: [PATCH] rtlwifi: Fix potential overflow on P2P code
Date:   Wed, 16 Oct 2019 16:57:16 -0400
Message-Id: <20191016205716.2843-1-labbott@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Waisman noticed that even though noa_len is checked for
a compatible length it's still possible to overrun the buffers
of p2pinfo since there's no check on the upper bound of noa_num.
Bounds check noa_num against P2P_MAX_NOA_NUM.

Reported-by: Nicolas Waisman <nico@semmle.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
Compile tested only as this was reported to the security list.
---
 drivers/net/wireless/realtek/rtlwifi/ps.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/ps.c b/drivers/net/wireless/realtek/rtlwifi/ps.c
index 70f04c2f5b17..c5cff598383d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/ps.c
+++ b/drivers/net/wireless/realtek/rtlwifi/ps.c
@@ -754,6 +754,13 @@ static void rtl_p2p_noa_ie(struct ieee80211_hw *hw, void *data,
 				return;
 			} else {
 				noa_num = (noa_len - 2) / 13;
+				if (noa_num > P2P_MAX_NOA_NUM) {
+					RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+						 "P2P notice of absence: invalid noa_num.%d\n",
+						 noa_num);
+					return;
+				}
+
 			}
 			noa_index = ie[3];
 			if (rtlpriv->psc.p2p_ps_info.p2p_ps_mode ==
@@ -848,6 +855,13 @@ static void rtl_p2p_action_ie(struct ieee80211_hw *hw, void *data,
 				return;
 			} else {
 				noa_num = (noa_len - 2) / 13;
+				if (noa_num > P2P_MAX_NOA_NUM) {
+					RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
+						 "P2P notice of absence: invalid noa_len.%d\n",
+						 noa_len);
+					return;
+
+				}
 			}
 			noa_index = ie[3];
 			if (rtlpriv->psc.p2p_ps_info.p2p_ps_mode ==
-- 
2.21.0

