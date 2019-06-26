Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C1C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333582080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My7eCbBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFZR35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:29:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46456 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFZR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:29:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so1696178pfy.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5T6JwdKRjR0/RiG3X8PeL3Pv8Cc3TnWD4IRh13Xy5ag=;
        b=My7eCbBlW0B5mb2GiL0BF8ubkmwJqvdlp2tjJodqd30zEwBuyaywestOcC28RB/fHl
         eWqpPYluiFgdQJnQ5cdPaifnUof2fwhquXW/5BbSuJrUrZvfU+F1QWXW7N8qvQRvepYz
         YuJkQJDQMoSFtGQ7zJtLkvhFrQ6V83tu+W1ALYoHtIHZBew3gtEM2P3hp4tnurJlS/vg
         CE+jLYwkZgBpNtUXa3L5ysct7ElmiI7l4Hb0u+LZVma+wMG6OLTrCEVuKDZJiJVaIFhe
         WHzIOALIYKaNa/uV0Ozs1qjve+pxiZpKu8Pa1KXzjfrqyRZkJ69xxlc5+Sf7y1oICyPd
         SY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5T6JwdKRjR0/RiG3X8PeL3Pv8Cc3TnWD4IRh13Xy5ag=;
        b=o6Iyu7FBk/L0Z9Qd9Pclq+p9oJ5mx5oYQtY2hFHJaG+m6cytRZBa+0UBO2Mo3Ex6Sx
         w++vMH7qFEg/f+sZrLrv/W5P6ciE17kcSXwBwuVfvk0m7Q6+jzfOnHoVInPjJPelip8I
         0FffMCrvcEGtzHGRomHwlEbP8Z/x/4LXEt3uonvQkYUWhfyds0/nqqTz7K5H4uMJsNpa
         +YCbv+pfzFn3m/dwLsUyWs9wXEeEkuuitgCETezJYZefm7OBj/axwdnfHin7FnwktzZp
         9OrawskIMiRwM2SFdB9HXIRxru5xP903QEEWtCaj13QNF3i0waAvTdkuk44R8x3So9Li
         CMqw==
X-Gm-Message-State: APjAAAX0KRf/uEpIPbaiXPou/hbsz7eDmuvG4fcWFh1c0fM060QPRyN4
        yYjp3r85cVvGMf4dTOEzImw=
X-Google-Smtp-Source: APXvYqzqQLv6YPA7wFT/1bH52+5xuqCsBHVv8kbrO5obSZEqzQEy5t8+odJ4iW8Nb9Gh6c2C+g2dmw==
X-Received: by 2002:a17:90a:be08:: with SMTP id a8mr190221pjs.69.1561570196512;
        Wed, 26 Jun 2019 10:29:56 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id 11sm30296257pfw.33.2019.06.26.10.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 10:29:55 -0700 (PDT)
Date:   Wed, 26 Jun 2019 22:59:51 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: rtl8723b_hal_init: remove set but
 unused variable pHalData
Message-ID: <20190626172951.GA7521@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but unsed variable pHalData in hw_var_set_mlme_join
function

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 6cfd240..8ca6249 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -3579,14 +3579,12 @@ static void hw_var_set_mlme_join(struct adapter *padapter, u8 variable, u8 *val)
 	u32 val32;
 	u8 RetryLimit;
 	u8 type;
-	struct hal_com_data *pHalData;
 	struct mlme_priv *pmlmepriv;
 	struct eeprom_priv *pEEPROM;
 
 
 	RetryLimit = 0x30;
 	type = *(u8 *)val;
-	pHalData = GET_HAL_DATA(padapter);
 	pmlmepriv = &padapter->mlmepriv;
 	pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 
-- 
2.7.4

