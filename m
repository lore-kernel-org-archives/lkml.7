Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B84BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336A22067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMNG8OFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfJJQ06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 12:26:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34690 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJQ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:26:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id k7so3050341pll.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/3L9d8Hq5e07DU4XHZuzPz1Kd0iVbIQrEZ53Rw3PFwc=;
        b=oMNG8OFlEGU3PWXGkW4uWbQiN1c4TgfEUV4U5ZaRnieGiVh9zJFF289MPunGMy0uQa
         seUQM8U2tTTWjYTuqnWM1hjDfz4EQSu6HMMR+BLW3eWSh4BlEZczW9TkQZKEJ/hk3f8b
         1JFjuInD9NbbsOx1TTAGItzyuIrtHBAw+AvyLljpiKbRSLyrTzWMOLnm4O599EaVohmY
         qyXHpkXA478RmdObxZO9bhYjjODG2+x1geIWOUjM1C4N9VKcwAJdm2FwBoPqZPyewoBt
         HCAcvkfg29toUTW1/GIlRSFNFLn9cq68xGT5V8C627JjNT5+CYI49sBWZkhztGviM0xZ
         RQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/3L9d8Hq5e07DU4XHZuzPz1Kd0iVbIQrEZ53Rw3PFwc=;
        b=t1khttK10YNE0inJEydnmyPhxDXCEU52qm2MlRMxehIkiaosm940qjKNnjLJstcgIo
         rCbawb5WZ1KnM0vVTY0TyXmE6dRi1z5kU0Vti1Lx5pJLqTpSFdVHP9qYRPimjt4fm89N
         eApPo+PCuzoNIk7q5jkWK+3DBWo3AaKHd39BwfFzAeXKzkDB7l+++HxSVqUY9WiWmAOJ
         Hv2TV9XMUoipC7MGmmAQl/nbmHqsWL8ybyJGnqrApo/xCs37Px5W6JoQwBe+z9yuStqy
         3Re8+xPQrf/ZQdMxwb6EY9iAp1YQeF7dV9nJLpGWjnplzj9GQrMc2V0aiVTKZJToLNC1
         aTSA==
X-Gm-Message-State: APjAAAXa4gZsgeSYpxDHimTeFGs40th3whsyU1Gdme6bk/6C+pgMy6Fo
        rrYullCUcx8E/S2bNlQTBjkuXg==
X-Google-Smtp-Source: APXvYqzUtSx9TXYj7cPELtcJoIFrQb9QmW162prSdvzhCjMi66kmK7ihqlK1y9torULncYYjxLcW0w==
X-Received: by 2002:a17:902:904b:: with SMTP id w11mr8623273plz.182.1570724816801;
        Thu, 10 Oct 2019 09:26:56 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o15sm6148342pjs.14.2019.10.10.09.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 09:26:56 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] ath10k: Correct error check of dma_map_single()
Date:   Thu, 10 Oct 2019 09:26:53 -0700
Message-Id: <20191010162653.141303-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of dma_map_single() should be checked for errors using
dma_mapping_error(), rather than testing for NULL. Correct this.

Fixes: 1807da49733e ("ath10k: wmi: add management tx by reference support over wmi")
Cc: stable@vger.kernel.org
Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3d2c8fcba952..a01868938692 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3904,7 +3904,7 @@ void ath10k_mgmt_over_wmi_tx_work(struct work_struct *work)
 			     ar->running_fw->fw_file.fw_features)) {
 			paddr = dma_map_single(ar->dev, skb->data,
 					       skb->len, DMA_TO_DEVICE);
-			if (!paddr)
+			if (dma_mapping_error(ar->dev, paddr))
 				continue;
 			ret = ath10k_wmi_mgmt_tx_send(ar, skb, paddr);
 			if (ret) {
-- 
2.23.0

