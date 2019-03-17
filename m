Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADB1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFD120896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHWZwE3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfCQSb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:31:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34241 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfCQSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:31:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id k1so14131370wre.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=tmad6UEivAM36OiZQwZuLuBdx+JVNNUEe2xoTGh/hEU=;
        b=oHWZwE3rATTMn1shhpEMUoJqQzLfxlFWTlg6eMgRjUiTba6bGzyQ7bkGI+nOCIBzFA
         fqKIGCna/+nO1WXoycrDo9Rlz0ikkAoHB/9WtpXQv5qVlpdXBo7fAjc9Sm0l4mWNxrAH
         L5jodhNRD4ZtDI8mLHhruyOFmfVa+VlrkpkLyPVL/UlkTEipV2LuGUpKB8BL9rg0uUDy
         R3S3sCShvYXYkjkOc/BUQHQLyLpEZ9Atpuh9xlxLcwAodfTNlZF26Dqs8fAmRu4EIhwu
         RTrz6309oeaVUV+G2EnwQxhsHgPQkeACB9t6VpgEkve/fuhUSuq4PbcPp4Iy4aJyM/Sg
         HfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=tmad6UEivAM36OiZQwZuLuBdx+JVNNUEe2xoTGh/hEU=;
        b=gh7dRJfPKt9HbRFlLq81ixeC3DVsx8ZAy4/6vMo9BFZAvaR+Z31w+3wwdCcIMObRbV
         FvMy2W0kVFrNt/IyrecP0aDZBOiZjd1Q1qbaMVHKM7jWj9okBwmeNRUzKJen7v+wo+Ph
         KWPc48ImUJskEPxx9e2D2doXUIUI5VOE+ZGO5C/8INJDOJtOfsVXJfmyX3QeNoG7HVZz
         iRr6PRuYmnA/RgBcXF5vma7HW3O411Zczieyg7oLk5R5G8dmljy38k+0T3DRjCmTi12E
         JeAUOO1pesJ6bL/NScUW/zUoscTMSihb8Xlf/a4oz7yfgnwTvNZ2cC5mbBsBZjc/hOTP
         C3lw==
X-Gm-Message-State: APjAAAVSR+BxTUUMPHaccW4+FgmaVxXgZ5SBFawOfjxe5+kUfEDUXiXw
        czaodze4aFQALxFnBT74AFsMPQ4Re7E=
X-Google-Smtp-Source: APXvYqx+C3iCMNVB4HYAyskB4hf/MQlIRwa2jnfD2a6uLmQDLKPUY9HwziPAKKFN9VJLjoMhmWBiNw==
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr10141392wru.67.1552847485852;
        Sun, 17 Mar 2019 11:31:25 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C9871AF900B43796A8F69485B6.dip0.t-ipconnect.de. [2003:c9:871a:f900:b437:96a8:f694:85b6])
        by smtp.gmail.com with ESMTPSA id q5sm8415358wrn.43.2019.03.17.11.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:31:25 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Thomas Avery <tavery321@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Florian Harbecke <florian.harbecke@fau.de>,
        Aymen Qader <qader.aymen@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Henriette Hofmeier <passt@h-hofmeier.de>,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/10] staging: rtl8723bs: Remove Dead Code in collect_bss_info Function
Date:   Sun, 17 Mar 2019 19:31:06 +0100
Message-Id: <20190317183115.32393-3-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190317183115.32393-1-benniciemanuel78@gmail.com>
References: <20190317183115.32393-1-benniciemanuel78@gmail.com>
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In `u8 collect_bss_info` is a ifdef-Preprocessor who checks
CONFIG_INTEL_WIDI, since this Macro doesn't exists anymore this Patch
removes the Dead Code in core/rtw_mlme_ext.c

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index ebb45acb4446..1f7c87e48c1e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4579,12 +4579,6 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 			pmlmepriv->num_sta_no_ht++;
 	}
 
-#ifdef CONFIG_INTEL_WIDI
-	/* process_intel_widi_query_or_tigger(padapter, bssid); */
-	if (process_intel_widi_query_or_tigger(padapter, bssid))
-		return _FAIL;
-#endif /*  CONFIG_INTEL_WIDI */
-
 	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) & 1
 	if (strcmp(bssid->Ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
 		DBG_871X("Receiving %s("MAC_FMT", DSConfig:%u) from ch%u with ss:%3u, sq:%3u, RawRSSI:%3ld\n"
-- 
2.19.1

