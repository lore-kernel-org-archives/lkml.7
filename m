Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D9C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E9D206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3KMmyUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfDBGaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:30:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44581 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBGaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:30:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so6010264pgj.11;
        Mon, 01 Apr 2019 23:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9BsIkZBYglgWK6GSpo0aZ/aTtxs6mxHN7TKHXjgH19w=;
        b=J3KMmyURzg8DeGMM5fCBb5O7IQPLqTE8ub/+e9g46rgM4dWjPbrr622Ll/K7l2kx3L
         hiRECEl2fztLifmV5Aw3FsFGshcfrLdlgHoQXqEGgO0uVlFLdz4w3S2GnMUKT0HPhPP2
         3Vji6Bxk5MwrUYUPbwRs6/0Cn+Y5ac3pUDVg5bWmJrEKzX2cub3jXqU0VT6DyTrElb0r
         S3GgLiBF2fXjwnRLnZLm4SGlBlqRcOpIVQ26fXVnfjp00hWE6PYjSM/h5szHhNAlNGxs
         cU65ms9pRRf5wE2wAbsScI4pgkERCUks4kPtGB+dzxxucfWH+yRtQ50WFZXaqKRR3290
         EGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9BsIkZBYglgWK6GSpo0aZ/aTtxs6mxHN7TKHXjgH19w=;
        b=ElyI+zbosZluwSUz+fsq8ABbQqPLGGQL+OwVuCkQCO+E0sGCjr+7W88T8HQZC241an
         uebsUoGaUpxXgl6yQdTdTjwt61Gyh3pzK7jb/UhEcLoj0WhZmkWXbNxIM66C2MPhecYI
         1VTonH6iaXBy0kvU8tH+0YJFlgCabnNHNbNEPusSOtccIp9/0IskoywDx53Zt1u/gHCG
         XejSKC/NRzD+qr+Mz/Fzhy+O/7ZAZhBkK3XrERBo8Gi5B8snYOkD+Y/Y89M9hIUFs/y6
         IKQGIbT+RuDwP3QWIc+9IP/MdIMmiip2CHUU+GSgztazTi0W8XHKF9COQz9cSbm96JNW
         3Lrg==
X-Gm-Message-State: APjAAAX0ivqqzCmr4LFFtxdNl6SvDThZiqtfzhRvFJ9J/9+BzlXcNgnJ
        G7DBBr0qcTgK0wNdCBUNEQU=
X-Google-Smtp-Source: APXvYqx0obJ8Ofk/95VNnfqwJ+f0hgu5fXiFV5AoyB+rJy+OxFNtuGvsiF99EFeuOhGjc5ANiU5clA==
X-Received: by 2002:a63:ff18:: with SMTP id k24mr66050078pgi.140.1554186610293;
        Mon, 01 Apr 2019 23:30:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 23:30:09 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 00/18] Introduce the Counter subsystem
Date:   Tue,  2 Apr 2019 15:30:35 +0900
Message-Id: <cover.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v10:
  - Fix minor typographical errors in documentation
  - Merge the FlexTimer Module Quadrature decoder counter driver patches

This revision is functionally identical to the last; changes in this
version were made to fix minor typos in the documentation files and also
to pull in the new FTM quadrature decoder counter driver.

The Generic Counter API has been and is still in a feature freeze until
it is merged into the mainline. The following features will be
investigated after the merge: interrupt support for counter devices, and
a character device interface for low-latency applications.

Benjamin Gaignard (2):
  counter: Add STM32 Timer quadrature encoder
  dt-bindings: counter: Document stm32 quadrature encoder

Fabrice Gasnier (2):
  counter: stm32-lptimer: add counter device
  dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move

Patrick Havelange (7):
  include/fsl: add common FlexTimer #defines in a separate header.
  drivers/pwm: pwm-fsl-ftm: use common header for FlexTimer #defines
  drivers/clocksource: timer-fsl-ftm: use common header for FlexTimer
    #defines
  dt-bindings: counter: ftm-quaddec
  counter: add FlexTimer Module Quadrature decoder counter driver
  counter: ftm-quaddec: Documentation: Add specific counter sysfs
    documentation
  LS1021A: dtsi: add ftm quad decoder entries

William Breathitt Gray (7):
  counter: Introduce the Generic Counter interface
  counter: Documentation: Add Generic Counter sysfs documentation
  docs: Add Generic Counter interface documentation
  iio: 104-quad-8: Update license boilerplate
  counter: 104-quad-8: Add Generic Counter interface support
  counter: 104-quad-8: Documentation: Add Generic Counter sysfs
    documentation
  iio: counter: Add deprecation markings for IIO Counter attributes

 Documentation/ABI/testing/sysfs-bus-counter   |  230 +++
 .../ABI/testing/sysfs-bus-counter-104-quad-8  |   36 +
 .../ABI/testing/sysfs-bus-counter-ftm-quaddec |   16 +
 Documentation/ABI/testing/sysfs-bus-iio       |    8 +
 .../testing/sysfs-bus-iio-counter-104-quad-8  |   16 +
 .../bindings/counter/ftm-quaddec.txt          |   18 +
 .../{iio => }/counter/stm32-lptimer-cnt.txt   |    0
 .../bindings/counter/stm32-timer-cnt.txt      |   31 +
 .../devicetree/bindings/mfd/stm32-lptimer.txt |    2 +-
 .../devicetree/bindings/mfd/stm32-timers.txt  |    7 +
 Documentation/driver-api/generic-counter.rst  |  342 ++++
 Documentation/driver-api/index.rst            |    1 +
 MAINTAINERS                                   |   15 +-
 arch/arm/boot/dts/ls1021a.dtsi                |   28 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/clocksource/timer-fsl-ftm.c           |   15 +-
 drivers/{iio => }/counter/104-quad-8.c        |  782 +++++++-
 drivers/counter/Kconfig                       |   60 +
 drivers/counter/Makefile                      |   10 +
 drivers/counter/counter.c                     | 1567 +++++++++++++++++
 drivers/counter/ftm-quaddec.c                 |  356 ++++
 drivers/{iio => }/counter/stm32-lptimer-cnt.c |  361 +++-
 drivers/counter/stm32-timer-cnt.c             |  390 ++++
 drivers/iio/Kconfig                           |    1 -
 drivers/iio/Makefile                          |    1 -
 drivers/iio/counter/Kconfig                   |   34 -
 drivers/iio/counter/Makefile                  |    8 -
 drivers/pwm/pwm-fsl-ftm.c                     |   44 +-
 include/linux/counter.h                       |  510 ++++++
 include/linux/counter_enum.h                  |   45 +
 include/linux/fsl/ftm.h                       |   88 +
 32 files changed, 4877 insertions(+), 148 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
 create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
 rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
 create mode 100644 Documentation/driver-api/generic-counter.rst
 rename drivers/{iio => }/counter/104-quad-8.c (44%)
 create mode 100644 drivers/counter/Kconfig
 create mode 100644 drivers/counter/Makefile
 create mode 100644 drivers/counter/counter.c
 create mode 100644 drivers/counter/ftm-quaddec.c
 rename drivers/{iio => }/counter/stm32-lptimer-cnt.c (51%)
 create mode 100644 drivers/counter/stm32-timer-cnt.c
 delete mode 100644 drivers/iio/counter/Kconfig
 delete mode 100644 drivers/iio/counter/Makefile
 create mode 100644 include/linux/counter.h
 create mode 100644 include/linux/counter_enum.h
 create mode 100644 include/linux/fsl/ftm.h

-- 
2.21.0

