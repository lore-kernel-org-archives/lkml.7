Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9369C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB0E205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uefMKJlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfGORq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:46:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36699 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbfGORq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:46:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so8064208pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FFqgSG9F031m7mlilYz1OsMw1AHlab2cWn77ylXznWQ=;
        b=uefMKJlV21LOHRI6/JVyMde8pUMN/xGrUurNHabZhCTt3Gw7b3gFXxylWv7K/Ou1qR
         KRJCuiHuFlN0QWixwxJPO8zMZesdMk2kGqLPpFiK8jPjQ2xtHiIAg/vZwJgEMuiAJ0om
         X6QoyCAWVfuWaQBQlRTGNW6BEt2+0m0lXE/L5CHOQxonl1jjMDiLRvuFYY+cUNKj9+nl
         mf2IHz0qkNrKTBhVRuHyy2N3W8I/YxyNKCQ5/u3wodtHHcQN/UQfLIPxYDVU0nK9EN7a
         KvlIm+1yvpXID/T6ADwHhnvFq8hATQ9hOkDhriDYbrLbsUWmswdR8J2ep1ffb2UVICJs
         bSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FFqgSG9F031m7mlilYz1OsMw1AHlab2cWn77ylXznWQ=;
        b=eirWm7qgvxhBh4XcM6AN1XXxs4DIvN7HxRq0TzLv5jgjI6q0woX8uOpeiMdLXfZxSS
         s2Bs2SwMYmeR+Hv5RKIX1nFIX9CX/hV+ioGM+LDFj1DBiJXXqjECK9jMKq2mcygGjUNp
         1vspp1IaNThRzUGUpOJ1yQ9/yoV2HxNZAC6Tzrn30IkweJPetCG2Pklu71aGTcGytrTi
         ZvUGVxAvdt+jQ3W3o+mhxEJ32qYsxSZM5Q9Et2P+hh4VgsedhxRz+tre4SlduRshywzZ
         YOiXuBPWPyzCrip6m+0y5aRiUf8syjr7oK9fEDcDf86fdmmjf3tPKVfQQsoDlcTne1hF
         MMbA==
X-Gm-Message-State: APjAAAXTMcez3mP9jlphK3Qzf4MW61O7v1oGAqcNGrrGHRKO6PD+b+KW
        vE0veVGMVPd6v+HRrzMMcOQ=
X-Google-Smtp-Source: APXvYqzF0JAlj9eEdu7Ea7/EHvis6Cquh01Zz1aZmlfYgNxBiUIDto7s5HAKW/y7Lmp2gFyrvpvATw==
X-Received: by 2002:a63:4c14:: with SMTP id z20mr28098485pga.360.1563212787344;
        Mon, 15 Jul 2019 10:46:27 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id 97sm17195643pjz.12.2019.07.15.10.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:46:26 -0700 (PDT)
Date:   Mon, 15 Jul 2019 23:16:18 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: core: Change return type of
 init_mlme_ext_priv
Message-ID: <20190715174618.GA8947@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As init_mlme_ext_priv function always returns SUCCESS , We can change
return type from int to void.

Fixes below issue identified by coccicheck
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:464:5-8: Unneeded
variable: "res". Return "_SUCCESS" on line 492

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 6 +-----
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c      | 6 +-----
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 4285844..0629117 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -459,9 +459,8 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, RT_CHANNEL_
 	return chanset_size;
 }
 
-int	init_mlme_ext_priv(struct adapter *padapter)
+void init_mlme_ext_priv(struct adapter *padapter)
 {
-	int	res = _SUCCESS;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -488,9 +487,6 @@ int	init_mlme_ext_priv(struct adapter *padapter)
 #ifdef DBG_FIXED_CHAN
 	pmlmeext->fixed_chan = 0xFF;
 #endif
-
-	return res;
-
 }
 
 void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 733bb94..70cd8c0 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -535,7 +535,7 @@ struct mlme_ext_priv
 };
 
 void init_mlme_default_rate_set(struct adapter *padapter);
-int init_mlme_ext_priv(struct adapter *padapter);
+void init_mlme_ext_priv(struct adapter *padapter);
 int init_hw_mlme_ext(struct adapter *padapter);
 void free_mlme_ext_priv (struct mlme_ext_priv *pmlmeext);
 extern void init_mlme_ext_timer(struct adapter *padapter);
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 544e799..d2decb3 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -768,11 +768,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 		goto exit;
 	}
 
-	if (init_mlme_ext_priv(padapter) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init mlme_ext_priv\n"));
-		ret8 = _FAIL;
-		goto exit;
-	}
+	init_mlme_ext_priv(padapter);
 
 	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
 		DBG_871X("Can't _rtw_init_xmit_priv\n");
-- 
2.7.4

