Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B8DC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 19:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAEA208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 19:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="0oOGBZDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfHKTBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 15:01:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42624 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfHKTBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 15:01:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id j7so6778661ota.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8CYB75tEXZ2XGjArz0sIzOXQhMzMA9ETRG0W57479F8=;
        b=0oOGBZDHawnT6tmmA7FIAOOT8r1zBTfrvPcrZf5O/ihWNLAllN93OL9uP95I9VkQmM
         nP5hxw8LFtTmglndTHiTXYpR3W3jYv56Gl6E0js3c83nUptmb2OdO+3Bbco9QmsAeD4h
         KtlxjbFd8VhocheXPss1Yt538XYGlGyAwtHOP/ZaPWOM9gYX6RFWSaOTsqn9J5nPUmkU
         wnEidQKmM5iGTz8daURN3XxmKJbFD+gnM+K7NWcXx8pqMwwFQCFiLShU/t77cu3YPfU0
         UWdGRsUmyGm7l18Ex8CDjsMpYcqYlpvoHLgcu2u/xEmQPdbCFGq8G+wpm+0yLFxUPya+
         kcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8CYB75tEXZ2XGjArz0sIzOXQhMzMA9ETRG0W57479F8=;
        b=S7YTK7qLKMjzrQe/jvEJB8V6i5+N+l4rEuvGtt1DSRe9wMCgtzdBxFV/be3bJshVCQ
         3jQYfZJBOshqviBVC6+mUWAlPKUIRUXC4+JR1KhVjh9f0C+9FfbAp0ZaOVNGbS0XFURR
         52Na1O+e2ffCLd8lE1TBbEXFFRUFlX5kYPfYlmnW2P6Ke4cW4RxDxZhFcyLxQUWrpztG
         k/nh6Y3t0FDe+W4OMC/g5qR00HwlsTc8iVEDgQwzNF5ChxOGccaSvLv+tL8dWvldwkri
         D3tX99K2HiYYilPQn65+ZhmHQkOk2YmGgCYXBAH6NgUJQNfRdTya1tmsR3xyv5vmx18C
         /NEw==
X-Gm-Message-State: APjAAAVKXtk5DFubJh8c4M/ko9LNiJx7fUYJq78sxEasjMG2q4GXutM+
        35N3wa1pbyDpuNVeiBkM4+aUVJw2lb1TvZ4ZtW3WP8iz4pA=
X-Google-Smtp-Source: APXvYqxCBXehuIHD7MVGr3oQ6+9vulwhlOrxF2TSbUxwyaVksmmBcJbvCHzRAExD9UI669rmu+iqnsMwb1EjIkGlO98=
X-Received: by 2002:a9d:5f13:: with SMTP id f19mr19214592oti.207.1565550073180;
 Sun, 11 Aug 2019 12:01:13 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 11 Aug 2019 12:01:02 -0700
Message-ID: <CAPcyv4iaYiXbv2sf-Znn5dYphLKEi77NjafkEzXA2kAEMqyR0w@mail.gmail.com>
Subject: [GIT PULL] dax fixes v5.3-rc4
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
tags/dax-fixes-5.3-rc4

...a filesystem-dax and device-dax fix for v5.3. The filesystem-dax
fix is tagged for stable as the implementation has been mistakenly
throwing away all cow pages on any truncate or hole punch operation as
part of the solution to coordinate device-dma vs truncate to dax
pages. The device-dax change fixes up a regression this cycle from the
introduction of a common 'internal per-cpu-ref' implementation.

The filesystem-dax fix has appeared in -next. The device-dax has not,
but it has been exposed on a kbuild-robot visible branch for the past
few days, and passes the nvdimm unit tests.

---

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fixes-5.3-rc4

for you to fetch changes up to 06282373ff57a2b82621be4f84f981e1b0a4eb28:

  mm/memremap: Fix reuse of pgmap instances with internal references
(2019-08-09 14:16:15 -0700)

----------------------------------------------------------------
dax fixes v5.3-rc4

- Fix dax_layout_busy_page() to not discard private cow pages of fs/dax
  private mappings.

- Update the memremap_pages core to properly cleanup on behalf of
  internal reference-count users like device-dax.

----------------------------------------------------------------
Dan Williams (1):
      mm/memremap: Fix reuse of pgmap instances with internal references

Vivek Goyal (1):
      dax: dax_layout_busy_page() should not unmap cow pages

 fs/dax.c      | 2 +-
 mm/memremap.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)
