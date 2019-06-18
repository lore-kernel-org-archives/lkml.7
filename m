Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF152C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A76206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIchASJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfFRBHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:07:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34369 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRBHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:07:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so6610426pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 18:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3qTJFL8TPYAqD0lX4UvXoMh+5EQ/OFFtCVywLSut39U=;
        b=HIchASJa206vE1wX0c7Oz9ds9JnvLJZKFYjW3anhBAHYujhrWUR9H0Lr9tZQpWO5kE
         huPFQLgon04TOH+mUxayg0ngWwQq4UPRfU9KRVL9yI8ZeMHaVVffXnqN3vV/VolXhHv3
         h/SbSSprbALTU+4mFTtb+b/PuTMXJMWOyZnczYbvLpYkoMCmhfNzDXLAFepTHo3QVbdt
         c72/2m7wsqG6gUbA7Vi1tM+fOTG0tNuOnRkPQumXgFL4cGtplwG5awcVGaAcAgonF2BT
         Pc9Y4RnPJ6XQ/e+h14jhV9ancEKGQmx6+o38gQ1CoAzJMjDn5c9a2fnJxw3PdIB26nsF
         in9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3qTJFL8TPYAqD0lX4UvXoMh+5EQ/OFFtCVywLSut39U=;
        b=k8+jtjVlXtcfhwWzeiDkxhsEsA3UEIceFb0coLX2quRwpbKtG+rLJvWYnZqnE2L/wZ
         C5QoGikFDqu/SDdej1P4bdjZv06P97ZX2zDFmV74g74UnG2tdH3AvgCpWHUaho6WMfL9
         py78wEGrts96MHn3wTXD/kq5W3NgNgl2brH3w22NXSn0vQ0M3h0L0CshcUMYST3cAm16
         ffH1/6QGDGRsHZh0TSaQnLXH3TpCfAdY5+Qtw5JDSWEg7/tU0BCJIycAiJ8PNpb1KcDr
         q/nEJCOYOSE0TONZfHKlp49OdCMSw3cJgsi6qhRNjSnxLS5uIYFwgHAizMMuIAKyY1Hd
         8wLg==
X-Gm-Message-State: APjAAAWh5D5czDkBK/SVsJTGA5TZwtzVZD3Mm4GAhaDWUdsxqEY+luwg
        gpXJgN+kVVdZdRffvyzGrWA=
X-Google-Smtp-Source: APXvYqweCsmBFCydDkHkLeyQD5pSD2Sp8qrKxrENAs7Xm/i3YBEfTpUlJYGwJDHb6k5T2fg0XgMmeQ==
X-Received: by 2002:a17:90a:5d15:: with SMTP id s21mr2134582pji.126.1560820029360;
        Mon, 17 Jun 2019 18:07:09 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id j16sm432558pjz.31.2019.06.17.18.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 18:07:08 -0700 (PDT)
Date:   Tue, 18 Jun 2019 06:37:03 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: rtl8723bs: hal: rtl8723b_hal_init: fix
 Comparison to NULL
Message-ID: <20190618010703.GA7061@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to fix below issues reported by checkpatch

CHECK: Comparison to NULL could be written "!efuseTbl"
CHECK: Comparison to NULL could be written "!psta"

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 21f2365..624188e 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1023,7 +1023,7 @@ static void hal_ReadEFuse_BT(
 	}
 
 	efuseTbl = rtw_malloc(EFUSE_BT_MAP_LEN);
-	if (efuseTbl == NULL) {
+	if (!efuseTbl) {
 		DBG_8192C("%s: efuseTbl malloc fail!\n", __func__);
 		return;
 	}
@@ -2139,7 +2139,7 @@ static void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_l
 		return;
 
 	psta = pmlmeinfo->FW_sta_info[mac_id].psta;
-	if (psta == NULL)
+	if (!psta)
 		return;
 
 	shortGIrate = query_ra_short_GI(psta);
-- 
2.7.4

