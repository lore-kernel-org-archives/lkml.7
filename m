Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FACCC19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F44206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpNcly7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388906AbfHBBrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:47:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33304 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfHBBra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:47:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so32903704plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lv/YL3fWYcrlgaCURXSs5Rp+POILoWLCMD+0ER71plA=;
        b=cpNcly7dwYKojxb0/zRsMqN8tD12gUNrsf4a79e+cJmqtCUxlL+RTTP+at3X8UzzBD
         tfsxe/GgZeLnUs+DRtoE2B+UWzkE8KL5/Sk1peURCN1D5cd7t752Io3YSx2p4DPH3R2k
         zIl31oIxigIjwk5kRhodoSmHHKVGGltO0+I4dwaVcJIDAmZ8MB4FxM200YFlJarf7ClJ
         nvdhYZctEp3drMM0UObGyzHtO1w/UTUuyuS361BDn+Ip7hx430ycy/49IXwp47wV+yxB
         qWLUOGSY18ugMfLZE5C1TsWf2d9p06TksH+s1qt02X9r0GqlrY7Ry0f41obqQAzSkis2
         81PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lv/YL3fWYcrlgaCURXSs5Rp+POILoWLCMD+0ER71plA=;
        b=SDMz8OoiKbYMjLM2CbTkmBDbbtE6knj6E8Md2XSIPYrNm1H6sCvgdrT8LAtstmwqwA
         7LPwdS9el2m5KxNfwqhqIVCEPkLodS2UBDROlCwC1biH9a3jQh8Yvsby5Do/GMSKjb4F
         Nlo8d/cUA/1EKVPmRQssCpA+mmPQ7eWJROn/kzZQVHb1brZI0UOpEOWy7bRM6WCOS7oF
         qRg3+7bjvyT1AwdP4+bkxBloY7M5ck2M3Xr76bgK89SmebDzVEzKmNX7Xxza1lpm0+h9
         3UvectdmNSOPwzKlPO4aTZpRspsCK1zu2etgnaJR7S5yf6vG6h0k81VqMPbVqGFxE1wY
         xcBQ==
X-Gm-Message-State: APjAAAWyVwI5ejLhzUO1CqXbuh3mLaTD3GOoqzaBBA5Tt26nFs8jiLgP
        AD+KIMQXOcLNw1Qn8XgDgwwPnc7YKffgAw==
X-Google-Smtp-Source: APXvYqy65mZu/oEqtCbSNW19hXmgQfXHPmcjfjjY5L8qPbo/hTSNpmCyFzjH+Zt6izNm6H/W+5EjKw==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr75073884plm.306.1564710449352;
        Thu, 01 Aug 2019 18:47:29 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id i124sm133657768pfe.61.2019.08.01.18.47.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:47:28 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 07/10] reboot: Replace strncmp with str_has_prefix
Date:   Fri,  2 Aug 2019 09:47:25 +0800
Message-Id: <20190802014725.9006-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix
to substitute such strncmp.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Revise the description.
  - Utilize str_has_prefix's return value to
    eliminate some hard codes.

 kernel/reboot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index c4d472b7f1b4..addb52391177 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -520,6 +520,8 @@ EXPORT_SYMBOL_GPL(orderly_reboot);
 
 static int __init reboot_setup(char *str)
 {
+	size_t len;
+
 	for (;;) {
 		enum reboot_mode *mode;
 
@@ -530,9 +532,9 @@ static int __init reboot_setup(char *str)
 		 */
 		reboot_default = 0;
 
-		if (!strncmp(str, "panic_", 6)) {
+		if ((len = str_has_prefix(str, "panic_"))) {
 			mode = &panic_reboot_mode;
-			str += 6;
+			str += len;
 		} else {
 			mode = &reboot_mode;
 		}
-- 
2.20.1

