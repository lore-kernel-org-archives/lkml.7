Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA1CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49BC2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK3CjNVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfDZPcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:32:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35899 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDZPcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:32:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so1809400pgc.3;
        Fri, 26 Apr 2019 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMtpBZHNTjBEWM34WtbrMm4mTxd0SDEioc+F71LS1nM=;
        b=EK3CjNVf6y2r0acYRaXnzs9QNGNqfgEBxLnXn43pWGRt1BkjsEeOUWOFB6dlP07RZV
         J3NNuwO9kwKuDWozC9GSsYO2yCjQQUo0bL8SkF3sv0VL7IlHjJm06+WeSH7YLW1uMpZn
         9TU9rbX9Oa/0OKd3HHc2CMYJQRil8h7X1tgkB+vxEy8rjLIZeo5y4vopotEolSrzF6qz
         cZuvzpFudb+8VlBZP8dkLEDURbRVYS+iIhp+2/p0qmxeJ/Q6cOx3MXqzCnrF4LRz23mU
         eaXYq41O98w/jBVM1qQe1bneloHr3QlZxWyomXV+Dntp0wCwGtxSPz89MdvPMdN1lvnx
         rDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMtpBZHNTjBEWM34WtbrMm4mTxd0SDEioc+F71LS1nM=;
        b=jcZfqkSqxqkEfbpdBjccUpX0rRMuITgw5/Mrac1374LdbNujqQtuB+vCtHfalKrhIo
         YOufzdJD3obg2ToK96Q9IsYE7vi2ZB/1rnHIeZZa7Y+e4WIJLEWnCu190sZY2Db/Y+30
         awCJUzo3KTJCXyQVBPTmGF7VqbJnOjm6fznEFFmMAuaJlcXL9WgYF+/cw8a+DAHjO+3k
         YsjHCaR7t2bLJF6dfaI2jPvK8v3CGHyymN4tldOFUSKJvPDgui3dJm8xA7Dd740stg4k
         5pVoBss2izzZOhVSmwYiz2W/QCH0c44ZzmhUIqSwYoLCmsFxjxjaGmPBV1EMs81So9i9
         +2tg==
X-Gm-Message-State: APjAAAXJvX4NkrDyzrLMJq/YS49Zq9xztXJs4t/C/dwnuRZNGVO0hNkT
        s5tKZ0HAbXVr4wTHPD3nDQ2HP3F9
X-Google-Smtp-Source: APXvYqxvJsMFHP2uwN3/jXWoE8Orx1IvFIOnMd1diYlEZGZ8Zzjjj6tluZIigu7LnupZGltHepiK9Q==
X-Received: by 2002:a62:ae06:: with SMTP id q6mr2471258pff.159.1556292732999;
        Fri, 26 Apr 2019 08:32:12 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:32:12 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 00/27] Include linux x86 docs into Sphinx TOC tree
Date:   Fri, 26 Apr 2019 23:31:23 +0800
Message-Id: <20190426153150.21228-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The kernel now uses Sphinx to generate intelligent and beautiful documentation
from reStructuredText files. I converted most of the Linux x86 docs to rst
format in this serias.

For you to preview, please visit below url:
http://www.bytemem.com:8080/kernel-doc/index.html

Thank you!

