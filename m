Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5DAC742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 11:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB9820863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 11:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4JGuK3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfGLLwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 07:52:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39885 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfGLLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 07:52:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so3121752otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 04:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=qaChsCD1R1LiREpVKm4OoTWp/cOYEyMFYaJ8KP8n3v8=;
        b=L4JGuK3YxsJ3fNVfLu/QIYTuLQ09FyFzME+2PCGB6Go/n4Xas8iS430q9OKC2J5yWJ
         vMc/eneBYhy4emrN8Bd1Cc4yArLFfYlaZn3SVFJ5bprHxwgCY8hF3lFRGfSPC4u3Sib4
         rpjPU2jq1J2RnkwO9gTmDGJJxwFJU3LFROqp+TPxaLOg3YT3Qb5a8ZrehwXw0yfwiYe9
         mYmCTWM07kPRtzx6dr5CvC1b5jWMgql1DxmJY7kwkjI5PWiKc0gASftITB1FS4LC8p/c
         rastlDr4sfX9VZJkNq9eYXEbEY4OCUawAXQ/Y02r6qIYC7z0bN/K207g4+9Vduxyejld
         7/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=qaChsCD1R1LiREpVKm4OoTWp/cOYEyMFYaJ8KP8n3v8=;
        b=SinxfFERQMXVARVRsFZKb7kTL48KBxFPNo0nkfsy87ej6WSDnbT+lVUBYylFfAFsNn
         L9K3ZHTONVKphWL9amLS34Q43pzO75NtAd857/91GGmn70uGmVjVr/zpS8CAqfmDtv+7
         +pLpAvXRFwHsUDa2N6QrfvVHobcSG1yAsrJAyvB6NHgpxs/wVA9lDikax/ADDIxgpy85
         DRtDiaVomdOVTS5qyBTPX20FJiTAdVpAzktuJEuRMW2hHYy11+2iyg2mGazfLAVHEwm1
         kHVi23wU4YlKIJ5jVu4F+6mBkUEd9K40LsDMHZl22fjKaPaxT7EskplegDFiHA/xJ5AC
         j/3g==
X-Gm-Message-State: APjAAAUHFrnIEx3k5GOZs5L2Q21Dvc+7JIelrlFZDZgK2p+A3nUmYyws
        KTvq/y6hrRelwcfhiW77rQ==
X-Google-Smtp-Source: APXvYqynlsFwSUUmfuL/LEqOzo70pUqHL/rT0eaXywko3y10nxX8CfYMs/jPpfbTrpyca05gr9+9Rw==
X-Received: by 2002:a9d:65cb:: with SMTP id z11mr8058567oth.325.1562932327402;
        Fri, 12 Jul 2019 04:52:07 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id e10sm2731547otq.69.2019.07.12.04.52.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 04:52:07 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:813e:fd97:36ac:e9a])
        by serve.minyard.net (Postfix) with ESMTPSA id 67F961800D1;
        Fri, 12 Jul 2019 11:52:06 +0000 (UTC)
Date:   Fri, 12 Jul 2019 06:52:04 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.3
Message-ID: <20190712115204.GD3066@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.3

for you to fetch changes up to ac499fba98c3c65078fd84fa0a62cd6f6d5837ed:

  docs: ipmb: place it at driver-api and convert to ReST (2019-06-30 19:33:25 -0500)

----------------------------------------------------------------
Some small fixes for various things, nothing huge, mostly found
by automated tools.

Plus add a driver that allows Linux to act as an IPMB slave device,
so it can be a satellite MC in an IPMI network.

----------------------------------------------------------------
Arnd Bergmann (1):
      ipmi: ipmb: don't allocate i2c_client on stack

Asmaa Mnebhi (1):
      Add support for IPMB driver

Kefeng Wang (3):
      ipmi_si: fix unexpected driver unregister warning
      ipmi_si: use bool type for initialized variable
      ipmi_ssif: fix unexpected driver unregister warning

Mauro Carvalho Chehab (1):
      docs: ipmb: place it at driver-api and convert to ReST

Suzuki K Poulose (1):
      drivers: ipmi: Drop device reference

YueHaibing (1):
      ipmi: ipmb: Fix build error while CONFIG_I2C is set to m

kbuild test robot (1):
      fix platform_no_drv_owner.cocci warnings

 Documentation/driver-api/index.rst   |   1 +
 Documentation/driver-api/ipmb.rst    | 105 ++++++++++
 drivers/char/ipmi/Kconfig            |   9 +
 drivers/char/ipmi/Makefile           |   1 +
 drivers/char/ipmi/ipmb_dev_int.c     | 364 +++++++++++++++++++++++++++++++++++
 drivers/char/ipmi/ipmi_si_intf.c     |   4 +-
 drivers/char/ipmi/ipmi_si_platform.c |   7 +-
 drivers/char/ipmi/ipmi_ssif.c        |   5 +-
 8 files changed, 492 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/driver-api/ipmb.rst
 create mode 100644 drivers/char/ipmi/ipmb_dev_int.c

