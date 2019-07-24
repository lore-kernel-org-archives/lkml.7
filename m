Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD86EC41517
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8977B2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mEZCcqXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfGXRoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:44:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33805 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfGXRoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:44:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so22306040plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FywIt8OT1EMOTmIAy3WP8I19o2OF6ItVldkRoa+GCeY=;
        b=mEZCcqXmrsbuucn/hNwwIXPn5j2WCVleHq1CESFVUV7PgWBYf/h6QmiPd8i6NPokrJ
         b/o2wjS6n8clWUT0PXJupulFfXPSQfONE58pm/ihWsgIFPJ9g22++KFr/TknOFLnjNUb
         W12b1oK8W04OhWN8lUXRHgycAQcXVl0p1CUeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FywIt8OT1EMOTmIAy3WP8I19o2OF6ItVldkRoa+GCeY=;
        b=dy7ZGY+DFyM50yKT69ld/REcuRkpfLLD96I9RnoJva/S1JakoY0uBUbsFQ8tfH3CwI
         pP5oc80Z0ZVZ9OUcNcDcwFOmL1PmnWWGV0MN4Kk4hyOjNdOywonfAX+KoDBqBFmr7Spx
         USXmTWxXWD1x+RIaW2hCBJWAG2ipLWPzsv9ELxTp6MjDdiyxOnfa58+AOv0sZ5/pXiqJ
         GazcxKxSiYQZBj2Ao5BuBtGOha34m6b9rduDeHXSq7Ob8KAR5o5ScxXYs7zGX1v0wem8
         oaUf2hzDS6qeeYWEqc1APZD5N5OOGfNbMNZPpCtFnGBGgJdc2RfaOjIoh2f3dUgq6LGq
         SEVQ==
X-Gm-Message-State: APjAAAVJwxwTtNdQI+VEeN5nxC5lDziD/+qyU4Dhwk+FfHQr4rnmE6iy
        NuLsP08PNBwTHhowyJi4mcAWsQ==
X-Google-Smtp-Source: APXvYqy2pnHWOC9hDkuyq92v3qp4Ie8KJWzgULXc3PrRAQgouwYUo+ezTI6gocJKB5EQ2kdwLMPmlQ==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr89684716plb.30.1563990242519;
        Wed, 24 Jul 2019 10:44:02 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id r6sm37620080pgl.74.2019.07.24.10.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jul 2019 10:44:01 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, gregkh@linuxfoundation.org,
        ravisadineni@chromium.org, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org, trong@google.com
Subject: [PATCH 0/2] Add wakeup_source symlink and update documentation.
Date:   Wed, 24 Jul 2019 10:43:53 -0700
Message-Id: <20190724174355.255314-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in https://lkml.org/lkml/2019/7/23/687 this patch set
creates symlink from device node to wakeup_source virtual device. This
patch set also updates the documentation accordingly.

Ravi Chandra Sadineni (2):
  power: sysfs: Add link to wakeup class device.
  power: sysfs: move wakeup related nodes in power dir to obselete.

 Documentation/ABI/obsolete/sysfs-device-power | 93 ++++++++++++++++++
 Documentation/ABI/testing/sysfs-devices-power | 94 -------------------
 drivers/base/power/power.h                    |  2 +
 drivers/base/power/sysfs.c                    | 25 +++++
 drivers/base/power/wakeup.c                   |  2 +
 5 files changed, 122 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-device-power

-- 
2.20.1

