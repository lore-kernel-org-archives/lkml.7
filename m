Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF2FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5831D218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mJJ9Z1/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfCTVUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:20:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46505 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfCTVUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:20:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so2571292pfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 14:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLFT8otiF3qbDJtenGoU8Taqeh/8zzCA8vs2YJoRSt8=;
        b=mJJ9Z1/+rVg/MuUGQ6bx5SVptRSG5LbB1xlQ3x5rz7nLHVtTpFypZEAf7JUC/koc7H
         g5OnpOGfSglELiB7EDFQo4towHBY4QEX89KS6Q23/DdP2XCeX70OuGXmWsNNaANR2aTh
         OwW7Pp5SJrTWR9pAG3NI3OqDeXJaUwvHLQMcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLFT8otiF3qbDJtenGoU8Taqeh/8zzCA8vs2YJoRSt8=;
        b=jXYP1/qXkBPlG5EQV1dsXIaRM3FZIu6CusnurfIN6/U1EsWNgsZ8Smgq8Ge7GZabOe
         JebbcaDy8p1jUyJjhDy3fY8o0Awmu+QDoK31WREYFYXkobe1wkZP34/QcV2FBuvEj/vp
         zeDuNEAsseD+PwYV6aLAtLcWReEeNYB+A+nEJqyJ6noi8geYyFBTvmtF4ysx7xpIhFq3
         k34J30j1k5YM7fzOLviT7OkegDtXAYGC1VCiBPCDLopd9giFpUM/dPSW57Z7at7PsDaj
         M/HRxQAkP4sbGKzE0GlbbhlGD3DwLU4jVFaF5+InNaS5qQ0i4g7Mpwzu10U1WWS8RzVC
         mPmw==
X-Gm-Message-State: APjAAAX1wY5aojXEmTRfiaZTJo8u/W4pKXgL2UYdZlSbyePTrNX57/Vp
        Cm3mzcv7tmiAk+RnDGY3LmW0Og==
X-Google-Smtp-Source: APXvYqwMd2IisHEiVeaiKRap1XD8hNxFIKYCOR+ewXfpqOhBTkaJVv2KbgGboIuU9kTgu63szp7rlw==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr10264262pla.177.1553116850768;
        Wed, 20 Mar 2019 14:20:50 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id u13sm5288609pfa.169.2019.03.20.14.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Mar 2019 14:20:50 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/2] platform/chrome: Add support for host sleep event command v1
Date:   Wed, 20 Mar 2019 14:20:28 -0700
Message-Id: <20190320212030.43682-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Chrome OS EC has an updated set of parameters for the host
sleep event command. With the new parameters, the host can indicate
a timeout along with suspend messages. Specifically S0ix suspend
messages are supported now, though the host command format isn't
specific to S0ix. When the EC sees an S0ix suspend host sleep event,
it arms a timer for the specified number of milliseconds (or a sane
per-board default baked into the EC). If the EC does not observe
the platform's SLP_S0 line assert within the specified timeout, then
the EC wakes the system.

On resume, the EC reports the number of transitions seen on the SLP_S0
line. The high bit is used to report whether or not a timeout occurred.
The number of transitions can then be used to detect cases of excessive
housekeeping activities, where the system wakes up out of S0ix temporarily
(unbeknownst to Linux), and then (hopefully) goes back to sleep.

This mechanism helps in cases where the system attempted to suspend
via S0ix, but due to driver bugs ended up suspending to a shallower
idle state instead. In concert with additional changes that detect
S0ix entry failures, this mechanism allows the system to quickly
detect and report on incorrect suspend outcomes.


Evan Green (2):
  mfd: cros_ec: Add host_sleep_event_v1 command
  platform/chrome: Add support for v1 of host sleep event

 drivers/mfd/cros_ec.c                   | 37 +++++++++++++---
 drivers/platform/chrome/cros_ec_proto.c |  9 ++++
 include/linux/mfd/cros_ec.h             |  2 +
 include/linux/mfd/cros_ec_commands.h    | 59 +++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 5 deletions(-)

-- 
2.20.1

