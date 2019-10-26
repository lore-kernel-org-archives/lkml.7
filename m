Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6972ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308B620679
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="HH2SlADz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfJZBGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 21:06:35 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33155 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfJZBGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 21:06:34 -0400
Received: by mail-qk1-f194.google.com with SMTP id 71so3505389qkl.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 18:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=o3JGLijrHeoByp9gbkT6wzfJ5d4fxo3U1OIP57EOzXU=;
        b=HH2SlADzTKXtbikufoaNw2xMGhXgxFdFTMJjuqm1VbQBnGse5SaGJQVEhnRfswGLDr
         DZsduRlDuPzii9l/nQ6zmL6NZzpiay1+Wvm10Z2nXv48LeIzWQvEJtkUcv6eDpAIF+W8
         8hGxvtzeXjRfhZ/9OQexRLn5EnpgWTUEETaJI3HkLlARqurabIq7lq0vVnrQrZLN0axY
         K8+oui+hKlb5sq4M+e8ph58ilX7ZHDzciB/gosbImh92NotXqst+ilD7WxCfKoa9ls6Q
         ZluEDEKyns4GkhkwikX5myoFJV+iV5uUvjQ3lC/Lce+uAWlY4iY2ZNQzIgpfk4BFtuS1
         69bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=o3JGLijrHeoByp9gbkT6wzfJ5d4fxo3U1OIP57EOzXU=;
        b=k2EFkSrhpMh5d+wi+DJVLms16gHGGLeck/P8N5WaOgBP9BreItk12x7oKp+PJnWVwv
         klsVIx7zFILVzwcMRYCfYFvAbUJwdMHF0J4DOft5LbQ4RZOJ8nabcaO+dec16FaCUplP
         UVPWBw/X6kNHTl1fa/l5ndXn30vJR657IJ7ZZ0J3wxrlCAWSlK5BXc7JCwaNdxwE5TxZ
         LGJAuLOw7rg3bqsf2EhSKNrwqp9sM5ttCBKu1orCdPez/Wq7A64ks4PGMq8TmL4QT6Ox
         fzOmS6AViKhDwuqHV/9xNply7RBu5ffQInrdquP7MzKbp7hHsw0vbfmoIhkqlhRbbvVV
         TfSQ==
X-Gm-Message-State: APjAAAVe/IhxliIMXXmscwMgp6D4OYXRAqC4u6aazWona5n65X0Qk+7p
        uJ7SC/pa84QfBusteYPl315u3BAFohzjXno3X6vTs7PS6So=
X-Google-Smtp-Source: APXvYqzhFLsroO8pOagwVrVJJjJJYI30TL8mpBBf8YDPfeKcwSfKB9sc6UtodxQ3eDYtEnGo0KP1dCCWsv0HNAclEdE=
X-Received: by 2002:a37:de0c:: with SMTP id h12mr5600689qkj.495.1572051993752;
 Fri, 25 Oct 2019 18:06:33 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 25 Oct 2019 18:06:22 -0700
Message-ID: <CAPcyv4gi--MyxXOt-vb4Tw+ku=jUYmo4y+YSV+6UJf24BCDAMA@mail.gmail.com>
Subject: [GIT PULL] dax fix for v5.4-rc5
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
tags/dax-fix-5.4-rc5

...to receive a regression fix for v5.4-rc5. It has appeared in a
-next release with no reported issues, and picked up reviews from the
regular dax contributors.

---

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fix-5.4-rc5

for you to fetch changes up to 6370740e5f8ef12de7f9a9bf48a0393d202cd827:

  fs/dax: Fix pmd vs pte conflict detection (2019-10-22 22:53:02 -0700)

----------------------------------------------------------------
dax fix 5.4-rc5

- Fix a performance regression that followed from a fix to the
  conversion of the fsdax implementation to the xarray. v5.3 users
  report that they stop seeing huge page mappings on an application +
  filesystem layout that was seeing huge pages previously on v5.2.

----------------------------------------------------------------
Dan Williams (1):
      fs/dax: Fix pmd vs pte conflict detection

 fs/dax.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
