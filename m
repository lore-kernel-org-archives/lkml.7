Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C7FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09A3218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3DukZ5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390805AbfDXRxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:53:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38671 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390252AbfDXRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:53:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so9743025pgl.5;
        Wed, 24 Apr 2019 10:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPuHtIqDgEwVTxPf5oUAzdbmrFLZLXxz4u1QOVxw17s=;
        b=P3DukZ5CazOUaFqxsp5C6d25Xjo51F5LGUHh1VZqJPRVzfmWyjGvVjTJS8TMPkyRXN
         wzAStM59sNzflnBraWOBClktstWjyelOIU9lDi2Qyud3RzqPKF4UXsoz1GDLjx5+vuv8
         BsXThzjLvgf9cm4BF+7+noQ4/xEWQY8yRSDPVymmqlmapeoKSpaBfJxWdWqiT4E1C9i1
         yjOvcLNkozR1ts6OTWNTMf0v0NQg+6ebjyG7DoyeGCE8NI1voA/3yzv6QDsMsx52hjjo
         ff+69EEMXG602yFBzOhqOUZgNf0sPnZVQHvTrmz80Ym6T50l73WVPOmUroujWs+p5em6
         y/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPuHtIqDgEwVTxPf5oUAzdbmrFLZLXxz4u1QOVxw17s=;
        b=dvD/JZnWL0pkO8LYQblRhmHpfVip3VETxExuykwTiWYm5tjCkIuTNQZX/6RdQ1M6mb
         Jsfb/VJGsM8rIgUJSkwJXQ/nimGKitvhJSPbSe10NcEEixAgIqegQLi28p6IFtqdqQSc
         jKEkuU9WcZA1LHmA/61n1AEwItfgLr202zYUiLF5j66zUOTloKXtTmchsEmo3OpJjGuY
         pwO4mMYpXj/nQED7IeUl7Rcpck0wpvIC5eaMhuNzpQj2UgoGRt4OHVfe/X8S8pzckUpL
         eoWeu7VRoLiLc+5gvDo4KikfzC5UX6TXrY/9qm9l7+46W01wUW+dPWc2r6JA8a2R+twB
         tIrA==
X-Gm-Message-State: APjAAAXnMiTzT5TFe5q+XuLsWiyIkKQYMtJeLRlZA6QfAq+OENPELPFR
        z08WRB58YNnaiHiZ50xWWh8=
X-Google-Smtp-Source: APXvYqyxgdBgQquztZP3pb0yqfUu0mNagvIlpzZjcmaglmncRxRMg3PkflI4CPtIy9RIAUvrGJ8xug==
X-Received: by 2002:a63:7843:: with SMTP id t64mr31727123pgc.130.1556128429835;
        Wed, 24 Apr 2019 10:53:49 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:53:48 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 00/23] Include linux ACPI docs into Sphinx TOC tree
Date:   Thu, 25 Apr 2019 01:52:43 +0800
Message-Id: <20190424175306.25880-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
The kernel now uses Sphinx to generate intelligent and beautiful documentation
from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
reST format in this serias.

The hieararchy of ACPI docs are based on Corbet's suggestion:
https://lkml.org/lkml/2019/4/3/1047
I did some adjustment according to the content and finally they are placed as:
Documentation/firmware-guide/acpi/
├── acpi-lid.rst
├── aml-debugger.rst
├── apei
│   ├── einj.rst
│   └── output_format.rst
├── debug.rst
├── dsd
│   ├── data-node-references.rst
│   └── graph.rst
├── DSD-properties-rules.rst
├── enumeration.rst
├── gpio-properties.rst
├── i2c-muxes.rst
├── lpit.rst
├── method-customizing.rst
├── method-tracing.rst
├── namespace.rst
├── osi.rst
└── video_extension.rst
Documentation/driver-api/acpi/
├── linuxized-acpica.rst
└── scan_handlers.rst
ocumentation/admin-guide/acpi/
├── cppc_sysfs.rst
├── dsdt-override.rst
├── initrd_table_override.rst
└── ssdt-overlays.rst

For you to preview, please visit below url:
http://www.bytemem.com:8080/kernel-doc/index.html

Many thanks for all the comments!

v5: Fix all comments from Mauro. Thanks for your careful review!

