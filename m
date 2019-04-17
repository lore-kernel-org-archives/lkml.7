Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144F5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C561320872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZ2sRS8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbfDQUyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:54:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43289 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDQUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:54:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id i68so9000933lfi.10;
        Wed, 17 Apr 2019 13:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JuxBwmf7jRt/0XY3VfmC3rtBkhd8PqPSNB0Hrltvo3Q=;
        b=oZ2sRS8s/lxqBuJWO9hC5uoK4a0SSI3NcSeqyMBI6++iwleqKiZxmsOGmzIRZV/nH3
         6kEJT9a3nos71+2dSRV/fxWtx6Q9/AzNjEf1TKzOx5WjFzuk2B+mUZLxEOEFJfqU85H+
         BteMUQJXwXzCqlNfjenZerePgaUL+sjs207d0cWXz9lWKKBnv9U9WpMVlZZC6H0Zeup6
         Cz4zc1/N7FfTFRLBFEMp3bCNa/ZCYu0Q9Udj5Si2ZzDKnUPe4CUQunKA6ze2Hrsa0Ql4
         drBo2VN7U0eIPCPuDeXkXLXQ+wHGzrsZ5QUAcxYhklJO0I4RPBfZKaR+bzdDrapXED1q
         uMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JuxBwmf7jRt/0XY3VfmC3rtBkhd8PqPSNB0Hrltvo3Q=;
        b=MwMhNQKp4GtQvxipprQHoxCZBPTHc/n0T4kBW7mKVEWBBXabVR56g+TWpQ6hOi5c2F
         2EGr9oymXMhAcWXo1WhT716WKa1M8b0gqSAtwsyCC3xUapGakSF1PlXajXe5TgUZ/wlW
         PrdU/bMXXnaumN3sbC2enPYObzSoO6LAEXYEWIndKrbewjUkGye4BOrE5aqE61L4lkRJ
         MSL4QOHm9mJXmA2r7pcVqQ0z9Tr5ra23tgyuW0xv8XYiVqTHC6q3sPXe0FQ55fn1q3/D
         zWCJEhuBeKjy9Qab1OXjjjrHj3kHV6yF3tWLDWNNz1KT0YHLmGBMy1eBkpS51I8mzOyM
         C0Tg==
X-Gm-Message-State: APjAAAXzpbQzH+TgXQjU/jI+ByCq+Jua4lpWyFNYzkdRPVaStecRtTPJ
        JelK41LLbqpDK1lERHgkodA+P+6N
X-Google-Smtp-Source: APXvYqyXputvpOqfRHD4w42OoPCDvPSQF1TsrOQ5ifO5aFaPU8zfuLIVmWBuFr1krJkbqfSuj4xhEQ==
X-Received: by 2002:ac2:51da:: with SMTP id u26mr14205916lfm.32.1555534490742;
        Wed, 17 Apr 2019 13:54:50 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:54:49 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com
Subject: [PATCH v4 00/26] Add generic support for composing LED class device name
Date:   Wed, 17 Apr 2019 22:54:13 +0200
Message-Id: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v3:

- allow for devicename section for hot-pluggable devices
- move led_colors array to led-core.c to avoid build break
  due to Kconfig dependency issue
- add a patch fixing led_colors array name clash with ALSA driver
- change led-enumerator DT property name to more meaningful function-enumerator
- add LED_FUNCTION_KBD_BACKLIGHT
- change naming and add new proprties to struct led_init_data
  and struct led_properties

Changes from v2:

- removed from drivers the responsibility of calling led_compose_name()
- added struct device* argument to led_compose_name() to allow using
  dev_<level> logging functions for more informative logs
- adjusted the list of LED_FUNCTION definitions according to the v2 review
  remarks
- renamed default_desc to default_label in the struct led_init_data
- added led-enumerator DT property to the common LED bindings
- removed LED_COLOR_NAME definitions from include/dt-bindings/leds/common.h
- change DT color property type from string to integer
- change struct initialization list to explicit property assignment in leds-sc27xx-bltc.c
- use led->client->name for led_hw_name in leds-lm3692x.c
- few other minor improvements to docs etc.

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

