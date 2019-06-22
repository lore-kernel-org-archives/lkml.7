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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1AFC48BE7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED05420665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qd+8j6h2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfFVQlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:41:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42125 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVQlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:41:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so5126908pff.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 09:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bfddTUlKO6se+VLq0VfMnq9Jkt0mYxtKJaFGDRxHeeE=;
        b=qd+8j6h2zxjzpicDhL90XpunLAbD3F7DpD27WMzsAJI7Eedu0VO2NKKwtDvkNvaXto
         eGluBun20fTxXsgI0MzUK5NW3JSJG1B+ZnEXl9NMjk5ln/A899sp28nNCKRBqlevihlf
         OoCCIHFC1bKlYq9C/SBsJFL1AHXqTPSmthEngKBDlHuZ3Zdyd6P+EbtosWOdHhseN+Du
         OMN2oV106VvIl9boTu/ZntjYyrzNMIL4lngDpwRuKpzNfixQCZHIr8qrZaQOs2p9h2Rq
         r7cYNxBLktcvbZm9v8V/rqW7rjEQpzG1tkGTGApqETx4DZ4mTzHIjy+u/mid+YajbSMj
         kzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bfddTUlKO6se+VLq0VfMnq9Jkt0mYxtKJaFGDRxHeeE=;
        b=KxNyR9mw2ULAGuz2hCbxq1BuWm0/mgxFjqy0Fh+C13FB382AE5AMcNwRAnCaVT6Fz7
         Ggp8FQZBj0VPCPiCQYLxpeRGgcpUFklbchafIvBtBUgz1lfIxF2wKev8qVU/YsaWKKPS
         KlvptX4Oj66CzHmwx2iz7rNWFfgzq2CAWfRFcdBhmVfJUwtk0LFZ8+wuqqJMCRQVsOix
         +p8IHazvDBAPCkwANWVicQbOkbIaMyAktr8W06mbwpjTjzV3ZYHXY/klpJiaILZwU0UW
         SMdAo31VowyjohS3B358nhlb2NuL4D6wLfO8F7xUSIT0r7mfeN68xv4hZvgHX5Zo4VFq
         hwgw==
X-Gm-Message-State: APjAAAU+e7exYnSSWLQTpbiShr7OxZUOF96NTN3as4rOSaldGgE54kIJ
        kih99ZVfJvvnwwoe45JYtEU=
X-Google-Smtp-Source: APXvYqz6/k67NNDcJEI+xl1saj4DMkIhRYpij+ZlCrOe4VQ0oRu6dZ1cuLVObCz6UN9zlWWNeaW1iw==
X-Received: by 2002:a17:90a:a385:: with SMTP id x5mr13803721pjp.76.1561221675861;
        Sat, 22 Jun 2019 09:41:15 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id u5sm5809161pgp.19.2019.06.22.09.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Jun 2019 09:41:15 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH 3/3] staging: rtl8723bs: os_dep: Change return type of rtw_init_default_value() to void
Date:   Sat, 22 Jun 2019 09:40:42 -0700
Message-Id: <ab71fb523942b596da4b7ec3782ce1c1a209b41a.1561220637.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1561220637.git.shobhitkukreti@gmail.com>
References: <cover.1561220637.git.shobhitkukreti@gmail.com>
In-Reply-To: <cover.1561220637.git.shobhitkukreti@gmail.com>
References: <cover.1561220637.git.shobhitkukreti@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_init_default_value() func always returns a value (u8)_SUCCESS.
Modified return type to void to resolve coccicheck warnings
of unneeded variable.

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 6b26af3..22d4461 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -601,9 +601,8 @@ void rtw_stop_drv_threads (struct adapter *padapter)
 	rtw_hal_stop_thread(padapter);
 }
 
-static u8 rtw_init_default_value(struct adapter *padapter)
+static void rtw_init_default_value(struct adapter *padapter)
 {
-	u8 ret  = _SUCCESS;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -665,7 +664,6 @@ static u8 rtw_init_default_value(struct adapter *padapter)
 	padapter->driver_ampdu_spacing = 0xFF;
 	padapter->driver_rx_ampdu_factor =  0xFF;
 
-	return ret;
 }
 
 struct dvobj_priv *devobj_init(void)
@@ -749,7 +747,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_init_drv_sw\n"));
 
-	ret8 = rtw_init_default_value(padapter);
+	rtw_init_default_value(padapter);
 
 	rtw_init_hal_com_default_value(padapter);
 
-- 
2.7.4

