Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33E2C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A0921852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhxemzA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfIQMdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:33:19 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:42096 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfIQMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:33:19 -0400
Received: by mail-pf1-f170.google.com with SMTP id q12so2080178pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oA4t4J/iJwjOniszeRVri+PSEkSUz1g5LhQPjOkZlVc=;
        b=IhxemzA+Fy0VcDDVzFLlFJRn02AeEwN1VMfG6U0o8ByC958eOZXI/feqwekvJFyoMy
         tyX5JhAhyJf2yAf1DLNHkcxutuVu8vGQjnVA65uVA0pbSPt/IkLzP6C4X6Hz73xu3ier
         07OQoVKHA9U1I3mvmos7nDiz6Mvg3ZAUqPpddSdaCjGIHUSPYt1MIQpSfDckL0C8iawr
         8l6QBbDCapvWyntKJdvc0jTjfu7Nh+u/6dLhsr52/mlWYS8c/JNLxbwa8Ky2JkvBV7kr
         bueCXIq47VuxEo9oOckAD9CwNEFZ+tbVjeVLAh/JbCTmndnDYi2eo5jGDnpYfFIXHFOr
         +qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oA4t4J/iJwjOniszeRVri+PSEkSUz1g5LhQPjOkZlVc=;
        b=QIUDKZh4YtfVvzl/EW8etEnxhCfCGtR6hndd9SmcW4eTer32Z/mDP6XH8WJlcCYcMq
         LkS06tAuQ+z0SA5BBCWqS6FV1A+MXMlPSpywGktrJYzh9nJJ8ymsH30ttq8i2KLrjzbh
         uUPm27n5Wf3h0P0xKe7dr2Mt6jCAPeu6AGa3hnoh9g9MzuFNxH44tdrTe6p7qv5yqyxU
         OSxlvr4LywWpM75PI9OuPIWivGKcAu0X+1YMynWvRoGSbvtKsZXnnM56eEU4+Npc8+Ab
         XJD8hhCas+FuB6gL5Pnme8drZTibsDk1IvsSixYi+u0fm+2ftXKtMaGMIkt9+l9rB9zr
         tB6Q==
X-Gm-Message-State: APjAAAU1L+v6l9OQuOdm0GCOE2sBLZLN2GvGveW+NjXhXNQdta8e7xH0
        KAxJF28KsVIy5K3SUwv65jke/SfF
X-Google-Smtp-Source: APXvYqz+aujTV4buh9xT9QjYqUAmBZ18/hx5Ep6d7/e/P5oAx5xrBzyveNMXbjnmgAGMWzcPT9As2Q==
X-Received: by 2002:a17:90a:3301:: with SMTP id m1mr4799592pjb.27.1568723596941;
        Tue, 17 Sep 2019 05:33:16 -0700 (PDT)
Received: from localhost (g143.222-224-150.ppp.wakwak.ne.jp. [222.224.150.143])
        by smtp.gmail.com with ESMTPSA id r187sm3111768pfc.105.2019.09.17.05.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 05:33:16 -0700 (PDT)
Date:   Tue, 17 Sep 2019 21:33:12 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, hch@lst.de
Subject: [GIT PULL] OpenRISC updates for v5.4
Message-ID: <20190917123312.GC24874@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling,

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to f3b17320db25b4cdd50f0396b096644455357dac:

  openrisc: map as uncached in ioremap (2019-08-31 11:57:53 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.4

Few small things for 5.4:
 - Fixup ethoc ethernet device tree descriptors which were previously
   broken, now ethernet works on FPGAs running OpenRISC!
 - Switch ioremap to use uncached semantics - from Christoph Hellwig

----------------------------------------------------------------
Christoph Hellwig (1):
      openrisc: map as uncached in ioremap

Stafford Horne (2):
      or1k: dts: Fix ethoc network configuration in or1ksim devicetree
      or1k: dts: Add ethoc device to SMP devicetree

 arch/openrisc/boot/dts/or1ksim.dts    |  5 +++--
 arch/openrisc/boot/dts/simple_smp.dts |  6 ++++++
 arch/openrisc/include/asm/io.h        | 20 +++-----------------
 arch/openrisc/include/asm/pgtable.h   |  2 +-
 arch/openrisc/mm/ioremap.c            |  8 ++++----
 5 files changed, 17 insertions(+), 24 deletions(-)

-Stafford