Jacek Anaszewski (26):
  ALSA: line6: Avoid polluting led_* namespace
  leds: class: Improve LED and LED flash class registration API
  dt-bindings: leds: Add LED_FUNCTION definitions
  dt-bindings: leds: Add LED_COLOR_ID definitions
  dt-bindings: leds: Add properties for LED name construction
  leds: core: Add support for composing LED class device names
  dt-bindings: sc27xx-blt: Add function and color properties
  leds: sc27xx-blt: Use generic support for composing LED names
  dt-bindings: lt3593: Add function and color properties
  leds: lt3593: Use generic support for composing LED names
  dt-bindings: lp8860: Add function and color properties
  leds: lp8860: Use generic support for composing LED names
  dt-bindings: lm3692x: Add function and color properties
  leds: lm3692x: Use generic support for composing LED names
  dt-bindings: lm36010: Add function and color properties
  leds: lm3601x: Use generic support for composing LED names
  dt-bindings: cr0014114: Add function and color properties
  leds: cr0014114: Use generic support for composing LED names
  dt-bindings: aat1290: Add function and color properties
  leds: aat1290: Use generic support for composing LED names
  dt-bindings: as3645a: Add function and color properties
  leds: as3645a: Use generic support for composing LED names
  dt-bindings: leds-gpio: Add function and color properties
  leds: gpio: Use generic support for composing LED names
  dt-bindings: an30259a: Add function and color properties
  leds: an30259a: Use generic support for composing LED names

 .../devicetree/bindings/leds/ams,as3645a.txt       |  22 ++--
 Documentation/devicetree/bindings/leds/common.txt  |  62 ++++++++--
 .../devicetree/bindings/leds/leds-aat1290.txt      |  12 +-
 .../devicetree/bindings/leds/leds-an30259a.txt     |  22 +++-
 .../devicetree/bindings/leds/leds-cr0014114.txt    |  26 +++--
 .../devicetree/bindings/leds/leds-gpio.txt         |  23 ++--
 .../devicetree/bindings/leds/leds-lm3601x.txt      |  10 +-
 .../devicetree/bindings/leds/leds-lm3692x.txt      |   9 +-
 .../devicetree/bindings/leds/leds-lp8860.txt       |   9 +-
 .../devicetree/bindings/leds/leds-lt3593.txt       |  11 +-
 .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  |  10 +-
 Documentation/leds/leds-class.txt                  |  56 ++++++++-
 drivers/leds/led-class-flash.c                     |   9 +-
 drivers/leds/led-class.c                           |  45 +++++---
 drivers/leds/led-core.c                            | 127 +++++++++++++++++++++
 drivers/leds/leds-aat1290.c                        |  14 ++-
 drivers/leds/leds-an30259a.c                       |  25 ++--
 drivers/leds/leds-as3645a.c                        |  69 ++++-------
 drivers/leds/leds-cr0014114.c                      |  33 ++----
 drivers/leds/leds-gpio.c                           |  23 ++--
 drivers/leds/leds-lm3601x.c                        |  38 +++---
 drivers/leds/leds-lm3692x.c                        |  22 +---
 drivers/leds/leds-lp8860.c                         |  35 +++---
 drivers/leds/leds-lt3593.c                         |  20 ++--
 drivers/leds/leds-pwm.c                            |   2 +-
 drivers/leds/leds-sc27xx-bltc.c                    |  22 ++--
 drivers/leds/leds.h                                |   1 +
 include/dt-bindings/leds/common.h                  |  48 ++++++++
 include/linux/led-class-flash.h                    |  15 ++-
 include/linux/leds.h                               |  81 +++++++++++--
 sound/usb/line6/toneport.c                         |   8 +-
 tools/leds/get_led_device_info.sh                  |  81 +++++++++++++
 32 files changed, 718 insertions(+), 272 deletions(-)
 create mode 100755 tools/leds/get_led_device_info.sh

-- 
2.11.0

