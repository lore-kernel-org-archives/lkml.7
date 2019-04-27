Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3717BC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 22:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9867206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 22:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZVxa2ZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfD0Wi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 18:38:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43019 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfD0Wi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 18:38:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id t22so287939pgi.10;
        Sat, 27 Apr 2019 15:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cFZkA5CUkgKwoe6mx3jHj9OoNUtIU52AVqJl0l10p1o=;
        b=VZVxa2ZVsNmslXFa3MWYrswOBwdr9s6QJMR2+aKDvywFu6Ar/6bQphKjRgDsD+75vs
         y6QShbWJg124f8+mK8i++/OIAADoRwjLgkyCNhirrBiSxTGAlpG/kAMFUW/7kSjMlHni
         rPczGR1OPDieo0GIQEQDSWjshuhdAP5VH9v03bFKE4KWtnLva8ZMzEY4FwWy7ry2a1io
         AdUkvqgU8624CcR3MaVsYIRO+6CyHWS+YWQS1ZzXQ4DztKuZv/wIRmy6BVu14MxLa6ci
         chtNPNn+CHvsaroiPX5ika04t203+K5iQWkJT93ioxH/ISvBgcndqhlLTW1VQKQdSZTz
         9mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cFZkA5CUkgKwoe6mx3jHj9OoNUtIU52AVqJl0l10p1o=;
        b=mVmddXN1BQp3ReP9wMM0sKJ4/exOhrSZkM7t8fAx0OiDKA/r2dY6yLoybuDaCVptjI
         vyFaEBCOtsqRJqoXKwlno4XftwRrC/Sh3CIK3OxRPMY38OhpWN+BCclTNE9HM24hDYKc
         oRZEHwyiHOk5JlgbeV5sSx3dEoh8JAohT/FDr5EV0lwO9FkALckDX3S0Sa7cz1siGqpT
         Jmb3hXNQf/2HF8MAkPeo0baC6scC5KFhbs/Uqlvba/P98oBKmJUNL9BEkQ651xBIrI6e
         3EBYYg/zAM8SmQ6ie15WE53Vkt8PBjRS8waFgCY1d+80isRlRg0CPMaS31BFWPrOY5rZ
         OLTw==
X-Gm-Message-State: APjAAAXKeVrcmgnHS23ia0b7yW2+YL3bwuf0G0MeMxbomInCbrdCjI7J
        lN0Tf78JV3XaqdsVQjcGpMY=
X-Google-Smtp-Source: APXvYqwNiWGeB2yro8u83u3Pxq+GHRCMpT7EjKPPWI3u6GGanQGkCJvfCiVQbCxt7E3jYbTzA9IDcg==
X-Received: by 2002:aa7:8252:: with SMTP id e18mr10359167pfn.105.1556404737087;
        Sat, 27 Apr 2019 15:38:57 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b144sm208054pfb.68.2019.04.27.15.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 15:38:56 -0700 (PDT)
Date:   Sat, 27 Apr 2019 15:38:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.1-rc6
Message-ID: <20190427223854.GA97206@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just a couple of fixups for
Synaptics RMI4 driver and allowing snvs_pwrkey to be selected on more
boards.

Changelog:
---------

Jacky Bai (1):
      Input: snvs_pwrkey - make it depend on ARCH_MXC

Lucas Stach (1):
      Input: synaptics-rmi4 - write config register values to the right offset

Pan Bian (1):
      Input: synaptics-rmi4 - fix possible double free

Diffstat:
--------

 drivers/input/keyboard/Kconfig  | 2 +-
 drivers/input/rmi4/rmi_driver.c | 6 +-----
 drivers/input/rmi4/rmi_f11.c    | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

Thanks.


-- 
Dmitry
