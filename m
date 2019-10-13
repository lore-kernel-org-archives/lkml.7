Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEC8C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 13:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B2B2067B
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 13:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwiZ/6Ig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfJMNNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 09:13:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43042 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbfJMNNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 09:13:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id r9so12472412edl.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jSePMrNOPVfUktsu+z0HK6zACURlJM3IWN/zSmsSyQ=;
        b=jwiZ/6IgOGV/zKKtpKYw5tL4i/alBZHyx+XyUyLn13u+I2YtSB5xp13Odo+3f5zRya
         Rdps56gkm0JpAA4r6fV6SV6OBk6qCVM4YnnwrgrGTAeWlDhvGc9+x1dJhtJFhsrhz/re
         F3n4g3B2uTdFWATBQbyA+i077azBTu2BoJsGs7UGW4hl8kfl1ipyPggCulcq6eWpOLvZ
         hqbdrLG34pkFWmMYZXToje7SJVZfujQZExKDYYLtxTksfq4qYGBfcNez5KxdbTA27CCl
         7e5kZ16OF2VsRO1HvtfahYXBN3QDP0GXQ+MLals5jvYOOz+rlbWNC6fXGCUkf8ygVGPU
         03jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jSePMrNOPVfUktsu+z0HK6zACURlJM3IWN/zSmsSyQ=;
        b=tSMeCKIj4M7QTfbhPwG1YpElRbLy6ZYpZc82RsoYsDNZO1/wYwdlmvsL9ZK7wgMrQG
         r1DWOBnWknxERjscYKqxjDTuXMTNmj8SCoiuLOVZtLdIKgl+kjAO/sRMyzj9v/ortl/l
         k3XLIsEalToZhHL5PKkXdlW5CzUwlEYyN+RBYU07LKUj7IdJDoyheLdNUqHLntDLX7e+
         xaajoiK6nRqKw91V5qGWMs1X2l+wzl5N02W5jdyiOVLtL9tkiZy+tyJ+DggNA0iNBulZ
         E7yyRQU5fqAiTNt2ezVRczKCmxFvk3Xu+bLdJPE1jw3f8ZK/L4SRIArrqm+epV+K2a5G
         9New==
X-Gm-Message-State: APjAAAWt+1xiBSoAfD69jkRruEPXYbrqt0pCflE22VI+MJDbkr6yeVs2
        E25gvQrLigu44Vxv96UGXfw=
X-Google-Smtp-Source: APXvYqxWWqA5UWry8XyE0fcHakoGUWdBcpzyDV86cVZOdeo/x5sdE213x1k5SRcM89eNuzKC6ylDNw==
X-Received: by 2002:a50:a781:: with SMTP id i1mr23527070edc.17.1570972385970;
        Sun, 13 Oct 2019 06:13:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id u30sm2580520edd.18.2019.10.13.06.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 06:13:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: remove braces from single statement if block
Date:   Sun, 13 Oct 2019 15:12:48 +0200
Message-Id: <20191013131249.34422-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove braces from single statement if block to comply with kernel
coding style. Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 1ec3b237212e..e764436e120f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -2045,9 +2045,9 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 
 		while (1) {
 			do_join_r = rtw_do_join(padapter);
-			if (do_join_r == _SUCCESS) {
+			if (do_join_r == _SUCCESS)
 				break;
-			}
+
 			DBG_88E("roaming do_join return %d\n", do_join_r);
 			pmlmepriv->to_roaming--;
 
-- 
2.23.0

