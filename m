Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669F0C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F78920659
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574688232;
	bh=U6EkuWu9FszQRWcOHeFTAfWkkc7UXM8QzhcC79xYYHA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FKfLC5vvJFuHDE5L6ws0szmKwP/i16XteTB/glt7Z5PMzES9VI7ufi50iDCUwFENk
	 2IpYUjqnEozIA1pSCM3s2VFbwVc+lEA3CxHsCK+xIuW7+e/jWqUjiKNYrnfF2qH6oN
	 CobCkW2UUEHAKjmhIfQgMZp9ZJxYs7LBZrHC3K/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfKYNXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:23:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38226 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfKYNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:23:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so18079222wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 05:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p6J9EdHS4Pj4b2Zc6Njcg6x4/1P15GSkkzO/2X0NY1E=;
        b=MOe5nRhEFxaeEMS8EqG5lP8MHOh01Kmqesh5RyoNBpbowM8atOu+qqpxyef0yYw6BM
         VKkrdrrl0KI7jFGydvEgG3JBg8U5DLNLXZwbJs36iJBpDAqcn8frdd/MjRebRws6yTJr
         RyTk8jjPqalsarIjjBytoz1OqNBo2JICi7aIGqnxG9G+5V4MAfYeSPHFtew3BSE7CmyU
         dKVbeLKc00Uzf63wdg13E1SB0wtpTGNwqIOdpJpRJI+Pr9Bxrat4Ja9vaEBWPPcXJGyD
         x8bbtzo9BX8/anvcyZQTk4CQzeF3MrRT5UBQf6YInZi50Rnqw12zBnt9cqA4+8M7i9X8
         ak2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=p6J9EdHS4Pj4b2Zc6Njcg6x4/1P15GSkkzO/2X0NY1E=;
        b=aQytmJbAVi2Ky3UM5RAWBLiQhUaj23UGp8gTSgA4FZUMxoDUjlPqH2brsG5pJu5GRp
         IIlBsQm5Goa+5Zvkm4iJI9R6cTWb7Wliec7gqtB9KacMWPeADvL6kJeRkiw/NpetYYdS
         TWQc7Rg22qlJlbaFkHc1PTj3y7eDmKEBpPQh89D9ojqXTnBE51VPPi4RKxfIm5R935yJ
         68+xoYSohLHvEk24s2pczUZLve9r7xCVs0RkRmAvxq26ifwWM1bkD4WwHwecUBfe6dyk
         oBmlwWoZHxuNQq3xIenys1fMYXQP/gbaISRLSNwXSB6UG8ZLVyOd+5y/pXCcfE56pQ84
         fToQ==
X-Gm-Message-State: APjAAAWudC1NZvOjrz7JWpqkA0yHm55oKwXve3LlfUilH0Xk7mqpb5Iy
        oKlNO9iLtjmEfQNxBT+Eu94=
X-Google-Smtp-Source: APXvYqzIuNqWHnw+8tDQuZKT8YnuAecb6F3vcK1cyR/1Vy6Pc5A4bkyx9sQ+bXmoUVjakSrjdbSORA==
X-Received: by 2002:a5d:4589:: with SMTP id p9mr15585311wrq.61.1574688228661;
        Mon, 25 Nov 2019 05:23:48 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u13sm7985230wmm.45.2019.11.25.05.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 05:23:48 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:23:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/boot changes for v5.5
Message-ID: <20191125132346.GA82640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-boot-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

   # HEAD: b3c72fc9a78e74161f9d05ef7191706060628f8c x86/boot: Introduce setup_indirect

The main changes were:

 - Extend the boot protocol to allow future extensions without hitting the 
   setup_header size limit.

 - Add quirk to devicetree systems to disable the RTC unless it's listed 
   as a supported device.

 - Fix ld.lld linker pedantry.
 
 Thanks,

	Ingo

------------------>
Daniel Kiper (3):
      x86/boot: Introduce kernel_info
      x86/boot: Introduce kernel_info.setup_type_max
      x86/boot: Introduce setup_indirect

Nick Desaulniers (1):
      x86/realmode: Explicitly set entry point via ENTRY in linker script

Rahul Tanwar (1):
      x86/init: Allow DT configured systems to disable RTC at boot time


 Documentation/x86/boot.rst             | 174 +++++++++++++++++++++++++++++++++
 arch/x86/boot/Makefile                 |   2 +-
 arch/x86/boot/compressed/Makefile      |   4 +-
 arch/x86/boot/compressed/kaslr.c       |  12 +++
 arch/x86/boot/compressed/kernel_info.S |  22 +++++
 arch/x86/boot/header.S                 |   3 +-
 arch/x86/boot/tools/build.c            |   5 +
 arch/x86/include/uapi/asm/bootparam.h  |  16 ++-
 arch/x86/kernel/e820.c                 |  11 +++
 arch/x86/kernel/kdebugfs.c             |  21 +++-
 arch/x86/kernel/ksysfs.c               |  31 ++++--
 arch/x86/kernel/setup.c                |   6 ++
 arch/x86/kernel/x86_init.c             |  24 ++++-
 arch/x86/mm/ioremap.c                  |  11 +++
 arch/x86/realmode/rm/realmode.lds.S    |   1 +
 15 files changed, 326 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/boot/compressed/kernel_info.S
