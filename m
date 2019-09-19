Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BEFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7E82196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY40J3Mb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391617AbfISQIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:08:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36271 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391604AbfISQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:08:11 -0400
Received: by mail-ot1-f68.google.com with SMTP id 67so3595782oto.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=rUW2ZKDVmFU25rXuzcHzPnF/hKyMTjr3SA4HSJinQ+A=;
        b=EY40J3Mbcprxs5FWe6X/AVaUMJP5AsyitSuDNT6vHeKS+dH9Vt7kQ9tdaQhlJC7dKC
         nAu06z/KiDlpx1k+iy78CsWzqZJ9mLxM50jC0aDlq2/T6v0zBC9qWq+CQ/4/WoxzBGl4
         4Ajpw1zVoh30/n/I6nr8CzHGDOaGwx0RszoM5G1GMmlBO0jfy4V3ZG5iPmWxWUS+Xa9U
         5KY5CFiK4Wd4f3XfR3KKFhdNx1BzzmpNgjFU3kYneQkOHe2BOnRmGR7SkA5m73UJqU4C
         Z3l/htS0jCVWH7EN1JF7ivJVUOCju5AbT7Cu5+0ggOigZ2LGlHwqEDYa6OS7rMe2nCd9
         10dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=rUW2ZKDVmFU25rXuzcHzPnF/hKyMTjr3SA4HSJinQ+A=;
        b=oOjLiOXRkUarFuN7vHPq+Tq8WSyV8Hj57HbENVr4RBbCLwg8glbmrSLJX/ytpCQ6/+
         U4b3bLPTHAPZdMnjlONKKFTrrG5jfBaT+de/+x0u7z9YUQItu4xTVItEt9BdP3ZWclTS
         j/ED+lmR9eEBO/CSOjJQUR08pLcZ5GfcrbNofCQi2muxV+yGV+1ZnSBYDAOwuazXESkU
         NL5QLxMSQGQMdDyggVRXKJLkUwjGZ81xYIVOl9OXNv5J4ApwJ7ZvfXW6RedmN/HIcvq0
         6/Cdo4S1xGGDTxYiAxV+u0Te+/enYDTz9uvpXA/goJIwCePV3raxNp0NT10PASF9xnZE
         SstA==
X-Gm-Message-State: APjAAAWu6wpaxSu3bA35sTmTG6iUl80vgqQDOo2KKDqF5g77ajl6gJXd
        yxh7b8ReaNACeSEIRcF/ja6fFWk=
X-Google-Smtp-Source: APXvYqzSir7sOGdsJSI/KFYTw6Uac+R9rdB36jKgfon7TP70OeKDdIUwYyz1f8FtuKCnvz/I5hcalQ==
X-Received: by 2002:a9d:51cc:: with SMTP id d12mr2946233oth.206.1568909289993;
        Thu, 19 Sep 2019 09:08:09 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id w201sm2983434oie.44.2019.09.19.09.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 09:08:09 -0700 (PDT)
Received: from t560 (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id 6EBAE1800D0;
        Thu, 19 Sep 2019 16:08:08 +0000 (UTC)
Date:   Thu, 19 Sep 2019 11:08:07 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.4
Message-ID: <20190919160807.GL13407@t560>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5c6207539aea8b22490f9569db5aa72ddfd0d486:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2019-07-31 13:26:54 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.4-1

for you to fetch changes up to c9acc3c4f8e42ae538aea7f418fddc16f257ba75:

  ipmi_si_intf: Fix race in timer shutdown handling (2019-09-12 16:03:18 -0500)

----------------------------------------------------------------
IPMI: A few minor fixes and some cosmetic changes.

Nothing big here, but some minor things that people have found and
some minor reworks for names and include files.

Thanks,

-corey

----------------------------------------------------------------
Corey Minyard (6):
      ipmi_si: Convert timespec64 to timespec
      ipmi_si: Rework some include files
      ipmi_si: Convert device attr permissions to octal
      ipmi_si: Remove ipmi_ from the device attr names
      ipmi_si: Only schedule continuously in the thread in maintenance mode
      ipmi: Free receive messages when in an oops

Jes Sorensen (1):
      ipmi_si_intf: Fix race in timer shutdown handling

Kamlakant Patel (1):
      ipmi_ssif: avoid registering duplicate ssif interface

Tony Camuso (1):
      ipmi: move message error checking to avoid deadlock

 drivers/char/ipmi/ipmi_dmi.c         |   1 -
 drivers/char/ipmi/ipmi_dmi.h         |   1 +
 drivers/char/ipmi/ipmi_msghandler.c  | 121 ++++++++++++++++++-----------------
 drivers/char/ipmi/ipmi_si.h          |  57 ++++++++++++++++-
 drivers/char/ipmi/ipmi_si_intf.c     |  98 ++++++++++++++++------------
 drivers/char/ipmi/ipmi_si_mem_io.c   |   2 +-
 drivers/char/ipmi/ipmi_si_pci.c      |   2 +-
 drivers/char/ipmi/ipmi_si_platform.c |   2 +-
 drivers/char/ipmi/ipmi_si_port_io.c  |   2 +-
 drivers/char/ipmi/ipmi_si_sm.h       |  54 ++--------------
 drivers/char/ipmi/ipmi_ssif.c        |  79 ++++++++++++++++++++++-
 11 files changed, 260 insertions(+), 159 deletions(-)

