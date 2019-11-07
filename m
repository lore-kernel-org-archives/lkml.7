Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74092C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD032084C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKwslkrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfKGXDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 18:03:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38961 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfKGXDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 18:03:21 -0500
Received: by mail-lf1-f68.google.com with SMTP id 195so2900415lfj.6;
        Thu, 07 Nov 2019 15:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cK+IGE/NngSL6LBLRuXqj1unYMeLxTCgHc31IK6M3A8=;
        b=lKwslkrsJNL4v1PLGJZrcegy75UV5RHVX6XUeyPijUS4tmRMuRdVYJXfWHgKvx0KgR
         RiNAkIxR2jptJD6TVzDzptLXuphcHIz0kFuznCitiUe5laMr4ZWT3z1TJwLFIr/g3UDO
         cszNM6BNSCF5p52KY6LhcajulwHxwrT2EaaNE9DZ1bs8SVybFaiYVnMPK/VvnG6SP9bW
         /6JKd8ogNa0Xqf3PjQFV5hcYGA5Y5r6d9YlKah3tXanB0U4zpL0ks+d6CHX3idViD45x
         zhLwDArqFs8XvbAzgmWiSqRsPZpaojkZ2/JStPLCjnB2TO+2Do724hi0oGV0S6LduTOQ
         tG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cK+IGE/NngSL6LBLRuXqj1unYMeLxTCgHc31IK6M3A8=;
        b=cuLQFeW4i+HvXG3K5oQU6RYu8Ci9JF+woVMkaGbqLKgMv9LbPdHEfYQmyzLuO0Ok44
         qzIF/2QeMTXarTQJMucveXO/BuEm96CCKMxNDydvqx8U3VtqT8JSIgLWzY1dAJ4S4XWT
         63QOabVdb4L5FoSilJTJZTeLYHcI/4FvQ7dWBtqrQxRIqlpWX/5mB6i8mOpjXfeFNriX
         2gSNC/P6t9KTS+wQWv+X5kJA06ENuMhlDpqyE08G+TidxRLrgMTWW6Q1r8EOHyhRR3th
         56ZJ5TDNA1nqh58VMScIY4Mxw1rDbBkgAGlys65yPuK/ijzYAb91xSWeu2Yyk7NnF61a
         v1tA==
X-Gm-Message-State: APjAAAUsCxKBXZbAgURIN5jVmSln3+vM1LLWRPIGhVpejn/hDHSN+7hq
        SSrmTKD28aVzWV2z+AuAV4nAIVhC1GI=
X-Google-Smtp-Source: APXvYqyVy3mWTc9CsJ7XvhmCYLYNBk7jTG0og6zCvwMsLGHHyslKc4rXNAMV/oan1g1zzGVLcfgEXg==
X-Received: by 2002:a19:957:: with SMTP id 84mr4048712lfj.123.1573167799696;
        Thu, 07 Nov 2019 15:03:19 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id r7sm1560635ljc.74.2019.11.07.15.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 15:03:19 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v3 1/3] asus_wmi: Fix return value of fan_boost_mode_store
Date:   Fri,  8 Nov 2019 01:03:10 +0200
Message-Id: <20191107230310.30754-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107230105.30574-1-leonmaxx@gmail.com>
References: <20191107230105.30574-1-leonmaxx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function fan_boost_mode_store should return number of bytes written
but instead it returns return value of kstrtou8 which is 0 if
conversion is succefull. This leads to infinite loop after any
write to it's SysFS entry.

Fixes: b096f626a682 ("platform/x86: asus-wmi: Switch fan boost mode")
Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e01635..723aa4d969dc 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1718,7 +1718,7 @@ static ssize_t fan_boost_mode_store(struct device *dev,
 	asus->fan_boost_mode = new_mode;
 	fan_boost_mode_write(asus);
 
-	return result;
+	return count;
 }
 
 // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
-- 
2.23.0

