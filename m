Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51356C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 05:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FBA2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 05:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg7MyJPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfG1FmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 01:42:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43256 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfG1FmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 01:42:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so19261543pld.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 22:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=buMofwxOkYYhsDK0eLU1yJJUmsd8db28MJ/pExWSBQA=;
        b=eg7MyJPyXSj0crmZvoM+Nw1hSPE04RPglm7h8SSUaz29dUFvNrPXNmhRY/xt5aL6Ne
         E88rG2u5IjemWpaeA3mWWgloMSUBp+7ysnPWUqCfNLGwHUiEbehaEA6PC1iU9x5RXQmj
         A+y8QY03KVythRMZbex2NqosNzNZ71w2BHcsdIKygJfeFPO0x4gfgn329kDllFLIErC8
         oGNRI0NFOVGITyXmeITi0/9CQpKqGFQaz3Se7/ZYs+VyK4NJLU5R6Btp3iBXsGJzJUKN
         4LgJK2F27McGQRs3MSnKYjZlE26BHWai/S4LmuaxGVVhE8J/oXsn72H2HOnIjgI1LMTj
         HtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=buMofwxOkYYhsDK0eLU1yJJUmsd8db28MJ/pExWSBQA=;
        b=n7MB5b1qf4PLdMGLkY8gKpQJ8z1LOFe59hCeeMdhVqoWH82VzVpcsNQUYEmKfRiQU/
         MxQ/ep/uVx6NMDN/DeszjIfH/FjNiaBVUfY1a0tNeGO3GXBmSLP4qgvXf4AYGV5E7kVB
         j9D8ACesW2nMCmONIWf/zP8ku07L/0h8WMxPIVEhx9ei1VHyhtdP7Lh1j7sgHfY0lNfQ
         C38ulhHhyhSc7JRASGgXWy8sYn1Ft7PhUkHefRJs2vLzgKi1fnkxbWwrXxWXU+9gVRT8
         YTD4ZV2PJG+dAcG7OKcUA4TqaEQuOqvHAYTTIhkU+FQnVGQDslREXMXxHA1gM9hPysRd
         mXpg==
X-Gm-Message-State: APjAAAWeSP8YUO++2mlCJTGcE58XdKms2ckS5WQWH7jxndJ9INusKqo0
        MKJ8+gSR/AHmqL5+5NmqCWwxRANt
X-Google-Smtp-Source: APXvYqwdWN716V5I8Vj+QbqYjBfOm8S6hHr1+K+FaSPEOwRgTGLtWLXrJjCEA6fuKlq1JKOTAfh2FQ==
X-Received: by 2002:a17:902:e20c:: with SMTP id ce12mr107471089plb.130.1564292525239;
        Sat, 27 Jul 2019 22:42:05 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id 81sm90907498pfx.111.2019.07.27.22.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 22:42:04 -0700 (PDT)
Date:   Sun, 28 Jul 2019 11:11:57 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net
Subject: [PATCH] staging: rtl8723bs: Remove unneeded function argument for
 init_addba_retry_timer
Message-ID: <20190728054148.GA18881@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_addba_retry_timer does not use padapter, so only keep psta

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c     | 2 +-
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index bdc52d8..39c3482 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -262,7 +262,7 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
 			)
 		);
 
-		init_addba_retry_timer(pstapriv->padapter, psta);
+		init_addba_retry_timer(psta);
 
 		/* for A-MPDU Rx reordering buffer control */
 		for (i = 0; i < 16 ; i++) {
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 733bb94..186f4f5 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -539,7 +539,7 @@ int init_mlme_ext_priv(struct adapter *padapter);
 int init_hw_mlme_ext(struct adapter *padapter);
 void free_mlme_ext_priv (struct mlme_ext_priv *pmlmeext);
 extern void init_mlme_ext_timer(struct adapter *padapter);
-extern void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta);
+extern void init_addba_retry_timer(struct sta_info *psta);
 extern struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv);
 
 /* void fill_fwpriv(struct adapter *padapter, struct fw_priv *pfwpriv); */
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index 52a5b31..038036d 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -179,7 +179,7 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	}
 }
 
-void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta)
+void init_addba_retry_timer(struct sta_info *psta)
 {
 	timer_setup(&psta->addba_retry_timer, addba_timer_hdl, 0);
 }
-- 
2.7.4

