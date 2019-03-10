Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCBFC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989612084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cunwv9tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfCJS27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:28:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54352 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfCJS26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:28:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so2244688wmj.4;
        Sun, 10 Mar 2019 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MY0pKMnNa9mvEl7aq3o2I5ARvScQE1UGbDH25VXztEo=;
        b=Cunwv9trk1PEea7OtIXiMm2c8viBsxOtl0Hqo+IJhg8jE9c3TZBlhxsnDCC0lWItyr
         kmEFKKROoTPqxpYCgLJxbhYc6NvUpF2k2z800eZuWO/rAPd4lzM9udsaZT1b8pD3lOMF
         GpDitH/Rkfg6lnRoy/G2SvxMd5hTsMGFsA3aHs0O3UwHj7B/q6Ls1vxxEX1kgmwknAAk
         nAPR5rs2I3hYqcbQC7GQAqJg+eoGG7tHdHVym/Mng/AQ9uvnSDUoFGMkSvta/szg5upw
         UI7Ja9Au5IxaybXl+G+ORQiNJN6iTrUrO1I6hRg/cxxTcUFnoR9FV2V9ggS0NdxSI2wI
         HfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MY0pKMnNa9mvEl7aq3o2I5ARvScQE1UGbDH25VXztEo=;
        b=JgtPeBngFKzq5lESoNCS2U3Lzhq5T323SYxU42Gv37rO1McGt/ce8kmmlVce+TsvyA
         qx6b4Ug7Z7vPeZL/cm9xSnKBCaGuDlNudHvBwXqqfhC8CAqdPxUIrClkqQICA+/G6Ipw
         HsoI8o/kH9dz7/cx5onWrxTZkdrz6bFgA+STkbrQY4Qis7ise9HvFC3Dkl44gITTIckP
         o81eXWk3sqpeeXfn5qbgDgMVGFVeyGQevFEIxZX9XJi/aZDdY3UXYpQ8DNbrUiREVseW
         lPFisjytVLLJRCv2y7Ddy9vOQHb1FaE5l1rn3STCNJqkUAF/Ky2BshU4v9TOTCEekT7N
         xIng==
X-Gm-Message-State: APjAAAWRa99bsmKywQCDSmYx2+/C+qgO7wsZRROKSNRjxtLlX+VC6P79
        FN8l3Vq4/ld8d1Xd6bEd/NAdgpIk
X-Google-Smtp-Source: APXvYqztUhda0KqGaLhaYnMiWvlqNq67duxAnkSIscVYW16Tu6dwh/Z73kM/fHd/z7ILxhmYsxiwgw==
X-Received: by 2002:a1c:3d84:: with SMTP id k126mr14907567wma.60.1552242535550;
        Sun, 10 Mar 2019 11:28:55 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:28:54 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com
Subject: [PATCH v2 00/25] Add generic support for composing LED class device name
Date:   Sun, 10 Mar 2019 19:28:11 +0100
Message-Id: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:

- improved led_parse_properties() to parse label property at first
  and return immediately after parsing succeeds
- added tool get_led_device_info.sh for retrieving LED class device's
  parent device related information
- extended LED naming section of Documentation/leds/leds-class.txt
- adjusted the list of LED_FUNCTION definitions according to the v1 review
  remarks
- added standard LED_COLOR_NAME definitions
- removed functions.h and moved both LED_FUNCTION and LED_COLOR_NAME
  definitions to include/dt-bindings/common.h
- rebased leds-as3645a changes on top of the patch switching to fwnode
  property API
- updated DT bindings to use new LED_COLOR_NAME definitions
- improved common LED bindings to not use address unit for sub-nodes
  without reg property

Generally I still insist on deprecating label property and devicename
section of LED name. The tool I added for obtaining LED device name
proves availability of the related information in other places in
the sysfs. Other discussed use cases are covered in the updated
Documentation/leds/leds-class.txt.

Beside that, I tried also to create macros for automatic composition
of "-N" suffixed LED functions, so that it would not be necessary
to pollute common.h with plenty repetitions of the same function,
differing only with the postfix. Unfortunately, the preprocessor
of the dtc compiler seems not to accept string concatenetation.
I.e. it is not possible to to the following assighment:

function = "hdd""-1"

If anyone knows how to obviate this shortocoming please let me know.

Original cover letter:

LED class device naming pattern included devicename section, which had
unpleasant effect of varying userspace interface dependent on underlaying
hardware. Moreover, this information was redundant in the LED name, since
the LED controller name could have been obtained from sysfs device group

