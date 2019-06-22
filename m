Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B20C4646B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245E42070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfqIDfj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfFVQlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:41:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47000 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:41:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so4808522pgr.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 09:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=l2wsp1H9xOrGxDdquGp3vARZO0MhvnPC+Qbj0a1u17M=;
        b=mfqIDfj/J32XirJmicVYBku/OXNZqom4lc5ugwi/dg5YH25felbJEkyOoBT3GlOn0Y
         EbpdNgrDUPX2p7knV8bUNemmzZu30EFkCCTDAF+XKoaVisgCrzZPy+OttzMv0x8JKy8h
         gL2ZISdTUKVs7ESRK1HIb7cfPcS0ZAPenNIbipGyLgEDTVk9B6rt+uwZhakWG604eyXI
         HHjwtonFhBoVWWQ4AZyIpYHuk2ffgglPWmX3dyavPVK4y0J8Q2RarBAjxbVWmwELClmL
         dnX34Tz3h72h9Xf27CEvi4qPdKDApH8IMo0ynvoV4WHOzZP0Hg19Mb3j5yIiCRxzyFnL
         7KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=l2wsp1H9xOrGxDdquGp3vARZO0MhvnPC+Qbj0a1u17M=;
        b=TC0qzzMjJVN1SIJ85B3sBagTG2umn2lv+hHiKd1eQ68q2bkxb+Zh7d8/Ek6PAUfNLN
         ouRI9Tx86/UNXIFNDsZACgOwid4ByOsSX332MFiWOJD+7xqw98anWIGqX+YAZmbiP3ec
         4x+gvKg/nz1YW+ywaN9ItZWjwdNWN0UgdJRIu2G2Lya9d/l+6G500ptpcjuUiF4chE8w
         2hnh5i2bG+AFnp6WupMBrgAoNZ92FGz7azConNoLmogikWg687i3SRVHdH8+29ed3tsn
         woigfNvPyWrD7zz/hhWgZpQG4HLJwP1OOYN51JzDzg3pZko0T/GuWfB9DPEIiR9dG6XQ
         d9AQ==
X-Gm-Message-State: APjAAAU0jpEZAVh+D6f/tJWx6lpslznpjT76TEOqz+JHQzv62LSu3Ghd
        g4rPHylxj77+7yW2X0avhyRDxwEst/A=
X-Google-Smtp-Source: APXvYqzypeZfa87R5pF2W/G4L5xhDirSAvZ9qR6JTkbdStADrTSh1DriA+iQtHgx2GTGz/WlF1nebw==
X-Received: by 2002:a17:90a:30aa:: with SMTP id h39mr14039408pjb.32.1561221674185;
        Sat, 22 Jun 2019 09:41:14 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id u5sm5809161pgp.19.2019.06.22.09.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Jun 2019 09:41:13 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH 2/3] staging: rtl8723bs: os_dep: modified return type of function rtw_suspend_wow() to void
Date:   Sat, 22 Jun 2019 09:40:41 -0700
Message-Id: <5a28f7afe2c87f3478d9fc277b45337445ca013c.1561220637.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1561220637.git.shobhitkukreti@gmail.com>
References: <cover.1561220637.git.shobhitkukreti@gmail.com>
In-Reply-To: <cover.1561220637.git.shobhitkukreti@gmail.com>
References: <cover.1561220637.git.shobhitkukreti@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed return type of function rtw_suspend_wow() to void.
The function always return _SUCCESS and the value is never
checked in the calling function.

Resolves coccicheck Unneeded variable "ret" warning.

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 0fd84c9..96346ce 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -673,7 +673,7 @@ int rtw_config_gpio(struct net_device *netdev, int gpio_num, bool isOutput);
 #endif
 
 #ifdef CONFIG_WOWLAN
-int rtw_suspend_wow(struct adapter *padapter);
+void rtw_suspend_wow(struct adapter *padapter);
 int rtw_resume_process_wow(struct adapter *padapter);
 #endif
 
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index e1e871e..6b26af3 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1289,14 +1289,13 @@ static int rtw_suspend_free_assoc_resource(struct adapter *padapter)
 }
 
 #ifdef CONFIG_WOWLAN
-int rtw_suspend_wow(struct adapter *padapter)
+void rtw_suspend_wow(struct adapter *padapter)
 {
 	u8 ch, bw, offset;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct net_device *pnetdev = padapter->pnetdev;
 	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(padapter);
 	struct wowlan_ioctl_param poidparam;
-	int ret = _SUCCESS;
 
 	DBG_871X("==> " FUNC_ADPT_FMT " entry....\n", FUNC_ADPT_ARG(padapter));
 
@@ -1364,7 +1363,6 @@ int rtw_suspend_wow(struct adapter *padapter)
 		DBG_871X_LEVEL(_drv_always_, "%s: ### ERROR ### wowlan_mode =%d\n", __func__, pwrpriv->wowlan_mode);
 	}
 	DBG_871X("<== " FUNC_ADPT_FMT " exit....\n", FUNC_ADPT_ARG(padapter));
-	return ret;
 }
 #endif /* ifdef CONFIG_WOWLAN */
 
-- 
2.7.4

