Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC63C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152DE2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5eVKL1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfCHVVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:21:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40928 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCHVVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:21:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so3609380wrw.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 13:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ne9yb9VUqbc5mhujnU04vF9d+jUVhs1WNFkzZ9SVc1I=;
        b=j5eVKL1YtiJo+d4hr1Y8V48gVOeI68d2COvxTtMyUTN2ne0EUUqkCxWw/rhq4x1jwV
         b5waafFFke5yiJCgmu0tIKVv42kGWWXctVwqaKoKs7vCVq8gwL3q+junKGytIIDPV3qF
         amCBWScoo7+1Yw3sWw3/Gu0pvSMPO0nu6DKmBzEVCR7gF2M7b58Am0C98i4wHHQ01qyk
         bb+CEJ/FhBXC6nN+v3e5/EQOp/RJ+VRT+yZ2L880aQ8Y7vPHkx0rN0sHV1O4wjBuLbMs
         QtDZ+NcYEjfBtngv4l3B18d5kJLllNbZFLss7FZNLSm0FJl6zlRMcXcq6oZYczUL2qx2
         KyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ne9yb9VUqbc5mhujnU04vF9d+jUVhs1WNFkzZ9SVc1I=;
        b=WUNkTX86s2uH8uVwh7QgKxmQm/RlexhSjsDVdnzGmcqaL0kN8BxL2928ho5F4/hUMO
         r7tq28QdZ+da3jLhQBfh8iw+aEihVLwuXwHBjSMbQ7lQod28fh7ZiKPyJsYN5SJk7Srl
         5vfeLeb67nHsQiz7Awt5f8rbNBMLm9C2R6PtSzxNCvG8KQQT23F/NshqTjXDcZRMrRFk
         lVqib8S+fTU+CzHT3jN8/prTxme0eXjW6vyxmUP0BivreVBI//F8PS5l93EwnjGKC6YH
         5/c0Gytj0IeVc2LFpTOBUyud79CQgfL0qy17t5EAD6G302HixgxP9hK5oVla/qIkWQCW
         WEqw==
X-Gm-Message-State: APjAAAUJhOP9qufhNGxlDCVHkwXPvP9tZOA9RBW61DjiRSXMaIXl3J12
        HAoh29WwNslR1CEismpxH6oPlQ==
X-Google-Smtp-Source: APXvYqy5sMQ046cz6qeeE/yGsSleSz0fXJZqOrl28rQBGCtM3B0TkZMqWr28/KDrvuFpKurv1+XvTg==
X-Received: by 2002:adf:f711:: with SMTP id r17mr4243207wrp.38.1552080063146;
        Fri, 08 Mar 2019 13:21:03 -0800 (PST)
Received: from clegane.local (246.127.130.77.rev.sfr.net. [77.130.127.246])
        by smtp.gmail.com with ESMTPSA id d2sm13568507wrq.94.2019.03.08.13.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 13:21:02 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net, tglx@linutronix.de
Cc:     ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] IRQ next prediction and mbed governor
Date:   Fri,  8 Mar 2019 22:20:44 +0100
Message-Id: <20190308212047.28767-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset provides the missing bits to predict the next
event on the the current CPU by identifying three categories of wakeup
sources, the interrupts from the devices, the timers and the IPI
rescheduling.

Initially, the interrupt prediction was based on the statistical
normal law, discarding interrupt intervals out of the gaussian curve,
thus allowing to predict only interrupts coming in regular intervals.
Unfortunately this approach prevents to handle any kind of irregular
intervals, closing the door for more accuracy in the prediction.

With a derived array suffixes algorithm, it is possible to quickly
detect the repeating patterns in less than 1us per interrupt on x86.

The algorithm is described in the documentation. It is simple in
in apparence but it needs some attention to understand how it allows
to detect the pattern and return a guess estimate of the next event.

And finally, a new cpuidle governor is added to make use of these
predictions for the different wake up sources but targetting embedded
systems.

Daniel Lezcano (3):
  genirq/timings: Remove variance computation code
  genirq/timings: Add array suffix computation code
  cpuidle/drivers/mbed: Add new governor for embedded systems

 drivers/cpuidle/Kconfig            |  11 +-
 drivers/cpuidle/governors/Makefile |   1 +
 drivers/cpuidle/governors/mbed.c   | 143 +++++++++
 kernel/irq/timings.c               | 488 +++++++++++++++++++----------
 4 files changed, 485 insertions(+), 158 deletions(-)
 create mode 100644 drivers/cpuidle/governors/mbed.c

-- 
2.17.1

