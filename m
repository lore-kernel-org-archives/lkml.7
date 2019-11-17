Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4320EC432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDD120850
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OvfyMqRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfKQO1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 09:27:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46189 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfKQO1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 09:27:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so16403030wrs.13;
        Sun, 17 Nov 2019 06:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lO0ksvtY9zH08AEg8nMyPZuqK7PCO3+wK/C9fssW7po=;
        b=OvfyMqRL7cZ3gebd6XwHEtVV9YVnBnpmUQ+SGXLKpFtR+NrDinyEXHs1csdkoydp8q
         Pz76g1Xstz23VWOmKek8l1li8ywKoeE91ym2jWw5r0salZd2DyYTtQDTJZD3EZqLK+Wr
         rZfRQfXX4Pd02T1ESdgH3cO+K1M+ipl06n/5SGW7RSR6nCFkVMX+eIk3fHU3q4bKITzN
         qcOEy1X6k8BlmtyeRq4P9eNBUMNO8ilWvlM6OY3sCi/uKnNkDLw81zLflSH/5Ar9DrZp
         1nC6TsOAY5vZzPe1eTTfPvKLr2qxbOphRb4PmqLerXtD+tHrXowmqJB58gpfshhQh2PU
         tKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lO0ksvtY9zH08AEg8nMyPZuqK7PCO3+wK/C9fssW7po=;
        b=VP1jKrxDDVJT+8b97sMyTpqEB48YI7vfoX/1YdsyOvIj0wotVjz74SDbHYCqMe4+9V
         +vbg5CFVKNnFy9Fwxvx4O4xreA7HpnqpMG39s9FPSji0kRkrKWGPRJvFkiYSfSIAw6aC
         qmGmpkXq7QcsJ28SLO963LxSXi9jk2CdP7Ljrqj+uHZPpqiVWPOAm5Bz9yQ/VKvtq53T
         MtWh2RAv3FRuVOsg9m7dpsrU6OfDOStmVCdJ28UmD+MLtoPpIglmIjl7lHN2jzl6RSs3
         VhsfxMTHt2S1vrFd2RU2Ubu/mKRFVSHHJ/iom/uqo47qQ2j3p4JGQGILK4Ht2hIugQ3Z
         Mizw==
X-Gm-Message-State: APjAAAX5dZeGAOFBpQnUZXhbsZbRi+svZBoSWIE87S3XesXzw7HbLUhV
        6UhIbIrHt3Guw4HHw+M6Bks=
X-Google-Smtp-Source: APXvYqzEOXSm+kKjgZdpqwrHaA8h04j+OEbYC2GEcLTVyczWFWgQ3/gy003iaQEgrZvvJmrJxZk5ag==
X-Received: by 2002:adf:ed48:: with SMTP id u8mr24028265wro.28.1574000848452;
        Sun, 17 Nov 2019 06:27:28 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id y6sm19298404wrw.6.2019.11.17.06.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 06:27:27 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org
Cc:     jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Amlogic 32-bit Meson SoC SDHC MMC controller driver
Date:   Sun, 17 Nov 2019 15:27:14 +0100
Message-Id: <20191117142716.154764-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is the first non-RFC version of the driver for the Amlogic "SDHC"
MMC controller found on Meson6, Meson8, Meson8b and Meson8m2 SoCs.

The public S805 (Meson8b) datasheet has some documentation starting on
page 74: [0]

It's performance is still not as good as the driver from Amlogic's 3.10
kernel, but it does not corrupt data anymore (as RFC v1 did).

Special thanks to the people who supported me off-list - you are
amazing and deserve to be mentioned here:
- Xin Yin who helped me fix two more write corruption problems. I am
  hoping that he will reply with Reviewed-by, Tested-by and Bug-fixed-by
- Jianxin Pan for sharing some of the internal workings of this MMC
  controller with me
- Wei Wang for spotting the initial write corruption problem and helping
  test this driver on his board. I have his permission to add his
  Tested-by (off-list, he's Cc'ed so if there's any problem he can speak
  up)


Changes since RFC v1 at [1]:
- don't set MESON_SDHC_MISC_MANUAL_STOP to fix one of three write
  corruption problems. the out-of-tree 3.10 "reference" driver doesn't
  set it either
- check against data->flags instead of cmd->flags when testing for
  MMC_DATA_WRITE as spotted by Xin Yin (many thanks!). This fixes
  another write corruption problem
- clear the FIFOs after successfully transferring data as suggested by
  Xin Yin (many thanks!). This is what the 3.10 driver did and fixes yet
  another write corruption problem
- integrate the clock suggestions from Jianxin Pan so the driver is now
  able to set up the clocks correctly for all known cases. documentation
  is also added to the patch description. Thank you Jianxin for the
  help!
- set the correct max_busy_timeout as suggested by Jianxin Pan (thanks!)
- convert the dt-bindings to .yaml (which is why I didn't add Rob's
  Reviewed-by)
- switch to struct clk_parent_data as part of newer common clock
  framework APIs to simplify the clock setup
- dropped CMD23 support because it seems to hurt read and write
  performance by 10-20% in my tests. it's not clear why, but for now we
  can live without this.
- use devm_platform_ioremap_resource instead of open-coding it


[0] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
[1] https://patchwork.kernel.org/cover/11035505/


Martin Blumenstingl (2):
  dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
  mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host

 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   |   64 +
 drivers/mmc/host/Kconfig                      |   14 +
 drivers/mmc/host/Makefile                     |    1 +
 drivers/mmc/host/meson-mx-sdhc.c              | 1174 +++++++++++++++++
 4 files changed, 1253 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
 create mode 100644 drivers/mmc/host/meson-mx-sdhc.c

-- 
2.24.0

