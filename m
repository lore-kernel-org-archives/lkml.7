Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E324AC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 16:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC86C206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 16:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWgXoMfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfESQ6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 12:58:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39852 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfESQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 12:58:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so6036797pfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=uOHbz+DwgepgwTxMGLbqewLAE0oXzfTmrvtxmoDPPc0=;
        b=nWgXoMfdrHftYK6fHFfMSoOKNLOH1lM+ykgVX+u9jyCWR1GGk1yqGG8Cx+dycje2v2
         /hUfCupLxLQOYbw/dp+cjSQDHP5bNHKmug3EuniBORbOwGWX51e8Kn2u88DbQZLQINjn
         nMrLm8+/emUYKMaN/CVozfh+DO7PZoUp8ayAwHJ+9zdWqzqnO18+dL8vWgJxV9TJMW+H
         g4642uqH2WOCCHUrAPOuxoVAuV2SLneOkZOrxihf2m1ZXhH5dyhibRNyi9aRlcgxqi4N
         ehhvFWU1lzCmaaoxVTe3QoYDBkN28FKd3BlihkBB5D2kffdZcloMvvs5OZRwAM1S4B73
         TVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uOHbz+DwgepgwTxMGLbqewLAE0oXzfTmrvtxmoDPPc0=;
        b=i8A913CsrpkLplJCTfGK4voqwutfdjlIBlnudZfBjqbneaIpQ0PRQkotyCQMunVJBX
         hemG4fv8JJU6u2Hoz9SSNB/t8K/5xfahrZ9ZljIJdHqclQYWH0o3DoxTazaXmLKI0KdC
         AFlqvDGBXEZSzVFc1q7D5/RDW3TT5IcKeqs2wZz8CFEMLJuL+akgCUZd0gqlrYVZB7hp
         CImLXRr64PtgZlD0uYZDF5cNLOcW5lgBQrkREEc2zLOz+Iqxyg32ZykTYHZ8YxmWop4Y
         d0uK5GTMnmVCvy+n8L9Tbka4l1kU14Q6D3vowZsMUySS4IDYidAnNlHZs4eHWvja2EmZ
         fP5A==
X-Gm-Message-State: APjAAAUqbGYTuaXKmyaSmpcLGNgXguw+V+wrWXjLa1+Mjzwei962lDRD
        qKnTi2THX5h/69MIwxCzPZoA8Ayz
X-Google-Smtp-Source: APXvYqyz0QIjyF3X+z2I2bbuS8+jmyk+CjlMiRgLJA/U9/2MWPtLXEYxMrTSTCsiwokGDoMYsnpjbA==
X-Received: by 2002:a63:8449:: with SMTP id k70mr69468888pgd.53.1558285084642;
        Sun, 19 May 2019 09:58:04 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id b16sm26112273pfd.12.2019.05.19.09.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 09:58:04 -0700 (PDT)
Date:   Sun, 19 May 2019 22:27:58 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: os_dep: os_intfs: fix warning Unneeded
 variable: "status". Return "_SUCCESS"
Message-ID: <20190519165758.GA6375@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warnings reported by coccicheck

drivers/staging/rtl8723bs/os_dep/os_intfs.c:228:6-12: Unneeded variable:
"status". Return "_SUCCESS" on line 333
drivers/staging/rtl8723bs/os_dep/os_intfs.c:607:4-7: Unneeded variable:
"ret". Return "_SUCCESS" on line 669
drivers/staging/rtl8723bs/os_dep/os_intfs.c:713:4-8: Unneeded variable:
"ret8". Return "_SUCCESS" on line 743
drivers/staging/rtl8723bs/os_dep/os_intfs.c:1379:5-8: Unneeded variable:
"ret". Return "_SUCCESS" on line 1421
drivers/staging/rtl8723bs/os_dep/os_intfs.c:1429:5-8: Unneeded variable:
"ret". Return "_SUCCESS" on line 1451
drivers/staging/rtl8723bs/os_dep/os_intfs.c:1300:5-8: Unneeded variable:
"ret". Return "_SUCCESS" on line 1368

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 8a9d838..71dfac5 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -225,7 +225,6 @@ static int netdev_close (struct net_device *pnetdev);
 
 static uint loadparam(struct adapter *padapter, _nic_hdl pnetdev)
 {
-	uint status = _SUCCESS;
 	struct registry_priv  *registry_par = &padapter->registrypriv;
 
 	registry_par->chip_version = (u8)rtw_chip_version;
@@ -330,7 +329,7 @@ static uint loadparam(struct adapter *padapter, _nic_hdl pnetdev)
 	registry_par->qos_opt_enable = (u8)rtw_qos_opt_enable;
 
 	registry_par->hiq_filter = (u8)rtw_hiq_filter;
-	return status;
+	return _SUCCESS;
 }
 
 static int rtw_net_set_mac_address(struct net_device *pnetdev, void *p)
