Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20604C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E471620828
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyAAedil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfF2Kh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:37:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45577 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfF2Kh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:37:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so4206265pfq.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yoei6OKyQ32Hktc4WD0L2ybo+pYYJb/gMNDeW+rSA+k=;
        b=nyAAedilz8ZuPvbjrF4k/MssId+dVX8zigThjC6ez/Brb1UluWi/wnReWSOuu+CYp3
         byrAGIynauAw66ZxxePBZuVF2h6FR5wTS98mfr+kf1f7P2qDvx3TPFLUDKUrFXp74laO
         5413Xo9aK32KGU2aGZ8ZaSU/b8Bwv8GvQk75DkW4kd/ATz0rmElcsZut6fw6YsBih9Sz
         fOImWiJuQH6Qt8hrLYOxcbTEMfy+7Mctlau2M18GV9gtfk7oR34mceA0thuT8Vw5DB6L
         fpNYB7skxFGZ86gMEuBck8QzPPAMmItNhNCrk8qZahlZYvk9LSp67ErvtJaX2ERJCo0T
         o62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yoei6OKyQ32Hktc4WD0L2ybo+pYYJb/gMNDeW+rSA+k=;
        b=nVu7u+DYxpXsqI0nD3DP3lbL4lOM+Kh+m3tMwAq0jjCLbkJI0ck2WvWa8poJhLCjmd
         P/0m1xxOXcOuYBdZvrciNVd025yTosjxPWtWSlIs6WCfzawPXafpfDl6dwi8uoIpEusW
         0fLZ/GlFG+ihmwaiFpf2FjT9UjpamXa9Pa4gQmQ1q/N3A5C3Vg65FTZ25LPy+Lcf/BN+
         eQAqQT48Pc5tvZhws+lrQtZxHE5OnWnQwwu4rbgf0Aj4sDDTrO+QpfJg6a2IToaSaSnV
         +irc7z6u75LunHEr0WoITtxWCXvaO0YBgGwHYPdNvoZW0/ZgZVx+8OrFUewovm5G3/YP
         0tOQ==
X-Gm-Message-State: APjAAAWJTPVDHD62SisZTi1zP/t99qYBCogRoWt6ksX9QqqiJEhIkoP9
        zj7DZwpW30Imk4qAgLYrXIM=
X-Google-Smtp-Source: APXvYqyRcYwh9MdNCoo4/AH7YAApEf4gE7xMCCJfQoiTzZp0CZe6hLNb6wn/nRQ6w8AAfJudQfrV3g==
X-Received: by 2002:a17:90a:b115:: with SMTP id z21mr18830524pjq.64.1561804676426;
        Sat, 29 Jun 2019 03:37:56 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id 201sm5880808pfz.24.2019.06.29.03.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 03:37:55 -0700 (PDT)
Date:   Sat, 29 Jun 2019 16:07:51 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] staging/rtl8723bs/hal: fix comparison to true/false is
 error prone
Message-ID: <20190629103751.GA15649@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issues reported by checkpatch

CHECK: Using comparison to false is error prone
CHECK: Using comparison to true is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 66caf34..99e0b91 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -290,7 +290,7 @@ static u8 halbtcoutsrc_IsWifiBusy(struct adapter *padapter)
 	if (check_fwstate(pmlmepriv, WIFI_ASOC_STATE) == true) {
 		if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
 			return true;
-		if (true == pmlmepriv->LinkDetectInfo.bBusyTraffic)
+		if (pmlmepriv->LinkDetectInfo.bBusyTraffic)
 			return true;
 	}
 
@@ -310,12 +310,12 @@ static u32 _halbtcoutsrc_GetWifiLinkStatus(struct adapter *padapter)
 
 	if (check_fwstate(pmlmepriv, WIFI_ASOC_STATE) == true) {
 		if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
-			if (true == bp2p)
+			if (bp2p)
 				portConnectedStatus |= WIFI_P2P_GO_CONNECTED;
 			else
 				portConnectedStatus |= WIFI_AP_CONNECTED;
 		} else {
-			if (true == bp2p)
+			if (bp2p)
 				portConnectedStatus |= WIFI_P2P_GC_CONNECTED;
 			else
 				portConnectedStatus |= WIFI_STA_CONNECTED;
@@ -372,7 +372,7 @@ static u8 halbtcoutsrc_GetWifiScanAPNum(struct adapter *padapter)
 
 	pmlmeext = &padapter->mlmeextpriv;
 
-	if (GLBtcWiFiInScanState == false) {
+	if (!GLBtcWiFiInScanState) {
 		if (pmlmeext->sitesurvey_res.bss_cnt > 0xFF)
 			scan_AP_num = 0xFF;
 		else
@@ -1444,7 +1444,7 @@ void hal_btcoex_IQKNotify(struct adapter *padapter, u8 state)
 
 void hal_btcoex_BtInfoNotify(struct adapter *padapter, u8 length, u8 *tmpBuf)
 {
-	if (GLBtcWiFiInIQKState == true)
+	if (GLBtcWiFiInIQKState)
 		return;
 
 	EXhalbtcoutsrc_BtInfoNotify(&GLBtCoexist, tmpBuf, length);
-- 
2.7.4

