Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E800EC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96D7208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEYRVAIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfEENVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:21:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37258 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfEENVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:21:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so5091967pgc.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z5fRXYMiBfJg+xYTlW25WDAJSg5CjbHE0LcJsh4KODU=;
        b=lEYRVAICwQDfCGgSKs8ls/XK3kTO205p/cpmzDAepE+udb3TnaYQDONHXOE304Leyw
         b6jRQ/F+jUoa3WlW8lZaE9ezz2ilGSd4gZ23pxU++0GVRpkc6gv+k5cUGSgFRBjF7Qon
         PsjETso15VymXpahNHCoVKTEJ0nVfKrJFSVYTz9KxzXx8FmB7g8et5xC7u7K4wYzDTQS
         aOMSSYggepqqZ+3VPtC6apiqTg2C52X74Wo5NWDLzfgbXIkkkF80+CCrZ+qfOBtPmYRB
         r2XgUQE8K28RNBPG/TG08DLZWFQ4AxSveoaasRAa0mP8P6mw9bnqt2tBwwjhQ+vc2JSU
         R9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z5fRXYMiBfJg+xYTlW25WDAJSg5CjbHE0LcJsh4KODU=;
        b=Uq7q4uw1E8h4usip42rCxmH5pl6KbgRtkbncw8G8UJCHSS0vq/G1LWDP0DAS+MrF8G
         SuujP76QL+chSQ1Amm04vgWxs0Fj8G/iVC4pmOuztUiv2LOjAD6qnTlslp0E9cb/ptQ1
         G6Q8qKVKJnmsvihdeBG6bn7Nfwo5+7fNhVvUaYf+7phzbOGJb+w7GyCa/tZeRYoq/Pqt
         PjfMnCjxO749hkLxnzXsrHN1+iaz8SBdbxle3h7bftQ8EcUS0JqEIqlSKiSisCsF1vXv
         2YhPDp60cjri3oga9NehJMT7VaK8rwHjKspSVKv7hz3+YCfB+inDgZg6J0B3Xgti/gr8
         BCpw==
X-Gm-Message-State: APjAAAWdgavryXb3VmTwrxIDdJy3n8d3vz7GvOwO/dUZu8HEjRMNSdFJ
        0VWBOgoKy/qbzRyfJ/u9GB8=
X-Google-Smtp-Source: APXvYqzp9oa2+Rpbio5vyTL8sGBN3O24gITSVAU446JkvxrVsI0zEBsOkgLW/4Y7DHU2c7yrCC8AHA==
X-Received: by 2002:aa7:80d0:: with SMTP id a16mr26460182pfn.206.1557062471332;
        Sun, 05 May 2019 06:21:11 -0700 (PDT)
Received: from localhost.localdomain ([103.87.56.229])
        by smtp.gmail.com with ESMTPSA id f63sm14292239pfc.180.2019.05.05.06.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 06:21:10 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH v2 3/6] staging: rtl8723bs: core: Remove unnecessary parentheses.
Date:   Sun,  5 May 2019 18:50:53 +0530
Message-Id: <20190505132053.4345-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses after 'address-of' operator to get rid of
checkpatch warning.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index ac70bbaae722..1cf6229a538b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -277,7 +277,7 @@ void init_mlme_default_rate_set(struct adapter *padapter)
 static void init_mlme_ext_priv_value(struct adapter *padapter)
 {
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	atomic_set(&pmlmeext->event_seq, 0);
 	pmlmeext->mgnt_seq = 0;/* reset to zero when disconnect at client mode */
@@ -464,8 +464,8 @@ int	init_mlme_ext_priv(struct adapter *padapter)
 	int	res = _SUCCESS;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	pmlmeext->padapter = padapter;
 
@@ -609,8 +609,8 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 	unsigned char *p;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex	*cur = &(pmlmeinfo->network);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex	*cur = &pmlmeinfo->network;
 	u8 *pframe = precv_frame->u.hdr.rx_data;
 	uint len = precv_frame->u.hdr.len;
 	u8 is_valid_p2p_probereq = false;
-- 
2.17.1

