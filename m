Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70142C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0701B20644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCkEi6A5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfEHQRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:17:36 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38175 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfEHQRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:17:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id u199so7625003oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=mEyEsLGtPKEz1Gmqe5gE55GzDPtET2Lqxlpu7didhoM=;
        b=PCkEi6A59MmQ6Yk/B4a0gbXmTZ7VfUnX/9TNvK6hT1hAAhQWNxd/BDbAPNHNIp+HGC
         8QUamDkihg9vWD3W8UGzPUaqa24+qrIAQ0F6JYPv5/xuTOJI3lp/1VnpnU3inIZrdW/G
         J/zCabBJiRCh9rY4B3j6XV/K8ZMHpVkvZsDtDX7NvjpkOnQLVMm2ni0bRGPViMsq5UHb
         Dg9miYz7SYTYqGcK3rYY21+iiBYIztIk94sPRDc5Ulh+neyLm00K+UzDK7DmdIEDDyUQ
         Nq10u6h29kCAoEnHRnbtVe7eFJLTZWqNpYuMDxieIjy416B8TmqKF/oyY8ybVhssRFdT
         rSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=mEyEsLGtPKEz1Gmqe5gE55GzDPtET2Lqxlpu7didhoM=;
        b=mK1X0KXMAzPy8RxMLTC/1I+yyUZ65Nw47hJqaijQ9e4Q81nZqqfPKAahlpRprQmPKO
         NaEFr0JZVfogl64qOGD3xz21COmu0NMijPgnMQpZx75HqWaeqf3553mgDIGpmkuKBz/y
         lKjZqsdMXUePKyDi3GsUxIGijslEMD5y6eppZYs9XygSJ/KtrXRcVtYori2TpedUCFL8
         zGqFJ9gHO4iFQ3v3yM0O9dtRqBFNjZDgyo4571LKMbriGJ4QrgYKwhQ5191KDH8cUJHA
         sGFnL2+h1kRupDN6EZSdp6LCSNaPWl82mcDqmp6dLGyqe6hQw+HopcqwXXYmGt4fLHKT
         62Og==
X-Gm-Message-State: APjAAAXb1ANxMZXkA8TzklZ5gOwahEM3yQ3mn6TyHbcmvkvWG4PniWPw
        TILTGz1kdIPn8NRHgPoweQ==
X-Google-Smtp-Source: APXvYqyTv39lIPGEh5IZ/Rq9WdRnwPNUebFVW34ZD+qvUNVoeejlvTdgZ/iAgMODS0GgNEPbWdXjlg==
X-Received: by 2002:aca:d509:: with SMTP id m9mr2642793oig.153.1557332254606;
        Wed, 08 May 2019 09:17:34 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id t14sm2294386otk.55.2019.05.08.09.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 09:17:33 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id 5B83C18190F;
        Wed,  8 May 2019 16:17:33 +0000 (UTC)
Date:   Wed, 8 May 2019 11:17:32 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.2
Message-ID: <20190508161732.GG16145@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe5cdef29e41c8bda8cd1a11545e7c6bfe25570e:

  Merge tag 'for-linus-5.1-2' of git://github.com/cminyard/linux-ipmi (2019-04-17 10:25:25 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.2

for you to fetch changes up to ed6c3a6d8996659e3bbf4214ba26b5e5a7440b26:

  ipmi: Remove warning if no slave address is present (2019-04-24 12:29:24 -0500)

----------------------------------------------------------------
Some minor cleanups for the IPMI driver.

----------------------------------------------------------------
Arnd Bergmann (1):
      ipmi: avoid atomic_inc in exit function

Colin Ian King (1):
      char/ipmi: fix spelling mistake "receieved_messages" -> "received_messages"

Corey Minyard (4):
      ipmi: Remove file from ipmi_file_private
      ipmi: Add the i2c-addr property for SSIF interfaces
      ipmi:ssif: Only unregister the platform driver if it was registered
      ipmi: Remove warning if no slave address is present

Dan Carpenter (1):
      ipmi_si: remove an unused variable in try_smi_init()

Kamlakant Patel (1):
      ipmi:ssif: compare block number correctly for multi-part return messages

YueHaibing (1):
      ipmi: Make ipmi_interfaces_srcu variable static

 .../ABI/testing/sysfs-devices-platform-ipmi        |  2 +-
 drivers/char/ipmi/ipmi_devintf.c                   |  3 ---
 drivers/char/ipmi/ipmi_dmi.c                       |  2 ++
 drivers/char/ipmi/ipmi_msghandler.c                |  4 ++--
 drivers/char/ipmi/ipmi_plat_data.c                 | 27 ++++++++++++----------
 drivers/char/ipmi/ipmi_plat_data.h                 |  3 +++
 drivers/char/ipmi/ipmi_si_hardcode.c               |  1 +
 drivers/char/ipmi/ipmi_si_hotmod.c                 |  1 +
 drivers/char/ipmi/ipmi_si_intf.c                   |  2 --
 drivers/char/ipmi/ipmi_si_platform.c               |  6 ++---
 drivers/char/ipmi/ipmi_ssif.c                      | 11 ++++++---
 11 files changed, 35 insertions(+), 27 deletions(-)

