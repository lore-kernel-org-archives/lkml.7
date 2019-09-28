Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382DDC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E9D20863
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="HODFctfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfI1AGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 20:06:15 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:44738 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI1AGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 20:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569629174; x=1601165174;
  h=from:to:cc:subject:date:message-id;
  bh=FaCTevKekKWl5COEvVNNzHMFqf8s6yFBpnUXYidtk40=;
  b=HODFctfzHQm5OD3d03A3lBChZUK6FnLUgLvYkY4UgOGqXQ/3Zwps9wMJ
   /HyATVsh/pICGXuTL3cpLQY2tVgQSMyY9kUCUEz/Fx9So6mBuO7VCUgeS
   70n5O4F7nc+QMM7H/TxOdTms/Z2zeQSLa0NyRUbgOxlVcp+IbAT0SE270
   tJK1bHiTMCW2FVXWyqearH7I+TigbOH1xLjH5yXMTb81yg+ZDuH7mapbn
   rVTBxAyWizvZCctI3j9HSjUNDKSYGCpP/UVJupgZ3NMmpe6bcYMbfT7GM
   q6B5Kx6ZH+M5fvgXHU18E4A7TUf3gJ41IzisyY48ALgJa3OER97sqvKI8
   g==;
IronPort-SDR: Us1RZBoAnQAuhL6i+6pgsyeQUjgNHchTfDOxZgklxnpxf5utUgVkb/Ce0+bcLX2iGO+XNtk16b
 NJwbbDlaTJ3aaMdjsdSq1XX2w3inzrKja/p0EG0GGmOL1tfxKYmXsJuW/ZAtNQk1tmw7bx7XJE
 eeEtWUIH+a+iBcg9/2+2h0qmCdpA2XNCTRUm3fQe8yT5r+s2vEa6mMeg4pQruLqoh3IwDbXS84
 w4WyGN+7hjhGgU6Vgqd330x3XOkTypKYuAjFsl3A30K7EkxiK5pfTW34NUhykVp7wqRspoVx3E
 Ek4=
IronPort-PHdr: =?us-ascii?q?9a23=3ABPoZvRXDnbKriX3wS+aIfoGgQ2fV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYx2Gt8tkgFKBZ4jH8fUM07OQ7/m7Hzdfqszf+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLuMQbg4RuJrgwxx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipEAoO9dIsPFOsBPeBXr4LguVUAtAa1BQetBOzxzj9Hm2L90ak03u?=
 =?us-ascii?q?g9FA3L2hErEdATv3TOtNj7NLkcX/27wqfLyjvOdO9a1Svn5YTUaB0tve2AUL?=
 =?us-ascii?q?RtesTR00kvEAbFg02SpozkPjKV1vkNs2+G5OdnVeOuim4npBtwojSz2sshhJ?=
 =?us-ascii?q?LEhp8JxVDe7yl23ps6JcChRUN9fNWqE4NQujmEO4dqRs4uWWJltSYgxrEYpJ?=
 =?us-ascii?q?K2fDIGxIkjyhPcc/CLbomF7xb5WOqPLzp1hGhpdKy+ihqo80WtxevxXdSu3l?=
 =?us-ascii?q?lQtCpKiNzMu2gI1xzU98eIVONw/lyk2TaTzwDT7fxEIVwsmarbNZEhxrkwm4?=
 =?us-ascii?q?IWsUvZHy/2nFz6jLeZdkk54+So5fnrb7Hlq5OGOI90jQb+MqsqmsOhG+g3Lg?=
 =?us-ascii?q?8OX22D9eS90r3s41H5Ta1UgvEqlqTVqpPXKMQBqqKnHgNY0pwv5wu7AjqlyN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLej4DPa+g1SjijZry+zaMrDvGZjNM2TMkK37cb?=
 =?us-ascii?q?lj9kFc1RI/zcpD6JJMFrEBPPXzV1f1tNzZCB85LgO1z//kCNpjzIMeX3yAAq?=
 =?us-ascii?q?uCPaPMvl+H+PgvL/OPZIALojb9LeYq5/r0gX8+g18dcvrh84EQbSWJH+ZmPk?=
 =?us-ascii?q?LRNWv+gt4AST9Rlhc1VqrnhEDUAm0bXGq7Q69pvmJzM4mhF4qWA9/1jQ=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GIAACYoo5dgMbXVdFmHQEBBQEMBQG?=
 =?us-ascii?q?BVAcBCwGDXUwQjR6FclABAQEGiyYYcYV6gwuFJoF7AQgBAQEMAQEtAgEBhEC?=
 =?us-ascii?q?DOiM1CA4CAwkBAQUBAQEBAQUEAQECEAEBCQ0JCCeFQoI6KYM1CxYVUlY/AQU?=
 =?us-ascii?q?BNSI5gkcBgXYUBaEogQM8jCUziHEBCQ2BSAkBCIEiAYc0hFmBEIEHhGGEDYN?=
 =?us-ascii?q?WgkQEgS8BAQGNcIcrlkkBBgKCEBSBeJMHJ4Q5iTuLPwEtpxICCgcGDyOBMQG?=
 =?us-ascii?q?CDk0lgWwKgURQEBSBWhcVji0hM4EIi2mCVAE?=
