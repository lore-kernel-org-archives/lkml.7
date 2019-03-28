Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B17C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6458A20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ISwu6sbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfC1Uvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:51:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40780 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfC1Uvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:51:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so287564wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6AZlRPvy4bz4vMcSu+kCq42rB+53+hRMtcQHdtCzPdA=;
        b=ISwu6sbcgNcmBdqUxz8m+j8/+rHJuGuVHp+E1Yc5VAzu0S2F0Io68uNpQK8pRC0YDB
         WOIfotcqbgZdt7tet3b6ybbee7+u/9ar4ZxqXgiCwgZxo9E0TkRqgOug/lpYvJLp3cd2
         fZHoTf4tS8R7Xsr0OZV+SOJno3HkoZ+QrrdbVrwVru+DSy9qe2Fr/1ux2yMGgcZHHcMu
         KzYBef/090gpVAVHQZATEcM4b/AXLsuOxQhDBpHkfl2VrZvrXVnTmS6grcGQIpiTO64y
         +edDYw/Z5m2bfu3GjuMPmo2JKF7Ipf5hF3q6fh4sa9LYvAZVAj+//OixhmaipXczp/ym
         tMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6AZlRPvy4bz4vMcSu+kCq42rB+53+hRMtcQHdtCzPdA=;
        b=P8AJ5qfW/0iXCMtfxh//qmarrZjqcvDohKDGgHfD2z5/01gnxTAU3XncN9mAT0wJ5H
         9B7H/I1kpIoorr1juj5HVIjKy0F84/btiget1r9sLpMqLfeOLMZKzzQ9eS63ks1T6UyP
         dvfpSCi+C3LQnnMxWklkaHq47+o0FVf83d62C+2A5XQpUy0W8cghBPgjTFgy4gqYGES+
         EQ4kuu+fYkmv0dSMxciCGqCxK/Ve4dSuzgYFK3MmYB6YQkAbxXQCUcdh7v2DCrDMkvs1
         vSZU1ZAi/fo/1mMItEU8QC8NwIW35a+mguM6y6uoh1Pj1UBPh0duz1ntTu9BUzWD4oGi
         BilA==
X-Gm-Message-State: APjAAAVUTtAW7WMpWyEndDtzD4z+fvRmJQckovkEj3JfhFAhqjkgcj6y
        PN7jzAYh3V+lgqeQQnc6Bmc=
X-Google-Smtp-Source: APXvYqzFqFZKu9lBgqtgV89zfsHEdXdz9Rz66JOMjoYUHyuRFYAqLiBYCBQibZDCqNHVQzz9VWGzBA==
X-Received: by 2002:a1c:c910:: with SMTP id f16mr1188931wmb.47.1553806307345;
        Thu, 28 Mar 2019 13:51:47 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD73999007CF185662A5FF671.dip0.t-ipconnect.de. [2003:dc:d739:9900:7cf1:8566:2a5f:f671])
        by smtp.googlemail.com with ESMTPSA id c10sm94375wrt.65.2019.03.28.13.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 13:51:46 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] Amlogic: update multi_v7_defconfig for the temperature sensor
Date:   Thu, 28 Mar 2019 21:51:21 +0100
Message-Id: <20190328205122.27092-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 5.1 gained support for the temperature sensor on the 32-bit
Amlogic SoCs. This requires the eFuse driver and the SAR ADC driver to
be enabled in the kernel config. This last bit was missing so far.

Three boards already have a iio-hwmon node defined. The driver for this
is already enabled in multi_v7_defconfig: CONFIG_SENSORS_IIO_HWMON


Martin Blumenstingl (1):
  ARM: multi_v7_defconfig: enable the Amlogic Meson ADC and eFuse
    drivers

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.21.0

