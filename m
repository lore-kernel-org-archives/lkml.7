Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B159DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB1F20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JcFFeyYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfFFNg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:36:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41630 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfFFNg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:36:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so2460637wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 06:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dMQoje3A+0QuY6d03qdojH8LCBsthMNo+3SlZkjo5Dg=;
        b=JcFFeyYh1751+B47UcZHbFJZ+QYlZUmSkfkKyepILPP91d69zlPjfNw4NUshuxLjuv
         c6+f+6AJ4xxxwgIl2CbkBXFQZEpDWxbTvGrRoV1RKknqD1mmRiYzylSYYDu8gRRQi2W5
         Spbo8ckjPSBHizQyNoOlm7DULD9gs7T+7S030=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dMQoje3A+0QuY6d03qdojH8LCBsthMNo+3SlZkjo5Dg=;
        b=MhIS3eY/njF6t9yQQRov5VBnKCiqpEm6V8yt7fHWw+HCLdsLZe5iiRr3l3lC/uX3ui
         x/scIrUDxGvohCPBsOlnL1r2YOCejrXYchwUsbp/1Er212wMFBBvFH0yAqAM7gKTCJI2
         TlW/9oyjhEhT+K+AZ8bVAhFbOsN6qCAH+RnYX8Tpxqm6hagTxfTQUN5f05Z8xZIc2Ad8
         Cr0cEUpnIbXjgxNcn2D/a+Z1aTzZUT4yEypEpmrgVvYoUTGMn3Mbb8rlI1n2QEzMxNVR
         GiJ/NjlT2YmAuekXoYHGF4J6sXor+H6qUlqXUqAKGu72Rs9shL5uiKqTF9VGiABTQR45
         hirA==
X-Gm-Message-State: APjAAAUkwdl+83hZAmZHwBn3j84f6Dwh0CohVgqcVPhy7m+LVzRXCAPj
        jK7MzfMst38q6WVK2JKsJDbkIC5ci4E=
X-Google-Smtp-Source: APXvYqx74mqUhMOOqkkyB7ZGXf3YbkwFJ8aN77g/VlWrPdi+A4qCmByDgKoJoXVqxagoPQdNO9l/Sw==
X-Received: by 2002:a5d:684c:: with SMTP id o12mr16899507wrw.305.1559828217675;
        Thu, 06 Jun 2019 06:36:57 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id s9sm1809917wmc.1.2019.06.06.06.36.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 06:36:56 -0700 (PDT)
Date:   Thu, 6 Jun 2019 15:36:50 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.2-rc4
Message-ID: <20190606133650.GA26408@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.2-rc4

This fixes a leaked inode lock in an error cleanup path and a data
consistency issue with copy_file_range().  It also adds a new flag for the
WRITE request that allows userspace filesystems to clear suid/sgid bits on
the file if necessary.

Thanks,
Miklos

----------------------------------------------------------------
Miklos Szeredi (4):
      fuse: fallocate: fix return with locked inode
      fuse: add FUSE_WRITE_KILL_PRIV
      fuse: fix copy_file_range() in the writeback case
      fuse: extract helper for range writeback

---
 fs/fuse/file.c            | 43 ++++++++++++++++++++++++++++++++-----------
 include/uapi/linux/fuse.h |  7 ++++++-
 2 files changed, 38 insertions(+), 12 deletions(-)
