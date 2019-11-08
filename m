Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C4DC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFF521924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZfpK+/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfKHQJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:09:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38866 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKHQJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:09:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so745961wro.5;
        Fri, 08 Nov 2019 08:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9B6l+33A/YE4NSu6Q04GW8I+W2ahCm/z4AJu3IrqsY=;
        b=BZfpK+/ilVoPH0Ae96MZL/uCc6IEOHMdNSNyjf9VYadxSCk+aPGZNMe3MWlFI45yTq
         PPiBBKQQR3As8HN/Ltxve2WZTEGBH52BLbQiTBnVrTpWO630b1mh8S7ouPHMwfaJZk/O
         3Lr72aNiVihLxk/9Kydq0yxz/aY3nEaTpoyGrjjLNsgHhwnio9dLuZLj4IxeUgXWd4jr
         jDzJz+O6Ml0zl+Q1Pf9qk7A8nAx4Vy6vu2cgLpHzcL6H9NH+SF1ByHSETzsyWeLkp1uI
         QPoEZvtKAgAGpM9+SxtetqieA8Mo+7kgKhs8G7csMMCqF+CQuHnyXXiGfnvThFWbykX0
         qzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9B6l+33A/YE4NSu6Q04GW8I+W2ahCm/z4AJu3IrqsY=;
        b=fWsyuTWFvm0io2zsNFTiApKaCHTvJ7LC9B8Dnl20V+vdbhrJSv0JFOgG+2jlcWIeTc
         0J7+t/uJ/7weor7SWaq/gIuQpBTLKIRKbFmNkT6IJJf+XlU26n9gfHg6KGI95mhB3CHH
         U1XxNmXrmxhwajB8OencBL4zZ7f0ij7XfAW3qwnEuQ4bCAl7xQYrBZxOU7fVJiam0eie
         hodKhSIJUpj8Bbbq0vwS4EncQoioYswahik3Kc+wcXtTzHSGPwHvRX8G26A6H9QWukH0
         F3+Sl7IuYkJWJTMUveMP3DenEJGGybWGRtpyxL1F5JX4Ra+Ikiu4njYlShGYb+Kl1u1m
         2gvw==
X-Gm-Message-State: APjAAAVlmpxM05Rcxs/P9dq3JKWS94g/i4NLvXdj5+TSLw6LVTQCkLsN
        1I6E+i8FA4BmSCe6YnynveQ=
X-Google-Smtp-Source: APXvYqzkmbLLVpxwSbeB5/VqBER7EduYsOe9lb6kp6oiiIgpIBoqIDbAV+PKUfkqW2aGJQcJ/OUo+w==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr9237051wrm.366.1573229348071;
        Fri, 08 Nov 2019 08:09:08 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id p10sm7665708wmi.44.2019.11.08.08.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 08:09:06 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: mmc_spi: Use proper debounce time for CD GPIO
Date:   Fri,  8 Nov 2019 17:09:00 +0100
Message-Id: <20191108160900.3280960-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

According to the comment, board files used to specify 1 ms for the
debounce time. gpiod_set_debounce() needs the debounce time to be
specified in units of microseconds, so make sure to multiply the value
by 1000.

Note that, according to the git log, the board files actually did
specify 1 us for bounce times, but that seems really low. Device tree
bindings for this type of GPIO typically specify the debounce times in
milliseconds, so setting this default value to 1 ms seems like it would
be somewhat safer.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/mmc_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 66e354d51ee9..74c6cfbf9172 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1421,7 +1421,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 	 * Index 0 is card detect
 	 * Old boardfiles were specifying 1 ms as debounce
 	 */
-	status = mmc_gpiod_request_cd(mmc, NULL, 0, false, 1, NULL);
+	status = mmc_gpiod_request_cd(mmc, NULL, 0, false, 1000, NULL);
 	if (status == -EPROBE_DEFER)
 		goto fail_add_host;
 	if (!status) {
-- 
2.23.0

