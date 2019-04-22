Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8CEC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC02520685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrAM+2Pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfDVJ6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:58:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43933 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDVJ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:58:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so15208057wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdTM9j75NhUBAfq1HSuZFivH5A9OnIIYJtGi43TRu3Y=;
        b=YrAM+2Pj/hsCS+pH5ocsX5XhDaT5l1MdVykPsAY1pCY8GXjjG5/i6ZXYb3ey/NQFKY
         Njcs1OC7ibYhxU4LHtW/IxsklCYds4CQf6cGTaaojRU1scwCb4spZEtqqvA+9EJ1g7qb
         4sUiNr26OdfyeUMSyYfseNi6DldoZSQajs6s/NNUfihuYpMXyT1Zy6ams+nOsA/+bOjr
         BmJH6D/2P1bTEoqlkWOawrKbo4ZhX4sWcw/sScXLdgpxDWuAF23ecec/wM0JTTCyYF1T
         ShzPIOz+zgvnxWbQ98W0j5FzRG8KcoEhAxEXxIxrt/hrB3pB4+jxa1V/2VJeV1Z7FKuP
         lIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdTM9j75NhUBAfq1HSuZFivH5A9OnIIYJtGi43TRu3Y=;
        b=jJ2sPI01r+gLxrcV4cUl1Q0fNxV2SxuZFPVfQDedJuPP9B8V3QmGdQKLH6GxOKOBL8
         0N9sqBqJ9TeuVF4XwpYBWCZN9sMP44Dl9xZ0YJ4MR/67hNhyB6vIGyrvFrbkjvsaOxfH
         KyTHrqihnLU7vBLNgqVcvSm5bKS3rzQQ4W9tkuNFEdCNBONGcA8yEDn26WXTn3OjEK/w
         P0o3CQMoENE0cOmvn3RAEA0bYKeEwzFIsbraWM6mmbfy89RMH2bYXMvOpr0QGyPPJfvK
         y4FGhahUMUmpZk+FhYMZWGmga2vnDgve/j/CXrhs3koGePpm631hYwecOEyq39U6mxFY
         8Rhw==
X-Gm-Message-State: APjAAAXxSUXIvWUfaN1i8m9PUIQFgxmwCLYNF3wDEK7cgdFHvkS15cMl
        vaeuBSHotsH4Z9tWDaHTAWU=
X-Google-Smtp-Source: APXvYqyume96QzDjLcPTM3ZHn4fsFzmOjVADsUSs+2M8A2CkkRlqfV4qBWo0kssxm70BQ9m5VIp8cQ==
X-Received: by 2002:adf:e309:: with SMTP id b9mr8315609wrj.165.1555927116418;
        Mon, 22 Apr 2019 02:58:36 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb88.dynamic.kabel-deutschland.de. [95.90.187.136])
        by smtp.gmail.com with ESMTPSA id i17sm12923181wrs.44.2019.04.22.02.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 02:58:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: rtl8188eu: add spaces around '-' in rtw_cmd.c
Date:   Mon, 22 Apr 2019 11:58:25 +0200
Message-Id: <20190422095826.3119-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190422095826.3119-1-straube.linux@gmail.com>
References: <20190422095826.3119-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '-' to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 7bd38b3745c9..61da56a3bbc4 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -405,8 +405,8 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->ie_length;
 
-	if ((psecnetwork->ie_length-12) < 255)
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], psecnetwork->ie_length-12);
+	if ((psecnetwork->ie_length - 12) < 255)
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], psecnetwork->ie_length - 12);
 	else
 		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], 255);
 
-- 
2.21.0

