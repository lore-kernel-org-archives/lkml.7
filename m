Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E77C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913B12083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXNI9TJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbfB1Lnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:43:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54191 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731013AbfB1Lnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:43:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id e74so8845013wmg.3;
        Thu, 28 Feb 2019 03:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EnQbj64Kf0cnE71mf3HWVpyDgTs7IX1kVCf1sH/lHdI=;
        b=lXNI9TJnavTHgHq2OUK07L+rTxVFxDZb37SRKMtT2WV8Ly0j6JEgsk/tGj7MLceHSS
         rNu9C/2QKF590v02PDbRG4sg4UfsqVGnGMcdiGeLVt/q5hGP2kv5nZeQU3noS80EGdML
         LGuxr3AK/K2Xp3X/6QpKN8eCGM8tra1D13XBKi53QPVCDYYHSJuArG3iO3aJOQiRd8N/
         syAfmlnFMO8ioC0/9EmiXon8y/pkyTSdYh7NYXxJOdy3XlCDihn72cXms9ug4fegZR9p
         UxIKKNoW96GhLmd8y2xeldkBj26sRPpk1emqayWxv5Hqoi3xAhK3L17wBEcyCf6ybO5k
         LXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EnQbj64Kf0cnE71mf3HWVpyDgTs7IX1kVCf1sH/lHdI=;
        b=WBZ+uiOtTtVjjC6tVXRoGcxS8pOcz7Y6gUmT/K16pAvZ+XHv5hahrw3GQepltSHGub
         9JlbMB5cpwUSSoOOOpvCAGxntVaR5z/9go8W1IwCtCaKCdo+M1UUzbGSpQleb6U4xKMp
         hdHK2Ozbre+5nX61m1jA5d0woNTTy9Tlx/FQp30YMg9GSejn7azsEXy6RKYMpZjyZMWF
         H5QYnj6PYRa0tcTPgQpThsOSOHlAtGN13JNPXTlW9r4wD9gCjho6Ys/DlT+rqhFw+/8f
         nIFg4uasWDXt/OSDWkWbQKfyDRON0ahsAkvDfxoKp8+OHu+lRZZB4pqdxYQWXgBPQrXe
         So+A==
X-Gm-Message-State: APjAAAUsqV2Kk7mfH5VTqE2KcGqGZwbEXBez3oZ/r1BEKEKHWHkDYCjf
        HjVxlIFqagKMoebkNB7b974=
X-Google-Smtp-Source: APXvYqyYIsK7V5krZl3nHkQIE1JEDUCYIEcbySK28hGWHl/xb1cHmjHg1GLTQy3Y9m42aWw0q+wrmQ==
X-Received: by 2002:a1c:39d5:: with SMTP id g204mr2725316wma.17.1551354230896;
        Thu, 28 Feb 2019 03:43:50 -0800 (PST)
Received: from uks1.vyatta.net ([137.221.143.78])
        by smtp.gmail.com with ESMTPSA id o12sm26022906wrx.53.2019.02.28.03.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 03:43:50 -0800 (PST)
From:   Robert Shearman <robertshearman@gmail.com>
To:     Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>
Cc:     linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Shearman <robert.shearman@att.com>
Subject: [PATCH v4 0/3] i2c: mux: pca954x: allow management of device idle state via sysfs
Date:   Thu, 28 Feb 2019 11:43:40 +0000
Message-Id: <20190228114343.36443-1-robertshearman@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Shearman <robert.shearman@att.com>

The behaviour, by default, to not deselect after each transfer is
unsafe when there is a device with an address that conflicts with
another device on another pca954x mux on the same parent bus, and it
may not be convenient to use devicetree to set the deselect mux,
e.g. when running on x86_64 when ACPI is used to discover most of the
device hierarchy.

Therefore, provide the ability to set the idle state behaviour using a
new sysfs file, idle_state as a complement to the method of
instantiating the device via sysfs.

Changes in v4:
 - also remove variables that are redundant as a result of platform
   data removal
 - improve ABI file description field
Changes in v3:
 - remove use of platform data to simplify the idle state by not
   having per-channel idle states.
 - correct some comments
 - fix a style issue regarding use of READ_ONCE
Changes in v2:
 - change from exposing deselect mask to idle state with more options
   and less implementation specific
 - fix style issues
 - don't fail the create of the mux device if the device attribute
   file in sysfs failed to create

Robert Shearman (3):
  i2c: mux: pca954x: remove support for unused platform data
  i2c: mux: pca9541: remove support for unused platform data
  i2c: mux: pca954x: allow management of device idle state via sysfs

 .../ABI/testing/sysfs-bus-i2c-devices-pca954x |  20 ++++
 drivers/i2c/muxes/i2c-mux-pca9541.c           |   8 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c           | 106 +++++++++++++-----
 include/linux/platform_data/pca954x.h         |  48 --------
 4 files changed, 100 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-pca954x
 delete mode 100644 include/linux/platform_data/pca954x.h

-- 
2.20.1

