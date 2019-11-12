Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF37CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94B421E6F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpmujUOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfKLQzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:55:00 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35721 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:54:58 -0500
Received: by mail-qv1-f68.google.com with SMTP id y18so6663976qve.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=2tZEjGn9AWJuu90IGU4ZcEA4pxCT88LgEy8kCZaNDsM=;
        b=DpmujUOK6jq6CWVSZcXbA1KzGl36fGH709fFYkJ/eBAPnT8MlWyCi8sShA060UTer0
         fAZjVVHYP7z3r+OfzlgF23woZcPQsQtQ7bcd0iFp8zd7X9RY416oHa4YbLUiwFS5ZTEC
         2aRgeErFHr+ELCMFiHkjpx4WMn3WzRz1Ui9JhCuuq7reGHSgYm92rPzl6PYBehny08FH
         RaV3IA4e1LcWS2PFlCIbbR9HVdvtLLt/yNIt/cqWT8VRhnXIvlX4nY5kymXrSSYHw5q4
         XfQamktekRtTMUc/NU18F8jdMotNZeIKm7CxYRZbbX2boSmN5N69kRzsNE9pDODr9w/x
         wgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=2tZEjGn9AWJuu90IGU4ZcEA4pxCT88LgEy8kCZaNDsM=;
        b=Urur0tt5VAZjzrow+dabkx6cF9Xt+N75DeGurONjKs4gMzx2sU/ZJ31K21JB+n+kpF
         6LlcNIDsDOwzZmLUJPsbwPqW6K5+GGwMYV4NzoIKCR7IZP5Q2ALk7TXjOg4IROmmAErJ
         EFZ2mwFqCT03FjJHgznv4NS+NYKDP/YWSAbyVv1c79a4Or5h12BUpr+8fpitdrkKbcQF
         CUxDCmxOv2JjlL/QjaW/4ySY38KYOLgNgV+F2vzzlFlioGl/zq+E8a72Nn7EQ2ba03ca
         FbVqtNdFUqdztS9tonTAQXPIH4ChYmSoyngFC+Ocx1Z+PedrwdN2wL356vlNEzI7uX5x
         RKSw==
X-Gm-Message-State: APjAAAVWmtG02h6tm/uYnZVPr/13NCO8mlyhU5xcLyhBtDdZG4hkCeDs
        IFkUJOOiy/0hfBU4GZgSJCc=
X-Google-Smtp-Source: APXvYqwoScy0WlqRfDjc+A4Rw+iksAsbuM+AN5MqsXH2pBWhJ8mS9zYTGh7iR3Y2Uzau1X+j+hqnOA==
X-Received: by 2002:a0c:b064:: with SMTP id l33mr30129564qvc.34.1573577697611;
        Tue, 12 Nov 2019 08:54:57 -0800 (PST)
Received: from gmail.com (dynamic-186-154-98-65.dynamic.etb.net.co. [186.154.98.65])
        by smtp.gmail.com with ESMTPSA id h44sm14231832qtc.1.2019.11.12.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:54:57 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:54:55 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 6/9] staging: rtl8723bs: Fix unbalanced braces
Message-ID: <d208c4db5ed51f94e61f67891dcf1c102c5501d9.1573577309.git.jarias.linux@gmail.com>
Mail-Followup-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <cover.1573577309.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573577309.git.jarias.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes unbalanced braces around else statements. It also
removes an empty else block.
Issue found by Checkpatch.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 42bd5d8362fa..be0d83280e1c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -372,8 +372,7 @@ static void update_attrib_vcs_info(struct adapter *padapter, struct xmit_frame *
 	if (pmlmeext->cur_wireless_mode < WIRELESS_11_24N  || padapter->registrypriv.wifi_spec) {
 		if (sz > padapter->registrypriv.rts_thresh) {
 			pattrib->vcs_mode = RTS_CTS;
-		}
-		else {
+		} else {
 			if (pattrib->rtsen)
 				pattrib->vcs_mode = RTS_CTS;
 			else if (pattrib->cts2self)
@@ -1453,8 +1452,7 @@ void rtw_update_protection(struct adapter *padapter, u8 *ie, uint ie_len)
 		perp = rtw_get_ie(ie, _ERPINFO_IE_, &erp_len, ie_len);
 		if (!perp) {
 			pxmitpriv->vcs = NONE_VCS;
-		}
-		else {
+		} else {
 			protection = (*(perp + 2)) & BIT(1);
 			if (protection) {
 				if (pregistrypriv->vcs_type == RTS_CTS)
@@ -1847,8 +1845,6 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 		queue = &pxmitpriv->free_xmit_queue;
 	else if (pxmitframe->ext_tag == 1)
 		queue = &pxmitpriv->free_xframe_ext_queue;
-	else {
-	}
 
 	spin_lock_bh(&queue->lock);
 
-- 
2.20.1

