Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AFACA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 13:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32835214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 13:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5YCU6c0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfJ0NGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 09:06:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55729 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfJ0NGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 09:06:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id g24so6675664wmh.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIE8XssdDi2D15V3zAvt/eEC5atPcZygXFN0pGgPoW4=;
        b=V5YCU6c0YaFSoVOLXUeBlkIVfmyzbRFjBosz5ee1KljrPAJdbemc22aK5+m4yPuZaP
         /X3an58nkOAXwMnio0/QFSumtp2VUYdRrlrvKxLeVuph9xHjzRHQADDrs9LOkygWW/Tl
         HTa2QFTDt2VIY7N1ARzhvTHIpdMnZGU1csZHyx8fyTNlnNHb26kaz2g0QK9fS5xMwLG/
         +r98BfbFdkzPZabFOY1DBS+t7MGfF5EHWWCGz8ozhyeu1SfJ+gyi3wALVbAlsUUXCoQv
         iP8XnA7D86lqSZZQbLnwkiIe+m2fP0gjuCbKyqv3hZ+w534PO1b/jcWN4FZnmhWupjew
         G1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIE8XssdDi2D15V3zAvt/eEC5atPcZygXFN0pGgPoW4=;
        b=Jzyxv0EBVnWLWFGcSqqeINFsSCqklx/GvNS5cOlmVqoXp1Zu3QUWHDFhmjpLNpKOsz
         H4ZFLS62eptL9PWkf3B1jpgdRB92wz77l+5t8qyWmbjNXzdWOPLrAIXyi7I6xHhWB3FF
         IOvzoK2sv2FG5qBip78+JbtuN+Qd0ZCoOLwEQKmZ8gO0zHfCRYiPsE/XNHqQSexDe9+8
         lNMEXUe31sTYAH0OQMF8XZ4YvlPt1GMovos7eUO07OCkHsONRT2M9mUGUEwB/bG94D4o
         aPbzb0/Ftf2mNnW2fO3yiOwmnSMvQobLmh8kKmyoPvq+fg4MQjeCRVGFFySI3iBZqfv9
         DTsA==
X-Gm-Message-State: APjAAAUVidZdye6YgxSLCme+3480H/8hfJV1QAuhxAxJGH2I9l8pU59H
        4OR45fobkzV5EMf8nTdmszQ=
X-Google-Smtp-Source: APXvYqw+rHqY8MyVMbrLRoK37aBhL4DbeoQPEB1GMR6L+lvLYeiKYBgu9qGh6zLgM08gBVDn4C+N5w==
X-Received: by 2002:a05:600c:228b:: with SMTP id 11mr11770998wmf.112.1572181591661;
        Sun, 27 Oct 2019 06:06:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id 126sm8127371wma.48.2019.10.27.06.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 06:06:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: rtl8188eu: remove return variable from rtw_init_bcmc_stainfo
Date:   Sun, 27 Oct 2019 14:06:03 +0100
Message-Id: <20191027130604.68379-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027130604.68379-1-straube.linux@gmail.com>
References: <20191027130604.68379-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable res, that is used to store the return value, from
rtw_init_bcmc_stainfo. Instead return _FAIL or _SUCCESS directly
and remove the now unneeded exit label.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 6c03068d7ed2..8b7adb9e76c2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -451,24 +451,21 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 {
 	struct sta_info *psta;
-	u32 res = _SUCCESS;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	psta = rtw_alloc_stainfo(pstapriv, bc_addr);
 
 	if (!psta) {
-		res = _FAIL;
 		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_,
 			 ("rtw_alloc_stainfo fail"));
-		goto exit;
+		return _FAIL;
 	}
 
 	/*  default broadcast & multicast use macid 1 */
 	psta->mac_id = 1;
 
-exit:
-	return res;
+	return _SUCCESS;
 }
 
 struct sta_info *rtw_get_bcmc_stainfo(struct adapter *padapter)
-- 
2.23.0

