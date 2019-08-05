Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6AFC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D8F20856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMZVytAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfHEMWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:22:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37432 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHEMWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:22:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1so6835845pgp.4;
        Mon, 05 Aug 2019 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnZJGZr/WPeKzWcVnuKXKMnqZkxEkSin124EXbUZO4g=;
        b=YMZVytApipzfRf/tfoqp0BMVYFmwPjqRNYChH3JThxyHrjHYuLpfNyQEX2O78uqhUi
         W/RvyEQhYxVak1D/Bg07x7JohNkuloEbuDOOEwOe9nFoBr/HGCjh8gafpmbS/JHPIsEm
         woT4LyUfMKl7D3LfuaS+L3xrKS4xwqVbyB4Sqi5vXyt+0FXzZzZip3OPnQZz7G+o9Hjg
         HGporvXaO5v53m18JncKk9X5jIKLFH9A6/rP9/uE8anO7a1j8XQMKygcubr9JI7JZrPO
         GLRJzYv5XovCufql9Rt1MZJ4huYKPH1C+p5Tylknt6p+CHRR8VHtjSUP6FNrxChvLgAy
         qe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnZJGZr/WPeKzWcVnuKXKMnqZkxEkSin124EXbUZO4g=;
        b=KRsN0q7jFW0Jahd3zC5zwKq2NbBjBRoVrZYwXqVoIP8U0w/tOpv2/6osYmBbswedox
         69LICmLtGjCGTvuiTkQubQC7zfegNjDmt4U7c+VRvuwUgxPNzuHfBjJmk+EoopG2D2I/
         iryl5dB0JAY8zHuJbmGht6l+MOI7QvT/WjMFi8sC2IZXMkH1N075WApwVHS9t/q5GiUN
         6brHxN1o9IN79BJx4uLhiQ89Xml35bgbhiIKNNfmMJQAvRr+IXr1p/zdPiE8TT4tVDzR
         CQmhSO+yuylYZhq32XosPSKqwkeesZkLr2k3Jk4rcObZ+GWMkf260cCPT0kNVpMLBI1C
         UHsQ==
X-Gm-Message-State: APjAAAWpMIWJGrbx0qrlnjp1JwDV+4E2kzigo8pT+IoWtSM9zUHJQAUz
        CPw9EC8fGo6BX/22E8r1sY0=
X-Google-Smtp-Source: APXvYqyKLr1RPFs4yDii4Xz8vPbeKw/8UkVo3pokS9Ud7nu9OfoV9R/f9UgtlPph92r+b13bjYgufQ==
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr135828216pgd.13.1565007773492;
        Mon, 05 Aug 2019 05:22:53 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id i15sm89514813pfd.160.2019.08.05.05.22.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:22:52 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3 3/8] PM/sleep: Replace strncmp with str_has_prefix
Date:   Mon,  5 Aug 2019 20:22:44 +0800
Message-Id: <20190805122244.12986-1-hslester96@gmail.com>
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
So we prefer using newly introduced str_has_prefix()
to substitute such strncmp to make code better.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v3:
  - Revise the description.

 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index bdbd605c4215..5e5f64bb3a43 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -495,7 +495,7 @@ static suspend_state_t decode_state(const char *buf, size_t n)
 	len = p ? p - buf : n;
 
 	/* Check hibernation first. */
-	if (len == 4 && !strncmp(buf, "disk", len))
+	if (len == 4 && str_has_prefix(buf, "disk"))
 		return PM_SUSPEND_MAX;
 
 #ifdef CONFIG_SUSPEND
-- 
2.20.1

