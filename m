Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D76C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8007208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAkMWvin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFZRNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:13:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45668 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfFZRNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:13:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so1675575pfq.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CsaoBvUbxc4mMIWtj7F1FJyHfEKhGjA3BcDoeeu3Mi0=;
        b=KAkMWvinYM3WCFHMk5qD8sTYuPiJ3/ha66J2WkO+zyCEeGVcyyAaWZD+rTZsiZGU6W
         EPjWJzzObfouO3IGkNT3FeUOfWqU1H+1sWaFZvTx6Pqtfi9rQ9MD/sk/8wnPeGhLr2LS
         u7zyOVNZkIgfVbPMK4K1LtS54PXSYzMpflGC5tU1uBK8a8y5vfNra/yCMeCDSBIPHwFE
         31S2zy2gXEwJ4CDdANZ/pSK//T2CG2KyUA/MUdp55o4txqCWwzAvPOUPShqLvUR3xeuu
         r0iusCKOBhzgPn/h78UI96oVwout/9MtuQ3xKmQOjtLSdqqPIo+kpQfsDSrqVbsnjhjB
         VIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CsaoBvUbxc4mMIWtj7F1FJyHfEKhGjA3BcDoeeu3Mi0=;
        b=FpQ2TUhFA0cCKjB20PKZ9PyA5ALkJB7gTAYd3x8HWQ2JbP0MQCyJbAwWKUyIG58qnJ
         HZ+FRmzmsRp/38yYM38QlJZiGOa+TQIRW4COComQ6HL4r5crX3iFiD5tRho7xVaMhSmU
         +na+DY9wCtYzZf1vkHV6iG+IBIKhisNveGLtFjua85VaUj5M6ziM27ECGp5e8Vy38P7a
         h6Pga/Ye1z/jLq6uSm8WapbIp89OeOI9yWIzYWO0mLt0mBxAvYRMyliQjIJdl9JWmMh+
         10uKSLKkLq68TfVumc0a8QuGCNuDFVinQ+ww/sHwiadkN+il5odl80nj3ydJ6YbWWs1I
         Jt6A==
X-Gm-Message-State: APjAAAUhPSpT07eHXFcmtRXiAa1/fCXghEz4nf/Rl02zVUPw+MRtcMmd
        S2cYjE0S4bg1Cv6KZ2kruvs=
X-Google-Smtp-Source: APXvYqxBT+vxW7Vr9Ioed3EaYFrEGIu6rhm47wEvrFmZ1H9U8/Ee9r2s2rKeZ8U+uY1J56ij5tPRkg==
X-Received: by 2002:a63:f817:: with SMTP id n23mr3997244pgh.35.1561569222723;
        Wed, 26 Jun 2019 10:13:42 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id 85sm24709590pfv.130.2019.06.26.10.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 10:13:41 -0700 (PDT)
Date:   Wed, 26 Jun 2019 22:43:37 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: rtl8723b_cmd: remove set but unused
 variable
Message-ID: <20190626171337.GA6080@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but unsed variable pHalData in rtl8723b_set_FwRsvdPagePkt
function

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 48efbfd..1bd5f5f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -1434,7 +1434,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 	struct adapter *padapter, bool bDLFinished
 )
 {
-	struct hal_com_data *pHalData;
 	struct xmit_frame *pcmdframe;
 	struct pkt_attrib *pattrib;
 	struct xmit_priv *pxmitpriv;
@@ -1464,7 +1463,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 
 	/* DBG_871X("%s---->\n", __func__); */
 
-	pHalData = GET_HAL_DATA(padapter);
 	pxmitpriv = &padapter->xmitpriv;
 	pmlmeext = &padapter->mlmeextpriv;
 	pmlmeinfo = &pmlmeext->mlmext_info;
-- 
2.7.4

