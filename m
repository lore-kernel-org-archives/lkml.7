Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4687C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C1E20843
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="t/6ieGbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEPBq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:26 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:33050 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfEPAGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:06:10 -0400
Received: by mail-oi1-f172.google.com with SMTP id m204so1211539oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 17:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0sh2UsByjRLANJVfg34Xwvsd0MFYNc105tKEUP8O1rU=;
        b=t/6ieGbP2moQ4DomPsZ+RRywuPL3Wbq45QXsaH688QBKmc7oDJ1FAgfntRPDerTkr0
         B5dATTpwfcAfKK+4gpamM6gs23Umg/83i1eKrIqhMN6crLTENvGX5ONFCugZnz1xxXXG
         OL8JFmNGX38Gnqhz4UTcyocFMVtXSBmHeFQdZGScAU2OprhO/MFVfOZhkgbE1E3QBwE8
         e0v1Isogrz2G0Kmk3jwVr4Cc9WgeiRjLpmeacB3devbCAd+PIv2BJ45IR4wXZU02kXUu
         15PMm7esKMEfA2CznYssIhKN+L4CM1Nv7Td40K2BAhMgIImki3dICH3Lmc7hxvl/yBbY
         Jhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0sh2UsByjRLANJVfg34Xwvsd0MFYNc105tKEUP8O1rU=;
        b=koXQcnMYQX/sS/zYh2LTSZzEK6Y3JMoQ6TNsbBUCXCdy3q2a0aAGwGH83SKTwlGQw6
         wm5YWo8V9Ikd5gTyanaZPmaPG4i3Y75pQeNYznyi6fPjihjqSFzkh2DBaXuqIFo2/R/A
         ioKMviozoucfY9aBxVCgRgAuihRtf/wH0MaiPt73Xm+syipS6ZVZ/+C4wBgtuCHXSdg4
         ZbPFQeJc8LG7lUE9caQnIUAi79LXIRDcu3n4Bju7AxKlmbOFqHuCA9UhuyEfFumruKpU
         mzj+CqqnGzOKmQj4u9dcMvQjJcAWxQUqQEvi0AM5K7kv4aK4BJtt+WTnMSNTWPP/wweN
         c2PQ==
X-Gm-Message-State: APjAAAVxYpOAogthJHutyPYQmLzm3KSzAMmY8OCeBreF5PfxJ27iaYoV
        u7kPXKCCGfimVaoKCoTD9kATmiO77xSil30NmGCYVYudaZ4=
X-Google-Smtp-Source: APXvYqy5GxTivc+0J2t+V+9MNN3bDq6Dh1ZdsH4nxzQwx1BRJ/lX37anMupt/b2FQBOfFsn/1FIvqGLdDxBy5z8M25k=
X-Received: by 2002:aca:ab07:: with SMTP id u7mr4282661oie.73.1557965169384;
 Wed, 15 May 2019 17:06:09 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 May 2019 17:05:58 -0700
Message-ID: <CAPcyv4iXv7Jh4rjO9XQAFpeCJEZ4-4nvb46nZyQP554uLNbOyg@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fixes for v5.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.2-rc1

...to receive just a small collection of fixes this time around. The
new virtio-pmem driver is nearly ready, but some last minute
device-mapper acks and virtio questions made it prudent to await v5.3.
Other major topics that were brewing on the linux-nvdimm mailing list
like sub-section hotplug, and other devm_memremap_pages() reworks will
go upstream through Andrew's tree.

These have seen multiple -next releases with no reported issues.

---

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.2-rc1

for you to fetch changes up to 67476656febd7ec5f1fe1aeec3c441fcf53b1e45:

  drivers/dax: Allow to include DEV_DAX_PMEM as builtin (2019-05-07
07:48:06 -0700)

----------------------------------------------------------------
libnvdimm fixes 5.2-rc1

* Fix a long standing namespace label corruption scenario when
  re-provisioning capacity for a namespace.

* Restore the ability of the dax_pmem module to be built-in.

* Harden the build for the 'nfit_test' unit test modules so that the
  userspace test harness can ensure all required test modules are
  available.

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      drivers/dax: Allow to include DEV_DAX_PMEM as builtin

Dan Williams (1):
      libnvdimm/namespace: Fix label tracking error

Vishal Verma (2):
      dax/pmem: Fix whitespace in dax_pmem
      tools/testing/nvdimm: add watermarks for dax_pmem* modules

 drivers/dax/Kconfig                         |  3 +--
 drivers/dax/pmem/core.c                     |  6 +++---
 drivers/nvdimm/label.c                      | 29 ++++++++++++++++-------------
 drivers/nvdimm/namespace_devs.c             | 15 +++++++++++++++
 drivers/nvdimm/nd.h                         |  4 ++++
 tools/testing/nvdimm/Kbuild                 |  3 +++
 tools/testing/nvdimm/dax_pmem_compat_test.c |  8 ++++++++
 tools/testing/nvdimm/dax_pmem_core_test.c   |  8 ++++++++
 tools/testing/nvdimm/dax_pmem_test.c        |  8 ++++++++
 tools/testing/nvdimm/test/nfit.c            |  3 +++
 tools/testing/nvdimm/watermark.h            |  3 +++
 11 files changed, 72 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/nvdimm/dax_pmem_compat_test.c
 create mode 100644 tools/testing/nvdimm/dax_pmem_core_test.c
 create mode 100644 tools/testing/nvdimm/dax_pmem_test.c
