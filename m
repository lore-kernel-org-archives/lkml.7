Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DB7C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE02A2067C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZesqP08Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfFFNoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:44:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40083 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfFFNoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:44:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so2485002wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fvQrk6QqMWIbLlAcsJuBVoZshDn5zuagYNbpKnSUNYk=;
        b=ZesqP08QI2a2cCi5fQdLu7o52AAZGx22ZZYszKIm4/0sAcYm8gmt3S8Xdy9/quXxo8
         fCc9Svaa7NjdeYsBcL7Z3PfXcbwUby41EXbz72I8BMIqAQD5+dH7o0DtybR6fEJClRXf
         UM+9oBxCF775fHhmCTgv7wTlyfvcGjkIx7jQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fvQrk6QqMWIbLlAcsJuBVoZshDn5zuagYNbpKnSUNYk=;
        b=bYLOBzstYOGLZ9UOYVyFK7ZE8hoRfmPY3gWBVMo9b/YuN9m0Zs4TkBZ7vkq0cAQSH5
         Y7dj6vVB4EwZ6lyMZp9+E6wVPLOpaDL8DGFlrz25+pyGx1XkEqHJFGdO+RBVO3lNyGPv
         +iiVQK6dsO2GRnir5xEnqpaWiCMyG4l+pIOs1cNuByP0B4FQnZMNMwyOImtqIGuE000+
         EZ7osBZu2ZTHmPd7R7esu1K6ZKFPN/gKarsqXcLB5cZsTq0zx4r45f6kKcAzVqd6f41o
         FrwxAyj2OOW3EjYbWxC5g6zPiKEJsttRbGEWNM87yULmhKuBDGEhd0ZmRhJ0WPVdEUvR
         /WKQ==
X-Gm-Message-State: APjAAAW2xO/84yh64T4EO74YCuAuxZcKEYEPLw0UYEbyrr7+Ecry+x/Y
        6EmKaA6D4aBa97x171gGd0Hm+A==
X-Google-Smtp-Source: APXvYqyd5ViDsM/ozDX+i5BT0Qs/6fseaDiqhur2F81bUtGwOj65M5uwWd0P+3/cqvLibI+BQjOSDw==
X-Received: by 2002:a1c:700b:: with SMTP id l11mr68339wmc.106.1559828661872;
        Thu, 06 Jun 2019 06:44:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v6sm2252245wru.6.2019.06.06.06.44.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 06:44:21 -0700 (PDT)
Date:   Thu, 6 Jun 2019 15:44:18 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.2-rc4
Message-ID: <20190606134418.GB26408@miu.piliscsaba.redhat.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.2-rc4

Here's one fix for a class of bugs triggered by syzcaller, and one that
makes xfstests fail less.

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: support the FS_IOC_FS[SG]ETXATTR ioctls
      ovl: detect overlapping layers

Miklos Szeredi (1):
      ovl: doc: add non-standard corner cases

---
 Documentation/filesystems/overlayfs.txt |  16 ++-
 fs/overlayfs/file.c                     |   9 +-
 fs/overlayfs/inode.c                    |  48 +++++++++
 fs/overlayfs/namei.c                    |   8 ++
 fs/overlayfs/overlayfs.h                |   3 +
 fs/overlayfs/ovl_entry.h                |   6 ++
 fs/overlayfs/super.c                    | 169 ++++++++++++++++++++++++++++----
 fs/overlayfs/util.c                     |  12 +++
 8 files changed, 249 insertions(+), 22 deletions(-)
