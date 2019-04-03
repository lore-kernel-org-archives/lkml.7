Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC03C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB372082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NpMRAqGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfDCVeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:34:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35443 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCVeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:34:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so126542pgf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVabg8vfpQdzoO1GOYLZ6s87p9khPMRcdnFHfdli2BE=;
        b=NpMRAqGn2uyOwkptaA9JfxSplN4MuWMrazo/aGDjyDVKYt3rZ7MMmpfVN7TX2PpNdR
         aSdLg5dXtHIhfYfY7K5hYLaSQEHYkt1ZsS0b2aXKEt0EGL8TY113qfGFs+uL7+JIupvr
         aP45J8OB1qPM0Lsr9d3oaZtHaXuKazBQqxUUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVabg8vfpQdzoO1GOYLZ6s87p9khPMRcdnFHfdli2BE=;
        b=Q1eO4ZPO332IBJd8x2fzSeTCjfRsdfaYkCMuFdPxtvu0BSVk3UYQilsSlehPERpfqJ
         FAZwvLFl8nUBCYIa9z7cB8DTQ2ATk06L13SkGvjkH0akWqbLW8Y6imuc/H2JMmuUyeUz
         E7I4Tb8Jwjd1edMEouEjYkuMd3+z+EjbBUYt46/0vD5p0rLN6Paf4IvySoEyLufOX7kT
         32mLWRSS5W2WdY+aaxuojQDOiwacFtCDP6em+wpIYRzDTsRDYB4Ha8uQPWaZaOX0LNwg
         vP3xJzr2qPkpxd2blCZpuA1tG8E3vEDjN/oAuL8l+wKc3GdD4bwkeCeh622+9vjoEVkz
         wMRg==
X-Gm-Message-State: APjAAAVrEZD8kE/SGWre2CnT1lUbwlrvF2KvEEeuKAewgTqlkLcpClua
        8UZwiDTE3rWTzxBofQABIWON/unDswyCuw==
X-Google-Smtp-Source: APXvYqz776fy/jobf2Hf0SC3Z7ehNvwqklV7Dpl4N9j3jz/dVocPM8A/rq/jh0JpWplDrflTWHz0ug==
X-Received: by 2002:a63:ed4f:: with SMTP id m15mr1877899pgk.387.1554327275508;
        Wed, 03 Apr 2019 14:34:35 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id k124sm21796741pgc.65.2019.04.03.14.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Apr 2019 14:34:34 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 0/2] platform/chrome: Add support for host sleep event command v1
Date:   Wed,  3 Apr 2019 14:34:26 -0700
Message-Id: <20190403213428.89920-1-evgreen@chromium.org>
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

Enric,
Gwendal informed me that his patch was rejected, so I'm sending this
as a standalone series rather than basing on top of his. The corresponding
EC code for this has now landed at:
https://chromium-review.googlesource.com/c/chromiumos/platform/ec/+/1501512


Changes in v3:
- Consolidated boolean logic for host_sleep_v1 (Guenter)

Changes in v2:
- Made unions anonymous
- Replaced reserved union members with a comment
- Removed unnecessary version assignment (Guenter)
- Changed WARN to WARN_ONCE (Guenter)
- Fixed C code to use anonymous unions
- insize is only bigger for resume events.

Evan Green (2):
  mfd: cros_ec: Add host_sleep_event_v1 command
  platform/chrome: Add support for v1 of host sleep event

 drivers/mfd/cros_ec.c                   | 39 ++++++++++++++---
 drivers/platform/chrome/cros_ec_proto.c |  6 +++
 include/linux/mfd/cros_ec.h             |  2 +
 include/linux/mfd/cros_ec_commands.h    | 57 +++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 5 deletions(-)

-- 
2.20.1

