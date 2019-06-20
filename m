Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE0AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D30206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kPzLnsqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfFTSxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:53:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34310 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfFTSxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:53:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so2054754pgn.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y38qr/fYJ7o3rsLs1bn8D1I8msndSGvVmOkbAWHtFu8=;
        b=kPzLnsqwupLhY4EZRC2++uwK6KDFRIKIHrbSBuqhJenumTiCZhEp6qUgyUMm4IQo3s
         pIe1OKuxICWQ66cYuUPT2BjJ+T3KWzMEZMFh2ZTkB4wKMPP8ELc40NdNObx0ewcJG7V3
         g/1TXKf5dV0qLm/mpNeKx3Hqj+IXoGBjURyCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y38qr/fYJ7o3rsLs1bn8D1I8msndSGvVmOkbAWHtFu8=;
        b=bN7B1HKGiPZOc37Qgope/c3CvYcIhm/bEs3SAEqjOXrK9CPigB8ZuFY3Q8cGdss03r
         DNNZhILmJ00kGIZNVQclwjMBLV+D8v9wVdXLN1iEWmeYRvLoH1UiRKCbossm6gKVFu04
         ONu8AdT56+/8PcECOkdIxm9BLck84Rx+7C1oQQ4vQPfD4RX5Rq0Ol6/X1kYmj3ASddHD
         /Hy+B1zhZizztGyUeY3Z5KvKPS05Ae7ljL7BqQbVFi75Ea9ZMXlr/odENl6JhNZrlpAS
         sxxMVhBbYpa16+jJx8ZFBEcLFrXr4lAo0RQr5UyLCIg6HULNr0drlFOhPlXpSl79noM6
         WxMA==
X-Gm-Message-State: APjAAAVw7BfBaMb1znCj3IE125wf2nqoFyKVaRXdwNRFnacb4EGi8xeq
        JzHbcmS3vssDYB1qcZah9sg/nA==
X-Google-Smtp-Source: APXvYqy/S7xo8/qezVDAb9cQUvhK9pinm4zGcjvF82lt2eXn6/alia4P00FdiTMtFl6AxG/C0hTr3A==
X-Received: by 2002:a63:90c8:: with SMTP id a191mr4334695pge.112.1561056786935;
        Thu, 20 Jun 2019 11:53:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id m6sm485194pjl.18.2019.06.20.11.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 11:53:06 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/2] Support accelerometers for veyron_minnie
Date:   Thu, 20 Jun 2019 11:52:57 -0700
Message-Id: <20190620185259.142133-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

veyron_minnie - ASUS Chromebook Flip C100PA - embedded controller
controls two accelerometers, one in the lid, one in the base.
However, the EC firmware does not follow the new interface that
cros_ec_accel driver use.
Extend the legacy driver used on glimmer - Lenovo ThinkPad 11e
Chromebook - to veyron_minnie.
veyron_minnie being ARM based, issue command over the I2C bus to the EC
instead of relying on the shared registers over LPC.

Gwendal Grignou (2):
  iio: cros_ec: Add sign vector in core for backward compatibility
  iio: cros_ec : Extend legacy support to ARM device

 drivers/iio/accel/Kconfig                     |   4 +-
 drivers/iio/accel/cros_ec_accel_legacy.c      | 353 ++++--------------
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   5 +-
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
 4 files changed, 84 insertions(+), 279 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

