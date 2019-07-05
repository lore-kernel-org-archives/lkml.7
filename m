Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49338C0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 00:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E33B21852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 00:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Csg0RK3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfGEAL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 20:11:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35879 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfGEAL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 20:11:27 -0400
Received: by mail-oi1-f193.google.com with SMTP id w7so5972542oic.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 17:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+KUa/pKnTzDUY8iKea0h5ooJheLbdX4Z7I3oB9ImT1k=;
        b=Csg0RK3gwejbtYn9Bb96veoScBvqb+LsOvHsMSjOVUfAQG6kL/HEasbVW03BPfrMDM
         ZeuMYi7iMCiXFYjKO7NNNvzX383rUBtSgQ7jb3iBxp0V4Cn64eMPQKIQJKzoxBXC7f46
         yq3qgX3oNi7KDe8mpw9URsinu3RdiHrxyNpf36txzLyNzX72aa5f/LyG71Vb4G3+ESVY
         3yFaL+JvV4wjgoWuBheorPaqmTVmjQj7WTkiaYl9yFoJInHv5PTAvYtbG+mrvIC1dO3T
         8UwG5AR2e7+7Lz/RRbqy9+ghEdHrOmb7R1lfER1Z2hAF8juynW3DZExwrjdWUIE5cTZd
         5pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+KUa/pKnTzDUY8iKea0h5ooJheLbdX4Z7I3oB9ImT1k=;
        b=Z0Buj4IvR4GR9Pq3dURCJzWtpXGy4qrznN3vPMIzBjJt9pJWx0bOaTT2D6niEHbrlG
         JJKCHaD+0Nzg7B8I7iGoz3nZoUpi/h+2wIcy74kEYPKu2hdBQFYBfOMaqx+/kE5LVdNS
         Cn6foWxg/1JD8YhqpNPH7X3h0d1jt3nKmZBU/ypBXP3rb0OKB/geMbuRz8Bc2JNRO0/X
         dAJ4nIcZNd8rJ9MzpDzvJFPrfbC3lNAYH8gxMwSdVmB9Zv3olMPyETdLCbJxL0yOACZE
         pEjhVU9HSjSPP4RqfaI7hrKYO4hvLkotAy/yNQHXFBOEfA65S/oK8DE7dD6tgPuJmTUQ
         gzsw==
X-Gm-Message-State: APjAAAWh9u+C0o00ERdRirpuHXNS4hiFCr9htSrvNXa2t/MCcO7mIkOk
        qYDU/4ciFJ0EiDX/zklhNtutVJRbbgTD5trBMmWUgg==
X-Google-Smtp-Source: APXvYqzlFmpt61vIj6L8l0EpOJd4L4Dl2URxNXWw5ml57YfYsXHkMntq9TesGECcSO3CKqdxrpnlkYkyniCr9rxgMas=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr461198oih.73.1562285486732;
 Thu, 04 Jul 2019 17:11:26 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Jul 2019 17:11:16 -0700
Message-ID: <CAPcyv4hs6bncxc3_vOKYYc-XdL+-dv_dJkmV8EduRrshv3rBgQ@mail.gmail.com>
Subject: [GIT PULL] dax fix for v5.2-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fix-5.2-rc8

...to receive a single dax fix that has been soaking awaiting other
fixes under discussion to join it. As it is getting late in the cycle
lets proceed with this fix and save follow-on changes for
post-v5.3-rc1.

---

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fix-5.2-rc8

for you to fetch changes up to 1571c029a2ff289683ddb0a32253850363bcb8a7:

  dax: Fix xarray entry association for mixed mappings (2019-06-06
22:18:49 -0700)

----------------------------------------------------------------
dax fix v5.2-rc8

- Ensure proper accounting page->index and page->mapping, needed for
  memory error handling, when downgrading a PMD mapping/entry to PTE size.

----------------------------------------------------------------
Jan Kara (1):
      dax: Fix xarray entry association for mixed mappings

 fs/dax.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)
