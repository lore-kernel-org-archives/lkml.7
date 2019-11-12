Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABD1C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EDC222CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMuvqXuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfKLQzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:55:33 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41997 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbfKLQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:55:30 -0500
Received: by mail-qk1-f194.google.com with SMTP id m4so15040817qke.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=0M0FA1unlp8F1Z996jxzOlmlSaGicPhBII8CqVqj8hA=;
        b=lMuvqXuCUyxt7K6tw9iOUffeRkz8nL6/nayHdtv/eE/m5Yvq0Mp4Bu4wUl8ev822K2
         5ufbDyuNNAROGVvkDCJqzwz13Xv3qFlQahfuRzUZy23A941vJzNeqTun+9xBVx679mGp
         k/oIKvH7b02vXAlDy+l7Apd29jJQ40PjtgN5YVYovPovRgYOD2xF+8WIOGxxBv5Ggwja
         NL2zK6/j+8yzelhwsoxah7QpAmL1SIWHrPfitW//1jwjKw/KNcYuozjMTmJHXGrKK7RD
         ndS997Xal8ryO2bJj39mwK2UTvSINOFki/KZa1/zr255ochOuFcOAHLDhDlymSvo5SCD
         uMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=0M0FA1unlp8F1Z996jxzOlmlSaGicPhBII8CqVqj8hA=;
        b=VzJfnYhp9I5k60A/vRvZp0gG9Mr2I+fe/eu5Ch7L64DvEf0szRYVPuEXbG5r6Vro/A
         cUiDbiQ0Aj+abDwJWM0Eh1LPAMnHAzF/1Z2FskpZCgSqMZ691RUVm6T8qQ9fanOEpiOb
         HMKKU7Y1ni+RPgKd1+aGZ9QbMoDu6/BJQ1ZIDeT5M3hLFpbNyRlHezDX2sjNA4jQ7Eac
         ZNt037qkOnCOqDb5DMAOtrwvlPRbGfIDsnKbjjBft4wV18dVfAZlCAHz26d11CDoWval
         I7Io3kpuI+a1x+yO6mI6upGgNXFfTA0VKkk7N6PGGuPT20IwmThdaxJFgz70EA93sGGx
         4NOg==
X-Gm-Message-State: APjAAAVUfKOAWBv9mmLLw0NKiv6bGB4IKdjzEn63J+RfpCd2IPuJP11g
        mPnC6lR57zLIFlgN0OJu3wGXNTrhsh9yow==
X-Google-Smtp-Source: APXvYqx/3pdPBFKUQspMyLPM+3UtuiuwD3qp9I4tZqiQC7QQSsPVMV9CwnkU8IAF1ohXfH8vDeA2Lw==
X-Received: by 2002:a37:582:: with SMTP id 124mr16678884qkf.396.1573577729731;
        Tue, 12 Nov 2019 08:55:29 -0800 (PST)
Received: from gmail.com (dynamic-186-154-98-65.dynamic.etb.net.co. [186.154.98.65])
        by smtp.gmail.com with ESMTPSA id n56sm11283172qtb.73.2019.11.12.08.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:55:29 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:55:27 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 7/9] staging: rtl8723bs: Fix incorrect type in argument
 warnings
Message-ID: <637726782ce6c6ed3d68b5e595481857916bbc56.1573577309.git.jarias.linux@gmail.com>
Mail-Followup-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <cover.1573577309.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573577309.git.jarias.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix incorrect type in declarations to solve the 'incorrect
type in argument 3' warnings in the rtw_get_ie function calls.
Issue found by Sparse.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index db6528a01229..bb63295e8d4e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -83,7 +83,7 @@ static char *translate_scan(struct adapter *padapter,
 {
 	struct iw_event iwe;
 	u16 cap;
-	u32 ht_ielen = 0;
+	sint ht_ielen = 0;
 	char *custom = NULL;
 	char *p;
 	u16 max_rate = 0, rate, ht_cap =false, vht_cap = false;
@@ -760,7 +760,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 			     union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	u32 ht_ielen = 0;
+	sint ht_ielen = 0;
 	char *p;
 	u8 ht_cap =false, vht_cap =false;
 	struct	mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-- 
2.20.1