This patch set introduces a led_compose_name() function in the LED core,
which unifies and simplifies LED class device name composition. This
change is accompanied by the improvements in the common LED DT bindings
where two new properties are introduced: "function" and "color" . The two
deprecate the old "label" property which was leaving too much room for
interpretation, leading to inconsistent LED naming.

There are also changes in LED DT node naming, which are in line with
DT maintainer's request from [0].

Since some DT LED naming unification, related to not including devicename
section in "label" DT property, is being requested during reviews of new
LED class drivers for almost a year now, then those drivers are the first
candidates for optimalization and the first users of the new
led_compose_name() API. The modifications were tested with Qemu,
by stubbing the driver internals where hardware interaction was needed
for proper probing.

Thanks,
Jacek Anaszewski

[0] https://lore.kernel.org/patchwork/patch/858993/

Jacek Anaszewski (25):
  leds: class: Improve LED and LED flash class registration API
  leds: core: Add support for composing LED class device names
  dt-bindings: leds: Add LED_FUNCTION definitions
  dt-bindings: leds: Add LED_COLOR_NAME definitions
  dt-bindings: leds: Add function and color properties
  dt-bindings: sc27xx-blt: Add function and color properties
  leds: sc27xx-blt: Use led_compose_name()
  dt-bindings: lt3593: Add function and color properties
  leds: lt3593: Use led_compose_name()
  dt-bindings: lp8860: Add function and color properties
  leds: lp8860: Use led_compose_name()
  dt-bindings: lm3692x: Add function and color properties
  leds: lm3692x: Use led_compose_name()
  dt-bindings: lm36010: Add function and color properties
  leds: lm3601x: Use led_compose_name()
  dt-bindings: cr0014114: Add function and color properties
  leds: cr0014114: Use led_compose_name()
  dt-bindings: aat1290: Add function and color properties
  leds: aat1290: Use led_compose_name()
  dt-bindings: as3645a: Add function and color properties
  leds: as3645a: Use led_compose_name()
  dt-bindings: leds-gpio: Add function and color properties
  leds: gpio: Use led_compose_name()
  dt-bindings: an30259a: Add function and color properties
  leds: an30259a: Use led_compose_name()

 .../devicetree/bindings/leds/ams,as3645a.txt       | 22 +++---
 Documentation/devicetree/bindings/leds/common.txt  | 55 ++++++++++++---
 .../devicetree/bindings/leds/leds-aat1290.txt      | 12 ++--
 .../devicetree/bindings/leds/leds-an30259a.txt     | 22 ++++--
 .../devicetree/bindings/leds/leds-cr0014114.txt    | 26 +++++--
 .../devicetree/bindings/leds/leds-gpio.txt         | 23 ++++--
 .../devicetree/bindings/leds/leds-lm3601x.txt      | 10 ++-
 .../devicetree/bindings/leds/leds-lm3692x.txt      |  9 ++-
 .../devicetree/bindings/leds/leds-lp8860.txt       |  9 ++-
 .../devicetree/bindings/leds/leds-lt3593.txt       | 11 ++-
 .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  | 10 +--
 Documentation/leds/leds-class.txt                  | 20 +++++-
 drivers/leds/led-class-flash.c                     |  9 +--
 drivers/leds/led-class.c                           | 34 +++++----
 drivers/leds/led-core.c                            | 82 ++++++++++++++++++++++
 drivers/leds/leds-aat1290.c                        | 17 +++--
 drivers/leds/leds-an30259a.c                       | 26 +++----
 drivers/leds/leds-as3645a.c                        | 73 ++++++++-----------
 drivers/leds/leds-cr0014114.c                      | 30 +++-----
 drivers/leds/leds-gpio.c                           | 26 +++----
 drivers/leds/leds-lm3601x.c                        | 45 ++++++------
 drivers/leds/leds-lm3692x.c                        | 39 +++++-----
 drivers/leds/leds-lp8860.c                         | 38 +++++-----
 drivers/leds/leds-lt3593.c                         | 19 +++--
 drivers/leds/leds-sc27xx-bltc.c                    | 23 +++---
 include/dt-bindings/leds/common.h                  | 47 +++++++++++++
 include/linux/led-class-flash.h                    | 15 ++--
 include/linux/leds.h                               | 68 +++++++++++++++---
 tools/leds/get_led_device_info.sh                  | 81 +++++++++++++++++++++
 29 files changed, 639 insertions(+), 262 deletions(-)
 create mode 100755 tools/leds/get_led_device_info.sh

-- 
2.11.0

