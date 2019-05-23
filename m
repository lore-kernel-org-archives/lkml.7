Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A776C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404C9204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="IxyjS7QI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfEWVHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 17:07:21 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:36376 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731666AbfEWVHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:07:20 -0400
Received: by mail-pf1-f177.google.com with SMTP id v80so3934316pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTioGuKOgNO6SwugnrEDEktz7xGxS3YWSFmCmowDiZ8=;
        b=IxyjS7QI/iWlVolD7qMxHAsrVnEz6vYW71ld0uA+5lDEvFXgNW5y/+Hovb10dtf0fk
         Pg6Q1W5Z978oA4Q50rBxaWG9aZoy1bha2AtsABYeJSCXvM8bvkBZe/H7yebqDH4tZPmb
         e3KCf7zt3QR2PwmHVAlWsefxzk/UkrygDd1Uaw5e8miN15gBHL6N1BLt2cSjBeE8pV9v
         0yEEQxhqQpHE+4rX9vVQHwlzDvEily5DxK5axwiUyupU/tLG3xoW/cechfBnsByTQiuO
         mLRIdBQbbuT12JKswtN7ln/DniAJ2Wb+AFrXu6zhCVMik0qJAZtehXqlyAZ0Ssage/4R
         /RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTioGuKOgNO6SwugnrEDEktz7xGxS3YWSFmCmowDiZ8=;
        b=B/otwtLq8ko0+MPBl1rRP1eRBojvHYq17391Lt4tqymvwn8SahxokJjKUae1WAPOAS
         IMwXi/M2ZKZkLtbfrvG1YiLM7ENuQ1NCBMryIzBYg70rwCc/Gs5MuphhbgII9zcdeeiR
         4IMYCcWJALtpZmz1ZyzksZjWjbm8yMJSWQB4EFxiaBzBWpQnAUoZVXswmgzOKjzfunpQ
         YqnXPq3qHuhsz0GHJgMWNJpTgoKHD97YJQq0DuR/ZoBq6vFMY2qmMeMLVdR48NMee2hc
         ReaZ5eAQeBNFWa5oJiO9fvmIMOcl3qtsQm8bTGejEYLZW9A69d4UW1cJPVwWHV5qTYyt
         ZHYw==
X-Gm-Message-State: APjAAAXbLU5MvwFKRB+GNXmfkbHS5tCNo6T7qL9fOfyAtTCBj+Q3rILR
        Y37xi+DTrkPDotk4vylwvSBDlzAuH5cdYZT8e7kmDg==
X-Google-Smtp-Source: APXvYqzuzYiOYVO1qbzCh4Aabm6AuxyJ016kEM0zJSXu1CU6EAU3utELN2tXg74h76qjcEGbSDT5iAY80582D/hn8Oc=
X-Received: by 2002:a63:550c:: with SMTP id j12mr5619579pgb.450.1558645640095;
 Thu, 23 May 2019 14:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=yYwk+g28_dnOcN--w-PLbGtA2oM5tq14W4X5bBjdurnF2iA@mail.gmail.com>
 <20190523174739.GY3274@piout.net>
In-Reply-To: <20190523174739.GY3274@piout.net>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Fri, 24 May 2019 02:36:42 +0530
Message-ID: <CAG=yYwmrE30nROqn63oAkXN9BCqfmo4T7+QPN-H3mSGG9dLU4A@mail.gmail.com>
Subject: Re: about selftests/rtc test related stuff
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, Shuah Khan <shuah@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 11:17 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Your user probably doesn't have access to the rtc device file.
anyway thanks related
Following is the result with sudo....
------------------------x--------------------------------------x----------------------------
$sudo ./rtctest
[sudo] password for jeffrin:
[==========] Running 7 tests from 2 test cases.
[ RUN      ] rtc.date_read
rtctest.c:49:rtc.date_read:Current RTC date/time is 23/05/2019 20:49:49.
[       OK ] rtc.date_read
[ RUN      ] rtc.uie_read
[       OK ] rtc.uie_read
[ RUN      ] rtc.uie_select
[       OK ] rtc.uie_select
[ RUN      ] rtc.alarm_alm_set
rtctest.c:137:rtc.alarm_alm_set:Alarm time now set to 20:49:58.
rtctest.c:156:rtc.alarm_alm_set:data: 1a0
[       OK ] rtc.alarm_alm_set
[ RUN      ] rtc.alarm_wkalm_set
rtctest.c:195:rtc.alarm_wkalm_set:Alarm time now set to 23/05/2019 20:50:01.
[       OK ] rtc.alarm_wkalm_set
[ RUN      ] rtc.alarm_alm_set_minute
rtctest.c:239:rtc.alarm_alm_set_minute:Alarm time now set to 20:51:00.
Alarm clock
$rtctest.c:258:rtc.alarm_alm_set_minute:data: 1a0

$

------------------------x--------------------------------------x----------------------------


-- 
software engineer
rajagiri school of engineering and technology
