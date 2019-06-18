Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A4EC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355F420861
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe9x1B7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfFRBJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:09:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38749 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRBJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:09:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so6709817pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 18:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QQb14onWvk/5mY6htEZ+rzhxVBpcQL/nxR/+F9szi7g=;
        b=Oe9x1B7li4jiDVE8u485Jm83AaejnNAgXWJ+AyieGXsjFqYpfIFbQe9lT2D3iYFLGT
         31iJArxFmpM/FxLmzKy7I0PmLRJlFZvH5xcDEf6X+GZC0n/ubKoApsDVJE5RCHFjIpiN
         KkBOn+0+yz2U+4goe/rCl8Bbb8EQP/4MeoQsu3bplTyRZVkGH+ODoO2tf7W9VO4Ig2r6
         K5vw/kzRGxx77l8Yt7ICkP881OlRwZ/STRFw+AQG+OKSMSAsRAsIYMjqXeTEj+XYJICU
         AfTsJR/satdfmtZa4ArkXJYNNCSe2zwepFG8I+neLX1NOcICMafVnuH3dniwVtvhZgYl
         hQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QQb14onWvk/5mY6htEZ+rzhxVBpcQL/nxR/+F9szi7g=;
        b=tFeFK6XscJZX115yJhNh24ixzCkitV1Ymru97ERO2fxY3RKvWBc8HGoeD0DkmpRoab
         3T9L/mbPQnaU9SPUXTUbuk0AHvwLTwiAXBE4FnQ2g/Kc1QT/2h8pWsn+0nzBWLB2SHlz
         rxMC2Ym7u2MA8+aPQ7wTo9RxTMWud3dDf+W31lxyFUb9GcseX/6PbZ60j9aGAg/nHdcT
         sk37kw9J0UfQ40f/Shjx26cMjTnPvPu6tqNb96gUEG1lidFNvX3FKF7AqIrOPhywWOoh
         nI6QyONQGHsCz/ASjKvMibmgNPJMNy+LqznnVkBgp6I6ObBTMJOd9+jEZLq+yz0aHb+T
         20/A==
X-Gm-Message-State: APjAAAW6x7o9+CJUy28y4crPs42qiBafz7hw6XM47kskfRvLUbDsVlsv
        BOZfuGR4o3aDOMOi9c/S4pA=
X-Google-Smtp-Source: APXvYqw62UkPTGBZzxxO0k7mcrtLrKHaWyIjtDcpJz4hT0z4eZdtDy5PPzabrsBLFSnpLchTcYx1Qw==
X-Received: by 2002:a63:35c9:: with SMTP id c192mr173085pga.140.1560820148612;
        Mon, 17 Jun 2019 18:09:08 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id f3sm6915303pfg.165.2019.06.17.18.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 18:09:08 -0700 (PDT)
Date:   Tue, 18 Jun 2019 06:39:03 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: rtl8723bs: hal: rtl8723b_hal_init: Remove set
 but unused variable
Message-ID: <20190618010903.GA7107@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable pHalData as it is not being used in function.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index b0cc882..6cfd240 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -4345,11 +4345,8 @@ void GetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
  */
 u8 SetHalDefVar8723B(struct adapter *padapter, enum HAL_DEF_VARIABLE variable, void *pval)
 {
-	struct hal_com_data *pHalData;
 	u8 bResult;
 
-
-	pHalData = GET_HAL_DATA(padapter);
 	bResult = _SUCCESS;
 
 	switch (variable) {
@@ -4367,11 +4364,8 @@ u8 SetHalDefVar8723B(struct adapter *padapter, enum HAL_DEF_VARIABLE variable, v
  */
 u8 GetHalDefVar8723B(struct adapter *padapter, enum HAL_DEF_VARIABLE variable, void *pval)
 {
-	struct hal_com_data *pHalData;
 	u8 bResult;
 
-
-	pHalData = GET_HAL_DATA(padapter);
 	bResult = _SUCCESS;
 
 	switch (variable) {
-- 
2.7.4

