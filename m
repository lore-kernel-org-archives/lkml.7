Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168EBC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC92E204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562602081;
	bh=8t+dLyRWE9OfKMGh8ltfYrD6RFexalTQvXnnTd7/0P8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=GnSALribXZrLoWXALtnY9rUNBC20oaqc2Z3aTZMx1r/cjaXwQC7Y5rhpMFYRyrhnx
	 iynycbg2U7Gjfeh+Mlj4REAgEsGifjL/m6LXl57qS+mKySRXL+5wV862EgjDUoj/LV
	 igtD0DM7hd8Y6FlY+RMMmWMNpxxFbDGrTSAurOjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390181AbfGHQIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:08:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37912 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388024AbfGHQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:08:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so76926wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SqvwTPw4pFUo8UkEsluda4taGEiFNEShHelVdcks3as=;
        b=OCOfgxPs1lIwoRPTi0XAHi2/CQjUMITyF305JFScqUGMcF18FTxriCII5/cW40qWcY
         R1/J5Rk0jIAgXfGtuJzT0Ga6kYd5+IYUFJJ3euCq9IPbOAjmpAhrBs/gqP9XD8TfYAmS
         7ClcbpLb7fSWmu3OEjTdF0zbV84FuQP3bm/fqlwmLuobtIihOllHBNU5on2iyFnxO/B8
         qRxoFaDAgdAnUZ4fW187jxoPc3R5k0MxfaOobUOjnGWnTVAFQ04YgtV4xVP8JSjLl9Wd
         dA8IVUFz/1/9Pn1yQlG4R0SLXaxkhWimhnqtb7koh2DmagtByUeKln/WROuO2CVksuMr
         p5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=SqvwTPw4pFUo8UkEsluda4taGEiFNEShHelVdcks3as=;
        b=pMHcNb+xdcPtMOXvE1cJATO1oTHZmJI8wIfhJV9mCyWlmpOrzojljYdOXot2XBcekJ
         GLxbxmcN6EgZlNJBQqnzhiW+gQo5XojtIkzbkF+/AGG/iwTOfIq6c/xp5S5xd3ys5/qr
         VMms30Qgp+oNzQd5OQyU+e+vt1xOf+8qH1hpC+iE66WeZC1eX6YJ+WwJ9F4vWfxSEbT4
         jSd+bDhwhfxD6/w5sXw5gGELqjgewhVS11m2Ub3ck4GL3D9fT3HveSg/3HiKAV1RvjOx
         eLpL1ddVhv7Ex13zmdDuoRasXCf02VQQC5Fvuyjrp0hR0pjb74IrTn1VUrBT9Dwv9vqg
         DQNQ==
X-Gm-Message-State: APjAAAU2RRBfy+QIQqG+me7L+twmylR6ddgIg196bFQ+XsjnnO526fJ0
        uO7rVl2HcZnEjwV1n/OU3VyhJtde
X-Google-Smtp-Source: APXvYqycTCBnFiANEmq5sLcYZleNUdlNuWKsTwQYg1Av9urvJQ5UIAkB3xYbnjEogcW7LVpElULycw==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr17305625wmb.39.1562602077867;
        Mon, 08 Jul 2019 09:07:57 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 17sm16600130wmx.47.2019.07.08.09.07.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:07:57 -0700 (PDT)
Date:   Mon, 8 Jul 2019 18:07:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 cleanups for v5.3
Message-ID: <20190708160755.GA76526@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cleanups-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

   # HEAD: 53b7607382b0b99d6ae1ef5b1b0fa042b00ac7f4 x86/kexec: Make variable static and config dependent

Misc small cleanups: removal of superfluous code and coding style 
cleanups mostly.

 Thanks,

	Ingo

------------------>
Krzysztof Kozlowski (1):
      x86/defconfigs: Remove useless UEVENT_HELPER_PATH

Masahiro Yamada (2):
      x86/io_delay: Break instead of fallthrough in switch statement
      x86/io_delay: Define IO_DELAY macros in C instead of Kconfig

Mathieu Malaterre (1):
      x86/tsc: Move inline keyword to the beginning of function declarations

Tiezhu Yang (1):
      x86/kexec: Make variable static and config dependent

YueHaibing (1):
      x86/amd_nb: Make hygon_nb_misc_ids static


 arch/x86/Kconfig.debug            | 44 ---------------------------------------
 arch/x86/configs/i386_defconfig   |  1 -
 arch/x86/configs/x86_64_defconfig |  1 -
 arch/x86/kernel/amd_nb.c          |  2 +-
 arch/x86/kernel/crash.c           |  4 +++-
 arch/x86/kernel/io_delay.c        | 38 +++++++++++++++++++++++----------
 arch/x86/kernel/tsc.c             |  4 ++--
 7 files changed, 33 insertions(+), 61 deletions(-)

