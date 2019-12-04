Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328D1C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D31820409
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iQ3NLwjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfLDJLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:11:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39916 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfLDJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:11:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so7560751wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 01:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Sdir8t22Whp6d5zfU/aglTF8nH6hZfnd2WBrWb4Hzmk=;
        b=iQ3NLwjAkMqPVUWrDPgMWFEJlCQWOIiJQX1XjeKSOseCyF0pFdXM3San8C5vT5vlCL
         k/oVy8qj//oSFJ4vePk0dOmR0tQ5BCxIkmUlP4YdFbdIBw/YRC7EbLWd85QmuqB9B1k7
         Ywg4c4Q1ZCXfV4I1wKUHfQ1r8WW7T9bwMYqUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Sdir8t22Whp6d5zfU/aglTF8nH6hZfnd2WBrWb4Hzmk=;
        b=tZtqV++0x4D/ys0OUt626Nx3btuFo17caFh603osK7ZDRkUJGd3xAylJ/bMlL639qs
         exBaZNeLKUaPhTEJ/cG2N4z8O2hpxbT5YLpVRTOj6YyfGrmld6nc9EKgpUhRPsQg2VZI
         hhsdFbdmHepN2Yjpzns5bpBUEsXymWR9ytSgJTVB619Yhrsx9XlGp743zRdpaqpPQf/F
         +nz8XqFw2N7c9+isiLU6wUDYDzX38iWhPqFMEc9Vvq47cDTLL0ZmIENc3d80Rz2wicjB
         luWUEiq9O4I7cRdNXabCeng5nl2htpNPxJ8tbHD8PuI4t4f9ETIydyn5tSPlNkpEKGQX
         QR9A==
X-Gm-Message-State: APjAAAU0RACcBBq9egE/qdkYbIOX8FzW+baCkPKwcOCeBRhV7VUcVBeC
        NEy13AjfX7N6jCwApztFvcH6gYJvKnw=
X-Google-Smtp-Source: APXvYqzkytORTQVPCACG5wYyyNFLEHO0L1v4wuq/QMOmPny/ytkdK4OTVqMTey4+mYHt68oxFWHylA==
X-Received: by 2002:adf:ef10:: with SMTP id e16mr2630023wro.336.1575450662345;
        Wed, 04 Dec 2019 01:11:02 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t13sm6193517wmt.23.2019.12.04.01.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 01:11:01 -0800 (PST)
Date:   Wed, 4 Dec 2019 10:10:59 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.5
Message-ID: <20191204091059.GB16668@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.5

 - Fix a regression introduced in the last release.

 - Fix a number of issues with validating data coming from userspace.

 - Some cleanups in virtiofs.

Thanks,
Miklos

---
Krzysztof Kozlowski (1):
      fuse: fix Kconfig indentation

Miklos Szeredi (4):
      fuse: verify attributes
      fuse: verify write return
      fuse: verify nlink
      fuse: fix leak of fuse_io_priv

Vivek Goyal (3):
      virtiofs: Use a common function to send forget
      virtiofs: Do not send forget request "struct list_head" element
      virtiofs: Use completions while waiting for queue to be drained

YueHaibing (1):
      virtiofs: Fix old-style declaration

---
 fs/fuse/Kconfig     |   4 +-
 fs/fuse/dir.c       |  25 +++++--
 fs/fuse/file.c      |   6 +-
 fs/fuse/fuse_i.h    |   2 +
 fs/fuse/readdir.c   |   2 +-
 fs/fuse/virtio_fs.c | 210 ++++++++++++++++++++++++++--------------------------
 6 files changed, 134 insertions(+), 115 deletions(-)
