Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB583C282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8847D20685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4ooDxDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfDVJ6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:58:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37492 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfDVJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:58:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so3501730wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 02:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJRpg3cNYwllvP1iYD9AWKgt68vnle6JLp+RxvHrM54=;
        b=d4ooDxDbqF4IMFRa0LTND58TMMwCS2e8Wg1a84APAGxqaHLarj2bTViotu+Aswh0cD
         zLy3esd1Fm1pCpM/7W0DlJmCaEii071153N+MTBn59YhU8pmvq1x6UZ00h5gjd3ae5QV
         EnK9qW9bgZuw4T+kBanxp2pbF5tX2BJ8sGXcEEnOib8TNDvXAhigZJ8OWrU5aJzP0zaT
         XOrK5mSnJg1L25q9z98dGmXvt4jt1LlOT9p4b2V/eM+VDfXMsK+UOH0R9zhGwdxATm+E
         /0AYhf34hWnPUUV0OmYHbb8Skg/F86m561etKMhVYoWnFpEV2QP0xAY43l1b7C239yjl
         I5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJRpg3cNYwllvP1iYD9AWKgt68vnle6JLp+RxvHrM54=;
        b=RWcp1ZH8DmrOsvnFl8a5By3yjcK4l2bH9dAh5HFbbnDx4BoAEkrSMcr/03EYb61lWE
         9H666NobFNhK41CCJdB/JBauLTa/WX/sWEAvVVcvPXVrow8lDaJ/mnCkh9xUwHFuQXv4
         ytOQ3CPnjDLKmPJ+TpeBmIyjfbsk9XvXFFTthlrYsHEeLWG+4zcpFBc2XgKitaQqjoAq
         EjaJPds9H68A8ST+53D9UFn0vs4E/HF1f3Euhd+68gtvtGWOmET6B3fJSjaEZtK8d8he
         +zMJ2mAQQ1Bg/njDiSGoaOgvPb1reSsgur7M91fO4ks7LubYILazsJpDw7h8LspghuB0
         IWzw==
X-Gm-Message-State: APjAAAVowEF7255mf5V+YCF30nndekF4JRYstgpImlY6JnmHvzG6JALr
        tEehiIwxuRkEXwsbSSa5Zm0=
X-Google-Smtp-Source: APXvYqzf7QuFkz99qpIFOswhn5g8KS02FNqMpDQVu17auw6hIWbZBAQEvbWVtZdQY8ziPwaHgDhhsg==
X-Received: by 2002:a5d:6a51:: with SMTP id t17mr12179092wrw.329.1555927115401;
        Mon, 22 Apr 2019 02:58:35 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb88.dynamic.kabel-deutschland.de. [95.90.187.136])
        by smtp.gmail.com with ESMTPSA id i17sm12923181wrs.44.2019.04.22.02.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 02:58:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: rtl8188eu: replace subtraction with result
Date:   Mon, 22 Apr 2019 11:58:24 +0200
Message-Id: <20190422095826.3119-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190422095826.3119-1-straube.linux@gmail.com>
References: <20190422095826.3119-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace subtraction with the result to improve readability and
clear missing spaces around '-' checkpatch issues.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 83a2e58aef53..7bd38b3745c9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -405,10 +405,10 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->ie_length;
 
-	if ((psecnetwork->ie_length-12) < (256-1))
+	if ((psecnetwork->ie_length-12) < 255)
 		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], psecnetwork->ie_length-12);
 	else
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], (256-1));
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], 255);
 
 	psecnetwork->ie_length = 0;
 	/*  Added by Albert 2009/02/18 */
-- 
2.21.0

