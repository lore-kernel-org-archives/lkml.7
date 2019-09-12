Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BA0C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FCF20693
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpikCFZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbfILLnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:43:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37223 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbfILLnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:43:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id r195so7305045wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qWyJzqvAlMobWBOwV84TIJK/7mR78qLFljNw2iai2k=;
        b=GpikCFZEyylw5f9E8A87RDuGOumm+W2OeNuk24B+SmRHZVmOGNCH8PQr8+/pNMfq0d
         1HbSspDZJifdwUFR26ynCGM3hOZkbyognj7zQSYymANtlgsSsKrIvxdf/Vzj0NLJqV0g
         WROTwuvDkBOYGFvGWKX7ZUFhsE9ImjOdKqKZDeDYbkSdTi2NTKxm5Tml2y5ALB3gBBVs
         7PsBv8NbkuFc4wYbRowazOj3M2DDxE/2Uj4VtHljyc7i5a2tneanddakI0hZj8YBVARL
         Ah+fCevZ1NdOxszhHzs0tscerO0n6sVT2cw7VnlC19A8bpDkEajok/6KKazQfSZfSVJK
         XhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qWyJzqvAlMobWBOwV84TIJK/7mR78qLFljNw2iai2k=;
        b=HCclAy+spHGDSgNAM5STsIPSo7Fmcl08vFyst8AYI5Xn2Vmo/pdINRMwuUgXi2q306
         ogV1roMW66myfc9iNuyZCmfQxY0B3NgoPQrAe/5vuBToIIe21noC0nwMFCHrDMZlmRSu
         pWHsxgqTDsxix19XwOXsZSmvSYZib3YqfYjbC0k8NRr8ppwzwIAFyxKK/y3QFHIwXVWa
         nd29HLvObeYNugTgrZNA8fOSiUGaPoe+UboGm8pYQnwQ2k8CC9HiEFcJLKCLb6G8mkcj
         YjClUaIwXMaCn6PG/0XZzyxeaatDOdmeGdLtZhegDiNb1/HCWKCH3bDwxlf93jBEJsms
         JQ3A==
X-Gm-Message-State: APjAAAUO1uRlHZnFRzNMFo1EdpWa76kUhKyxLNDCGHYzhdtfB4sovE+E
        bpXyfcH1ZhoMtO7m/bRZvBbRac8G
X-Google-Smtp-Source: APXvYqxQJNDvhUPj1LBZ1bHoKivBJHr8WZG4mqpwyi62mAotEWrGMbEIWQLyXh9Yw8zJQRC6blUOOw==
X-Received: by 2002:a1c:4e14:: with SMTP id g20mr8196245wmh.112.1568288589980;
        Thu, 12 Sep 2019 04:43:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id h21sm19074876wrc.71.2019.09.12.04.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 04:43:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: cleanup long line in rtw_mlme_ext.c
Date:   Thu, 12 Sep 2019 13:42:57 +0200
Message-Id: <20190912114257.17529-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove comparsion to NULL and unnecessary parentheses to avoid line
length over 80 characters and follow kernel coding style.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 18dc9fc1c04a..e984b4605e91 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -507,7 +507,7 @@ static void issue_probersp(struct adapter *padapter, unsigned char *da)
 		pwps_ie = rtw_get_wps_ie(cur_network->ies+_FIXED_IE_LENGTH_, cur_network->ie_length-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
 		/* inerset & update wps_probe_resp_ie */
-		if ((pmlmepriv->wps_probe_resp_ie != NULL) && pwps_ie && (wps_ielen > 0)) {
+		if (pmlmepriv->wps_probe_resp_ie && pwps_ie && wps_ielen > 0) {
 			uint wps_offset, remainder_ielen;
 			u8 *premainder_ie;
 
-- 
2.23.0

