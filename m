Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5086C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E3A214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557135749;
	bh=NTaVrnlyGoU6Xky7YkSm5m4v3sxRF5JVoI59ymzAEyo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=yJ7vXSjy0R6wPztJijWjr0tljuYY33ukKSO2/roB5jeDetsB6wDuxhts2LG6EUpVq
	 4gk28gHn8EpBFty/rDAQ9z6XP6QXRAJ1ZJ+bstkv8Qo811hwT8CWxX9EeqOhX5ljxi
	 SZS8PLYdwBdCfUkS5UpnHzwfKplThoFIWjRTKcXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfEFJm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:42:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33456 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfEFJm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:42:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id e11so3312576wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FRzRNFrlJ68cyLke1iNAbZLNosLengXI/UAWjZMkwu4=;
        b=HZIeEEW9hevEWXEkfLkQKHWyxdL6PfEbiHlcz27Ni5+DNu/mOvXOMosaK/Wn+k81ET
         T5WkkdTKiV/Kd/N4Iss63Yk5Q5MtwWpFbAD/M+Xut+A7nTsre0Pf44rPuU+F8B/cYHLR
         KZOse9qNRVOTL2QRJF8fZd60uLHbPv1oekcrPtR5nltdJ3Ud6VXkqEbch56lKZsASm3m
         nUjUj1bh7WIXvs17UnsWlUiwrwHtaCnCBGa3G38J4bkK6vzDrqE86Ko1wJb9/IxfVmFD
         9Fqy4v1BESEFLfNqQzGt4n/n9NhqTbIp+3mz8LwdFhkgu1kHGoOxqsECto3o+x6DwXuz
         qAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=FRzRNFrlJ68cyLke1iNAbZLNosLengXI/UAWjZMkwu4=;
        b=WPujmXW9j1691VXthiFXlErcA+jbeqcAKZNrCbl8yKh6MWJmxuuFg53jIEjq34RJUp
         JIlayrkxZ89/WZO6LxYYG4fLVLIasN/NO9xtVxLZSobr5dzny0x1qmbp5aB6aRR6W9rd
         T8UVgEhTsFjCkNS6PgVyJgeRmz0Oy9TKvKdG4Gykh61higTudNbYT8TbdkmuOWqK+Co1
         KsZxcImob3T/vi7xGowgedGvg6Z7bfFg7bIypmdS/mBld7Tir8NTYVNckGdrQRpiHd5B
         2hi7fU7iI50foHzGTZWoXqWws1b46TiKxU640F/OVVuAdDge/6HvxJreYxnyjo1wVFt5
         Igqw==
X-Gm-Message-State: APjAAAXU7HJkpBDviW54z0HZn9X3EXs7cmFYTPSzq/fMInOSz7e0zBCi
        USpJpwC2QPExDVmXWNgq9lw=
X-Google-Smtp-Source: APXvYqxGFHPo6vs8Dnpa1hfm/AFmV6Tl9RmQ1V9dTwRbSTeTYkxWOnjm71ZgU0Z5d8qm0MkBEfXfGw==
X-Received: by 2002:adf:80c3:: with SMTP id 61mr17882241wrl.123.1557135745958;
        Mon, 06 May 2019 02:42:25 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k206sm20118463wmk.16.2019.05.06.02.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:42:25 -0700 (PDT)
Date:   Mon, 6 May 2019 11:42:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/build changes for v5.2
Message-ID: <20190506094223.GA99131@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-build-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

   # HEAD: f36e7495dd3990d6848e6d6703c78f1f17a97538 x86/tools/relocs: Fix big section header tables

Misc updates:

 - Add link flag quirk to solve LLVM linker bug that removes local 
   relocations, causing KASLR boot failures.

 - Update the defconfigs to remove archaic partition table support

 - Fix kernel growing pains: we had a bug in relocs.c handling section 
   header table entries count larger than 0xff00 (~65k), which can happen 
   with the -ffunction-sections flag, causing a build failure with a 
   cryptic error message. Add support for detecting the limit and using 
   the ELF protocol that extends the sections table via ->sh_size. The 
   new limit is now much larger - over a billion entries?

 Thanks,

	Ingo

------------------>
Ahmed S. Darwish (1):
      x86/defconfig: Remove archaic partition tables support

Artem Savkov (1):
      x86/tools/relocs: Fix big section header tables

Kees Cook (1):
      x86/build: Keep local relocations with ld.lld


 arch/x86/Makefile                 |  2 +-
 arch/x86/configs/i386_defconfig   | 12 -------
 arch/x86/configs/x86_64_defconfig | 12 -------
 arch/x86/tools/relocs.c           | 74 ++++++++++++++++++++++++---------------
 4 files changed, 46 insertions(+), 54 deletions(-)
