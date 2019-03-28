Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB628C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8EB2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJjCI+QR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfC1Q1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:27:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34106 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1Q1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:27:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so10220864pfd.1;
        Thu, 28 Mar 2019 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hys5XWK16NK0DvPqdVaviTNRazNN4qav5JwIyqF0Kvc=;
        b=QJjCI+QRN7+XUegfOLzBjfTOd1zorDKsdVwhEbv89vMSjVGEHXPVbbyPjxrmbjvz+s
         AhdSGNE5pU6FjsSc816cxLd3iQDZUN8fl2TOnNk0SL5T90obAHWoYgC5DV3Rar59z9UN
         5ULOtMf9wEsvKA90p+54rxdf/PeofZPYoITLPWwbo93DSjwZZ4AS2IJnOI87slYVIyJd
         Ibd8yxznMGNw0a7oKwn3Uv7FD+L7054X1/+38tw1Cc9JL/TGJa7b2mpArh0C7sKDHuNN
         oaQT8IP7P4q+20yxryA31YiEtZfb30OSDF/ezuEuAWCPmBa2I60znVHH/WSXBXXz6ZvW
         ad+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hys5XWK16NK0DvPqdVaviTNRazNN4qav5JwIyqF0Kvc=;
        b=KRvBlyHnyI174Vgrl7vaBLM9kGUCYpCpJ5AOR0Srhh3AGaHZ08eWivOcfl7qfjrLZv
         iPMMzVbLEb9f6aAR4samHnm+WrRlxEgjB5PLk+dxp7rpOepiktsoeHVGWxn6VQ+sNq3J
         0H/JCbeB3wNEJKmv53oOwwcPH63mwyuq3lsvfYfdZ7k3nJxGHheIetCrSWIBC3vO6pjT
         lNWTsC9gAHm7KZdHOZ1d5+zuUTFM0Q2X5xAYpHTqJzfL7LFzqngNQm0au/seIbnnjhys
         kurg7W3J04v3aKWXlZvKKJDxSnovtHFOWN6031JLlUhBs5uMEyEHJA4XwtfTCoJiFKCw
         IpEg==
X-Gm-Message-State: APjAAAUnLNs7A5JCSCSryUx3YOqpCKMr0s6Iet//V7xA4CNlzfjbtxVv
        6eSxO4MahozgslHL/x4wz8U=
X-Google-Smtp-Source: APXvYqxVyHLK27bv9iE6QyX/8oHHQx7cQiZJlHllIx6DQqQaK7EUorqGB6nWkvPhsYIpVougLMExYw==
X-Received: by 2002:a63:6883:: with SMTP id d125mr41160905pgc.324.1553790460136;
        Thu, 28 Mar 2019 09:27:40 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:27:39 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 00/23] Include linux ACPI docs into Sphinx TOC tree
Date:   Fri, 29 Mar 2019 00:26:58 +0800
Message-Id: <20190328162721.26138-1-changbin.du@gmail.com>
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

