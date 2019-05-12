Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC61EC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE822173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6lmQ0g5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfELQxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 12:53:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35269 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfELQxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 12:53:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id g5so5205311plt.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pUkqfemPvj4U8k6I42VkBU64ojbl3SFKE12XTRr6nbI=;
        b=f6lmQ0g5Dsaclu3LMgF/xUHC4LOXFD+rMnCi2sCWxkWNG/zOnY40KTn/HzL2/b4z+b
         FcDmVU9vTZZTSjOOyRcLUytpkPekVuLT5bingKQzfpymJeX4qGjlVAHG4/RZxK4Qj6/+
         W7epK0SRK/tU2M1KUg4l9+2sZN32VHS3eeyv3jF+PAszSLJO0hyiix2pkfHNXIzTMksS
         7E6PugJ6NbXetbCGdw1tVGtvZyQm3tRFtIH1qhbmZ405RVV+tHC3J5jOsv8hGXCz2E5s
         y+ehkhh2uKFA3ErVvOzht/oVAo2MfplvDgrvHYZxbJL9+ow2JgpbmohA+QV8ZiTbwv7r
         Eh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pUkqfemPvj4U8k6I42VkBU64ojbl3SFKE12XTRr6nbI=;
        b=lhUIGAVtmnt5969zbC9tJCyuGOl9VmJ6dJ5aJccBzvfNTKphL/J+3qB5Q6r9tuKx7c
         LU8zxw18Guxero7SK4TVPLtgNsY+E2fr4P0z9aXX60PQBUfBJPhhWz48xlKocjpZPobC
         OyEwQ7WYWZGiSXTLUR1ZSbvqo+D2lEJZegneMdw9dfmSDZTg2UFpu3KtMBVbkzRkZFby
         3QF4lS2s+UNhAYY07sEdzav0yipWuv9LEOBDveuOfWVDCX9+kQNnJujECQXLQsSc3c5c
         JQ6jeN0VB2ZmJBarhESIO7kDJnRtdaHH1Te9hJLlA8G4vJ/YNkaJTsV0lIO5S5jEWAGs
         WEiQ==
X-Gm-Message-State: APjAAAU9GBHd6cmjV4HuXsO5DMtwpX1x/ljez1TaLW5DP76t6x6kac9m
        CqsGayjw5RqHBAFSEsZAUBM=
X-Google-Smtp-Source: APXvYqwYCmX6Tq5bub63pCJHg/4b2SzIuKopJVV/+vqJXE6oUFHkbrlbInsKjC40nnm1qMbnMJltGQ==
X-Received: by 2002:a17:902:2bca:: with SMTP id l68mr24857776plb.301.1557679997486;
        Sun, 12 May 2019 09:53:17 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id g24sm17472311pfi.126.2019.05.12.09.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 09:53:16 -0700 (PDT)
Date:   Sun, 12 May 2019 22:23:11 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging :rtl8723bs :core fix WARNING: Comparison to bool
Message-ID: <20190512165311.GA27289@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by coccicheck

drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:181:5-40: WARNING:
Comparison to bool

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 5c468c5..c337a528 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -178,7 +178,7 @@ void rtw_ps_processor(struct adapter *padapter)
 	if (pwrpriv->ips_mode_req == IPS_NONE)
 		goto exit;
 
-	if (rtw_pwr_unassociated_idle(padapter) == false)
+	if (!rtw_pwr_unassociated_idle(padapter))
 		goto exit;
 
 	if ((pwrpriv->rf_pwrstate == rf_on) && ((pwrpriv->pwr_state_check_cnts%4) == 0)) {
-- 
2.7.4

