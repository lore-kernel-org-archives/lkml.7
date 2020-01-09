Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770D4C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5D92082E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLCsoIur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgAILZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:25:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55066 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbgAILZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:25:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so2491797wmj.4;
        Thu, 09 Jan 2020 03:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+Toa4T3V42nYUR4pTxu4naMD6fS1uKuRhSO8hjFYyjc=;
        b=YLCsoIurIVE36egSRqOuMabobXqCBnc5LSh/ZnCaWDR1A/NDyRq1bVzKZXNa+BudWh
         26Q1/sYcurwzm6l3bGjvD+0701nbe5C90QGeMUwd5t6lyMKqdB7kFbXlYxsiaHXr9DjH
         nWZ8hUvYs+PG9yIVpkgOrNEaYR22/K3rYJUD3+gwiTiIHUBWk+iZTkOj6U2bQOqLJ6gI
         IZO8gSKcTxQlH1TDKohQg23LQ7SmgKUk+OPth19JVyJMHbIoQNHrrLUU16Ma5PjfGyXW
         um7CAy4nR65jM1/Sz65hyLVHFmVWft1QSyCXpfmBt9ALuWty1xrSX46rpleSMz+lwInW
         osVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Toa4T3V42nYUR4pTxu4naMD6fS1uKuRhSO8hjFYyjc=;
        b=kz4Rkoz3QjS87obIglh5Vu8/a2XWyXjYT4VZH6NIG93hue6/DKDbzAXNFWJikmo+YS
         8keczdC0GvmhSRVBIZEz2C4y3VSwAiEe14a5wP94AMRoYBwWZvRXgDxI+Y7OIu+rckaC
         WZnZhTQ6qgGqDcDMKBeiloIAJm6plLQQFSilBL6vZOFHk2C5LcZV3yq0GZFh5DkFoVww
         351qsimCU+6DTLeXB5QSTSNIHqLlfOxotKfT1ZlWVDzFh5cFZaZuMx4hhWIV253MuAEs
         zHirp9VuDRm4N+vPrbS0Mfw3a/+XioQImGbbCY1WmfBf6kcZuwTU2gUYRAp7KZ6P9ZcD
         MmIg==
X-Gm-Message-State: APjAAAWC097sRLUI19Mwprw5CVy+pfGg7hIInubdVYC6b/13gCRGAZef
        432mWKdgdv8rVijucyz8vgs=
X-Google-Smtp-Source: APXvYqyTK0RUCzvJcHNsMMNoZd233kKaa9x0ZuBiB9U547aRbZUn3ynRM9mKDBALB1bWorBxdQH+Cg==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr4225271wmb.174.1578569156634;
        Thu, 09 Jan 2020 03:25:56 -0800 (PST)
Received: from localhost.localdomain (p5B3F655B.dip0.t-ipconnect.de. [91.63.101.91])
        by smtp.gmail.com with ESMTPSA id 60sm8298660wrn.86.2020.01.09.03.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 03:25:55 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] Add regulator support for mpq7920
Date:   Thu,  9 Jan 2020 12:25:44 +0100
Message-Id: <20200109112548.23914-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V6:
    - replaced dts parse loop with an of_parse_cb callback

Changes in V5:
    - removed timeslot related changes, the timeslot register holds the value of
      time duration between each regulator of power on/off sequence. Although
      timeslot register is accessed over I2C the changes reflects on next powercycle
      of pmic, so cannot handled part of this driver.
    - device tree bindings property are defined per regulator node

Changes in V4:
    - fixed 0-DAY warnings

Changes in V3:
    - fixed review comments in Documentation and dt_bindings_check passed

Changes in V2:
    - fixed all the review comments in the driver, avoid ternery operator, inline & constant
    - fixed/modifed review comments in Documentation

This patch series add support for PMIC regulator driver for Monolithic
Power System's MPQ7920 chipset. MPQ7920 provides support for 4-BUCK converter,
one fixed voltage RTCLDO and 4-LDO regualtor, accessed over I2C.

Saravanan Sekar (4):
  dt-bindings: Add an entry for Monolithic Power System, MPS
  dt-bindings: regulator: add document bindings for mpq7920
  regulator: mpq7920: add mpq7920 regulator driver
  MAINTAINERS: Add entry for mpq7920 PMIC driver

Saravanan Sekar (4):
  dt-bindings: Add an entry for Monolithic Power System, MPS
  dt-bindings: regulator: add document bindings for mpq7920
  regulator: mpq7920: add mpq7920 regulator driver
  MAINTAINERS: Add entry for mpq7920 PMIC driver

Saravanan Sekar (4):
  dt-bindings: Add an entry for Monolithic Power System, MPS
  dt-bindings: regulator: add document bindings for mpq7920
  regulator: mpq7920: add mpq7920 regulator driver
  MAINTAINERS: Add entry for mpq7920 PMIC driver

 .../bindings/regulator/mps,mpq7920.yaml       | 202 ++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mpq7920.c                   | 346 ++++++++++++++++++
 drivers/regulator/mpq7920.h                   |  68 ++++
 7 files changed, 636 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
 create mode 100644 drivers/regulator/mpq7920.c
 create mode 100644 drivers/regulator/mpq7920.h

-- 
2.17.1