@@ -603,7 +602,6 @@ void rtw_stop_drv_threads (struct adapter *padapter)
 
 static u8 rtw_init_default_value(struct adapter *padapter)
 {
-	u8 ret  = _SUCCESS;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -665,7 +663,7 @@ static u8 rtw_init_default_value(struct adapter *padapter)
 	padapter->driver_ampdu_spacing = 0xFF;
 	padapter->driver_rx_ampdu_factor =  0xFF;
 
-	return ret;
+	return _SUCCESS;
 }
 
 struct dvobj_priv *devobj_init(void)
@@ -709,7 +707,6 @@ void devobj_deinit(struct dvobj_priv *pdvobj)
 
 u8 rtw_reset_drv_sw(struct adapter *padapter)
 {
-	u8 ret8 = _SUCCESS;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);
 
@@ -739,7 +736,7 @@ u8 rtw_reset_drv_sw(struct adapter *padapter)
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
-	return ret8;
+	return _SUCCESS;
 }
 
 
@@ -1296,7 +1293,6 @@ int rtw_suspend_wow(struct adapter *padapter)
 	struct net_device *pnetdev = padapter->pnetdev;
 	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(padapter);
 	struct wowlan_ioctl_param poidparam;
-	int ret = _SUCCESS;
 
 	DBG_871X("==> " FUNC_ADPT_FMT " entry....\n", FUNC_ADPT_ARG(padapter));
 
@@ -1364,7 +1360,7 @@ int rtw_suspend_wow(struct adapter *padapter)
 		DBG_871X_LEVEL(_drv_always_, "%s: ### ERROR ### wowlan_mode =%d\n", __func__, pwrpriv->wowlan_mode);
 	}
 	DBG_871X("<== " FUNC_ADPT_FMT " exit....\n", FUNC_ADPT_ARG(padapter));
-	return ret;
+	return _SUCCESS;
 }
 #endif /* ifdef CONFIG_WOWLAN */
 
@@ -1375,7 +1371,6 @@ int rtw_suspend_ap_wow(struct adapter *padapter)
 	struct net_device *pnetdev = padapter->pnetdev;
 	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(padapter);
 	struct wowlan_ioctl_param poidparam;
-	int ret = _SUCCESS;
 
 	DBG_871X("==> " FUNC_ADPT_FMT " entry....\n", FUNC_ADPT_ARG(padapter));
 
@@ -1417,7 +1412,7 @@ int rtw_suspend_ap_wow(struct adapter *padapter)
 	rtw_set_ps_mode(padapter, PS_MODE_MIN, 0, 0, "AP-WOWLAN");
 
 	DBG_871X("<== " FUNC_ADPT_FMT " exit....\n", FUNC_ADPT_ARG(padapter));
-	return ret;
+	return _SUCCESS;
 }
 #endif /* ifdef CONFIG_AP_WOWLAN */
 
@@ -1425,7 +1420,6 @@ int rtw_suspend_ap_wow(struct adapter *padapter)
 static int rtw_suspend_normal(struct adapter *padapter)
 {
 	struct net_device *pnetdev = padapter->pnetdev;
-	int ret = _SUCCESS;
 
 	DBG_871X("==> " FUNC_ADPT_FMT " entry....\n", FUNC_ADPT_ARG(padapter));
 	if (pnetdev) {
@@ -1447,7 +1441,7 @@ static int rtw_suspend_normal(struct adapter *padapter)
 		padapter->intf_deinit(adapter_to_dvobj(padapter));
 
 	DBG_871X("<== " FUNC_ADPT_FMT " exit....\n", FUNC_ADPT_ARG(padapter));
-	return ret;
+	return _SUCCESS;
 }
 
 int rtw_suspend_common(struct adapter *padapter)
-- 
2.7.4

