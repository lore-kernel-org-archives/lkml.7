Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AE2C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCD024656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGiv7UgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgAHNMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:12:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33694 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAHNMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:12:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so3382222wrq.0;
        Wed, 08 Jan 2020 05:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CW1vsmVOYVpnu21wOV1FaVQtVlxQeM9zvVeI3WDjoeQ=;
        b=TGiv7UgYOnCvuzeHdEbOimyJWrw0yKav/L80GnMtkV3tQsGQB0qsfwJwoIjI9a8EyY
         Edi0fjN7J30XXnYRBDvH7r9dNEIoUg/OMEesb0PGkwjop57B8UHXxtx//W7JVGu6MpIW
         tl8YijCWvV/pLDOzHl7ZiTXVguS7u2J1rCSftGu1mpKseTBKrmOIVoN+sRMbnhPpFLmh
         XDbB4gKsAzGM0uBcgTjabj/xHFzKuxgFc+giboEvqLY3lexuRV1FCVJJ8st3/lrThiOX
         01giLKsLHfvrMx0vbHbzS5hMDL+1XfeRbKNB/XOwDoh/BCjIFoskOi7PntEsweng0igd
         CVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CW1vsmVOYVpnu21wOV1FaVQtVlxQeM9zvVeI3WDjoeQ=;
        b=ExbJa0NvjYmwlOHSP9PlFZRzZltGTw+2QHhJIXT+R0LhnmMUPgfbJooUrSJl2W0amK
         Aby5/vrD1A7v2bOit3w5F7Pqz2Kn1DUMN5Gq9ZTCBQIpfy7rVZ0IjGF1bTqV/XZSvavO
         VWm2NPPk5LY4F7LC9yXouE3NNw8s5T6IUvW8HlISQexoq+wBvk2kf+LXNoAThrAHQQ9Q
         GSB/xdz3hj0HJed+nEnXDhjzdJfDf0XC+PwzHiTeOACt+iUMex+kKVYioCmaxHDYLkiq
         dd7OImeQCtk1xHHjc3jeUup9OAGIvqtqE3Gom8+O/IVj17+TdTxYYfpsKSfyF7VgrO30
         3jGA==
X-Gm-Message-State: APjAAAVZiQTVTXoVeGiyh2yP8MU4NQCqNkKOsgH+tSkgnvrjE+CPrd/D
        BNJH+nwp24leJPr+CzvAcGU=
X-Google-Smtp-Source: APXvYqw/u2BVw/HyzOF7uxDcGn7emrybdnMAcnzp/hI83PU8kL4Xy2UxLatfb/e8u7n4Ijadyri1gg==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr4468409wro.310.1578489163703;
        Wed, 08 Jan 2020 05:12:43 -0800 (PST)
Received: from localhost.localdomain (p5B3F64F6.dip0.t-ipconnect.de. [91.63.100.246])
        by smtp.gmail.com with ESMTPSA id k82sm3875878wmf.10.2020.01.08.05.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 05:12:42 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Add regulator support for mpq7920
Date:   Wed,  8 Jan 2020 14:12:30 +0100
Message-Id: <20200108131234.24128-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 .../bindings/regulator/mps,mpq7920.yaml       | 202 +++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mpq7920.c                   | 342 ++++++++++++++++++
 drivers/regulator/mpq7920.h                   |  72 ++++
 7 files changed, 636 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
 create mode 100644 drivers/regulator/mpq7920.c
 create mode 100644 drivers/regulator/mpq7920.h

-- 
2.17.1

