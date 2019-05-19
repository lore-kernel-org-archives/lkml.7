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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB6FC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29B8204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa1xhBGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfESRMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:12:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39631 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfESRMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:12:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so5612557pgi.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2aJVDwIx9CNCJgquAEUdJfowE2zu/TP85bAx23aqgcE=;
        b=aa1xhBGV+J6MUtB32Shj+5dPHvNdaqFAnSUVX2fFGJSKdL62Clq1dNrTbNuhBZxCOg
         19a+Bbu50onEJQS/Vqmzcjl47CKbkJ8sj5jM/NPFw5mrhv942OOjwHDJE0QhP1w+6zZf
         mPIWoXmcpbXCTQGFBnrnE6wMgKkap7wymXycMEkT9WWwv+aAd4xBQ5BqDP5M9X3PTxfZ
         n79Uj7yFVO/tdfrDtb121GelXnybzzqQZ6A8l8rsbGa4JkeEa05RH+Ora5oMf8PYj/v8
         axxgVQHGFBrCp1dC/dtFDbgvYfOaoRkkFrVJafB3kxZJmllbPEAU5bWDyIazb8YJKv5j
         TlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2aJVDwIx9CNCJgquAEUdJfowE2zu/TP85bAx23aqgcE=;
        b=D67yzSuKsDdkSsbdKJhT/XVMDRaSAIUN+VIdA7bloEKLw4JixvyAlWiERimGFXqO1t
         Tnl7pye4VUHyjcAn6g9rB3oA8LJPoFmwreq1F0yvppGU8TSG9EVmaEu7RiZ0M2zsqRsG
         ROfnKiHNweyN6xwYF1ZGogpgyFPWPiciu62IipRdc3zMLy354fwXW1CXTGNTOLYenh4i
         GdYK0EDLijbqL24tioiaA+3HRr3QmrlIAyckzMQaVmIcYsqvxE/l6dec4qdefXLRpvpg
         sIm4k9BNGwuRuV05b0zVfc0jIBjpWWGIpYE3KpXXvR7GvJD6hAqhJ/stv9RZP/orgdi3
         E9tg==
X-Gm-Message-State: APjAAAVEA6JguJkxwGvkT9bb68C69/71qe/tX3RhO3ITmxOVQUXkjpSz
        JgIjELO599TIAfacEmGuNERn5IF0oz8=
X-Google-Smtp-Source: APXvYqxsn5ZvQTyKQYV5eB5cw3Gz6/f1BFVE0KCPTTWYwjlRlpndUVeNuqyi3oOVshg2U+TQzzQflQ==
X-Received: by 2002:aa7:9289:: with SMTP id j9mr30426595pfa.251.1558285953896;
        Sun, 19 May 2019 10:12:33 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id c76sm28951727pfc.43.2019.05.19.10.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 10:12:33 -0700 (PDT)
Date:   Sun, 19 May 2019 22:42:27 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Young Xiao <YangX92@hotmail.com>,
        Aymen Qader <qader.aymen@gmail.com>,
        Henriette Hofmeier <passt@h-hofmeier.de>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: core: rtw_mlme_ext: fix warning Unneeded
 variable: "ret"
Message-ID: <20190519171227.GA8089@hari-Inspiron-1545>
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
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index d110d45..6a2eb66 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -463,7 +463,6 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, RT_CHANNEL_
 
 int	init_mlme_ext_priv(struct adapter *padapter)
 {
-	int	res = _SUCCESS;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
@@ -491,7 +490,7 @@ int	init_mlme_ext_priv(struct adapter *padapter)
 	pmlmeext->fixed_chan = 0xFF;
 #endif
 
-	return res;
+	return _SUCCESS;
 
 }
 
@@ -1885,7 +1884,6 @@ unsigned int OnAtim(struct adapter *padapter, union recv_frame *precv_frame)
 
 unsigned int on_action_spct(struct adapter *padapter, union recv_frame *precv_frame)
 {
-	unsigned int ret = _FAIL;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->u.hdr.rx_data;
@@ -1917,7 +1915,7 @@ unsigned int on_action_spct(struct adapter *padapter, union recv_frame *precv_fr
 	}
 
 exit:
-	return ret;
+	return _FAIL;
 }
 
 unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_frame)
-- 
2.7.4

