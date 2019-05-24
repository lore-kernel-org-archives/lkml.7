Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F37C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D845F206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkt1xXfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbfEXTtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 15:49:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43248 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfEXTte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:49:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id l17so2700583wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5NKdljWifItqg0lBXQOL6XHIUxxttCmzpNdraOrTMhc=;
        b=fkt1xXfHy0LTigBiwV5C3pONwOUeNGPtVJ4EFQf1Pl3DhRQ2lcGy6ZjYe8jpNsp03L
         ad3DxnnQZehIRvn4STNWuo7w/4aNiZaHb6Aij/SCnp2vNbm2Cqz8vySKh8jVhGxp0x1a
         9PKgMNhw3IjYPJYhNTujdGeO2C8eesu2Mwqqw/L2A87e5P3Ien02ML4t1/eiYmG5ehX1
         EtWP/7elC8Lhb59Anef3yyYBo3AodHKnLTa76x1iGc4uYAjREyOn1Pz7MFyUTTjH5IKF
         wtgDATHJ1x053YsCB4ERKYDXxJVRR1fyPFJ4iRdOuQTS/KrwEWjBhKdWw0fAnXZmkZ2g
         36/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5NKdljWifItqg0lBXQOL6XHIUxxttCmzpNdraOrTMhc=;
        b=XZRr/7cPjfQEALukLT1ityatoo88q0vJULSM9zyoywe1b21AdF/+slCLrmoue1nI12
         QFrcjG1rBNz1MozPDNJekum4HdjIA+hXGohwvRbCN8+vrBzDOp8IT6eg8Un7dhimkaV2
         pTiwkGZiDQZ9qQTeBmz36Gunr1whkR2sTrtG60+EVD361OFm3fqeMSi6f9yZs+any3TB
         DXd92e8v1dYpSsfUTGBV0lnI6S0zxvtGxcrnmP3tghtWCLCs5ZQvMNd8pCIc85+exl2i
         8pdR3/Zk5bMy/33LZ3Gk4lyrZSF6WvEJ2A9Jlz+iEvYrnF3LcbsgUAZfj1hLiEcMnCsC
         5dbw==
X-Gm-Message-State: APjAAAVNCjSUFXCsWYw+vKVwH7SdwvewFpVTUGhGTte9N6Ot4r5U+qiI
        UHb/7iAWld0DNfhdrTQw8bG28U3X
X-Google-Smtp-Source: APXvYqwM3UA8hEMFf89nmRr7aaqgWi2rgVO+rQ62xenWqKPKg0+BUdcuPGNOPKZzu9zt4vK8mgk1QA==
X-Received: by 2002:adf:dc0c:: with SMTP id t12mr52443182wri.101.1558727372998;
        Fri, 24 May 2019 12:49:32 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 205sm4374479wmd.43.2019.05.24.12.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 12:49:32 -0700 (PDT)
Date:   Fri, 24 May 2019 22:49:30 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull v2] habanalabs fixes for 5.2-rc2/3
Message-ID: <20190524194930.GA13219@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is the pull request containing fixes for 5.2-rc2/3. It is now
correctly rebased on your char-misc-linux branch.

It supersedes the pull request from 12/5, so you can discard that pull
request, as I see you didn't merge it anyway.

It contains 3 fixes and 1 change to a new IOCTL that was introduced to
kernel 5.2 in the previous pull requests.

See the tag comment for more details.

Thanks,
Oded

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-05-24

for you to fetch changes up to 8d45f1de3994c566cb5ce9b3cb07ff1518e68ddb:

  habanalabs: Avoid using a non-initialized MMU cache mutex (2019-05-24 22:46:15 +0300)

----------------------------------------------------------------
This tag contains the following fixes:

- Halt debug engines when user process closes the FD. We can't allow the
  device to issue transactions for a user which doesn't exists anymore.

- Fix various security holes in debugfs API.

- Add a new opcode to the DEBUG IOCTL API. The opcode is designed
  for setting the device into and out of debug mode. Although not a fix
  per-se, because this is a new IOCTL which is upstreamed in kernel 5.2, I
  think this is justified at this point because we won't be able to change
  the API later.

- Fix a bug where the code used an uninitialized mutex

----------------------------------------------------------------
Jann Horn (1):
      habanalabs: fix debugfs code

Oded Gabbay (1):
      uapi/habanalabs: add opcode for enable/disable device debug mode

Omer Shpigelman (1):
      habanalabs: halt debug engines on user process close

Tomer Tayar (1):
      habanalabs: Avoid using a non-initialized MMU cache mutex

 drivers/misc/habanalabs/context.c             |  6 +++
 drivers/misc/habanalabs/debugfs.c             | 60 ++++++++-------------------
 drivers/misc/habanalabs/device.c              |  2 +
 drivers/misc/habanalabs/goya/goya.c           |  3 +-
 drivers/misc/habanalabs/goya/goyaP.h          |  1 +
 drivers/misc/habanalabs/goya/goya_coresight.c | 17 ++++++++
 drivers/misc/habanalabs/habanalabs.h          |  2 +
 drivers/misc/habanalabs/mmu.c                 |  8 +---
 include/uapi/misc/habanalabs.h                | 22 +++++++++-
 9 files changed, 69 insertions(+), 52 deletions(-)
