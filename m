Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC29C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2297920835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kX8PvXde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfCGJfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:35:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37689 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfCGJfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:35:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id w6so16568708wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 01:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=hpdTVYyv+pay3S0TPETNXPWevRpOExmQA7j8Wk2JztU=;
        b=kX8PvXdeOiDHL1pKXkQjL+hfFW/6eWkxvbc/UN8DORQqyXQ8XUV/Gv43L1mly88XtK
         MHLEIw3IWcoGQPjyFlIMx2wOB+Yy995667Kl5jCLbsgNEwh6UYiuvPaw0vYkbHiogwhI
         ygAl01E1hAJndmwbq6kvag3N+k7tSzPo8e4eEI1skyFGltN76eWss7DYWqoIRy9Hq+aJ
         5cjLsIO5Zqv33kUu++kwekW4hBqIZJ0qqt1Yg7dsgkxMRJ547yIPqQfuRUKrwZbYUUmK
         ly/9NWfOttaxmcpJtZULa9C31+Y3iIP4DZTiVS8A1PQ6j90Uz6XFAJ+fQBvVgDRo023B
         +EyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=hpdTVYyv+pay3S0TPETNXPWevRpOExmQA7j8Wk2JztU=;
        b=bsmiw+Eu49dti5NWWERqDeNIf233w8nfntF4ENCN5NAKatUXVJ8snjalhMBR+XPsBR
         dHv8awuW7JER0cyJYWtEbm7MnZw0Jzk+yrS5B+lNHB0mQDnM50TVJk6p/lAnjBzD76u1
         apTnZj8a7Jf+KHmv7A2gDQ89jMpdxlPffWWwDsfdPtcjq8nCfavbN6kq1uQJYanIQ+b0
         5JqpOa/l1Hv5ERMTk9shavdJw23GMJvfRXTDFDolwO3lD/hqb8cC/R0ScC+6KlE2XCpJ
         1Iuh/sC+GzjutxsxqHjoCQqzb12RgEC5Lc6rA0DfhzHeAugH468V7CxmNlPZf3NQ837+
         1HTw==
X-Gm-Message-State: APjAAAUMVt26yuJK4kHjcspbEQs7n5E4sCZ9bSijhUQhgKyBZnewQvpq
        Hj0ON+qEZIXpCOqESrdrWcGToPRxOsc=
X-Google-Smtp-Source: APXvYqy4J8tDOV9xlHynCD1hP18CZ5AGYD6ma111hoFOr0ZaCEl/kck+PrxEmgZrsfr65fiuKpC1gQ==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr6055716wre.215.1551951298423;
        Thu, 07 Mar 2019 01:34:58 -0800 (PST)
Received: from dell ([2.27.35.194])
        by smtp.gmail.com with ESMTPSA id j5sm5675729wrw.59.2019.03.07.01.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 01:34:57 -0800 (PST)
Date:   Thu, 7 Mar 2019 09:34:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v5.1
Message-ID: <20190307093455.GC4634@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

Enjoy!

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.1

for you to fetch changes up to cec2b18832e26bc866bef2be22eff4e25bbc4034:

  backlight: pwm_bl: Use gpiod_get_value_cansleep() to get initial state (2019-01-30 13:37:42 +0000)

----------------------------------------------------------------
 - Fix-ups
   - Allow GPIO call to sleep; pwm_bl

----------------------------------------------------------------
Chen-Yu Tsai (1):
      backlight: pwm_bl: Use gpiod_get_value_cansleep() to get initial state

 drivers/video/backlight/pwm_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
