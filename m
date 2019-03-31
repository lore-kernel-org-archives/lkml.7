Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5FBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D8020870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7YHHt4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbfCaRzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43516 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731228AbfCaRzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so8882351wrx.10;
        Sun, 31 Mar 2019 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lzH4aC313mJST3ZULspMhUqFXGrLZXE+Kj3cGLbwBHE=;
        b=N7YHHt4etKuyCKJ4qvlqucxJkk8okikpO9Lb3mgr+L096WyC/9gXnMyOvtr6PWL9Yn
         pRr02ucwoT2Qr5e/kjuVxZZUfhPRpl89wfCEFuyE9afzJnk7kit05gnWNQQ4vmI1suw5
         pfMRF6xvuXTXZ1RCkzOz2mMjAmq4SMvsyQ8BxS9dwhv0MjzE7vBbctpmzkPRYz+hP4N0
         3nnkoV91hQfKdfcr2eGVPFCK8Q/9Ezg3k5OYpRQ+3XNMzhVC+jPsCknBza1X5Ryxu+FR
         OqXx1UMbmjK5HmJ6fFzDQU5ZYG1ddd6zfM/r6q+rWr0UzYP0lSy4M8ikjqherbYSq7zG
         zmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lzH4aC313mJST3ZULspMhUqFXGrLZXE+Kj3cGLbwBHE=;
        b=R9KUR2QZYyvpVotDw8dLBvj7J+PHkY8VWP/x7NkmupdatFRrUZGXAmwsVZlNc1Kl9i
         f90I3xfWZvnb+i6gPPet2+Etf0jaKMaek6v0N83v9iOfOk1Vq3b5k6mW1ok/TTmnZnf9
         e4hs4zQ66QQHg0rdCqXfELD2WJ7/gXuxI6+gomJo+6KHqlwEK8mC1GrxwFWCPiDkLAGq
         I7ayhUtBtpZF3RErswkwpu5PejCib1RjGaE1rXSDKmru6Eq302j+BGZkAA9bOzbmane/
         Va4UE8AnI3afKe//l32meSJJUR9qgusst++71/qKHd4vQsHDLtMcKUCRXy5fNwvEkGq6
         m9Vw==
X-Gm-Message-State: APjAAAVmXW88OYrYbxeKC6EPGn3y5ldCMyjGWZl3XDVzNbYnNgo/Erje
        NImGJpMFWd2GGHc0bJTcI3l4Yi28
X-Google-Smtp-Source: APXvYqzmQAg9oyfKicj71Q6j526JAvMLCHFFPp0uyRflq4THOHHmhbG3UXLhHc0n5jWhRqEi++EWaQ==
X-Received: by 2002:adf:e683:: with SMTP id r3mr22326437wrm.286.1554054910657;
        Sun, 31 Mar 2019 10:55:10 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:09 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com
Subject: [PATCH v3 00/25] Add generic support for composing LED class device name
Date:   Sun, 31 Mar 2019 19:54:36 +0200
Message-Id: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Jacek Anaszewski (25):
  leds: class: Improve LED and LED flash class registration API
  dt-bindings: leds: Add LED_FUNCTION definitions
  dt-bindings: leds: Add LED_COLOR_ID definitions
  dt-bindings: leds: Add function, color and led-enumerator properties
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

 .../devicetree/bindings/leds/ams,as3645a.txt       | 22 +++--
 Documentation/devicetree/bindings/leds/common.txt  | 61 ++++++++++++--
 .../devicetree/bindings/leds/leds-aat1290.txt      | 12 ++-
 .../devicetree/bindings/leds/leds-an30259a.txt     | 22 +++--
 .../devicetree/bindings/leds/leds-cr0014114.txt    | 26 ++++--
 .../devicetree/bindings/leds/leds-gpio.txt         | 23 ++++--
 .../devicetree/bindings/leds/leds-lm3601x.txt      | 10 ++-
 .../devicetree/bindings/leds/leds-lm3692x.txt      |  9 +-
 .../devicetree/bindings/leds/leds-lp8860.txt       |  9 +-
 .../devicetree/bindings/leds/leds-lt3593.txt       | 11 ++-
 .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  | 10 ++-
 Documentation/leds/leds-class.txt                  | 27 +++++-
 drivers/leds/led-class-flash.c                     |  9 +-
 drivers/leds/led-class.c                           | 58 +++++++++----
 drivers/leds/led-core.c                            | 96 ++++++++++++++++++++++
 drivers/leds/leds-aat1290.c                        | 14 ++--
 drivers/leds/leds-an30259a.c                       | 25 +++---
 drivers/leds/leds-as3645a.c                        | 69 ++++++----------
 drivers/leds/leds-cr0014114.c                      | 33 +++-----
 drivers/leds/leds-gpio.c                           | 23 +++---
 drivers/leds/leds-lm3601x.c                        | 38 ++++-----
 drivers/leds/leds-lm3692x.c                        | 22 ++---
 drivers/leds/leds-lp8860.c                         | 35 ++++----
 drivers/leds/leds-lt3593.c                         | 20 ++---
 drivers/leds/leds-sc27xx-bltc.c                    | 22 ++---
 include/dt-bindings/leds/common.h                  | 47 +++++++++++
 include/linux/led-class-flash.h                    | 15 ++--
 include/linux/leds.h                               | 78 +++++++++++++++---
 tools/leds/get_led_device_info.sh                  | 81 ++++++++++++++++++
 29 files changed, 660 insertions(+), 267 deletions(-)
 create mode 100755 tools/leds/get_led_device_info.sh

-- 
2.11.0

