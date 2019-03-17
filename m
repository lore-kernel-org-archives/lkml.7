Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B553C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B33320896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPkLgEbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfCQSbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:31:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41760 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfCQSbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:31:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id p1so14598516wrs.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=BjtpPpig+YxIpgX3Tkx5OQYluC87qGjw+N+NKgdMzDw=;
        b=qPkLgEbVQ5PzaV7zT1GVkCmJEXPYAYmcB0ZNkH40lwepPIIX0J2BH4k665pYu1fQGL
         cMhcvgdp/nTqHkU5ThOBh9YqQzRuZuEfkAZgEAlc0sKxeKhi9RhQjAl1ZW0mPS+lXzmG
         tIR9SvlJeeZMjzdopr6YUeHnDRze62Zeeo9ZC/DhYSVmjRHqTSFY8LOPaKrjHxb4LMs4
         ZI5k9K+Rott7kSqFe+50oCbrKft+rnvjA7ZmbeRqHznGhhbNpFxEEFivBTrY7hUXEivS
         M91ITwCjRRerLKwMQxdn78oIPSHYjyekUMKeKXitlRI2pTTrwpdfaTwZ0SE08CmFYAOt
         6RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=BjtpPpig+YxIpgX3Tkx5OQYluC87qGjw+N+NKgdMzDw=;
        b=oKdNGD+M/qtmKdSCy4O65PuWE70+nHi+5cFEw8rUvzJKRPV0FXl8/lHumBFdrLwkE0
         kiep/GhJmrmJmIVT/cZ89MC7u0awtHS0hRDRMedpYqPWbRZR9aJgfTbot/D+q8Lu3+m4
         RhsvAkR7g9kWg6tZaC1rSfl9ISYF0G/0AcpN13mGM2eQ1D3WgYIo2g7P2e9MZUIExW9J
         Bbmep/QTLTDLPD/gN6rzM8R2uVBAYUN2d+1ACE3wMPvSXQ7jhQuItq6wqVB7qu6S7nEJ
         6F67fU1s2AFYXj8UiecaqdnQFcZK1/SrzgHZjqUgNrtG0KKsErOm/1FsFVe4ZN0TDCdx
         366Q==
X-Gm-Message-State: APjAAAVYQIDw11wlNQEic6Ygm45BY5gJjluhy0ahtTNuCCrot4F48P/r
        LVR352vODnVQZqkcLed5tHj5I5hu4vM=
X-Google-Smtp-Source: APXvYqzW0rJnvV8ftjKcjVWCGnYiEVaZuunVqby9b3cX98YPEE46EctdFktZfRab8Zb6jTCCZy28xA==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr2357931wro.20.1552847477765;
        Sun, 17 Mar 2019 11:31:17 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C9871AF900B43796A8F69485B6.dip0.t-ipconnect.de. [2003:c9:871a:f900:b437:96a8:f694:85b6])
        by smtp.gmail.com with ESMTPSA id q5sm8415358wrn.43.2019.03.17.11.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:31:17 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 01/10] staging: rtl8723bs: Remove Dead Code in `struct mlme_priv`
Date:   Sun, 17 Mar 2019 19:31:04 +0100
Message-Id: <20190317183115.32393-1-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Lines in the struct mlme_priv are Dead due to CONFIG_INTEL_WIDI.
This Fix removes the dead code.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_mlme.h | 27 --------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index 1ea9ea0e8d2e..ed59f16c26c4 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -454,33 +454,6 @@ struct mlme_priv {
 	_lock	bcn_update_lock;
 	u8 update_bcn;
 
-#ifdef CONFIG_INTEL_WIDI
-	int	widi_state;
-	int	listen_state;
-	_timer	listen_timer;
-	atomic_t	rx_probe_rsp; /*  1:receive probe respone from RDS source. */
-	u8 *l2sdTaBuffer;
-	u8 channel_idx;
-	u8 group_cnt;	/* In WiDi 3.5, they specified another scan algo. for WFD/RDS co-existed */
-	u8 sa_ext[L2SDTA_SERVICE_VE_LEN];
-
-	u8 widi_enable;
-	/**
-	 * For WiDi 4; upper layer would set
-	 * p2p_primary_device_type_category_id
-	 * p2p_primary_device_type_sub_category_id
-	 * p2p_secondary_device_type_category_id
-	 * p2p_secondary_device_type_sub_category_id
-	 */
-	u16 p2p_pdt_cid;
-	u16 p2p_pdt_scid;
-	u8 num_p2p_sdt;
-	u16 p2p_sdt_cid[MAX_NUM_P2P_SDT];
-	u16 p2p_sdt_scid[MAX_NUM_P2P_SDT];
-	u8 p2p_reject_disable;	/* When starting NL80211 wpa_supplicant/hostapd, it will call netdev_close */
-							/* such that it will cause p2p disabled. Use this flag to reject. */
-#endif /*  CONFIG_INTEL_WIDI */
-
 	u8 NumOfBcnInfoChkFail;
 	unsigned long	timeBcnInfoChkStart;
 };
-- 
2.19.1

