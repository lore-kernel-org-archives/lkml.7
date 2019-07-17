Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F84C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E933E21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMtj8j9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbfGQR4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:56:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36852 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfGQR4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:56:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so11523343pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5ZzkyzHu/9GruXdKeTYRFl7pejTn8WM+7V712xwIO2Q=;
        b=gMtj8j9qouvBU3wgRFzrTl5vpM7V2I0pGuJplwz8ASYq/NXhQuepN8g4pyvgCYuDZ1
         KpId1aj1ANWprHXYUXE2KpmqgcabUBaC2MB86AYSq4QAsA2qA03YT+jRoY59inL/xqaB
         +UPuab9jfYaf2io/XQH5ZByA4iQlEQ6vkxNLUGSGLH57V0T3E1p7pwfVjvvRzab6SzxA
         VL5JpiqTbeefJ1PnKh7THB3Vrqm/5m/ZXeTn8jNKSn+HF5bk4nDIs2Gf8yI1jZUcrX80
         DXA5bZyOCndr/ssgEcjYNubwGBTPnm9TgM+rp8T1B8WgNhE1ejML2IYmui7IiVQjbRk3
         he1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5ZzkyzHu/9GruXdKeTYRFl7pejTn8WM+7V712xwIO2Q=;
        b=SJ9pONcSecYqdRRvGTSTetpJcgKhuQ3hIiwEQ2TUeMReVyUmLRYeP1YFSgc7eMO+1L
         SKQ9z6+KmFcW9pUqcs+oxYCfMnAcmFj2Ouwj9JQLKsIyZkkzxYDRFXDOIKodXh9P5HIQ
         O3W4Z8x613DsmFgfglh6TNCZyWWMNHWRDdRCe91ZMNLkztN8aIqDnwtTfqHz4Y6UcPxR
         NKyA6uuVWe8AmeGom++zFelcumdPyBoRd4aUhcHVzcAidDXTNyTVX9VPgry4O7FWGd6c
         x6HN5Zfwcr6yvJyqO6Upw1urr+XPgPwcXDvTVyNlYkvL1ObaIfkJYGFa4jZh24qsbIHz
         KOCA==
X-Gm-Message-State: APjAAAVCukSO0WOC3osvQUzwnk4mwjFjafbd9w8DXsWOzlZoGkbONAtL
        d8rQYP81UxivYqMI/8RJUOg=
X-Google-Smtp-Source: APXvYqybm2s5X0roXllcEeWDBu1R1qHYnoYJ+cpHoGStf2x+lBDzFi3aqvzcqE3HW4KdtDHMwY/OEg==
X-Received: by 2002:a63:4c5a:: with SMTP id m26mr42052935pgl.270.1563386210373;
        Wed, 17 Jul 2019 10:56:50 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id t7sm20566932pjq.15.2019.07.17.10.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 10:56:49 -0700 (PDT)
Date:   Wed, 17 Jul 2019 23:26:43 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: os_dep: change return type of
 rtw_suspend_ap_wow
Message-ID: <20190717175642.GA10582@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change return type of rtw_suspend_ap_wow as its always return SUCCCESS.

Issue found with coccicheck

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 544e799..285fd54 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1361,13 +1361,12 @@ void rtw_suspend_wow(struct adapter *padapter)
 #endif /* ifdef CONFIG_WOWLAN */
 
 #ifdef CONFIG_AP_WOWLAN
-int rtw_suspend_ap_wow(struct adapter *padapter)
+void rtw_suspend_ap_wow(struct adapter *padapter)
 {
 	u8 ch, bw, offset;
 	struct net_device *pnetdev = padapter->pnetdev;
 	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(padapter);
 	struct wowlan_ioctl_param poidparam;
-	int ret = _SUCCESS;
 
 	DBG_871X("==> " FUNC_ADPT_FMT " entry....\n", FUNC_ADPT_ARG(padapter));
 
@@ -1409,7 +1408,6 @@ int rtw_suspend_ap_wow(struct adapter *padapter)
 	rtw_set_ps_mode(padapter, PS_MODE_MIN, 0, 0, "AP-WOWLAN");
 
 	DBG_871X("<== " FUNC_ADPT_FMT " exit....\n", FUNC_ADPT_ARG(padapter));
-	return ret;
 }
 #endif /* ifdef CONFIG_AP_WOWLAN */
 
-- 
2.7.4