X-IPAS-Result: =?us-ascii?q?A2GIAACYoo5dgMbXVdFmHQEBBQEMBQGBVAcBCwGDXUwQj?=
 =?us-ascii?q?R6FclABAQEGiyYYcYV6gwuFJoF7AQgBAQEMAQEtAgEBhECDOiM1CA4CAwkBA?=
 =?us-ascii?q?QUBAQEBAQUEAQECEAEBCQ0JCCeFQoI6KYM1CxYVUlY/AQUBNSI5gkcBgXYUB?=
 =?us-ascii?q?aEogQM8jCUziHEBCQ2BSAkBCIEiAYc0hFmBEIEHhGGEDYNWgkQEgS8BAQGNc?=
 =?us-ascii?q?IcrlkkBBgKCEBSBeJMHJ4Q5iTuLPwEtpxICCgcGDyOBMQGCDk0lgWwKgURQE?=
 =?us-ascii?q?BSBWhcVji0hM4EIi2mCVAE?=
X-IronPort-AV: E=Sophos;i="5.64,557,1559545200"; 
   d="scan'208";a="79200551"
Received: from mail-pg1-f198.google.com ([209.85.215.198])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2019 17:06:13 -0700
Received: by mail-pg1-f198.google.com with SMTP id f10so3802294pgj.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 17:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iWRIaOK35hrLohXaCf+wY4P/hDj86VUIyT0UiZ54CEE=;
        b=RDtA4+zvv7lt1Wnff6/d860vx9iFlrCI6VUxXgpWCdWs16tMzcKviV2SfYVJ9kRAie
         /eGrLaEfZlLOuZjfqTkAgYpjj6Qir0auRZrCujM9WbLlBWAKrAvlCVwyObTyGz3S1RvO
         /KAxFGs2wutXEQrBtxDWxCoLuX3KoZNfn2a1B6onSvCMhjo4UXr2ba6VX2rlzwl2zS+7
         xxC9jyisZD0UFnGZ5DPAipcAFpZ4WCbdw5O2+Ip8/9rSkHvx1WaPu/+WOrjpcn/EOFo6
         HRtOgALvT9b1i0Hc6LFD1zNLvLJQ+A/Pp0BEuybi0N0oTbTHM3kKXByEiC6RYCE8mxNB
         V3rA==
X-Gm-Message-State: APjAAAXBtSk2CBkK18uUIv+jx9seR8y0LFl5LWlgdHbRG61mhMkho2PB
        wvW2htBulDJEY0Vyrh7rpJGymoDURJ28N7MGw0On3LoYCO9gZsLKPvX2ruRUsxSNfMGZBT38zl4
        r7QmcnhD/0GtiTx2rtZThKhESqw==
X-Received: by 2002:a65:5003:: with SMTP id f3mr12170037pgo.335.1569629172932;
        Fri, 27 Sep 2019 17:06:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx3zzIUKbwUDelODLitrwoLWyQ8vBQ0lg/rhYGX9pv+WYB6eYPDVIHDeWRYXarba746c+dW0w==
X-Received: by 2002:a65:5003:: with SMTP id f3mr12170002pgo.335.1569629172560;
        Fri, 27 Sep 2019 17:06:12 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id p1sm7381787pfb.112.2019.09.27.17.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 17:06:11 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Jeeeun Evans <jeeeunevans@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Puranjay Mohan <puranjay12@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Variable rf_type in function rtw_cfg80211_init_wiphy() could be uninitialized
Date:   Fri, 27 Sep 2019 17:06:51 -0700
Message-Id: <20190928000655.27507-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function rtw_cfg80211_init_wiphy(), local variable "rf_type" could
be uninitialized if function rtw_hal_get_hwreg() fails to initialize
it. However, this value is used in function rtw_cfg80211_init_ht_capab()
and used to decide the value writing to ht_cap, which is potentially
unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 9bc685632651..dd39a581b7ef 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -3315,7 +3315,7 @@ static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum
 
 void rtw_cfg80211_init_wiphy(struct adapter *padapter)
 {
-	u8 rf_type;
+	u8 rf_type = RF_MAX_TYPE;
 	struct ieee80211_supported_band *bands;
 	struct wireless_dev *pwdev = padapter->rtw_wdev;
 	struct wiphy *wiphy = pwdev->wiphy;
-- 
2.17.1

