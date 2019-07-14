Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD81C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463AB2089C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsyK6x4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfGNR2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 13:28:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39850 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfGNR2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 13:28:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so2373211pfn.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Eg/DP7K1WzO3LKkPNWtjmpuyH7UktmZHkdh6/bI4Cu0=;
        b=JsyK6x4IIiDh+I9mbXhj+rgYkW2WSYpo3quaqhQlZPNey6c5ioCyqypxTQuADUSkAC
         zVOaXrA6raVvlGhbcqSojvguzmYgV0ESFwq6QSaj7lAEiAKVrOmKPpuTGtBCtJ3Y5Zsg
         4aeCK4XSqgqk98qNcA+w8b2jbg0XCyxbyn5dtpcG7alAkSMi9pVCR/hUtEuJx1FsIg4T
         spxPSj+fgkkZfbN9YaB4/eOhiGyelLe//Sb/328jP96r/gFDoE2Lh6P0KZEy9CayY4OP
         VFrKhgDFXijPWU+0n5psEwDq9UWuPkD1Mg44feFq0V2SkzyzVhFzBjtwEux5H2ghzqep
         S8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Eg/DP7K1WzO3LKkPNWtjmpuyH7UktmZHkdh6/bI4Cu0=;
        b=A2ut2dhg7qWHqEZYCayBYR/4ES6IEz/93qZ+nKPH0C7/wgdXm9o3KaHi1In3R89j+i
         3BOZzu7G0goZ6CjMHgd9vfZGKJVIKmVZazQAzyQLzztyKbs/40rF+hdQK72ldrYvcn3H
         3tdFZb3PWsqA9d4NHk1p6TuRjT7qelQhlJQA4/SYV1xqnoPcXYxdX1MwpM4U9+EzHL/+
         EWn1V/OCf6Fmoi44ZimsusWdID8Qledvpm3nuamZc6vAyhjXjtGANx0/auc4zgCVMlcm
         GDbC2l9Oi8Z+G7bQptrKajZ9/hFNDguCGBBYqX7NODFkiFO7aOn0pC4e+I2fDEnLJovv
         RdNw==
X-Gm-Message-State: APjAAAVEaItSe7d0Wi7000XoO4ZIlOy27mB+uLMn/C5IccoXuw/edKyv
        yfGcL8edas3wTfyoejt/UZE=
X-Google-Smtp-Source: APXvYqyxA1WfTxRlxIFCPjpD2t2gTPEmD3S2Oie4bywlLZUETO7LwfA9DHzey256spKkh5OV166VIw==
X-Received: by 2002:a63:fb14:: with SMTP id o20mr11837553pgh.136.1563125312117;
        Sun, 14 Jul 2019 10:28:32 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id u1sm12971306pgi.28.2019.07.14.10.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 10:28:31 -0700 (PDT)
Date:   Sun, 14 Jul 2019 22:58:26 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH] staging: rtl8723bs: core: Remove code valid only for 5GHz
Message-ID: <20190714172826.GA6950@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per TODO ,remove code valid only for 5 GHz(channel > 14).

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 4285844..967da71 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -295,11 +295,7 @@ static void init_mlme_ext_priv_value(struct adapter *padapter)
 
 	init_mlme_default_rate_set(padapter);
 
-	if (pmlmeext->cur_channel > 14)
-		pmlmeext->tx_rate = IEEE80211_OFDM_RATE_6MB;
-	else
-		pmlmeext->tx_rate = IEEE80211_CCK_RATE_1MB;
-
+	pmlmeext->tx_rate = IEEE80211_CCK_RATE_1MB;
 	pmlmeext->sitesurvey_res.state = SCAN_DISABLE;
 	pmlmeext->sitesurvey_res.channel_idx = 0;
 	pmlmeext->sitesurvey_res.bss_cnt = 0;
-- 
2.7.4

