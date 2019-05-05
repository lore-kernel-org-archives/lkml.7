Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8539BC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538BF208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErIf4xe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfEENXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:23:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34574 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfEENXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:23:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so5306912pfd.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UQqO8W5D4CT+ksezNayfRuTwaSX+rCT5sHrxvCqimbQ=;
        b=ErIf4xe5fYpYMe9INM/qc3CEZIKoHTj2S6l6oBe8RS67eQBWDRYdt4hEmdCw8t0sjw
         5/YpbgsP41BrjdBgFBp1Rj59pK35ihXEg+8rlc4bmDXvxmDjwtsMmRPwpJ7HPxiBX7ME
         o9xfWE+s8WnAVUK7xTRq+H3vK+xcRH5DyJnMncw5gzlbz/WoBc8i3N9ueniTl2tiLz+E
         YK2hz41eW+XLFltiOtDNUFdM+IvHYGxkoyTdYZW1gss48sqzrD+wSRTpyoOQb1SoA0WD
         Y7QUnk1OJjTGoI5T3E5QiA4mq7LQ4i3U9yPZnmfkpuytGIOy74QepzjiDJzE7xP/e9ag
         QouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UQqO8W5D4CT+ksezNayfRuTwaSX+rCT5sHrxvCqimbQ=;
        b=VzZSH59+ZZUFq6xFry+RP1AHL/U7urRkI96BhTBYqWZm79+ckukHMqzvdcn8A/3tq3
         lZ7CTLXRC8tKwEmeqbt3vgpsynLEUzmoo7IpaWZxhEEF3LXVtfB5/5bO12kUK3/6ekLZ
         1RDVnizdYXGk8u33cRpd172QUkrQ8HxxRa0JGQrm63dOHJZSurKwmjuUTAKDQReXSwQQ
         IJH9SmbT9uLW48VCoCDbd9XRmYbT1NTXpyc5qXHbapW4IB5iZ140Atl9L7HJneeImVnG
         92q1zv8oLS4TFkqXg0m9JAS94bTPMggVZNyPcQeGCPmy5LvmM74qORQ8HiyHZzfKdzSl
         tN/A==
X-Gm-Message-State: APjAAAWUMBuPAFPsu5BZ29sxTnOiLHfEWcR3RoydRrdBrHBrZqutStlu
        EROm9jhbTUKHekOrxwbeBr8=
X-Google-Smtp-Source: APXvYqxVvYTOatU5SYFHrVIYPqWoVVEyDux3Fe5NTaerGxjib46XgBej05B7sQf8FaoM8/jz0YdViQ==
X-Received: by 2002:aa7:8d98:: with SMTP id i24mr26015539pfr.8.1557062592276;
        Sun, 05 May 2019 06:23:12 -0700 (PDT)
Received: from localhost.localdomain ([103.87.56.229])
        by smtp.gmail.com with ESMTPSA id a26sm10312709pfl.177.2019.05.05.06.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 06:23:11 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH v2 6/6] staging: rtl8723bs: core: Move logical operator to previous line.
Date:   Sun,  5 May 2019 18:52:53 +0530
Message-Id: <20190505132253.4516-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move logical operator to previous line to get rid of checkpatch warning.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 0b5bd047a552..b5e355de1199 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5656,9 +5656,9 @@ static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
 	);
 	#endif
 
-	if ((sta_rx_data_pkts(psta) == sta_last_rx_data_pkts(psta))
-		&& sta_rx_beacon_pkts(psta) == sta_last_rx_beacon_pkts(psta)
-		&& sta_rx_probersp_pkts(psta) == sta_last_rx_probersp_pkts(psta)
+	if ((sta_rx_data_pkts(psta) == sta_last_rx_data_pkts(psta)) &&
+	    sta_rx_beacon_pkts(psta) == sta_last_rx_beacon_pkts(psta) &&
+	     sta_rx_probersp_pkts(psta) == sta_last_rx_probersp_pkts(psta)
 	) {
 		ret = false;
 	} else {
-- 
2.17.1

