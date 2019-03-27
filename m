Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D954C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20DE2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvitqHl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbfC0GnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:43:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36594 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfC0GnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:43:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id p10so9268285pff.3;
        Tue, 26 Mar 2019 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Jy7F2QSsf5OTfixtg/4VNXIPeW3wBP1cuuaUxSIcMMA=;
        b=pvitqHl4Wz4/M52ef9EPVvoUKyFldCtAyYXHPqLkOPa7Cm9AKJcaCZTpzNFi/0WgEC
         4UEzFFsQO1no14cCUsLzjWjG9dAREb+PZVOw8TycPf/llHtecYio9Ef6xqPwLtQWVlgl
         KikSBKb8aGIXYgNABQuG8h98qBAHA/6+7Fg1yq9uhqbqSAVgJ1dPpMX7uLzIMNJS0iVg
         103fCgY9SuEBFnT/go6msGkhB6OLEVm+UytBoOhIWIHjr3N+dUnYBOhWk23ObMOy8XWX
         YVj1mGZyrjE5v6a3UL9NO5iPszGF4bqcPYWy+6Sm5YQJIy9CWnmN4sIEpj96BjjpMUoW
         PurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jy7F2QSsf5OTfixtg/4VNXIPeW3wBP1cuuaUxSIcMMA=;
        b=i1KXnvQsXG9jbHNTNCk5tuY/b9K33ouRbjHz9CZcfK5M/dwb6nfwWvaY43/L4DTbmr
         eJ9Z2okUDNUECdsRfiFNRJYl3PXHtmiUyaB0W9FxHXZsp0TAd5DbcqChd0qxnMGiX0Pe
         MpsuLwr86XIsmaT3D3vBoCv555GwJ+7JuA1Mt/FI3T3EkonZFarYsPVmOV3sQ/f7SxPH
         dJap/PXEesw/hQbcykV32ayWBfiJaIDICZTOcw0siCE9I7m9vxEKvppOFvwfjLOWXEd2
         8EPwdUuqpk57SGEcjvx+H2Nhpo9JFzhaU0/T9vFRzAHsG/ld+UgfwsUtqlmDL7ZctBa6
         1hqw==
X-Gm-Message-State: APjAAAXIXJqKnaZcb5HD/UbLmQaZx3WejMunzR/0Kv/STLw0Cu8TisyC
        pizYAAYXjkpnvVrpfbDpWdxQyh1q
X-Google-Smtp-Source: APXvYqzTL+Awbn/SXMSTQWAYApC+eFZm/MR4hORxtVsMRyCVa8BUjEF4CbGR8HWfpbuhuMvivjzzhQ==
X-Received: by 2002:a63:6bc6:: with SMTP id g189mr33157008pgc.427.1553668980149;
        Tue, 26 Mar 2019 23:43:00 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id q62sm25737760pga.32.2019.03.26.23.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 23:42:59 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V2 1/2] watchdog: f71808e_wdt: separate declaration and assignment
Date:   Wed, 27 Mar 2019 14:42:50 +0800
Message-Id: <1553668971-18801-1-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate declaration and assignment in watchdog_start()

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/watchdog/f71808e_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 9a1c761258ce..bd2ced9f39f4 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -338,8 +338,10 @@ static int f71862fg_pin_configure(unsigned short ioaddr)
 
 static int watchdog_start(void)
 {
+	int err;
+
 	/* Make sure we don't die as soon as the watchdog is enabled below */
-	int err = watchdog_keepalive();
+	err = watchdog_keepalive();
 	if (err)
 		return err;
 
-- 
2.7.4

