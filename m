Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CA9C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E662173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mGythxfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390527AbfGROhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:37:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45422 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfGROhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:37:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id x22so22504781qtp.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=P952fJXBLk5gGmwzQWc4AdTbQsUFnxHNQ/JjKtt4NKc=;
        b=mGythxfugEaFvl0wyE39KZQUFGsK+FuHqI4IU0NimV+KcqB82JKwxtNkJYwrBATEBJ
         c/Cd25vpiSXyQEREaH66Utgzdw+g4fYhB+0VYAuoTeM3N3qHyl6WbR75bH+NIKMeeV2e
         cwh63Sl3S1aqo4pnm12YqKlEYwetRIANDF33tUMpoThDQmnV52nqKcKScBS+gkn1/NOg
         Gh/63dvdIPrMahiYbuhKcWd/K40WXUA/XWKiL3WlKx43udHTGN0e8l7ez0zyLgGYXACv
         1frTvKYJdrQcaikMAbT7y6F/IaYIQGvG4gJZbmukAWqiNzL8aHkITUKWY+7kcYHXvu/g
         wmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P952fJXBLk5gGmwzQWc4AdTbQsUFnxHNQ/JjKtt4NKc=;
        b=buSdxn3NgffQWX3aLtITYOrbzzod/4pzqfGLRes73yNcRLB1zLIhuG0L2IEX3Q395C
         GzPSbctsOL2Ah6wLaKOQQVvr6PFhWI8hDg7OcIMgF7cKe1RywtOBbTQt1I+cKQkqs9sH
         kvHoSfqsujuZgZQrVB0lp9LHbdYEo318sWbgMX922yWd77d/5cUSDwLVRnJUm2Gdmj9z
         nh0elWRdQ+yKKIGgeaeMTgZhyhufp6Y5p40iXBIWu9VjpW4Pjur9fCzDtISchw4O5Z+J
         376+Q275VmEtH+ctgtvc4yZJJPc425Suh/q2IUDhDoezFnpfyfAx3FSM3m7nVPkDQ2zF
         nnaw==
X-Gm-Message-State: APjAAAW8BFqSW+64K3f/DxAu43Clpo2TNolAs1O8XiBfED5PMUVIlsNS
        EI7GwVKBic7FkqsugX7jxXOdyHzNc/nF1YrBzxW6gA==
X-Google-Smtp-Source: APXvYqwlRBjp0w1syFaW3nPSBwwug0SrJnGWLAMIYDiIoIGHAU6aSAPrRGiIr53fvkPxLKi+KZvUIFrxm7qmxiv9rs8=
X-Received: by 2002:ac8:1e8a:: with SMTP id c10mr31333075qtm.45.1563460638305;
 Thu, 18 Jul 2019 07:37:18 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Jul 2019 07:37:07 -0700
Message-ID: <CAPcyv4jMjvPYTa00hbq=64LZ=Vcu-gi7hLcgDTnD9d4dF0t9ng@mail.gmail.com>
Subject: [GIT PULL] dax for 5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-for-5.3

...to receive the fruits of a bug hunt in the fsdax implementation
with Willy and a small feature update for device-dax. These have
appeared in a -next release with no reported issues.

---

The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-for-5.3

for you to fetch changes up to 23c84eb7837514e16d79ed6d849b13745e0ce688:

  dax: Fix missed wakeup with PMD faults (2019-07-16 19:30:59 -0700)

----------------------------------------------------------------
- Fix a hang condition that started triggering after the Xarray
  conversion of fsdax in the v4.20 kernel.

- Add a 'resource' (root-only physical base address) sysfs attribute to
  device-dax instances to correlate memory-blocks onlined via the kmem
  driver with a given device instance.

----------------------------------------------------------------
Matthew Wilcox (Oracle) (1):
      dax: Fix missed wakeup with PMD faults

Vishal Verma (1):
      device-dax: Add a 'resource' attribute

 drivers/dax/bus.c | 19 +++++++++++++++++++
 fs/dax.c          | 53 +++++++++++++++++++++++++++++++++--------------------
 2 files changed, 52 insertions(+), 20 deletions(-)
