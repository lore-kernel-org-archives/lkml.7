Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D1C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9953C2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCg9ZanY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfEFRJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:09:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45966 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEFRJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:09:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so6748333pgi.12;
        Mon, 06 May 2019 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJ5Vy1fvJOMCfsNlZt9kLkloUoOWT4WJb6tP7nNpgzI=;
        b=uCg9ZanY5YS3ptCxOrBuUCjZAvjpv9NNZKCZwZpHEdiCjrwL+vnSUjKfMCs2DJiCXs
         pgLr5jyCxBSDqdDbTcz6QjWyLM+KJanKZVm+QbrgCchpw3I25EciN+RG4wxs7PiT2Es0
         ++YKwZevPTxRUHbMkEdBzFYh+5NHDR6br81moXZY1gBqV+zDqakrrY5ekgIqR2b9DyCu
         elmPrXKuH8nVCS9uZTEWdItHxZ9ym/sruHKQhTnfv7P3+Ko+cbp7TT+fYZ7lPSmlYOzw
         5NRZOEjyel32nIKWctOM7u0Vi/UXgZjmNCGpOYaTe2EIsBqwL4K/zdLVNz6A11hQShi0
         Jd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJ5Vy1fvJOMCfsNlZt9kLkloUoOWT4WJb6tP7nNpgzI=;
        b=qkWwSmQRcamYZSxLNjp9w/Ks1DdNWDoucugesB0XjMze90pUVMsQXf2UClht+kAuLM
         iah6xLFt+IR+Ihx+IgtnJZVfb9CZeg2TmAr+9sj1HBiN985mJosrDtigQiSxwSWEI2GR
         x5dt5xQvf43c9obAeSGhCuz5e6PL3bcnVAEnbV7PQWTFejXsIYw5uG63ui90RYIJBS+l
         /Z997MbbCYb5hKi+S7/VIHZmsarr+sdIDAeJYQjI/Gxdmj2vKUf3F9ns5lEen8N5eG+d
         5pMyJsbnHtJyGDV9lILCwVrE0GI5FlXltD+Ub2FfURZIWFaebAuqeMKOhpD3KtyLFxQD
         Lbeg==
X-Gm-Message-State: APjAAAUfJKgc1Va09ScoY4LPepCxtMzKYoh6KtZGUYlvQrBXdPKsqQn5
        7GbnvWKtdogFNwU7apW5Ud4=
X-Google-Smtp-Source: APXvYqxeD3Fk3xGdhGPsF+4N81pTgqKo/gdUwCLyybMHlPhc1dJ4LhVGomO+AeIMwfSsDWV6TDxcZA==
X-Received: by 2002:a63:c50c:: with SMTP id f12mr33112898pgd.71.1557162579234;
        Mon, 06 May 2019 10:09:39 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.09.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:09:38 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 00/27] Include linux x86 docs into Sphinx TOC tree
Date:   Tue,  7 May 2019 01:08:56 +0800
Message-Id: <20190506170923.7117-1-changbin.du@gmail.com>
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

v3: rebase to docs-next branch.
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
 Documentation/x86/{boot.txt => boot.rst}      | 530 ++++++----
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
 35 files changed, 2561 insertions(+), 2060 deletions(-)
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

