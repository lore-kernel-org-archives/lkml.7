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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64846C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C1B217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBJCw3Pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfCQSbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:31:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40074 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfCQSbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:31:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so14620630wri.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=Y2kIBLQ2EKuMYw8b+gVcyD4tG9MsvDSLq7+qsCXQ0ZY=;
        b=mBJCw3Prd9I7wT1X17v/TxI5XFjQCwtoT17BAt3Q9tzJkVThVu/t2yP7zGSBLKNPd4
         be1s1I1goyY70adzPHAX4l7L0TjqG3hDBk9Ugp/5DXyIZJ9J7invdmf59rRIn7BCOmH4
         xoT8NEADOig4Hn3YBMXqFlmPlk8M7pVBrtpKU7OWhNSztDyw9E2e+IFP8VazxRVrPdfl
         W0G2nOiEJOtFLiyQCRwdSp/5xv0HaTsGV0ljtdQUCy8yo7KSFoFCNwTbR8rOQ+rUvAnD
         LYl1asVay/C+QhIaDh5tOQwC0iQcu12WrFvgS9gdEe6aOYgZkW6C9ZTM1ysMqknoUlUU
         7N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=Y2kIBLQ2EKuMYw8b+gVcyD4tG9MsvDSLq7+qsCXQ0ZY=;
        b=gxKYgw3rqQFrr9kcUjIdQjrufqi9U628+9Cax6PclaNAMl2FDS4cN47/3Juw6DydnX
         BE3uATo3DqonWnFYpvM24qxYW7Tz8NDwgJ2ab8o3pSgA6w5+FfcmnxhlQva9uCEANrs3
         +yQQ1mJlR2/SC0bSTC7nZKOx+THajQq6nx5GOup0ntQXb8VSMcttGV4CMSmF26Feww/j
         jVXpeXbdjcd5lJOGr3wAceDaL8vaqEkOnz13lovp4HboUJP/qsduU6dExgutGNA9/IWQ
         GcaA8xkez68o2VU/VyrVisOrI/fS49VTxqRS53I2IW8TjJiPWhuaBvQk6Wql5wuKmEzQ
         q4aQ==
X-Gm-Message-State: APjAAAW9wDQ8XzfOC0BxtC+XMotZiiQWRdBsxhBCgTHBNkzf2hjWNIKT
        H6qFN2LuAwUIYEc5imZsFpjwU2sy5ms=
X-Google-Smtp-Source: APXvYqyL25j1K5pozwuvNyb/IkUFnDC+Is2rVagNL+BuX1JPDdBfknJo+FVM7hYAIx0Ox9wil+ZGRQ==
X-Received: by 2002:adf:8367:: with SMTP id 94mr9992442wrd.46.1552847501855;
        Sun, 17 Mar 2019 11:31:41 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C9871AF900B43796A8F69485B6.dip0.t-ipconnect.de. [2003:c9:871a:f900:b437:96a8:f694:85b6])
        by smtp.gmail.com with ESMTPSA id q5sm8415358wrn.43.2019.03.17.11.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:31:41 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>
Subject: [PATCH 07/10] staging: rtl8723bs: Remove Dead Code in os_dep/os_intfs.c
Date:   Sun, 17 Mar 2019 19:31:10 +0100
Message-Id: <20190317183115.32393-7-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190317183115.32393-1-benniciemanuel78@gmail.com>
References: <20190317183115.32393-1-benniciemanuel78@gmail.com>
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Functions `u8 rtw_init_drv_sw` and `u8 rtw_free_drv_sw` uses the
Macro CONFIG_INTEL_WIDI witch doesn't exists anymore.
This Patch removes those redundant Code Lines.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 4980fedb2fcc..5c0fbf5170cc 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -813,14 +813,6 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 	rtw_hal_dm_init(padapter);
 
-#ifdef CONFIG_INTEL_WIDI
-	if (rtw_init_intel_widi(padapter) == _FAIL) {
-		DBG_871X("Can't rtw_init_intel_widi\n");
-		ret8 = _FAIL;
-		goto exit;
-	}
-#endif /* CONFIG_INTEL_WIDI */
-
 exit:
 
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_init_drv_sw\n"));
@@ -857,10 +849,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 {
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("==>rtw_free_drv_sw"));
 
-#ifdef CONFIG_INTEL_WIDI
-	rtw_free_intel_widi(padapter);
-#endif /* CONFIG_INTEL_WIDI */
-
 	free_mlme_ext_priv(&padapter->mlmeextpriv);
 
 	rtw_free_cmd_priv(&padapter->cmdpriv);
-- 
2.19.1

