Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752DEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334C22147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UQuKc5lC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfCLXVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 19:21:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45801 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfCLXVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 19:21:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12so50397otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 16:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1jJQacBl3c4YFvB1tFugqbGSybVgDP2s6ootgfTR99U=;
        b=UQuKc5lCR3pnU4XP9WfMNSwDpOJZWMz+NU9ufjhnsOZa0bFH2TtEAALZsM4rwOAS4F
         OfZ2g8L7+R31dIKKvITQ7GrJ3VMAVQCynLONkv68PrKlxSNUtvaYU/tN8mYCuK4jKkPS
         7spd18/NHnQzuC1/7zmW/vFReNaRKtQFM8/FlCruZ/lF5S20bs2FHuSbOS85FKK9whhM
         LEh+odraUNitDlRgEBAgVIj9fOMe6ddA5yeTu1wQyQe5igwpARNtRxZjIyJwI9Gy5S+H
         s9VElplmkU3uDmKSBV4q2V246I155iTVMEjKWSER5P8KQwpgMwpbdluwnpUayXFvFjmA
         6xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1jJQacBl3c4YFvB1tFugqbGSybVgDP2s6ootgfTR99U=;
        b=czJLpplQhKXT/wpt/h8eG5dYVDOsdUhSgM6YXcidsFyYCAinJt4J8nwcOvd/+eeZ43
         VI+MBwtv1UKj9A9KZi7gSE3nEA/2Y01LdtnDVosetg40Va8CituPW9/TolT6cv0SXNgt
         ahSlcqKelN18fPjGRemxfMSVADieB0pZk8v4ZYaQe6FzzyGFLcqwIbOm5lqy14XicUg9
         yhfBjJMTmH9KZ0le6MEQ/JePko56lJLkGPjuQiaZX88aW4DhbAqoo6Ns1ZZJjy34IDvo
         LTMW+VUwfkEaCntcxleK2RbQ+DgDXbdL3jeFvmY9iI0tGQ8sLZuoJi4Kx4RCJ/i6Ygx/
         u74Q==
X-Gm-Message-State: APjAAAUIOfLrMm4BK2fSzi0MLC+vSEXKolh+GDjqshYkl11nR4ENCVDO
        sfVz3v8cDNltOgxO6cHkw3jvRcdTsW1tS7SAtEDJjOc0acc=
X-Google-Smtp-Source: APXvYqy1bAAdK2iisYU9Kh1JPeTVRptRjRrYN650HOAUj8YCQ8GahFgnADDoyJdWedQW54TPdXzY0UxN4cxmoGpoaEA=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr13547159ota.214.1552432863421;
 Tue, 12 Mar 2019 16:21:03 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Mar 2019 16:20:52 -0700
Message-ID: <CAPcyv4g5NH=4wKs7+V3hTw1Qv6peBQbb7xCyjjQn3bhj7J0WTw@mail.gmail.com>
Subject: [GIT PULL] Filesystem-DAX fixes for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/fsdax-for-5.1

...to receive a small collection of cleanups and an Xarray fix for
v5.1-rc1. It has soaked in -next without issue, although the Xarray
fix was recently re-flowed to fix up a tracepoint argument and add
Jan's reviewed-by.

---

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/fsdax-for-5.1

for you to fetch changes up to e4b3448bc346fedf36db64124a664a959995b085:

  dax: Flush partial PMDs correctly (2019-03-01 17:24:48 -0800)

----------------------------------------------------------------
filesystem-dax for 5.1

* Fix handling of PMD-sized entries in the Xarray that lead to a crash
  scenario.

* Miscellaneous cleanups and small fixes

----------------------------------------------------------------
Ira Weiny (1):
      fs/dax: NIT fix comment regarding start/end vs range

Matthew Wilcox (1):
      dax: Flush partial PMDs correctly

Souptick Joarder (1):
      fs/dax: Convert to use vmf_error()

 fs/dax.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)
