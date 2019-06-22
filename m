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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C65C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B4E2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRDkeEcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfFVPX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 11:23:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34794 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVPX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 11:23:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so5091622pfc.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=h80AaTSFvhmc0YkZ0rkDk0PBqR1tQ1utYB0+pTg7hDo=;
        b=FRDkeEcJbWKXNWXyNJaoCwbsKvdAGm7euu1rEsCxGLOqmdX4hKy1xJBO3AFM4PvQsZ
         Xyx/e+jpRM+PX3Jmh+e8zcEZVyAs6FSMaE+zgwDT08BtrIBs2p5oDW4PbBLx47QQIKup
         ELgRwW9xtlpCw0dYYVyFiQaJLncYkWZQNRTntyeV15Ndw2iBcjox3/DKrmJRtZh841sW
         ba9Ddq3Xh2rNuI4zNDZzNsRezUbkOv/CS6PkeOogrdyroQQ8+M4HpGCOGk4baIoWYEVF
         Yjr8R39iVSmq7SEqiBxz/oM+TuUZGGb0wSasrs4pZ6bG0oGi+4kBz5trGluFJmvIjR2b
         6Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=h80AaTSFvhmc0YkZ0rkDk0PBqR1tQ1utYB0+pTg7hDo=;
        b=TKKQerf/Ik9cTdE0PXpNXxRlq/KQJ62Gz6GpihocoxRjpLSPKSwt99ciTRyq8emmVp
         7e4yHuyciXMudWFEmx1pTzuQNgBzrfu9mpqIf0jaiv8aqR8oWtJcipY1L0myJniMGpS+
         9Faw41UODqkdUNzNrZ/okslws/dSVPvz/VC+aZbRvH38bQQoc1XfP1j5pDZKZ/u1jXjN
         lsp6Ub/zEl2cH1pZP/EkKIk6XnHlUSRTKygN+cMYrhWyzLf0RdMujiAiGTEaM4Cp56dr
         CnwbC3CfS9JLBvDmDynpernjIthkf7pVJgOvbIQsEpKfC7rXtNh8nlxFYqPpWaVdgmvz
         i7+Q==
X-Gm-Message-State: APjAAAUTBEiYhhPna8ClKoaYjDZYWqGnb6uCMUfTAUENLEqZMSQlVoFW
        jN6W0ftCN0bYI46KtX8b0hA=
X-Google-Smtp-Source: APXvYqyaAuWPIWUW27cEh9b/8XG86AYW25iim73AROxmyfihsGMAKh40FhwFmnLweKZpc1oOy3JGLA==
X-Received: by 2002:a65:6495:: with SMTP id e21mr23505403pgv.383.1561217036566;
        Sat, 22 Jun 2019 08:23:56 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id l44sm12496777pje.29.2019.06.22.08.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Jun 2019 08:23:55 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH 2/2] staging: rtl8723bs: os_dep: Modify return type of function rtw_reset_drv_sw() to void.
Date:   Sat, 22 Jun 2019 08:23:08 -0700
Message-Id: <eaf48808898ee0a0bb14118bced5a247bd0dca7a.1561215416.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1561215416.git.shobhitkukreti@gmail.com>
References: <cover.1561215416.git.shobhitkukreti@gmail.com>
In-Reply-To: <cover.1561215416.git.shobhitkukreti@gmail.com>
References: <cover.1561215416.git.shobhitkukreti@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_reset_drv_sw() return value is set to _SUCCESS.
The return value is never checked when the function is called.
Modified the return value to void to remove "Unneeded Variable warning
of coccicheck.

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/staging/rtl8723bs/include/osdep_intf.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c    | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_intf.h b/drivers/staging/rtl8723bs/include/osdep_intf.h
index 0ea91a1..40313d1 100644
--- a/drivers/staging/rtl8723bs/include/osdep_intf.h
+++ b/drivers/staging/rtl8723bs/include/osdep_intf.h
@@ -46,7 +46,7 @@ void devobj_deinit(struct dvobj_priv *pdvobj);
 
 u8 rtw_init_drv_sw(struct adapter *padapter);
 u8 rtw_free_drv_sw(struct adapter *padapter);
-u8 rtw_reset_drv_sw(struct adapter *padapter);
+void rtw_reset_drv_sw(struct adapter *padapter);
 void rtw_dev_unload(struct adapter *padapter);
 
 u32 rtw_start_drv_threads(struct adapter *padapter);
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index bd8e316..79d073e 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -705,9 +705,8 @@ void devobj_deinit(struct dvobj_priv *pdvobj)
 	kfree(pdvobj);
 }
 
-u8 rtw_reset_drv_sw(struct adapter *padapter)
+void rtw_reset_drv_sw(struct adapter *padapter)
 {
-	u8 ret8 = _SUCCESS;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);
 
@@ -737,7 +736,6 @@ u8 rtw_reset_drv_sw(struct adapter *padapter)
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
-	return ret8;
 }
 
 
-- 
2.7.4