Changbin Du (27):
  Documentation: add Linux x86 docs to Sphinx TOC tree
  Documentation: x86: convert boot.txt to reST
  Documentation: x86: convert topology.txt to reST
  Documentation: x86: convert exception-tables.txt to reST
  Documentation: x86: convert kernel-stacks to reST
  Documentation: x86: convert entry_64.txt to reST
  Documentation: x86: convert earlyprintk.txt to reST
  Documentation: x86: convert zero-page.txt to reST
  Documentation: x86: convert tlb.txt to reST
  Documentation: x86: convert mtrr.txt to reST
  Documentation: x86: convert pat.txt to reST
  Documentation: x86: convert protection-keys.txt to reST
  Documentation: x86: convert intel_mpx.txt to reST
  Documentation: x86: convert amd-memory-encryption.txt to reST
  Documentation: x86: convert pti.txt to reST
  Documentation: x86: convert microcode.txt to reST
  Documentation: x86: convert resctrl_ui.txt to reST
  Documentation: x86: convert orc-unwinder.txt to reST
  Documentation: x86: convert usb-legacy-support.txt to reST
  Documentation: x86: convert i386/IO-APIC.txt to reST
  Documentation: x86: convert x86_64/boot-options.txt to reST
  Documentation: x86: convert x86_64/uefi.txt to reST
  Documentation: x86: convert x86_64/mm.txt to reST
  Documentation: x86: convert x86_64/5level-paging.txt to reST
  Documentation: x86: convert x86_64/fake-numa-for-cpusets to reST
  Documentation: x86: convert x86_64/cpu-hotplug-spec to reST
  Documentation: x86: convert x86_64/machinecheck to reST

 Documentation/index.rst                       |    1 +
 ...cryption.txt => amd-memory-encryption.rst} |   13 +-
 Documentation/x86/boot.rst                    | 1238 +++++++++++++++++
 Documentation/x86/boot.txt                    | 1130 ---------------
 .../x86/{earlyprintk.txt => earlyprintk.rst}  |  103 +-
 .../x86/{entry_64.txt => entry_64.rst}        |   12 +-
 ...eption-tables.txt => exception-tables.rst} |  231 +--
 .../x86/i386/{IO-APIC.txt => IO-APIC.rst}     |   26 +-
 Documentation/x86/i386/index.rst              |   10 +
 Documentation/x86/index.rst                   |   30 +
 .../x86/{intel_mpx.txt => intel_mpx.rst}      |  120 +-
 .../x86/{kernel-stacks => kernel-stacks.rst}  |   20 +-
 .../x86/{microcode.txt => microcode.rst}      |   62 +-
 Documentation/x86/mtrr.rst                    |  350 +++++
 Documentation/x86/mtrr.txt                    |  329 -----
 .../{orc-unwinder.txt => orc-unwinder.rst}    |   27 +-
 Documentation/x86/pat.rst                     |  235 ++++
 Documentation/x86/pat.txt                     |  230 ---
 ...rotection-keys.txt => protection-keys.rst} |   33 +-
 Documentation/x86/{pti.txt => pti.rst}        |   17 +-
 .../x86/{resctrl_ui.txt => resctrl_ui.rst}    |  913 ++++++------
 Documentation/x86/{tlb.txt => tlb.rst}        |   30 +-
 .../x86/{topology.txt => topology.rst}        |   92 +-
 ...acy-support.txt => usb-legacy-support.rst} |    8 +-
 .../{5level-paging.txt => 5level-paging.rst}  |   16 +-
 Documentation/x86/x86_64/boot-options.rst     |  326 +++++
 Documentation/x86/x86_64/boot-options.txt     |  278 ----
 ...{cpu-hotplug-spec => cpu-hotplug-spec.rst} |    5 +-
 ...-for-cpusets => fake-numa-for-cpusets.rst} |   25 +-
 Documentation/x86/x86_64/index.rst            |   16 +
 .../x86_64/{machinecheck => machinecheck.rst} |   11 +-
 Documentation/x86/x86_64/mm.rst               |  161 +++
 Documentation/x86/x86_64/mm.txt               |  153 --
 .../x86/x86_64/{uefi.txt => uefi.rst}         |   30 +-
 Documentation/x86/zero-page.rst               |   45 +
 Documentation/x86/zero-page.txt               |   40 -
 36 files changed, 3412 insertions(+), 2954 deletions(-)
 rename Documentation/x86/{amd-memory-encryption.txt => amd-memory-encryption.rst} (94%)
 create mode 100644 Documentation/x86/boot.rst
 delete mode 100644 Documentation/x86/boot.txt
 rename Documentation/x86/{earlyprintk.txt => earlyprintk.rst} (59%)
 rename Documentation/x86/{entry_64.txt => entry_64.rst} (95%)
 rename Documentation/x86/{exception-tables.txt => exception-tables.rst} (67%)
 rename Documentation/x86/i386/{IO-APIC.txt => IO-APIC.rst} (93%)
 create mode 100644 Documentation/x86/i386/index.rst
 create mode 100644 Documentation/x86/index.rst
 rename Documentation/x86/{intel_mpx.txt => intel_mpx.rst} (75%)
 rename Documentation/x86/{kernel-stacks => kernel-stacks.rst} (92%)
 rename Documentation/x86/{microcode.txt => microcode.rst} (81%)
 create mode 100644 Documentation/x86/mtrr.rst
 delete mode 100644 Documentation/x86/mtrr.txt
 rename Documentation/x86/{orc-unwinder.txt => orc-unwinder.rst} (93%)
 create mode 100644 Documentation/x86/pat.rst
 delete mode 100644 Documentation/x86/pat.txt
 rename Documentation/x86/{protection-keys.txt => protection-keys.rst} (83%)
 rename Documentation/x86/{pti.txt => pti.rst} (96%)
 rename Documentation/x86/{resctrl_ui.txt => resctrl_ui.rst} (68%)
 rename Documentation/x86/{tlb.txt => tlb.rst} (81%)
 rename Documentation/x86/{topology.txt => topology.rst} (74%)
 rename Documentation/x86/{usb-legacy-support.txt => usb-legacy-support.rst} (92%)
 rename Documentation/x86/x86_64/{5level-paging.txt => 5level-paging.rst} (91%)
 create mode 100644 Documentation/x86/x86_64/boot-options.rst
 delete mode 100644 Documentation/x86/x86_64/boot-options.txt
 rename Documentation/x86/x86_64/{cpu-hotplug-spec => cpu-hotplug-spec.rst} (88%)
 rename Documentation/x86/x86_64/{fake-numa-for-cpusets => fake-numa-for-cpusets.rst} (85%)
 create mode 100644 Documentation/x86/x86_64/index.rst
 rename Documentation/x86/x86_64/{machinecheck => machinecheck.rst} (92%)
 create mode 100644 Documentation/x86/x86_64/mm.rst
 delete mode 100644 Documentation/x86/x86_64/mm.txt
 rename Documentation/x86/x86_64/{uefi.txt => uefi.rst} (79%)
 create mode 100644 Documentation/x86/zero-page.rst
 delete mode 100644 Documentation/x86/zero-page.txt

-- 
2.20.1

