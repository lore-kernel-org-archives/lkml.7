Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71587C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8989A2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZ0/y/Ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfDYPbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:31:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43265 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYPbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:31:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so17710pgu.10;
        Thu, 25 Apr 2019 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38uz3qJNPvtDRMAt1xDrXWeaVF5xlbamdqed+OfZn+E=;
        b=uZ0/y/Mls3TIS2W94diWWMLbkQi4vN3XpTJrZPsHzlrU3dQVgRAgBxiRX20Ynd2pOV
         Kedu24tJ9bD/n4LWcVDT+4XXepndPCeosMaDvjjByhsUgBqo9fsaPLNZ7A5cJs3BdpVr
         6XtGsYeDGWqrVEAWO3SmSKFVLHTRDDJcBWVYKOTgmhoDB9ZuB+humMRDlaJlXP4YFX4B
         h0bJktvWFhjU0aToCZNJRuGUB+TWBVOEI9JV5lXskoFstVym5kEeoAkjYFiFeLRVZ3Nj
         uP1YpATEuVZaWN+EjnNQzd+de4ekJCFUkWEqbj+rqtv87aX/Q6MUwnalMElgfEgR/jf5
         MC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38uz3qJNPvtDRMAt1xDrXWeaVF5xlbamdqed+OfZn+E=;
        b=ci7uEFWbKvNSs3/670UizuG7ZT5TJnI4uyVL2sGLYGRmwcnNTeHtil8Hv2f70Zw656
         b2fqQjU9C+O8e1LcYbMaWX3AGINcT5iCckE2rMaqhs6gVwKOrvi0+o2S2B1MIEUhxgxo
         hfUVX3wCa3wfW1C5RF3+AiY/GTQs8wddnrzS8NQ5ADOJadI5jydhT9fP+vlSgOerG4Jv
         4gKqULSemWvwYMKPxVpmE4URl4EVtqgfezi4BBZACstMfErqb3nqhNl4c2Sx0Rhev5gl
         nxRpa5Re1iyx6Yh4ppFvVmwEm0anNd7VpuLKPLtbmnLh+fftUYsQGXs9zBJsNmEw/UZ7
         tC4A==
X-Gm-Message-State: APjAAAXp+iEMkerOsXYq9oH9LAxjggGB6BDkKHDQuDQFgQDR+0i3dMVE
        mMDmfoIgVSJwuKHce0GwOwY=
X-Google-Smtp-Source: APXvYqz4vstQOb+DmzkKaxVX1jZv48TV1t+eOGfn+77NOzK+ntFfMZpuZbEP4+D+DuaxqbiN8B/eiA==
X-Received: by 2002:aa7:884b:: with SMTP id k11mr21257474pfo.49.1556206294356;
        Thu, 25 Apr 2019 08:31:34 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:31:33 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 00/24] Include linux ACPI docs into Sphinx TOC tree
Date:   Thu, 25 Apr 2019 23:30:53 +0800
Message-Id: <20190425153117.16057-1-changbin.du@gmail.com>
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

v6: add a missed patch.
v5: Fix all comments from Mauro. Thanks for your careful review!

Changbin Du (24):
  Documentation: add Linux ACPI to Sphinx TOC tree
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
 Documentation/admin-guide/acpi/index.rst      |  14 +
 .../acpi/initrd_table_override.rst            | 115 +++++++
 .../admin-guide/acpi/ssdt-overlays.rst        | 180 +++++++++++
 Documentation/admin-guide/index.rst           |   1 +
 Documentation/driver-api/acpi/index.rst       |   9 +
 .../acpi/linuxized-acpica.rst}                | 109 ++++---
 .../acpi/scan_handlers.rst}                   |  24 +-
 Documentation/driver-api/index.rst            |   1 +
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
 Documentation/firmware-guide/acpi/index.rst   |  26 ++
 .../lpit.txt => firmware-guide/acpi/lpit.rst} |  18 +-
 .../acpi/method-customizing.rst               |  89 ++++++
 .../firmware-guide/acpi/method-tracing.rst    | 238 ++++++++++++++
 .../acpi/namespace.rst}                       | 294 +++++++++---------
 .../osi.txt => firmware-guide/acpi/osi.rst}   |  15 +-
 .../acpi/video_extension.rst}                 |  85 +++--
 Documentation/firmware-guide/index.rst        |  13 +
 Documentation/index.rst                       |  10 +
 MAINTAINERS                                   |   2 +-
 38 files changed, 1659 insertions(+), 1360 deletions(-)
 delete mode 100644 Documentation/acpi/aml-debugger.txt
 delete mode 100644 Documentation/acpi/apei/output_format.txt
 delete mode 100644 Documentation/acpi/i2c-muxes.txt
 delete mode 100644 Documentation/acpi/initrd_table_override.txt
 delete mode 100644 Documentation/acpi/method-customizing.txt
 delete mode 100644 Documentation/acpi/method-tracing.txt
 delete mode 100644 Documentation/acpi/ssdt-overlays.txt
 rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)
 rename Documentation/{acpi/dsdt-override.txt => admin-guide/acpi/dsdt-override.rst} (56%)
 create mode 100644 Documentation/admin-guide/acpi/index.rst
 create mode 100644 Documentation/admin-guide/acpi/initrd_table_override.rst
 create mode 100644 Documentation/admin-guide/acpi/ssdt-overlays.rst
 create mode 100644 Documentation/driver-api/acpi/index.rst
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
 create mode 100644 Documentation/firmware-guide/acpi/index.rst
 rename Documentation/{acpi/lpit.txt => firmware-guide/acpi/lpit.rst} (68%)
 create mode 100644 Documentation/firmware-guide/acpi/method-customizing.rst
 create mode 100644 Documentation/firmware-guide/acpi/method-tracing.rst
 rename Documentation/{acpi/namespace.txt => firmware-guide/acpi/namespace.rst} (56%)
 rename Documentation/{acpi/osi.txt => firmware-guide/acpi/osi.rst} (97%)
 rename Documentation/{acpi/video_extension.txt => firmware-guide/acpi/video_extension.rst} (68%)
 create mode 100644 Documentation/firmware-guide/index.rst

-- 
2.20.1

