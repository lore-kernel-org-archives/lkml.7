Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E7DCA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB3F21783
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dr7wEaSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfJUMoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:44:38 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41605 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbfJUMoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:44:37 -0400
Received: by mail-wr1-f51.google.com with SMTP id p4so13817091wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpVTW+WZL6DdTi8R1egFqPRwhOG2T/BnlrI0vbGyKSo=;
        b=dr7wEaSY8UQJ/AGGF8UXvMrEs1GBk4PDp/qRe60BXnj7SOebY0ws+tP9IK08OXd3WA
         kJoq8fetsUi4FkHh+sBV/YmnRD6gIjEH4N1Am4Ke2muT28aQSeyApTI3r+2/dP9N+0t7
         onSwyMIwTu7ueIJ+elRnh3UjKkx+mEYmzWe1tFb7MvYeii774AU19xwhKT/Zt8V6uotq
         02Em+Q3qsSDWgWOGt+RSYtRMl1ZmT4ZbyjojQJE7RlUNLYaVhOzGY+ZEGj9ZKpTzwIOe
         gR5kB15y/ls8Ufg9q5zq1voYnC1BU+xBenMeFh562h8p/UmuHrVeS1dCHx8ihObV8JOk
         ZBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpVTW+WZL6DdTi8R1egFqPRwhOG2T/BnlrI0vbGyKSo=;
        b=Mp+cx9lmqr9T56CaJZOjLxn0W6F1sDiToioKajpHGZk6Ods5eFzwwO56sdWBpuvU8c
         mrkxFK7Pmxqop8lndLu2svQn5I7MUMmzBEdC9qC860VC3aD4YXJLhjRK+R+3Uhbq4I5x
         IozpyVXo30Ti2pLWLSt3HIT2WgOC39Qqesh90/ya1Y8qlg1UUP+q2LabX/b3kyQdtiFf
         bDJ0NtLfhnQZtaEj4NvIXdbCgY9Cp9JXJTuSqfrK7POUdFWF6mSXnf1RyWDN5sufJo7r
         t+h9ia23Sv7xY38DjzlZnr4wME8LDZjvDWPXZCogAWRQJhdVjHcdzTevBxyRMARNV3S7
         cEXQ==
X-Gm-Message-State: APjAAAUkOEYJmpRjrc+eYysm59sCmVxBR5vwuEu63xQKbxnMc+EcqnR3
        1Wzggk7XeQQ7kW5Nbpl9J5Hssw==
X-Google-Smtp-Source: APXvYqyQZq9D7JNE8PCA9bjbf3OX5gqPK3dKrKLOL8KxWrUV3Y0cO+9DD/86Di3mogYOVO6kiCvOTA==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr18874464wrj.283.1571661873402;
        Mon, 21 Oct 2019 05:44:33 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a17sm10216150wmb.8.2019.10.21.05.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:44:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 0/6] dt-bindings: max77650: convert the device-tree bindings to yaml
Date:   Mon, 21 Oct 2019 14:44:22 +0200
Message-Id: <20191021124428.2541-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series converts all DT binding documents for MAX77650 PMIC to YAML.

v1 -> v2:
- use upper case for abbreviations in commit messages

v2 -> v3:
- pull all example fragments into the binding document for the core MFD module
- fix all dt_binding_check errors
- add references to submodules to the main binding document
- drop the type for gpio-line-names
- drop the description for the interrupts property
- completely delete the previous txt files

v3 -> v4:
- remove unnecessary parts of descriptions, added details on the chip
- correct file references (.txt -> .yaml)
- fix mixing scalar and array constraints
- dropped type refs for globally defined properties

Bartosz Golaszewski (6):
  dt-bindings: input: max77650: convert the binding document to yaml
  dt-bindings: regulator: max77650: convert the binding document to yaml
  dt-bindings: power: max77650: convert the binding document to yaml
  dt-bindings: leds: max77650: convert the binding document to yaml
  dt-bindings: mfd: max77650: convert the binding document to yaml
  MAINTAINERS: update the list of maintained files for max77650

 .../bindings/input/max77650-onkey.txt         |  26 ---
 .../bindings/input/max77650-onkey.yaml        |  35 ++++
 .../bindings/leds/leds-max77650.txt           |  57 -------
 .../bindings/leds/leds-max77650.yaml          |  51 ++++++
 .../devicetree/bindings/mfd/max77650.txt      |  46 ------
 .../devicetree/bindings/mfd/max77650.yaml     | 149 ++++++++++++++++++
 .../power/supply/max77650-charger.txt         |  28 ----
 .../power/supply/max77650-charger.yaml        |  34 ++++
 .../bindings/regulator/max77650-regulator.txt |  41 -----
 .../regulator/max77650-regulator.yaml         |  31 ++++
 MAINTAINERS                                   |   4 +-
 11 files changed, 302 insertions(+), 200 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.yaml

-- 
2.23.0

