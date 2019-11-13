Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004EFC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DB4222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYKLPGn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfKMOxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:53:54 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36873 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfKMOxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:53:54 -0500
Received: by mail-qk1-f196.google.com with SMTP id e187so1952212qkf.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 06:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lhqQlqdW++vif/0zLTr34V8bvbj/h6vwMDBBkzo/1cQ=;
        b=nYKLPGn0KIreC+b7ngmpcaxW79MmzNwqJ0DI97DbJ/yKichejkrmExUX83dJryPw0V
         Y0CPB7AzstAwzaNoe7MsLucH2ChbJ3TybUS5WFQfiYceehhD+W7RNiYMgIOuOxtMhRkN
         b18bWiJas0olWEnKYDPrK/vqjnk/poOcCgSbgwoNJk2a6WNW7mKF89jo35TRhrrOWVQO
         8jNgYXe3nNerubY97PGJcODBzjxQNu94BQjtqsbrzgqS0QLcDHeEd0FXDF74d187qfvZ
         QvY3p9yVLtJJv7edEjYgWV6e2F9Ac+uTeSC7PbZqXhcy/jrySCk/dJBLI4DEWORxiCuJ
         aJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lhqQlqdW++vif/0zLTr34V8bvbj/h6vwMDBBkzo/1cQ=;
        b=G/lDKVWo1h9p114fJUvBML1jVEPQJfl+Y5GEGuXcDEjBFQ4sIOdHXIH8C3YABZ3wmH
         qj348hSUwlSjJ6HLy+RoTVJvsRYmeKJPyfWz0WGhvm3N0LXK48z1WoFBsj9+dIi8YG3p
         PGGbSRzz8YiNKJE73VX+nF/BHJOiAP0pgYAL8dJEThuez2uj7BoiMMo5zwMIiBegJV2Q
         TKZVqMY7YcVsWhMj0ZcbihwzSx+dvdmvhynXkYXYI/phU9ZzqDNKK5+q3sDNublYquwG
         NTtaU69VfeQBqmml8lFBefkzjkGXOxXUtB7MWGv7yQWFuzY/72oI0Np6Gb3Rzp5tkpv1
         IzrA==
X-Gm-Message-State: APjAAAW1y2doywBTnmqzqDC0urryeY3oLCmQdbFZ8W377swKE2OB7Tzy
        0KyNqnaLaSanplfdZbxhVVQ=
X-Google-Smtp-Source: APXvYqypu6735IJY9l5K2DmESPoA5fGEliJBh6WfdQ7+vH+CTpDkcxzrEw7xqbmqbWp5xQfh8C9O0g==
X-Received: by 2002:a37:a14a:: with SMTP id k71mr2713056qke.421.1573656832297;
        Wed, 13 Nov 2019 06:53:52 -0800 (PST)
Received: from gmail.com ([184.75.212.4])
        by smtp.gmail.com with ESMTPSA id l132sm1097498qke.38.2019.11.13.06.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 06:53:51 -0800 (PST)
Date:   Wed, 13 Nov 2019 09:53:49 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/4] staging: rtl8723bs: Remove unnecessary conditional
 block
Message-ID: <f1016e162abbf855c89bcc17281805d3e4d72f75.1573656487.git.jarias.linux@gmail.com>
References: <1d47d745c077cc808bf0c09d2ee40e3c03d34b06.1573656487.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d47d745c077cc808bf0c09d2ee40e3c03d34b06.1573656487.git.jarias.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a conditional block that had no effect.
It also reformat the affected lines to set the right indentation
after the removal.
Issue found by Coccinelle.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
Changes in V3:
        - No changes.
Changes in V2:
        - No changes.

 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 0f5dd4629e6f..b4b535c66bae 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -551,18 +551,13 @@ static void HalRxAggr8723BSdio(struct adapter *padapter)
 
 	pregistrypriv = &padapter->registrypriv;
 
-	if (pregistrypriv->wifi_spec) {
-		/*  2010.04.27 hpfan */
-		/*  Adjust RxAggrTimeout to close to zero disable RxAggr, suggested by designer */
-		/*  Timeout value is calculated by 34 / (2^n) */
-		valueDMATimeout = 0x06;
-		valueDMAPageCount = 0x06;
-	} else {
-		/*  20130530, Isaac@SD1 suggest 3 kinds of parameter */
-		/*  TX/RX Balance */
-		valueDMATimeout = 0x06;
-		valueDMAPageCount = 0x06;
-	}
+	/*  2010.04.27 hpfan */
+	/*  Adjust RxAggrTimeout to close to zero disable RxAggr, suggested by designer */
+	/*  Timeout value is calculated by 34 / (2^n) */
+	valueDMATimeout = 0x06;
+	valueDMAPageCount = 0x06;
+	/*  20130530, Isaac@SD1 suggest 3 kinds of parameter */
+	/*  TX/RX Balance */
 
 	rtw_write8(padapter, REG_RXDMA_AGG_PG_TH + 1, valueDMATimeout);
 	rtw_write8(padapter, REG_RXDMA_AGG_PG_TH, valueDMAPageCount);
-- 
2.20.1

