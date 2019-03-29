Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E26C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2769621850
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA6y2IaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfC2ALy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:11:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47052 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfC2ALy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:11:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so279007pgv.13;
        Thu, 28 Mar 2019 17:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VzXGDK1c00He5FH1H3fHSIHRMUkNlWro80SC65ZmM0k=;
        b=QA6y2IaTmpb10yxXTjvjrdicwG5v5A8WSEixxkNPfj4ypTXZpTooWX9NjlICNdz/VR
         AN422vHlyaPqYtmeB09vDj2Z24uUMzjDYbzVopRnjIIwpZtJOPPU59VehvW20WNlASgl
         33TKLxSmB4wdSxL4EJA8AquXJKjf8ESwuSdk5oGFNr9gdoBTmsVESk9rqQhswwNHPPnh
         FZM0voGZ2gH04u8OtIYDLtuITkGFiJl3BOVOZZ+HEk5gXxZnjXglskJY8MalACVI1nF6
         kBcVq5E0uHvrDOFaUN3QFHMQnM8JzZMAlOqF2h6RjWJhe20SNdVPer04pzBnUeuEObl8
         fPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VzXGDK1c00He5FH1H3fHSIHRMUkNlWro80SC65ZmM0k=;
        b=fBoy1yLnuY+zmKIccipPqODTtmgPaF7dYkZzlvhWblvpTHmLN3LgGICxa1ajhy1iQA
         rnZB5MqAUzupciSgJVXmtl9MamVslHpKx/Vy1xmy69cl+roQ0GEga01lEdSIrn3NMQk0
         hq94iTcfv4zBJ2ED1T2W6KfSqixndZfJOlCInuOlpP9phpOavwd0S+6B51joiMm6QZ8G
         hOC5TKsr6Zf49hBsCFNyf8QG5pnQaxRO0xPjyFdFBgzwuC79xDX7c61e6QwyxJszkJCb
         rjuSm4bo5XNoEMdDLBQPgZxvXpLxXGtswIuDNNkgDNotRhvkDfOHr413sOz24bSsvgRD
         wcHg==
X-Gm-Message-State: APjAAAXdB2nxtTEqrDvUmkFF7FHF1tU9RGCYWgoqgaIxVirbSIVg1I8B
        aV8qrIHnGMfo9vtNxW0Rpib3HlOfoDk=
X-Google-Smtp-Source: APXvYqySzJnDhucsClJuKxiq4AXy9wl0Z86y5nhWSzNP6E8ssz/SCVlYgjkDzul06mYTvSc/2FJViQ==
X-Received: by 2002:a62:565c:: with SMTP id k89mr44094785pfb.175.1553818313166;
        Thu, 28 Mar 2019 17:11:53 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:11:52 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
Date:   Fri, 29 Mar 2019 08:11:11 +0800
Message-Id: <20190329001135.15847-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corbet and All,
The kernel now uses Sphinx to generate intelligent and beautiful documentation
from reStructuredText files. I converted most of the Linux ACPI docs to rst
format in this serias.

For you to preview, please visit below url:
http://104.238.181.70:8080/kernel-doc/acpi/index.html

Thank you!

v2:
  o Update MAINTAINERS.
  o Add SPDX tags for all docs.

