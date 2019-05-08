Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09590C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5023214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/5xCEou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfEHPWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:22:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36695 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfEHPWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:22:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so1025926pgb.3;
        Wed, 08 May 2019 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XXdDTrkBMomscqKxaDUgTHEj/BRRiivaCmeozZnvf3Y=;
        b=u/5xCEoumvmIQckjvd4nzXb37vVH12TTlIycHU7eW4cew8nR+hMT5TXw7GfMimfI+1
         8UlR9FUOnTxggNElE6p1y5ZHm7Pgyfb8d1tgB2s2J1bohY5XW9mjZkiKkhFxrIqidgWR
         iy/0iiAYPl/8AqUF8KwEN86KfsyqQ9gCZ6fHJiErd8Sirz7oZsGk4jxPpfuPd4SnbTWT
         zygbm0yGIsQZdWz7I4rX6DGYItxIyBBd37N8ihPZqljqPlieN+i5W81LMcwLi5oHkcsO
         zTuIfEkIJtd1GPivmcHEUY3U8uwv+jFbXdLfc9oRL322xtYX5iwKUl/saq0Nci53g1Tb
         jPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XXdDTrkBMomscqKxaDUgTHEj/BRRiivaCmeozZnvf3Y=;
        b=NLw4cAQNkXLHMuDZIXurgubTJBZRby/z3N7XF43PDZYuvRTOIoEH1R1/LOi0AaZcK+
         RZSGEBu2b1zGeYWard1l9fZ6OKw59PkDHQ/tYPtp1sW9NDLT52O+xNLj3NjJ4bAXk3zz
         kPQ9RgjyvBjqNPp/V2tMN/iAMNCFfKriNLzIb/oq0cs0SYkCx87JJkzKrX7UxQdLW/bq
         rFS0d2fboiDoPGpJhpnOsOGuDs753v4V/y1eWdz3XHk1lFTkk6bDOTxA8t96kCmGYPjB
         MwcNMaYI5s8+DnId+P/6guZKq6IWJEGjXOKiHLTPKdGHpY93TX20ZRGYGSO/ID5ClqA6
         7FjA==
X-Gm-Message-State: APjAAAUbGYxtosPmq6vn56aF4kHpiAb+efF4ipWgQkO2WF0AcDgDp4kd
        Qk6GLCejRl90th1m3VPKYzQ=
X-Google-Smtp-Source: APXvYqxHp9GwWQuit+sOFj1M7h22l+E+DPApRcaOedg2+bTqAGwc6vbrc+iOBQ8vy/pzGRCGgLBeow==
X-Received: by 2002:a63:610f:: with SMTP id v15mr47949725pgb.128.1557328920036;
        Wed, 08 May 2019 08:22:00 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.21.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:21:59 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 00/27] Include linux x86 docs into Sphinx TOC tree
Date:   Wed,  8 May 2019 23:21:14 +0800
Message-Id: <20190508152141.8740-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The kernel now uses Sphinx to generate intelligent and beautiful documentation
from reStructuredText files. I converted all of the Linux x86 docs to rst
format in this serias.

For you to preview, please visit below url:
http://www.bytemem.com:8080/kernel-doc/index.html

Thank you!

v4: fix 2 comments for boot.rst.
v3: rebase to docs-next branch (one conflict).
v2: resolve comments from Mauro and Borislav.

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

 Documentation/index.rst                       |   1 +
 ...cryption.txt => amd-memory-encryption.rst} |  13 +-
 Documentation/x86/{boot.txt => boot.rst}      | 528 ++++++----
 .../x86/{earlyprintk.txt => earlyprintk.rst}  | 122 +--
 .../x86/{entry_64.txt => entry_64.rst}        |  12 +-
 ...eption-tables.txt => exception-tables.rst} | 247 ++---
 .../x86/i386/{IO-APIC.txt => IO-APIC.rst}     |  28 +-
 Documentation/x86/i386/index.rst              |  10 +
 Documentation/x86/index.rst                   |  30 +
 .../x86/{intel_mpx.txt => intel_mpx.rst}      | 120 +--
 .../x86/{kernel-stacks => kernel-stacks.rst}  |  20 +-
 .../x86/{microcode.txt => microcode.rst}      |  62 +-
 Documentation/x86/mtrr.rst                    | 354 +++++++
 Documentation/x86/mtrr.txt                    | 329 -------
 .../{orc-unwinder.txt => orc-unwinder.rst}    |  27 +-
 Documentation/x86/pat.rst                     | 242 +++++
 Documentation/x86/pat.txt                     | 230 -----
 ...rotection-keys.txt => protection-keys.rst} |  33 +-
 Documentation/x86/{pti.txt => pti.rst}        |  17 +-
 .../x86/{resctrl_ui.txt => resctrl_ui.rst}    | 916 ++++++++++--------
 Documentation/x86/{tlb.txt => tlb.rst}        |  30 +-
 .../x86/{topology.txt => topology.rst}        |  92 +-
 ...acy-support.txt => usb-legacy-support.rst} |  40 +-
 .../{5level-paging.txt => 5level-paging.rst}  |  16 +-
 Documentation/x86/x86_64/boot-options.rst     | 335 +++++++
 Documentation/x86/x86_64/boot-options.txt     | 278 ------
 ...{cpu-hotplug-spec => cpu-hotplug-spec.rst} |   5 +-
 ...-for-cpusets => fake-numa-for-cpusets.rst} |  25 +-
 Documentation/x86/x86_64/index.rst            |  16 +
 .../x86_64/{machinecheck => machinecheck.rst} |  12 +-
 Documentation/x86/x86_64/mm.rst               | 161 +++
 Documentation/x86/x86_64/mm.txt               | 153 ---
 .../x86/x86_64/{uefi.txt => uefi.rst}         |  30 +-
 Documentation/x86/zero-page.rst               |  45 +
 Documentation/x86/zero-page.txt               |  40 -
 35 files changed, 2559 insertions(+), 2060 deletions(-)
 rename Documentation/x86/{amd-memory-encryption.txt => amd-memory-encryption.rst} (94%)
 rename Documentation/x86/{boot.txt => boot.rst} (73%)
 rename Documentation/x86/{earlyprintk.txt => earlyprintk.rst} (51%)
 rename Documentation/x86/{entry_64.txt => entry_64.rst} (95%)
 rename Documentation/x86/{exception-tables.txt => exception-tables.rst} (64%)
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
 rename Documentation/x86/{usb-legacy-support.txt => usb-legacy-support.rst} (53%)
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

