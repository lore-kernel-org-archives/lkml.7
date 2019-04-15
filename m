Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041B5C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E8520830
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Y9vZHysk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfDOXaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:30:15 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43841 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfDOXaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:30:15 -0400
Received: by mail-oi1-f193.google.com with SMTP id t81so15343106oig.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 16:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+g42Wfc/GIpu/WqaAZv5aGm8UOBgJOaJrKqeL0UmA3I=;
        b=Y9vZHysk7NDou5NigfbE9/49GeiH5xUrUA0pIHMLZ8e+twIdSpuVGD3X7hFmgmmY8u
         sM3ariCE+BbpEJXvuzzfSiYSDaMdmqFkysOZwrnDRZcFhjOqCLWustkvIACg89yOKCUk
         /N7qlW20ydBKvXAuUmZ+vQUGmdjB33LZOUfUQnVPz5LZ3YohuHnkfpa9YbMn3UAJqYUZ
         N6GHC6rUCFVHir9a3cka9lXnWiWe98OeogIx+K3p2I22I7L2//A48wGZx7LZWVYj6tS6
         r/IU8vAISmMrEVonkxlp2ROdO3tcjV8tuUMrsMDsFzAlu4EdAeAdHaVY+0A3qgb7f9SU
         ZGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+g42Wfc/GIpu/WqaAZv5aGm8UOBgJOaJrKqeL0UmA3I=;
        b=FPTmMc7nNhv3xynUaBdeKMRAYgYTKlyjlAgXpZ6pmqS/TD5cEsY9xFzzaWY9piOl3E
         NwgLudOtNrhmShh+FQAXhtu4z3+JfLo1OPx2rZXlo0N3zniJIpqHc7VMoPcRgXVEZgav
         5vhnyc4oaZ6OMgV3IG9F9zgdL88QmJBMfREZnGTssgxnJ+YRGR1G9MLpJdtbWyxOQjAw
         C+Jt/5ZIOQFU6GANUujVyy4CDxOYSm3W420V/obJp9U7MycuP68KVkznxK4g7Ymkx0uO
         dem8mq3qG68wjrAEepwJuADH1soZgSsLRHtGmri6qoUA54JT3EBUGLSvVB242GWjLELb
         5tQQ==
X-Gm-Message-State: APjAAAWiRUPz5cbHPXdiH4mrr02x62udzOfeLnLDUFXOIKxg4hLB3JIW
        BXZs9/0DMWR8mc7T1YzbJZTemXlz1hq7+/wXjH+mLrGL+Ek=
X-Google-Smtp-Source: APXvYqy30mCVV43vy/d3+9bdDfAecASlTu6fwf4ASF6LFKnqvBIqTpWEEzfYfP2HjHilChhtIXON6Vin/7tUjCTOOFo=
X-Received: by 2002:aca:f581:: with SMTP id t123mr22437267oih.0.1555371014333;
 Mon, 15 Apr 2019 16:30:14 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 15 Apr 2019 16:30:02 -0700
Message-ID: <CAPcyv4gqXL4H8p-PB1196zx0Gm3+hCZcMUF5330eAGK6SWXoOw@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fixes for 5.1-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.1-rc6

...to receive an optional libnvdimm update for v5.1-rc6. I debated
holding this back for the v5.2 merge window due to the size of the
"zero-key" changes, but affected users would benefit from having the
fixes sooner. It did not make sense to change the zero-key semantic in
isolation for the "secure-erase" command, but instead include it for
all security commands.

The short background on the need for these changes is that some NVDIMM
platforms enable security with a default zero-key rather than let the
OS specify the initial key. This makes the security enabling that
landed in v5.0 unusable for some users.

---

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.1-rc6

for you to fetch changes up to 2170a0d53bee1a6c1a4ebd042f99d85aafc6c0ea:

  tools/testing/nvdimm: Retain security state after overwrite
(2019-04-08 09:39:32 -0700)

----------------------------------------------------------------
libnvdimm fixes v5.1-rc6

- Compatibility fix for nvdimm-security implementations with a default
  zero-key.

- Miscellaneous small fixes for out-of-bound accesses, cleanup after
  initialization failures, and missing debug messages.

----------------------------------------------------------------
Aditya Pakki (1):
      libnvdimm/btt: Fix a kmemdup failure check

Dan Williams (1):
      acpi/nfit: Always dump _DSM output payload

Dave Jiang (3):
      libnvdimm/security: provide fix for secure-erase to use zero-key
      libnvdimm/security, acpi/nfit: unify zero-key for all security commands
      tools/testing/nvdimm: Retain security state after overwrite

Kangjie Lu (1):
      libnvdimm/namespace: Fix a potential NULL pointer dereference

Li RongQing (1):
      libnvdimm/pmem: fix a possible OOB access when read and write pmem

 drivers/acpi/nfit/core.c         |  12 ++--
 drivers/acpi/nfit/intel.c        |  10 ++--
 drivers/nvdimm/btt_devs.c        |  18 ++++--
 drivers/nvdimm/namespace_devs.c  |   5 +-
 drivers/nvdimm/pmem.c            |   8 +--
 drivers/nvdimm/security.c        | 118 ++++++++++++++++++++++++---------------
 tools/testing/nvdimm/test/nfit.c |  17 ++++--
 7 files changed, 117 insertions(+), 71 deletions(-)
