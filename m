Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1184C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 19:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623BA20C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 19:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5JZmF3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfELTll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 15:41:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43297 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfELTlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 15:41:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so12870634wro.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 12:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iCOE3Lx6Cb7K+puvEJ0JXXJFYGgFv7+7QeyyjnRyHs0=;
        b=H5JZmF3ChVLTqTx0P8KprOZ3KNh5hnZbTTwGR5LwMWCBRj3rAR94sqVR9vIsofWowG
         NCfhWcKo5LkHCT0q1TIeDzwyoNrqVzry7Slodb7yZJXHiw1e5gwGCtJRWZRfOr3ZKf9i
         iE1VNIOYH51/CRKyx2jRjP4HEIHm9NHFTYAwxowFqkLmnTSCp1q9eoprBiT5xaJ3ONDn
         zk+3m4AXbIWkxNzhDS8eMb+rB/CVYrJllAjKiaD/MMDDosmGYDxVHFjwM3Hxoza4mLyy
         8Xc5u0ffImbkc0cie6TauVzWHBSunJC0/jzSoYTx/zqe8JOe9Md6hi0JA0q/bXWeWlrG
         cYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iCOE3Lx6Cb7K+puvEJ0JXXJFYGgFv7+7QeyyjnRyHs0=;
        b=OSlGrQ7gMSCys5FAIEVVvTCkbiX97ofv+//q78Te3ywyz7VEwlwk5UPWF1FouE3QIy
         xaQXY8iivArti5YDo25Jfb8TSK/MpXVJMiJAWwCGUGOGMNpkHzMDwu26Tq41tRyNn+F1
         sBKylyCqk9NtMtasupBU7SS7ixsLOszMPBUucqapJ6HTC6DQEoT0csIhLH9J9L6+z1WM
         u484AKU1fGAVFIk+zspWU/1QzerWq9hDJnRSb9GIV+nJjnY08ffQomE2mtlyJxl7cFaf
         5CagtBL6u+zDnfMsh+csQMLavb1OJmKgK41MC31SbZZ6N+DamBxn1RVximf4c6sKT8fI
         Q4zQ==
X-Gm-Message-State: APjAAAWz+fI3/uiBVp4DYDeLWaAYg+TC7VzO4ceUoRyyO0AeT5yPRMCP
        T0y6f3TYe1ho+2ZTugT5E5/rj1I0
X-Google-Smtp-Source: APXvYqyTFeAk51teRzTWTpvEPDB2inT7xme9sE4V8OaVTXWdLy+fpdxD4gefeY+Bx8Dcx/OLXPR4jQ==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr15089685wrn.51.1557690098891;
        Sun, 12 May 2019 12:41:38 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o8sm24752552wra.4.2019.05.12.12.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 12:41:38 -0700 (PDT)
Date:   Sun, 12 May 2019 22:41:36 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.2-rc1/2
Message-ID: <20190512194136.GA12189@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is the pull request containing fixes for 5.2-rc1/2.

It contains 2 fixes (1 of them for stable) and 1 change to a new IOCTL
that was introduced to kernel 5.2 in the previous pull requests.

See the tag comment for more details.

Thanks,
Oded

The following changes since commit 8ea5b2abd07e2280a332bd9c1a7f4dd15b9b6c13:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2019-05-09 19:35:41 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-05-12

for you to fetch changes up to 6800914b3a6dc11a08e7143f981c110aee439110:

  habanalabs: fix debugfs code (2019-05-04 15:56:08 +0200)

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

----------------------------------------------------------------
Jann Horn (1):
      habanalabs: fix debugfs code

Oded Gabbay (1):
      uapi/habanalabs: add opcode for enable/disable device debug mode

Omer Shpigelman (1):
      habanalabs: halt debug engines on user process close

 drivers/misc/habanalabs/context.c             |  6 +++
 drivers/misc/habanalabs/debugfs.c             | 60 ++++++++-------------------
 drivers/misc/habanalabs/goya/goya.c           |  3 +-
 drivers/misc/habanalabs/goya/goyaP.h          |  1 +
 drivers/misc/habanalabs/goya/goya_coresight.c | 17 ++++++++
 drivers/misc/habanalabs/habanalabs.h          |  2 +
 include/uapi/misc/habanalabs.h                | 22 +++++++++-
 7 files changed, 66 insertions(+), 45 deletions(-)
