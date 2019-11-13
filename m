Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6EAC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C0B206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wi3O4TLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfKMU0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:26:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35574 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfKMU0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:26:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id q13so2416375pff.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 12:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+jBZPXGfzcnRw7QYo9gRDJnZjTKzZ/V8mqM60vhhaw=;
        b=wi3O4TLRwAqZuc7rG1hKf1wffoYiplV9EKCXwbESnVGxc8rWUypX7Jv/gCExV56QvW
         0QhlD9bXNDkCV+wjAjAdF8lBbRM+LYHGH8vKSb11Ufa7eRlZg1kqhtWeHEaVEjJHQH6I
         X7KBoDDQ73vGJIXZJTiImFias1/fOinLl7ftdC9qqfTlmiPjBaf+TB68+FPaMwEAsLm7
         uUQu6x6q2bZsomjlGMqdoKtattnlblREftbgb1Jm/TSz9Xz/GzGm3ei1ZZ2pZVK8ddVc
         FJcmbeOPypuuvLrLTFCOEN1ZMIZHsaicd4CHTy+Zb2Jnwyzkyq6mLORbZCPBJToMWxAo
         ppqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+jBZPXGfzcnRw7QYo9gRDJnZjTKzZ/V8mqM60vhhaw=;
        b=AKOuYNl+KOKDv+keXUplvNo1QYAcotTP3bW6Hz6+Wub1k/gCkDhTEeG77sLkBPbeME
         hFg2jrEf1zRrtEgZBh7DtWSlxAo49zoTBBMBI4fagNuHgeWxl21kqi4dY3zvrmstmqWa
         NSS96t+lLn7zuSbOAVtWwec4dMtA3dBrwVEqdDF+wwCZ7qjx2BdeU0DaImnr9kHJuuvL
         X5VAKg3Da7fX98uP5zAwZBFNdDNcJVBHqKsZa+6z3TQuM4yjX+7ecE8FSZJeKAVZwNqu
         MRPlVVbtsG33Na1k5PGKSgI8xiQFZPxlfNoK3Tq34kLyqtnJt5lHxKm6qWkZK4M0hA/Z
         XLVg==
X-Gm-Message-State: APjAAAVS+O1W2pr/6St5mWZbM6akFLR6O7UxlW68BPgDeFYtLxTgF/Kt
        7zcbuhyJryqcsk1lX5a1zfqh+g==
X-Google-Smtp-Source: APXvYqws5sHFjkVpWCAoo2wwOeNcsN0HZ1YtKA/fi79+wXnJUg21ygBsmcG+kSht7hkEW7DWgMr0OA==
X-Received: by 2002:a63:364d:: with SMTP id d74mr5862446pga.408.1573676809438;
        Wed, 13 Nov 2019 12:26:49 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a145sm3991905pfa.7.2019.11.13.12.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 12:26:48 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jeffrey.l.hugo@gmail.com,
        wenwen@cs.uga.edu
Subject: [PATCH] ath10k: Revert "ath10k: add cleanup in ath10k_sta_state()"
Date:   Wed, 13 Nov 2019 12:26:44 -0800
Message-Id: <20191113202644.3673049-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'334f5b61a6f2 ("ath10k: add cleanup in ath10k_sta_state()")' causes
ath10k_snoc on Qualcomm MSM8998, SDM845 and QCS404 platforms to trigger
an assert in the firmware:

err_qdi.c:456:EF:wlan_process:1:cmnos_thread.c:3900:Asserted in wlan_vdev.c:_wlan_vdev_up:3219

Revert the offending commit for now.

This reverts commit 334f5b61a6f29834e881923b98d1e27e5ce9620d.
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index e8bdb2ba9b18..68f7d7246ef2 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6638,12 +6638,8 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 
 		spin_unlock_bh(&ar->data_lock);
 
-		if (!sta->tdls) {
-			ath10k_peer_delete(ar, arvif->vdev_id, sta->addr);
-			ath10k_mac_dec_num_stations(arvif, sta);
-			kfree(arsta->tx_stats);
+		if (!sta->tdls)
 			goto exit;
-		}
 
 		ret = ath10k_wmi_update_fw_tdls_state(ar, arvif->vdev_id,
 						      WMI_TDLS_ENABLE_ACTIVE);
-- 
2.23.0