Changbin Du (23):
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
  acpi doc: convert acpi/debug.txt to rst format
  acpi doc: convert acpi/method-tracing.txt to rst format
  acpi doc: convert acpi/aml-debugger.txt to rst format
  acpi doc: convert acpi/apei/output_format.txt to rst format
  acpi doc: convert acpi/apei/einj.txt to rst format
  acpi doc: convert acpi/cppc_sysfs.txt to rst format
  acpi doc: convert acpi/lpit.txt to rst format
  acpi doc: convert acpi/ssdt-overlays.txt to rst format
  acpi doc: convert acpi/video_extension.txt to rst format

 ...ies-rules.txt => DSD-properties-rules.rst} |  19 +-
 .../acpi/{acpi-lid.txt => acpi-lid.rst}       |  47 ++-
 Documentation/acpi/aml-debugger.rst           |  74 +++++
 Documentation/acpi/aml-debugger.txt           |  66 ----
 .../acpi/apei/{einj.txt => einj.rst}          |  96 +++---
 Documentation/acpi/apei/output_format.rst     | 148 +++++++++
 Documentation/acpi/apei/output_format.txt     | 147 ---------
 .../acpi/{cppc_sysfs.txt => cppc_sysfs.rst}   |  69 ++--
 Documentation/acpi/{debug.txt => debug.rst}   |  31 +-
 ...eferences.txt => data-node-references.rst} |  27 +-
 .../acpi/dsd/{graph.txt => graph.rst}         | 155 ++++-----
 .../{dsdt-override.txt => dsdt-override.rst}  |   6 +-
 .../acpi/{enumeration.txt => enumeration.rst} | 133 ++++----
 ...pio-properties.txt => gpio-properties.rst} |  76 +++--
 Documentation/acpi/i2c-muxes.rst              |  59 ++++
 Documentation/acpi/i2c-muxes.txt              |  58 ----
 Documentation/acpi/index.rst                  |  30 ++
 Documentation/acpi/initrd_table_override.rst  | 118 +++++++
 Documentation/acpi/initrd_table_override.txt  | 111 -------
 ...uxized-acpica.txt => linuxized-acpica.rst} | 114 ++++---
 Documentation/acpi/{lpit.txt => lpit.rst}     |  16 +-
 Documentation/acpi/method-customizing.rst     |  80 +++++
 Documentation/acpi/method-customizing.txt     |  73 -----
 Documentation/acpi/method-tracing.rst         | 224 +++++++++++++
 Documentation/acpi/method-tracing.txt         | 192 -----------
 .../acpi/{namespace.txt => namespace.rst}     | 309 +++++++++---------
 Documentation/acpi/{osi.txt => osi.rst}       |  13 +-
 .../{scan_handlers.txt => scan_handlers.rst}  |  23 +-
 .../{ssdt-overlays.txt => ssdt-overlays.rst}  | 166 +++++-----
 ...ideo_extension.txt => video_extension.rst} |  61 ++--
 Documentation/index.rst                       |   1 +
 31 files changed, 1463 insertions(+), 1279 deletions(-)
 rename Documentation/acpi/{DSD-properties-rules.txt => DSD-properties-rules.rst} (89%)
 rename Documentation/acpi/{acpi-lid.txt => acpi-lid.rst} (78%)
 create mode 100644 Documentation/acpi/aml-debugger.rst
 delete mode 100644 Documentation/acpi/aml-debugger.txt
 rename Documentation/acpi/apei/{einj.txt => einj.rst} (68%)
 create mode 100644 Documentation/acpi/apei/output_format.rst
 delete mode 100644 Documentation/acpi/apei/output_format.txt
 rename Documentation/acpi/{cppc_sysfs.txt => cppc_sysfs.rst} (51%)
 rename Documentation/acpi/{debug.txt => debug.rst} (91%)
 rename Documentation/acpi/dsd/{data-node-references.txt => data-node-references.rst} (80%)
 rename Documentation/acpi/dsd/{graph.txt => graph.rst} (56%)
 rename Documentation/acpi/{dsdt-override.txt => dsdt-override.rst} (63%)
 rename Documentation/acpi/{enumeration.txt => enumeration.rst} (87%)
 rename Documentation/acpi/{gpio-properties.txt => gpio-properties.rst} (82%)
 create mode 100644 Documentation/acpi/i2c-muxes.rst
 delete mode 100644 Documentation/acpi/i2c-muxes.txt
 create mode 100644 Documentation/acpi/index.rst
 create mode 100644 Documentation/acpi/initrd_table_override.rst
 delete mode 100644 Documentation/acpi/initrd_table_override.txt
 rename Documentation/acpi/{linuxized-acpica.txt => linuxized-acpica.rst} (78%)
 rename Documentation/acpi/{lpit.txt => lpit.rst} (70%)
 create mode 100644 Documentation/acpi/method-customizing.rst
 delete mode 100644 Documentation/acpi/method-customizing.txt
 create mode 100644 Documentation/acpi/method-tracing.rst
 delete mode 100644 Documentation/acpi/method-tracing.txt
 rename Documentation/acpi/{namespace.txt => namespace.rst} (54%)
 rename Documentation/acpi/{osi.txt => osi.rst} (97%)
 rename Documentation/acpi/{scan_handlers.txt => scan_handlers.rst} (91%)
 rename Documentation/acpi/{ssdt-overlays.txt => ssdt-overlays.rst} (50%)
 rename Documentation/acpi/{video_extension.txt => video_extension.rst} (80%)

-- 
2.20.1