Changbin Du (24):
  Documentation: add Linux ACPI to Sphinx TOC tree
  acpi doc: convert acpi/namespace.txt to rst format
  acpi doc: convert acpi/enumeration.txt to rst format
  acpi doc: convert acpi/osi.txt to rst format
  acpi doc: convert acpi/linuxized-acpica.txt to rst format
  acpi doc: convert acpi/scan_handlers.txt to rst format
  acpi doc: convert acpi/DSD-properties-rules.txt to rst format
  acpi doc: convert acpi/gpio-properties.txt to rst format
  acpi doc: convert acpi/method-customizing.txt to rst format
  acpi doc: convert acpi/initrd_table_override.txt to rst format
  acpi doc: convert acpi/dsdt-override.txt to rst format
  acpi doc: convert acpi/i2c-muxes.txt to rst format
  acpi doc: convert acpi/acpi-lid.txt to rst format
  acpi doc: convert acpi/dsd/graph.txt to rst format
  acpi doc: convert acpi/dsd/data-node-references.txt to rst format
  acpi doc: convert acpi/debug.txt to rst format
  acpi doc: convert acpi/method-tracing.txt to rst format
  acpi doc: convert acpi/aml-debugger.txt to rst format
  acpi doc: convert acpi/apei/output_format.txt to rst format
  acpi doc: convert acpi/apei/einj.txt to rst format
  acpi doc: convert acpi/cppc_sysfs.txt to rst format
  acpi doc: convert acpi/lpit.txt to rst format
  acpi doc: convert acpi/ssdt-overlays.txt to rst format
  acpi doc: convert acpi/video_extension.txt to rst format

 ...ies-rules.txt => DSD-properties-rules.rst} |  21 +-
 .../acpi/{acpi-lid.txt => acpi-lid.rst}       |  48 ++-
 Documentation/acpi/aml-debugger.rst           |  75 +++++
 Documentation/acpi/aml-debugger.txt           |  66 ----
 .../acpi/apei/{einj.txt => einj.rst}          |  98 +++---
 Documentation/acpi/apei/output_format.rst     | 150 +++++++++
 Documentation/acpi/apei/output_format.txt     | 147 ---------
 .../acpi/{cppc_sysfs.txt => cppc_sysfs.rst}   |  71 ++--
 Documentation/acpi/{debug.txt => debug.rst}   |  31 +-
 ...eferences.txt => data-node-references.rst} |  28 +-
 .../acpi/dsd/{graph.txt => graph.rst}         | 157 ++++-----
 .../{dsdt-override.txt => dsdt-override.rst}  |   8 +-
 .../acpi/{enumeration.txt => enumeration.rst} | 135 ++++----
 ...pio-properties.txt => gpio-properties.rst} |  78 +++--
 Documentation/acpi/i2c-muxes.rst              |  61 ++++
 Documentation/acpi/i2c-muxes.txt              |  58 ----
 Documentation/acpi/index.rst                  |  32 ++
 Documentation/acpi/initrd_table_override.rst  | 120 +++++++
 Documentation/acpi/initrd_table_override.txt  | 111 -------
 ...uxized-acpica.txt => linuxized-acpica.rst} | 115 ++++---
 Documentation/acpi/{lpit.txt => lpit.rst}     |  18 +-
 Documentation/acpi/method-customizing.rst     |  82 +++++
 Documentation/acpi/method-customizing.txt     |  73 -----
 Documentation/acpi/method-tracing.rst         | 225 +++++++++++++
 Documentation/acpi/method-tracing.txt         | 192 -----------
 .../acpi/{namespace.txt => namespace.rst}     | 310 +++++++++---------
 Documentation/acpi/{osi.txt => osi.rst}       |  15 +-
 .../{scan_handlers.txt => scan_handlers.rst}  |  24 +-
 Documentation/acpi/ssdt-overlays.rst          | 180 ++++++++++
 Documentation/acpi/ssdt-overlays.txt          | 172 ----------
 ...ideo_extension.txt => video_extension.rst} |  63 ++--
 Documentation/index.rst                       |   1 +
 MAINTAINERS                                   |   2 +-
 33 files changed, 1596 insertions(+), 1371 deletions(-)
 rename Documentation/acpi/{DSD-properties-rules.txt => DSD-properties-rules.rst} (88%)
 rename Documentation/acpi/{acpi-lid.txt => acpi-lid.rst} (77%)
 create mode 100644 Documentation/acpi/aml-debugger.rst
 delete mode 100644 Documentation/acpi/aml-debugger.txt
 rename Documentation/acpi/apei/{einj.txt => einj.rst} (67%)
 create mode 100644 Documentation/acpi/apei/output_format.rst
 delete mode 100644 Documentation/acpi/apei/output_format.txt
 rename Documentation/acpi/{cppc_sysfs.txt => cppc_sysfs.rst} (51%)
 rename Documentation/acpi/{debug.txt => debug.rst} (91%)
 rename Documentation/acpi/dsd/{data-node-references.txt => data-node-references.rst} (79%)
 rename Documentation/acpi/dsd/{graph.txt => graph.rst} (56%)
 rename Documentation/acpi/{dsdt-override.txt => dsdt-override.rst} (56%)
 rename Documentation/acpi/{enumeration.txt => enumeration.rst} (87%)
 rename Documentation/acpi/{gpio-properties.txt => gpio-properties.rst} (81%)
 create mode 100644 Documentation/acpi/i2c-muxes.rst
 delete mode 100644 Documentation/acpi/i2c-muxes.txt
 create mode 100644 Documentation/acpi/index.rst
 create mode 100644 Documentation/acpi/initrd_table_override.rst
 delete mode 100644 Documentation/acpi/initrd_table_override.txt
 rename Documentation/acpi/{linuxized-acpica.txt => linuxized-acpica.rst} (78%)
 rename Documentation/acpi/{lpit.txt => lpit.rst} (68%)
 create mode 100644 Documentation/acpi/method-customizing.rst
 delete mode 100644 Documentation/acpi/method-customizing.txt
 create mode 100644 Documentation/acpi/method-tracing.rst
 delete mode 100644 Documentation/acpi/method-tracing.txt
 rename Documentation/acpi/{namespace.txt => namespace.rst} (54%)
 rename Documentation/acpi/{osi.txt => osi.rst} (97%)
 rename Documentation/acpi/{scan_handlers.txt => scan_handlers.rst} (90%)
 create mode 100644 Documentation/acpi/ssdt-overlays.rst
 delete mode 100644 Documentation/acpi/ssdt-overlays.txt
 rename Documentation/acpi/{video_extension.txt => video_extension.rst} (79%)

-- 
2.20.1

