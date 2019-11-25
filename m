Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBE7C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E22E2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JKqRWwZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKYUri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:47:38 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43869 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYUri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 15:47:38 -0500
Received: by mail-il1-f194.google.com with SMTP id r9so15463763ilq.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 12:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGtTbbiSE5dj1/mTlXQ5k0Rw2FeOQZ84/77O/3M8RCg=;
        b=JKqRWwZ6FOmra40yWcI+SAIx6WXfpb41+vj5YTllwEbJk7/vdLnQ2jlAhi0exp+rXm
         4VQChm+SwQyop5Ocq6+naGPJPnn2CEdlVX48HbodAlgKOtVFjCUkIJITy1XwXfBFQkcK
         YC7ngUJEhckutxm2agHYrauIX5DStR0l4NnvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGtTbbiSE5dj1/mTlXQ5k0Rw2FeOQZ84/77O/3M8RCg=;
        b=M3j20eHXTZgqHlaeTFjwmvC6RFQsXkz6zhueeFhTwIdhsFd8SVQEbom0SHxQ/INshh
         ZDbVgvnQHsjvcoi25PDbKlA4MP2kqL8ErJqxXhsjalHAE5a74ML926NebBbf2hRWm/o3
         /JMFLbWa2L4B6OhZBSnnvD/0YG6esfw9tiy9J2j6iCipyIfbTqFbYyDgN0ytlCPs7RIi
         Rh22Wc9F5GrLjPue+l7baQxKQPM82Cw+4yW6y8QC00BQbvzXC0BnOkKBacrx//LoxFSX
         mbKlavTj90Yl+KseCbcfz8aY3s2fkJ+iv/0LDINYQk5eLE352DLD7bBwQJNi5RdGl41A
         UQjg==
X-Gm-Message-State: APjAAAX9lPjwV4K7V8P0OUym8y9FSyzt7J6IMaK4AvJjO//jKp8UreY9
        y19QlyrKpBSaO/x24DMlyzn/2A==
X-Google-Smtp-Source: APXvYqwWURvSGC7bu3mFjP9EBh3AKvol6fK9p9oqnU0fPDZxo0PQniLBD3zVB/46FdDEQJZ5WxyRfQ==
X-Received: by 2002:a92:902:: with SMTP id y2mr31416080ilg.284.1574714857234;
        Mon, 25 Nov 2019 12:47:37 -0800 (PST)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id z10sm2500057ill.73.2019.11.25.12.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 12:47:36 -0800 (PST)
From:   Raul E Rangel <rrangel@chromium.org>
To:     enric.balletbo@collabora.com, Wolfram Sang <wsa@the-dreams.de>
Cc:     Akshu.Agrawal@amd.com, Raul E Rangel <rrangel@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 0/2] Convert cros-ec-i2c-tunnel to MFD Cell
Date:   Mon, 25 Nov 2019 13:47:28 -0700
Message-Id: <20191125204730.187000-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having the cros-ec-i2c-tunnel behave as a MFD Cell fixes a race condition
that could happen if the cros-ec-i2c-tunnel gets probed before the
cros_ec_lpc init has finished.

Changes in v2:
- Extracted platform_device_info into its own variable.
- Moved i2c tunnel into cros_ec_platform_cells
- Requires https://lkml.org/lkml/2019/11/21/208 to correctly enumerate.

Raul E Rangel (2):
  platform/chrome: cros_ec: Pass firmware node to MFD device
  platform/chrome: i2c: i2c-cros-ec-tunnel: Convert i2c tunnel to MFD
    Cell

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 36 +++++++++----------------
 drivers/mfd/cros_ec_dev.c               |  9 +++++++
 drivers/platform/chrome/cros_ec.c       | 14 +++++++---
 3 files changed, 33 insertions(+), 26 deletions(-)

-- 
2.24.0.432.g9d3f5f5b63-goog

