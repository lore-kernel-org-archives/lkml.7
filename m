Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC49BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7FD20879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKSYTSQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfEVRzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:55:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39453 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVRzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:55:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so1717782pfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+3r9XlOPnzbK3z3FjSACcbiHwzswR8weMh25pGyOfPg=;
        b=cKSYTSQ2RqjpU+ut04v7P9lRKYr4f/oXVOho0VAUSXsfjokUmRHHmAJx7uVYcZlFNs
         Yoc5pbMzio+/c3pI79Y/uIdRelADA99uqMUacQ39zHo7SvOntPdDl/554luQ61etlkSR
         OFNHxAn6e5RvdpcROYT+qpdJGhM0VUSXgeBro8mU7Nt7bpWpKF7NcsaL/q58AmsvElJi
         L5505DXVd0A+DfV+gOYChvqxkLQoGAEIX5XEJqmynoWyFHpkU3e91Dlu9L5G6c6aGswS
         yw7rllIaHJ1zWNQCgJ4JUBF08JbQliZ39cCCUMG/bYzTox+qxiHriI24xFi2cea548kG
         OiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+3r9XlOPnzbK3z3FjSACcbiHwzswR8weMh25pGyOfPg=;
        b=qD5ZkV31bHLmCMVjw2d3pskgyP+hk/VT1Dlbp322Tqv1zsUJ8JM0Xjr4dMF1vKMXeI
         lAoXaP6Md2J1mYYUbYSe8A8vZESD3Cge5xBlaXhcli3izf5agBXwb+ZKQVWFju2a7pIq
         pYDT+kO8SIs9+CrRJF6aaM/pXNbKPB2A/AHqeDHEhAQQvYhtzve619eXjkDcvj+RrzLU
         Q2LBa0sWPgul8bLCcdpzaPvQ4PiJXrzBzEs1I3fVYGNYRm13cXM5GrkqPRMYKQlhK+m0
         XvKeiwb98NiX4T+vYH5PSLGkeyReB7ovcTVjOfBaFrmCgUkYnEukdamffx5Y3oG7hixi
         Dgug==
X-Gm-Message-State: APjAAAUY9Y+C/8IFe42wNNKLPysAMMusfamDwxLLu1BovfGphNQfD/bh
        jqE2mdlVjcGVovmwZZ69Y/Y=
X-Google-Smtp-Source: APXvYqyikKBmSIVVx6oYXLSiiMTSDrugIobuXOc6xzwdi1VWYpkzMuV3zTuBFYnQ45LI4UEha21eLg==
X-Received: by 2002:a63:8949:: with SMTP id v70mr91990157pgd.196.1558547710213;
        Wed, 22 May 2019 10:55:10 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id u134sm36730992pfc.61.2019.05.22.10.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 10:55:09 -0700 (PDT)
Date:   Wed, 22 May 2019 23:25:01 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Henriette Hofmeier <passt@h-hofmeier.de>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Abeni <pabeni@redhat.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: core: rtw_mlme_ext: fix warning
 Unneeded variable: "ret"
Message-ID: <20190522175501.GA8383@hari-Inspiron-1545>
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
----
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ++-------
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c      | 5 -----
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index d110d45..b240a40 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -461,9 +461,8 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, RT_CHANNEL_
 	return chanset_size;
 }
 
-int	init_mlme_ext_priv(struct adapter *padapter)
+void	init_mlme_ext_priv(struct adapter *padapter)
 {
-	int	res = _SUCCESS;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
@@ -490,9 +489,6 @@ int	init_mlme_ext_priv(struct adapter *padapter)
 #ifdef DBG_FIXED_CHAN
 	pmlmeext->fixed_chan = 0xFF;
 #endif
-
-	return res;
-
 }
 
 void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
@@ -1885,7 +1881,6 @@ unsigned int OnAtim(struct adapter *padapter, union recv_frame *precv_frame)
 
 unsigned int on_action_spct(struct adapter *padapter, union recv_frame *precv_frame)
 {
-	unsigned int ret = _FAIL;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->u.hdr.rx_data;
@@ -1917,7 +1912,7 @@ unsigned int on_action_spct(struct adapter *padapter, union recv_frame *precv_fr
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
index 8a9d838..c2422e5 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -774,11 +774,6 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 		goto exit;
 	}
 
-	if (init_mlme_ext_priv(padapter) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init mlme_ext_priv\n"));
-		ret8 = _FAIL;
-		goto exit;
-	}
 
 	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
 		DBG_871X("Can't _rtw_init_xmit_priv\n");
-- 
2.7.4

