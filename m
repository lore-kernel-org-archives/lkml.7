Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5ABC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 14:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF542073F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 14:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+OD4E+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfKXOIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 09:08:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39758 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKXOIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 09:08:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id f18so8905188lfj.6;
        Sun, 24 Nov 2019 06:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djNoRlTWtwWVMyo0eztbYD8jcaOBK45bmqDNKrBX3ow=;
        b=W+OD4E+xl6FIPz9xKbR7vI/nBDy4v3vm2WSmWFBRLpogBWc+SsHwRwydh1evXXc1EN
         YIfS3anD0wN/Kg1e4j+/1ARXkZqc2E/TPm/TceqYHGUWy7tgMLx5rbgEQQokoj/5jhNf
         7+wM073BWI5qFuhHYeFrAOLRIRMKQnOigWlDp+mv31JscR2BUa0VtnQd36o2+op2p1Yh
         c7Vh905t7Ctx05VH5yy6fixfCo8VQECiuX8h47eUusjnM1qIowtnm72wlZG1FBzyzdHq
         8y/w6UAcqQq81MVzhQHYHOcGMa4chLOIIv41OfGM5efYZmZYq5fVVJb6vASbBRRNwVMY
         Dh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djNoRlTWtwWVMyo0eztbYD8jcaOBK45bmqDNKrBX3ow=;
        b=KWzobwUfsfQWruXlxWlmgRLvM+WVD/KLEOr04+bmGx1kIbDiHC9kDz7jv+MH0M38dw
         tEGxq3iHTdWRIifQwwCIHztu5a23R8tC4YbECpbxKysEM9qbYHOuxx8zPjfrMoXjWIjz
         NyNm/2PmHEdtYkd4GVCHySGMBEYqbh9gTQl25zgurt7/SVNa2QwfjLHoVAUTvIBOL0p6
         6dQDNK4SvFZblcNkYN7ihSvUQpDHkzG3MfacLR8EFG73DdtEeh4T95zXaMY86PUk5FUs
         lOElAjIpDOQJsy4hCNEh91QD7dBD/0GoUIJpkV9ErvzLTtUrwZTFtItQTgbQkCx3TtdJ
         8QLA==
X-Gm-Message-State: APjAAAUr5t1XXOrXl0tFD18e7nZjn/157LoXu+Hgr+WyAA9KoZficrpE
        76+kxDOuFOeZeewPZs07XpF+q8Uk4a0=
X-Google-Smtp-Source: APXvYqySRYbqTJAQgylFf4+k1D9oORKTVhxHwZ3oTPW3BcyKuowO1r82MV6ZxlVb1cMNvENtnO19GA==
X-Received: by 2002:ac2:4191:: with SMTP id z17mr6752629lfh.22.1574604532666;
        Sun, 24 Nov 2019 06:08:52 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id i8sm2000110lfl.80.2019.11.24.06.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 06:08:52 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        kristian@klausen.dk, andy@infradead.org, dvhart@infradead.org,
        corentin.chary@gmail.com, Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v5 2/2] platform/x86 asus_wmi: Set throttle thermal policy to default
Date:   Sun, 24 Nov 2019 16:08:41 +0200
Message-Id: <20191124140841.20929-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191124140625.20736-1-leonmaxx@gmail.com>
References: <20191124140625.20736-1-leonmaxx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS TUF FX705DY/FX505DY starts in silent mode and under heavy
CPU load it overheats and drops CPU frequency to 399MHz and stays
at it until reboot [1]. Set throttle thermal policy to default
to avoid overheating and throttlig.

[1] Link: https://bugzilla.kernel.org/show_bug.cgi?id=203733

Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 88faea6..fe571d1 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1782,6 +1782,15 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
 	return 0;
 }
 
+static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
+{
+	if (!asus->throttle_thermal_policy_available)
+		return 0;
+
+	asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
+	return throttle_thermal_policy_write(asus);
+}
+
 static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
 {
 	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
@@ -2552,6 +2561,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 	err = throttle_thermal_policy_check_present(asus);
 	if (err)
 		goto fail_throttle_thermal_policy;
+	else
+		throttle_thermal_policy_set_default(asus);
 
 	err = asus_wmi_sysfs_init(asus->platform_device);
 	if (err)
-- 
1.8.3.1

