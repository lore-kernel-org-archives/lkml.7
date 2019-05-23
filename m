Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74405C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F712075B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+sioj7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbfEWRjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 13:39:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36266 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbfEWRjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 13:39:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id v80so3638400pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 10:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DdCWM/RhsOQBi0pr1uXjXm1hyU+XOF2nH7K19lGI0JY=;
        b=C+sioj7qmwJk1QSoOfsngDiuLJlK3EJNqH6i27UnfGSFTVnd8roo3H/X0MHVKuHyOv
         7mzjp+fg2SyOf98euai4crSM85/7N2g3AdSm+TAO9Ie47B/9wxjzzawW1bJVpY+HOdLF
         bU3gcjyKBmAp9B/mQIMGZq6LyI+1KCC/gJ4tGQl0WBUKXqKJV9Ut3HgYyLmqRBvyicKL
         SWkTglBEvsvn1VibOf1NOPzz94/22Tf2P53F95pviJxfOVSoenoaLzqgzdM1U7sx4hJE
         P6ga/YDTHl+x5QG9yevsWytRnqj08aVSYoAN8obtkWqtyLmHmElaxF0H96c/gs15Hr/r
         8o1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DdCWM/RhsOQBi0pr1uXjXm1hyU+XOF2nH7K19lGI0JY=;
        b=ErvkMS55p3zwYb9398a1/DMUxIqiqem2ZT/03usiuA8xAii9W/eQRFz2ThQaDf5gDQ
         UprbxPLSonldC1GL8/hvdAeuS0ha3CWqRNF8cw3WDwd2mF/NHpy6e5br/WC3hp1sMbub
         9UanApXu2+5133HIiUCVFPVZeOlRzlJkeR5zxmMS0ABe3MvWAdHM42d/hyENsff3UU6/
         IKLbL2yFvMY4u8WsrIolfD/pQVG6WINszxxnJNJhVqBQ/VovECxORo7qbfrXszHEJhsl
         zPcN7XxoPlWZ0s7i+6uPR+AVgtUi7nqXP97/uLmzv1MHB/96xLPUNPs9rSuFDGUBr+I+
         vMAg==
X-Gm-Message-State: APjAAAUxhaFLvAW+UR5w2X4Z9D2c2qQNwbtFFVeMKarq8K5J5QFJvYKS
        AhrAHXQhwK4VmnbPkbFKRL4=
X-Google-Smtp-Source: APXvYqw12QIYhc6B++mLMjMpKs3jMir9qCdWGSgMZ6dtTfT9Q1c16VGuWMiJbupO9QWp16A/JZJksA==
X-Received: by 2002:a63:130d:: with SMTP id i13mr98791173pgl.396.1558633187315;
        Thu, 23 May 2019 10:39:47 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id t25sm57118pfq.91.2019.05.23.10.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 10:39:46 -0700 (PDT)
Date:   Thu, 23 May 2019 23:09:41 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Abeni <pabeni@redhat.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v3] staging: rtl8723bs: core: rtw_mlme_ext: fix warning
 Unneeded variable: "ret"
Message-ID: <20190523173940.GA6591@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warnings reported by coccicheck

drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:1888:14-17: Unneeded
variable: "ret". Return "_FAIL" on line 1920
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:466:5-8: Unneeded
variable: "res". Return "_SUCCESS" on line 494

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
----
changes in v2:
                change return type of init_mlme_ext_priv() from int to
                void
                We cant change return type of on_action_spct() it is a
                call back function from action_handler.
                So directly return _FAIL from this function.
changes in v3:
		Dont remove initilization of init_mlme_ext_priv
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ++-------
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c      | 6 +-----
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 65e8cba..4b0129c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -458,9 +458,8 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, RT_CHANNEL_
 	return chanset_size;
 }
 
-int	init_mlme_ext_priv(struct adapter *padapter)
+void	init_mlme_ext_priv(struct adapter *padapter)
 {
-	int	res = _SUCCESS;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -487,9 +486,6 @@ int	init_mlme_ext_priv(struct adapter *padapter)
 #ifdef DBG_FIXED_CHAN
 	pmlmeext->fixed_chan = 0xFF;
 #endif
-
-	return res;
-
 }
 
 void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
@@ -1881,7 +1877,6 @@ unsigned int OnAtim(struct adapter *padapter, union recv_frame *precv_frame)
 
 unsigned int on_action_spct(struct adapter *padapter, union recv_frame *precv_frame)
 {
-	unsigned int ret = _FAIL;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->u.hdr.rx_data;
@@ -1913,7 +1908,7 @@ unsigned int on_action_spct(struct adapter *padapter, union recv_frame *precv_fr
 	}
 
 exit:
-	return ret;
+	return _FAIL;
 }
 
 unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_frame)
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index f6eabad..0eb2da5 100644
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
index 8a9d838..4afb35b 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -774,11 +774,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
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

