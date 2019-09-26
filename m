Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A728C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8ED721D80
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfIZPDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:03:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36414 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfIZPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:03:23 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <connor.kuehl@canonical.com>)
        id 1iDVIf-0007Xl-5t
        for linux-kernel@vger.kernel.org; Thu, 26 Sep 2019 15:03:21 +0000
Received: by mail-pg1-f198.google.com with SMTP id x31so1568126pgl.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 08:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FVKRXmx8SRBsU+0IWvQgA4/r5KeBrIiQqcBDYIkxnNs=;
        b=jeC1g62jS9bXC+4AgeNasmx0NQWD52+cYR+rYf6FK0YWkwAuHsSMXS5+AzsCdXU2lg
         0nDJM8GRGxZgqOtgXmvHp9PrLkqc+YsdIpGuwUW2/9yBcykS9iZmqDPBcbWWl/Ekkj9a
         bF8vg+8666z0IQ4vIe6NzCOLNlZF9MC+J7nSH+MdDxWx1iqhaQWpo4xdUpTOGCES9SRP
         muleZMrtzGOirAz8jxrXtjTOZxd7eqJXOJIySSEiZ0xT5wLDvyg7amBh5ZANnAUeraoZ
         4Tz0J3CtntM+/mCWAnUvmVW2Uqkv8GwLsD1QIFVyxctplNsWSaNNNsmM2sal4uVLmRQC
         xWIA==
X-Gm-Message-State: APjAAAX/bmGQQlXxToVzBwiTB3hQvpJSXJ4xIkLnd1G8hbrUMs/tBMCo
        d6bWxEyOO5X/s/YDB3QHvnIERDI8u/mZZ4RxF9rY/Ai+Dm1finN87oSA3zbGWnU204MwkkNgPH1
        MkVVh29AokzMWVe+EMmAU65M0prjvzkF+hohjilE2uQ==
X-Received: by 2002:a63:205:: with SMTP id 5mr3768388pgc.77.1569510199733;
        Thu, 26 Sep 2019 08:03:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwGYVioB4IbG1XfNiYKe+o084bQp5nriB3OlDVYJz5tA7ZRgTZbV6cYI1c8SsKqVdfHhAab3g==
X-Received: by 2002:a63:205:: with SMTP id 5mr3768358pgc.77.1569510199466;
        Thu, 26 Sep 2019 08:03:19 -0700 (PDT)
Received: from canonical.lan (c-24-20-45-88.hsd1.or.comcast.net. [24.20.45.88])
        by smtp.gmail.com with ESMTPSA id 4sm2174992pja.29.2019.09.26.08.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 08:03:18 -0700 (PDT)
From:   Connor Kuehl <connor.kuehl@canonical.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] staging: rtl8188eu: fix possible null dereference
Date:   Thu, 26 Sep 2019 08:03:17 -0700
Message-Id: <20190926150317.5894-1-connor.kuehl@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside a nested 'else' block at the beginning of this function is a
call that assigns 'psta' to the return value of 'rtw_get_stainfo()'.
If 'rtw_get_stainfo()' returns NULL and the flow of control reaches
the 'else if' where 'psta' is dereferenced, then we will dereference
a NULL pointer.

Fix this by checking if 'psta' is not NULL before reading its
'psta->qos_option' data member.

Addresses-Coverity: ("Dereference null return value")

Signed-off-by: Connor Kuehl <connor.kuehl@canonical.com>
---
v1 -> v2:
  - Add the same null check to line 779

 drivers/staging/rtl8188eu/core/rtw_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 952f2ab51347..c37591657bac 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -776,7 +776,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 			memcpy(pwlanhdr->addr2, get_bssid(pmlmepriv), ETH_ALEN);
 			memcpy(pwlanhdr->addr3, pattrib->src, ETH_ALEN);
 
-			if (psta->qos_option)
+			if (psta && psta->qos_option)
 				qos_option = true;
 		} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
 			   check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
@@ -784,7 +784,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
 			memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv), ETH_ALEN);
 
-			if (psta->qos_option)
+			if (psta && psta->qos_option)
 				qos_option = true;
 		} else {
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("fw_state:%x is not allowed to xmit frame\n", get_fwstate(pmlmepriv)));
-- 
2.17.1

