Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7796C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D96A2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoPhSAd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfCMIhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:37:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33339 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCMIhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:37:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id z7so767131lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MZr2k6g6z4ZB9yvwqMfa1ceioBU+Gv/DqU6UlU5ofaA=;
        b=zoPhSAd7OoYkC5voyrY3MdAM6iAYeQDAgMS6D2qiIr5+cSETkWBwfIOgdhZd860HdC
         TZ5DmkDBh1POBC44WWhdWNLjo56YNRNWFb9t44Z/4ggzIODvDyXvLbN2KSoqxQvg+JFd
         DukJUolF73y92LcLiNjHihva7L/2TcCHscIJEYEsCVOB9lwMhiyhcpb3byZ1yTpE7Biu
         qjnwW4id4UiCwqQCzJ+HZDmUhTccmbDHoUEYPotPe7/WiGX8xZTmyKNnNewRby53xpFR
         6lb5De/adP3z8h5ibAfhJuTUvbN6SUq4qWJQXX2Op5XRYesqZZFkbHqF9W8qNbrSa7IK
         KT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MZr2k6g6z4ZB9yvwqMfa1ceioBU+Gv/DqU6UlU5ofaA=;
        b=cxP+hyIUS1PiOA9wvXnOAkFWP9XGG1Itdeh+d4LD9zLapfwDgXwbHnlDgeCQOdgSni
         txIPLi9n6h3IlSuS5i3ySbpUCV10KxoOCN5yl3TfB9dbxxE8HjUcW5WEr679eItX4aNP
         fnwyNJ4iNNDRPOlczGqThhMYg56f1JkYvyQsYGE5SqMagaslfJHo0senn/o/XwvEx25S
         dPZLD3gBB8GkGLF38VwVATyU0JZ3jVeuPLP0GywdnlSxVNhzQXx4F7SGO4DWlEHmRWN8
         j6+0DCU6NQ01RfHa3Sd1A12UpubBmG47DAoxb7Szbl3lfwhiNsaB1Rfs25uLnVDJFItH
         JezA==
X-Gm-Message-State: APjAAAXnRTI+ZgCRjJwVjVLj3u/uDF3UMoSdcc4YX6GyorAIFiHu4IVk
        SKEe0lFdNSdsUIgYEgq4GjPn6Q==
X-Google-Smtp-Source: APXvYqwBB+MaFhXAmFaMUJgFRfuaC5Yh0EpcDTxBxyCaq0J809QCfbG4/wEr1kFv+duGt0WAVLmUvQ==
X-Received: by 2002:a2e:2202:: with SMTP id i2mr21301786lji.170.1552466225468;
        Wed, 13 Mar 2019 01:37:05 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a23sm1707716ljd.20.2019.03.13.01.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 01:37:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] drivers: firmware: psci: Some cleanup and refactoring
Date:   Wed, 13 Mar 2019 09:36:54 +0100
Message-Id: <20190313083659.7100-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
	- Drop two patches from the series.
	- Added acks and other tags, no other changes.

All of these patches have been sent earlier, but part of a bigger series [1].
Instead of waiting for that series to get reviewed and accepted, I have split
it up, such that these trivial independent cleanups can go in as a first step.

The only intentional function change, should be the last patch, where we start
checking if PSCI OSI mode is supported in the PSCI FW and print a message about
it, as that is quite useful information for the user/developer.

Rafael, discussions between me and Lorenzo for v1 concluded that these are ready
to be queued for v5.2 - and if possible, we would like this to go via your
linux-pm tree. Can you please pick it up?

Kind regards
Ulf Hansson

[1]
https://lkml.org/lkml/2018/11/29/1801

Ulf Hansson (5):
  drivers: firmware: psci: Move psci to separate directory
  MAINTAINERS: Update files for PSCI
  drivers: firmware: psci: Split psci_dt_cpu_init_idle()
  drivers: firmware: psci: Simplify error path of psci_dt_init()
  drivers: firmware: psci: Announce support for OS initiated suspend
    mode

 MAINTAINERS                                |  2 +-
 drivers/firmware/Kconfig                   | 15 +---
 drivers/firmware/Makefile                  |  3 +-
 drivers/firmware/psci/Kconfig              | 13 ++++
 drivers/firmware/psci/Makefile             |  4 +
 drivers/firmware/{ => psci}/psci.c         | 86 +++++++++++++---------
 drivers/firmware/{ => psci}/psci_checker.c |  0
 include/uapi/linux/psci.h                  |  5 ++
 8 files changed, 78 insertions(+), 50 deletions(-)
 create mode 100644 drivers/firmware/psci/Kconfig
 create mode 100644 drivers/firmware/psci/Makefile
 rename drivers/firmware/{ => psci}/psci.c (93%)
 rename drivers/firmware/{ => psci}/psci_checker.c (100%)

-- 
2.17.1

