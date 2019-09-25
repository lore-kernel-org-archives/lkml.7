Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F49C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D271821D80
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfIYVcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 17:32:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57196 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbfIYVct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:32:49 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <connor.kuehl@canonical.com>)
        id 1iDEu0-0001Iv-RI
        for linux-kernel@vger.kernel.org; Wed, 25 Sep 2019 21:32:48 +0000
Received: by mail-pg1-f199.google.com with SMTP id b18so600343pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 14:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MkF7goRdpeReW9T+fX+Did5lBMAtqHM/JtXL483fHaU=;
        b=geCEw8xWrZiWzaGSm0D29FMeU2i+5MPFFkQF24yf4ItCYQnQfwTqjd8NjS+bQ9hWye
         p1sROTjYP6jxXwCPkjUhvM28hs3I9l4VCTmq58dviRpe6O3q3IclTfzbuK7fLaP0QnBV
         yMeRilrFxE6zTpWfZFecp/Zlwx+yP3qAJlR+mdp+8dv3W2/iSKg8OpACmnumSOBb8FCB
         /A2Ul4lOG9YTkBjIb7lrwUBovx+0TRBu1+m8AQTJHYZrWHuyvFp/HNGMU0tJEGMYsLtp
         KBVI3Ok+vo1FhK1Lt0zD2EBT4lfVsHzkpQU7wvCAWN7/TXHCOaL/mlS/W3A/B4+aKcI2
         7ePg==
X-Gm-Message-State: APjAAAUbksGsIDybdW+IHYPIxbodIkTuGHHcT/A9RmaGWnRtbyv27A++
        6sSKVOvp3FGRdGQc4INssEdE1EYgN/ayz4MehyEyVgU5GDBEJpL5UxG5WJ66q7lLZ4S/Obvkt5T
        L3Zj2S/rMctYkJOie3Vgt6JxwZGAnYL1woUD0mRLAsg==
X-Received: by 2002:a63:471a:: with SMTP id u26mr1442952pga.266.1569447167541;
        Wed, 25 Sep 2019 14:32:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxZkEa7zMT3dos3IakamBasOKGUMVJ9uw/N3eJjjrq/mIxyHi0gpqxjixnecmDwARyKb7Heaw==
X-Received: by 2002:a63:471a:: with SMTP id u26mr1442937pga.266.1569447167322;
        Wed, 25 Sep 2019 14:32:47 -0700 (PDT)
Received: from localhost.localdomain (c-71-63-171-240.hsd1.or.comcast.net. [71.63.171.240])
        by smtp.gmail.com with ESMTPSA id 195sm5290313pfz.103.2019.09.25.14.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 14:32:46 -0700 (PDT)
From:   Connor Kuehl <connor.kuehl@canonical.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: fix possible null dereference
Date:   Wed, 25 Sep 2019 14:32:15 -0700
Message-Id: <20190925213215.25082-1-connor.kuehl@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside a nested 'else' block at the beginning of this function is a
call that assigns 'psta' to the return value of 'rtw_get_stainfo()'.
If 'rtw_get_stainfo()' returns NULL and the flow of control reaches
the 'else if' where 'psta' is dereferenced, then we will dereference
a NULL pointer.

Fix this by checking if 'psta' is not NULL before reading its
'psta->qos_option' data member.

Addresses-Coverity: ("Dereference null return value")

Signed-off-by: Connor Kuehl <connor.kuehl@canonical.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 952f2ab51347..bf8877cbe9b6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -784,7 +784,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
 			memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv), ETH_ALEN);
 
-			if (psta->qos_option)
+			if (psta && psta->qos_option)
 				qos_option = true;
 		} else {
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("fw_state:%x is not allowed to xmit frame\n", get_fwstate(pmlmepriv)));
-- 
2.17.1

