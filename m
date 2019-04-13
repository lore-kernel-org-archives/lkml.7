Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCD0C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D39C214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EqmMlP68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfDMQgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:36:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33470 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfDMQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:36:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so15979770wrp.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eUlrZNmzEIhs7/anF1YSLhB9mWOmJ5DjO2LhLTU+ow8=;
        b=EqmMlP682lgyqRc3Nd3Gtx0Y58CU2naPNN0Y2efrH4jKu6osJ4o+gYv+0DQlXHXERG
         X3jijZ9lTNSYM5V4YqyHTvXPHRIzep0rlQJwFFN7hRadYhOBwMr5crHydTC7p+AucD5v
         tBnvAtn0GuYrrVUL8vhlwZwPY3vk3o6mUrQs20ayQJ2EP7AWmJh5JBfBmbgdwWYEZhvR
         0FXyKPzgbTHxDwxn19DcRyRIOMS84QgKtG73OJaqwdgjogdp2s0iBoEZMdNQxT0Z301x
         uIqa68wp5UjTk+aIW79uUP1VsNdBg1ZYggi/76EWcvP8ji5tYX/UAqfFySRIdBZWEahN
         JM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eUlrZNmzEIhs7/anF1YSLhB9mWOmJ5DjO2LhLTU+ow8=;
        b=KMClnAk+7f7+1I0sisMf8o8SC/uMYtRpAmEkoAhTnRLClrVOX/A/HRtIPgZP3cvA9l
         XCXr0/91G7fyP7x4OexKGpxgPPlUDi4ZrTfOAPo6OnyFQsoE5fA1Jfufo98ueDcZ96bO
         u/4c3TXHD3QDwZnrFvj3tgDSmTqZYAbxYeYTdF2zPCVEj9+jaK50Z+j0W9XJ1h3Uuzue
         rd0RdIgtocDg08E0Z1DbmIAo+Qnp08nxhU5zdaNGiNaYa+WFtw8VJ8Y1WMb+iJePWGn0
         fRX0YQEQ6foHkKibnkQ8+F601SxDERtdxyaxFQ/2f9TMa45BEMLkrYQ8U33B+AeL3uF2
         IjrA==
X-Gm-Message-State: APjAAAWyeJ3JKCnOwaEhITnrKk00tUshMwDBo+M8Xuqm8EuYThA1bhKa
        fN6xJcNLV0xTG+zKB3iq4L9Iq0VE
X-Google-Smtp-Source: APXvYqxMBvHoLeBzMx8VHk8xicAgEWnIX21exRLPUtQqjMRcCSFtPqruqVsddJO8tLHx6fe7/fuEUA==
X-Received: by 2002:adf:f286:: with SMTP id k6mr37373261wro.137.1555173395877;
        Sat, 13 Apr 2019 09:36:35 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD00714E418F6C82D049.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:714e:418f:6c82:d049])
        by smtp.googlemail.com with ESMTPSA id j3sm106200069wre.51.2019.04.13.09.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 09:36:35 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jianxin.pan@amlogic.com, ccaione@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] Meson8b: add support for the RTC on EC-100 and Odroid-C1
Date:   Sat, 13 Apr 2019 18:34:20 +0200
Message-Id: <20190413163423.15149-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the RTC on the Meson8b EC-100 and Odroid-C1
boards. Example kernel log snippet while booting my EC-100:
  [    5.713750] meson-rtc c8100740.rtc: setting system clock to 2019-04-13T16:21:48 UTC (1555172508)

I am only 99% sure about the naming of the clock in patch 2 and 3.
The public S805 datasheet from Hardkernel shows (on page 24 for example)
that clk81 can use "XTAL/32khz" as clock input. That "XTAL/32khz" clock
is described as a mux between 24MHz (our main XTAL) and 32kHz ("that
other XTAL").
I believe that this other 32kHz XTAL is NOT the RTC32K crystal because:
- schematics of the EC-100 and Odroid-C1 clearly show that the SoC input
  for the RTC32K clock is labeled RTC32K_XI / RTC32K_XO
- GPIOAO_6 has a CLK_32KIN function (shows in EC-100 and Odroid-C1
  schematics as well as the public S805 datasheet)
- Always On domain PWR_CNTL0[11:10] (public S805 datasheet page 19)
  describes it as "Alternate 32khz input clock select from GPIO pad"

Thus I believe that the naming of the RTC32K clock is correct, but I
wanted to point out that I'm only 99% (instead of 100%) sure.
Jianxin, please let me know if you disagree with my findings.


Martin Blumenstingl (3):
  ARM: dts: meson: add support for the RTC
  ARM: dts: meson8b: ec100: enable the RTC
  ARM: dts: meson8b: odroid-c1: prepare support for the RTC

 arch/arm/boot/dts/meson.dtsi           |  9 +++++++++
 arch/arm/boot/dts/meson8.dtsi          |  5 +++++
 arch/arm/boot/dts/meson8b-ec100.dts    | 14 ++++++++++++++
 arch/arm/boot/dts/meson8b-odroidc1.dts | 14 ++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi         |  5 +++++
 5 files changed, 47 insertions(+)

-- 
2.21.0

