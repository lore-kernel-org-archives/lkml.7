Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EE8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2877920675
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BNTCCk+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfDXX33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:29:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38607 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbfDXX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:29:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so10169213pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXvBxbUR2vxcxzpDK9gRctRmbqQbx1zmvcONhNTtADI=;
        b=BNTCCk+WGZM3jQTjod/XrLAxSzRhR2SdA8+bFwpgtkM6QlMgVHIlv/eVU1PzYYl86i
         hjwcko/Uc8qwcZjnRtU/EZVht3Kr+HfSYqPtR4fAVzey2Fybp/uyNhIx/Oj7otlcu8W2
         UL2h2n+utBb9qsGlcpaYqaXTWjBrRGCU9KDms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXvBxbUR2vxcxzpDK9gRctRmbqQbx1zmvcONhNTtADI=;
        b=hNVCINmcA66XJMiOZUNjkL22I2nTHDIc01m54u3khP4jhKoD6ar+RWR7wZTVul3twL
         +SBcPD0BUyU7Jcu7nri9vFwx39DYine8umpuyq6Eo3CAZaEYR8BGJBUiwSaQIigRJqgS
         2UPpvK76oIjrIaTGPEzcXPt0Dp/20++qfdX688iobApXFlvKB4wiWcqTdvalcJ/a3Jc5
         9R5vurQDgELiJP8FEkeriaEybBwOTpgOSaCc8IzgIY5+sFzReL+y2vcoQoeTe5CI2sSZ
         bLOOH1CiTgW8tN6Bt/hQM5RAw96GFHrTQ6DA+EkoVVYVQHI7wPFr3ZcfDAf7CH889Sd9
         1v6Q==
X-Gm-Message-State: APjAAAWatN/mGwYgL7TfCHlgLSbVtQtVMQml/aJlFzYPb4e0oU/wy8KM
        SoUIzbqk2yKZ9UweGpgNPgeEJA==
X-Google-Smtp-Source: APXvYqzWhluK0mIVKXSrFZIGuZIRD1iRwV7qSIg8zkRtENd3UoCIexWujNfctxBcDbvZqEUSDNB41Q==
X-Received: by 2002:a62:5fc7:: with SMTP id t190mr35928881pfb.191.1556148568327;
        Wed, 24 Apr 2019 16:29:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id b9sm24635845pfd.32.2019.04.24.16.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:29:27 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 00/30] Update cros_ec_commands.h
Date:   Wed, 24 Apr 2019 16:28:48 -0700
Message-Id: <20190424232918.243308-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interface between CrosEC embedded controller and the host,
described by cros_ec_commands.h, as diverged from what the embedded
controller really support.

The source of thruth is at
https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h

That include file is converted to remove ACPI and Embedded only code.

From now on, cros_ec_commands.h will be automatically generated from
the file above, do not modify directly.

Fell free to squash the commits below.

Gwendal Grignou (30):
  mfd: cros_ec: Update license term
  mfd: cros_ec: Zero BUILD_ macro
  mfd: cros_ec: set comments properly
  mfd: cros_ec: add ec_align macros
  mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
  mfd: cros_ec: use BIT macro
  mfd: cros_ec: Update ACPI interface definition
  mfd: cros_ec: move HDMI CEC API definition
  mfd: cros_ec: Remove zero-size structs
  mfd: cros_ec: Add Flash V2 commands API
  mfd: cros_ec: Add PWM_SET_DUTY API
  mfd: cros_ec: Add lightbar v2 API
  mfd: cros_ec: Expand hash API
  mfd: cros_ec: Add EC transport protocol v4
  mfd: cros_ec: Complete MEMS sensor API
  mfd: cros_ec: Fix event processing API
  mfd: cros_ec: Add fingerprint API
  mfd: cros_ec: Fix temperature API
  mfd: cros_ec: Complete Power and USB PD API
  mfd: cros_ec: Add API for keyboard testing
  mfd: cros_ec: Add Hibernate API
  mfd: cros_ec: Add Smart Battery Firmware update API
  mfd: cros_ec: Add I2C passthru protection API
  mfd: cros_ec: Update I2S API
  mfd: cros_ec: Add API for EC-EC communication
  mfd: cros_ec: Add API for Touchpad support
  mfd: cros_ec: Add API for Fingerprint support
  mfd: cros_ec: Add API for rwsig
  mfd: cros_ec: Add SKU ID and Secure storage API
  mfd: cros_ec: Add Management API entry points

 include/linux/mfd/cros_ec_commands.h | 3735 +++++++++++++++++++++-----
 1 file changed, 2993 insertions(+), 742 deletions(-)

-- 
2.21.0.593.g511ec345e18-goog

