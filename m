Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E93CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9F0218BA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOyNo4Wv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfJTRA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 13:00:29 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43737 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfJTRA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 13:00:28 -0400
Received: by mail-vk1-f196.google.com with SMTP id i21so199316vka.10;
        Sun, 20 Oct 2019 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xTKcAHDsuXP3J9ZHHpeh3KHfStzUnhUUmFI7W4D55s=;
        b=HOyNo4WvAqisv+1p12J+bckQ+w3fyRj4Za0GVf9Gai7P9M2/MFs5LZI3bIHD4ycpEG
         YJu+xDgmwAjqKsfyEdEnXTw/fc23VDLNfZcvIKjrzytnKIh3yrFLVeCBT41bow7TdaXJ
         mRQ0lK3VRFXFZtJ0/a3W1bUlRJ7u+Woz3PYxOPoZSRPlATyCkLWqPMsceE3AeIKHJRdX
         qpucNtbVSJhjMpPopBwNJUgKxc4SlI/4kMkQGuteVJKnEXs+dPOGBFUDgdvh4V/tFxpV
         2TbOoZGFHX1yWnNYSjkTSehMPe1tJHn5Kn43kMQG8RBUMOei7xC1kZhgT5w4kh00Gd0L
         KL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xTKcAHDsuXP3J9ZHHpeh3KHfStzUnhUUmFI7W4D55s=;
        b=HGo8WQV18fEvFm8CjJuD++3nF6+Ci1z9kcdI8EwD+0+wr5e6IeuHUNUFUst3O7IGz7
         c15bd9F8Z+xeG0SdcBUCoQZoOD3wJTsRsSSagdfQruK73Fe7duSFcCjiAKjeXvCrx6vQ
         l9dRd3off06Vg7IKm9vmsi6hL/ShsOTeJ+QSPucM0SuRe7Yyd3XeoJOcYFboGNUHQtvF
         y+fg0nkeqHE50NjgnjvPW5bOcmx8dt92xXXdRYvLxeguelJZgTjJ51raaNqOcwO8ZVIK
         zePn+scD1r9bESO036u7rbpohyvLI/yr688imdGzR/ZUR5vnrvDMJaCSdLjtp3t/TzkJ
         7+gw==
X-Gm-Message-State: APjAAAUUD+fe288f2N8IzyMX+JAoVwLMhJuw61uGyvBzv6zhT7mP667A
        YzZuhcn7k8Pcut8NXO3aBg==
X-Google-Smtp-Source: APXvYqx8dy1VdnoJuEUxEP2aZNFtgDDh3RRXasgijwFdpUtwC5iTSuTjGxbRQehlW5ONyG9g40ukhQ==
X-Received: by 2002:a1f:a48a:: with SMTP id n132mr10687027vke.68.1571590827355;
        Sun, 20 Oct 2019 10:00:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:901:202:18cc:820:670:dd1:f572])
        by smtp.gmail.com with ESMTPSA id n126sm612962vke.51.2019.10.20.10.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 10:00:26 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Mattias Jacobsson <2pi@mok.nu>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/x86: huawei-wmi: Stricter battery thresholds set
Date:   Sun, 20 Oct 2019 13:00:07 -0400
Message-Id: <20191020170020.26251-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if battery thresholds are within 0 and 100.

Fixes: 355a070b09ab ("platform/x86: huawei-wmi: Add battery charging thresholds")
Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 5837d1b8693d..26041d44286a 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -345,7 +345,7 @@ static int huawei_wmi_battery_set(int start, int end)
 	union hwmi_arg arg;
 	int err;
 
-	if (start < 0 || end > 100)
+	if (start < 0 || end < 0 || start > 100 || end > 100)
 		return -EINVAL;
 
 	arg.cmd = BATTERY_THRESH_SET;

base-commit: c4b9850b3676869ac0def5885d781d17f64b3a86
-- 
2.21.0

