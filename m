Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A788C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF51520645
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcXdM/Oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfENW6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:58:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36247 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfENW6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:58:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id z1so758374ljb.3;
        Tue, 14 May 2019 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkD4gxzoy6M/6Uyme9PNzGTsnVPGlvJZdl9aKPy2J08=;
        b=WcXdM/OjwPVpt+kZRbKWgfllCF/2LwUxAbvyokqyGgTsGOvlqSQIyd2Q/QTL/+8s/0
         x836KMIcFMgIKklHjn29ktdxoyleBMOhlOZw8JPvfcraio6qBraCbj70jituB0JcYlcq
         hk+6lyf99nhlG5TsgfXRfTwkavD8Na3bxtUPW9w6uS4eiC2NhKjRFHCVYMufzcxF/3l4
         s7xq8cM4glP9S8VJCmI5bUfKqqp5oen2mQcliGs1VmeEUHI9y0qXKvEAPQuHYniI9P2N
         ILdyk1qam/PBQIx2izuTRwXPvxtwbG0ObNosh0nxtwIGMxlRsUETvVCVZvy3xPl4VtEG
         Qo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkD4gxzoy6M/6Uyme9PNzGTsnVPGlvJZdl9aKPy2J08=;
        b=Ljor0nxy3o4ttvRXaboKm7PEVPy99kuJ68m/+9JfF1iNYQ6k8f0ZZSuJiUGY2ulwKl
         SVqs7B7aerBFrpTwn86K+s4OaDNkJsDD+kH9h5D3kSxTBY6lkncur9nW8+x4d0uWyueZ
         cKG4yMEQNVknCDe6ldq+wmdWpsCw83ro6OOqZNPhaIBYW+P7CwD7Rx9mEcITEe/lYLC7
         mx3ODYunxgKsYXLQDkQtp/yLmAT0G98jlwWrFu0YNRyoRzjrNP0o4LwKmgWGKUE0Ccvc
         oELcv2eUaViDLpVn7SdCJ+dkVoVuDTWZ40ZHDVDJnLZE6l19nZsx7XB5dZwyAs+fR0d5
         RCQA==
X-Gm-Message-State: APjAAAWpuP4GuYy1pOVBUhjBr0c+xeHbVBeudkdItA97Z5Q4h+V9F5L3
        0AHTNl7iPYZHlMieqrTdWmMbhLcjFoM=
X-Google-Smtp-Source: APXvYqxzoU6BYRCsYnRzsgIF0xJ13h0v9nBKhZEIJfqLoWG7P/6Qa4ANxez76TkoF4S3veVRMoWLuA==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr18773817ljb.3.1557874724881;
        Tue, 14 May 2019 15:58:44 -0700 (PDT)
Received: from localhost.localdomain ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id n26sm30342lfi.90.2019.05.14.15.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 15:58:43 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dirk Eibach <eibach@gdsys.de>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH 0/2] hwmon: Add TI ads1000/ads1100 driver package
Date:   Wed, 15 May 2019 01:58:07 +0300
Message-Id: <20190514225810.12591-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This a simple single-channel ADC device similar to ads1100 series,
but with much less capabilities. These ADCs are working over i2c-interface
with just one differential input and with configurable 12-16 bits
resolution. Sample rate is fixed to 128 for ads1000 and can vary from 8
to 128 for ads1100. Vdd value reference value must be supplied so to
properly translate the sampled code to the real voltage.

Even though ads1000/ads1100 devices seem more like ads1015 series, they
in fact pretty much different. First of all ads1000/ads1100 got less
capabilities: just one port, no configurations of digital comparator, no
input multi-channel multiplexer, smaller PGA and data-rate ranges.
In addition they haven't got internal voltage reference, but instead
are created to use Vdd pin voltage. Finally the output code value is
provided in different format. As a result it was much easier for
development and for future support to create a separate driver, which
is opensoureced by means of this patchset.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>


Serge Semin (2):
  dt-bindings: hwmon: Add DT bindings for TI ads1000/ads1100 ADCs
  hwmon: Add ads1000/ads1100 voltage ADCs driver

 .../devicetree/bindings/hwmon/ads1000.txt     |  61 ++++
 Documentation/hwmon/ads1000.rst               |  72 ++++
 MAINTAINERS                                   |   8 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/ads1000.c                       | 320 ++++++++++++++++++
 include/linux/platform_data/ads1000.h         |  20 ++
 7 files changed, 492 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ads1000.txt
 create mode 100644 Documentation/hwmon/ads1000.rst
 create mode 100644 drivers/hwmon/ads1000.c
 create mode 100644 include/linux/platform_data/ads1000.h

-- 
2.21.0