Changbin Du (23):
  Documentation: ACPI: move namespace.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move enumeration.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move osi.txt to firmware-guide/acpi and convert
    to reST
  Documentation: ACPI: move linuxized-acpica.txt to driver-api/acpi and
    convert to  reST
  Documentation: ACPI: move scan_handlers.txt to driver-api/acpi and
    convert to reST
  Documentation: ACPI: move DSD-properties-rules.txt to
    firmware-guide/acpi and covert to reST
  Documentation: ACPI: move gpio-properties.txt to firmware-guide/acpi
    and convert to reST
  Documentation: ACPI: move method-customizing.txt to
    firmware-guide/acpi and convert to reST
  Documentation: ACPI: move initrd_table_override.txt to
    admin-guide/acpi and convert to reST
  Documentation: ACPI: move dsdt-override.txt to admin-guide/acpi and
    convert to reST
  Documentation: ACPI: move i2c-muxes.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move acpi-lid.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move dsd/graph.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move dsd/data-node-references.txt to
    firmware-guide/acpi and convert to reST
  Documentation: ACPI: move debug.txt to firmware-guide/acpi and convert
    to reST
  Documentation: ACPI: move method-tracing.txt to firmware-guide/acpi
    and convert to rsST
  Documentation: ACPI: move aml-debugger.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move apei/output_format.txt to
    firmware-guide/acpi and convert to reST
  Documentation: ACPI: move apei/einj.txt to firmware-guide/acpi and
    convert to reST
  Documentation: ACPI: move cppc_sysfs.txt to admin-guide/acpi and
    convert to reST
  Documentation: ACPI: move lpit.txt to firmware-guide/acpi and convert
    to reST
  Documentation: ACPI: move ssdt-overlays.txt to admin-guide/acpi and
    convert to reST
  Documentation: ACPI: move video_extension.txt to firmware-guide/acpi
    and convert to reST

 Documentation/acpi/aml-debugger.txt           |  66 ----
 Documentation/acpi/apei/output_format.txt     | 147 ---------
 Documentation/acpi/i2c-muxes.txt              |  58 ----
 Documentation/acpi/initrd_table_override.txt  | 111 -------
 Documentation/acpi/method-customizing.txt     |  73 -----
 Documentation/acpi/method-tracing.txt         | 192 ------------
 Documentation/acpi/ssdt-overlays.txt          | 172 ----------
 .../acpi/cppc_sysfs.rst}                      |  71 +++--
 .../acpi/dsdt-override.rst}                   |   8 +-
 Documentation/admin-guide/acpi/index.rst      |   4 +
 .../acpi/initrd_table_override.rst            | 115 +++++++
 .../admin-guide/acpi/ssdt-overlays.rst        | 180 +++++++++++
 Documentation/driver-api/acpi/index.rst       |   2 +
 .../acpi/linuxized-acpica.rst}                | 109 ++++---
 .../acpi/scan_handlers.rst}                   |  24 +-
 .../acpi/DSD-properties-rules.rst}            |  21 +-
 .../acpi/acpi-lid.rst}                        |  40 ++-
 .../firmware-guide/acpi/aml-debugger.rst      |  75 +++++
 .../acpi/apei/einj.rst}                       |  94 +++---
 .../acpi/apei/output_format.rst               | 150 +++++++++
 .../acpi/debug.rst}                           |  31 +-
 .../acpi/dsd/data-node-references.rst}        |  36 ++-
 .../acpi/dsd/graph.rst}                       | 157 +++++-----
 .../acpi/enumeration.rst}                     | 135 ++++----
 .../acpi/gpio-properties.rst}                 |  78 +++--
 .../firmware-guide/acpi/i2c-muxes.rst         |  61 ++++
 Documentation/firmware-guide/acpi/index.rst   |  17 +
 .../lpit.txt => firmware-guide/acpi/lpit.rst} |  18 +-
 .../acpi/method-customizing.rst               |  89 ++++++
 .../firmware-guide/acpi/method-tracing.rst    | 238 ++++++++++++++
 .../acpi/namespace.rst}                       | 294 +++++++++---------
 .../osi.txt => firmware-guide/acpi/osi.rst}   |  15 +-
 .../acpi/video_extension.rst}                 |  83 +++--
 MAINTAINERS                                   |   2 +-
 34 files changed, 1606 insertions(+), 1360 deletions(-)
 delete mode 100644 Documentation/acpi/aml-debugger.txt
 delete mode 100644 Documentation/acpi/apei/output_format.txt
 delete mode 100644 Documentation/acpi/i2c-muxes.txt
 delete mode 100644 Documentation/acpi/initrd_table_override.txt
 delete mode 100644 Documentation/acpi/method-customizing.txt
 delete mode 100644 Documentation/acpi/method-tracing.txt
 delete mode 100644 Documentation/acpi/ssdt-overlays.txt
 rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)
 rename Documentation/{acpi/dsdt-override.txt => admin-guide/acpi/dsdt-override.rst} (56%)
 create mode 100644 Documentation/admin-guide/acpi/initrd_table_override.rst
 create mode 100644 Documentation/admin-guide/acpi/ssdt-overlays.rst
 rename Documentation/{acpi/linuxized-acpica.txt => driver-api/acpi/linuxized-acpica.rst} (80%)
 rename Documentation/{acpi/scan_handlers.txt => driver-api/acpi/scan_handlers.rst} (90%)
 rename Documentation/{acpi/DSD-properties-rules.txt => firmware-guide/acpi/DSD-properties-rules.rst} (88%)
 rename Documentation/{acpi/acpi-lid.txt => firmware-guide/acpi/acpi-lid.rst} (86%)
 create mode 100644 Documentation/firmware-guide/acpi/aml-debugger.rst
 rename Documentation/{acpi/apei/einj.txt => firmware-guide/acpi/apei/einj.rst} (67%)
 create mode 100644 Documentation/firmware-guide/acpi/apei/output_format.rst
 rename Documentation/{acpi/debug.txt => firmware-guide/acpi/debug.rst} (91%)
 rename Documentation/{acpi/dsd/data-node-references.txt => firmware-guide/acpi/dsd/data-node-references.rst} (71%)
 rename Documentation/{acpi/dsd/graph.txt => firmware-guide/acpi/dsd/graph.rst} (56%)
 rename Documentation/{acpi/enumeration.txt => firmware-guide/acpi/enumeration.rst} (87%)
 rename Documentation/{acpi/gpio-properties.txt => firmware-guide/acpi/gpio-properties.rst} (81%)
 create mode 100644 Documentation/firmware-guide/acpi/i2c-muxes.rst
 rename Documentation/{acpi/lpit.txt => firmware-guide/acpi/lpit.rst} (68%)
 create mode 100644 Documentation/firmware-guide/acpi/method-customizing.rst
 create mode 100644 Documentation/firmware-guide/acpi/method-tracing.rst
 rename Documentation/{acpi/namespace.txt => firmware-guide/acpi/namespace.rst} (56%)
 rename Documentation/{acpi/osi.txt => firmware-guide/acpi/osi.rst} (97%)
 rename Documentation/{acpi/video_extension.txt => firmware-guide/acpi/video_extension.rst} (70%)

-- 
2.20.1

