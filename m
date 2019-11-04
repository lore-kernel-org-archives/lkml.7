Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B598ECA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885B220848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7oKkHMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfKDVjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:39:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46765 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfKDVjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:39:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id 19so8252819lft.13;
        Mon, 04 Nov 2019 13:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iurp4sakzOCEdz++tzDZDRAOZsuv2t30XmhXJuaXI1U=;
        b=V7oKkHMo48znnhlUeslmupwVBtoFfTzrKpmJKOZ7+GR8cB5HkK5v7gRCY8oOU98ePO
         n6e4wnKhJBsl5lq/L2WafrwV1Dfir0Ya8UxYui1wSenHVF4Wvswm5YvfENhtwu+RUtWQ
         IKTFQquTERbrqyqDxEkhSPnQJDtG/ZhOPAfy/xTDPIVJO+pnoSSc8E8JSkUqij7J6aHy
         KDnRObG46BIz9gmsa3NS94PECc7oiZLEW2u/yjVNceqnymlaxu2m9iUX4eWU/yXg+iJg
         ZUKfDwzmbftjmPSBipp9q3rs5GU7ZVEF7HNQZ9c/0mwove38GXBDwXQA7AC7GYDm+I31
         BcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iurp4sakzOCEdz++tzDZDRAOZsuv2t30XmhXJuaXI1U=;
        b=IfR9TniLPVV9KEFpGGTeRWBAuY85XG1u3R4CzKQO3Je1r+rRqwc5Pn+sGK1SsJ93Hk
         RsPVK5O6bywVBLDbVD6lBzmMx/aiqR5h92pzasqndqbcsZpeJrLtJqVwOpd3eh/xrxvE
         lUpDxtp4hFxv4AwXho/d4bZ+WfTkuI+Sugf0bfD6sI/jnbN5jjNqAE3AcnTZKhQLUbd+
         g5f0c2KjeyD13ndl/VVsZnInNOi1bPhSGmX/1RjOBpbMcWWOVCXZLwTC6e5aJ1xez2KA
         uMe9Koql8qT0BLAvcCVXThMzCw6mI8SAVq/WT738ICPE55JLe4tcLYcAu7qewxyKgnBn
         7h7g==
X-Gm-Message-State: APjAAAUkNY2Gbf++x3UyilkR2h5aMcBFB9n8eUJe2d8TvAM9mldyNG9a
        D4Dbg3/tmDx7YPSPPmnDc61ySEiCgX4=
X-Google-Smtp-Source: APXvYqxy28+hFisUWybxv0Nvg95SfKtpcWfQve3kAeZQRS4e79YxeloNW8IjF2DPFEAtpBsPzPETvg==
X-Received: by 2002:ac2:48af:: with SMTP id u15mr17754498lfg.151.1572903558796;
        Mon, 04 Nov 2019 13:39:18 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id v21sm5708728ljh.53.2019.11.04.13.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 13:39:18 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v2 3/3] platform/x86: asus_wmi: Set default fan boost mode to normal
Date:   Mon,  4 Nov 2019 23:39:07 +0200
Message-Id: <20191104213907.18413-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104213417.18036-1-leonmaxx@gmail.com>
References: <20191104213417.18036-1-leonmaxx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set default fan boost mode to normal for multiple reasons:

1) existing code assumes that laptop started in normal mode and that is
   not always correct.
2) FX705DY/FX505DY starts in silent mode and under heavy CPU load it
   overheats and drops CPU frequency to 399MHz [1]. Setting fan mode to
   normal avoids overheating.

[1] Link: https://bugzilla.kernel.org/show_bug.cgi?id=203733

Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f4e5840..70c5fbb 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1674,6 +1674,18 @@ static int fan_boost_mode_write(struct asus_wmi *asus)
 	return 0;
 }
 
+static int fan_boost_mode_set_default(struct asus_wmi *asus)
+{
+	int result = 0;
+
+	if (asus->fan_boost_mode_available) {
+		asus->fan_boost_mode = ASUS_FAN_BOOST_MODE_NORMAL;
+		result = fan_boost_mode_write(asus);
+	}
+
+	return result;
+}
+
 static int fan_boost_mode_switch_next(struct asus_wmi *asus)
 {
 	u8 mask = asus->fan_boost_mode_mask;
@@ -2450,6 +2462,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
+	fan_boost_mode_set_default(asus);
 
 	err = asus_wmi_sysfs_init(asus->platform_device);
 	if (err)
-- 
1.8.3.1

