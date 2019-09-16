Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B01C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B39C214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568638697;
	bh=vj1VWr2Gu0ZgnmL1BCAE4IZSjuMQ16zRUx+SNOTEUHk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mpIjEgNAbJwg1k6TN3eK5LwBdb/q8cMtgLHx1TtBoiRn787vdMCR3dAH4sRqlpiPX
	 CZrH/yOXiwky73CTxb8Y8v+NeJ1It3cvzIvnmNY7MJlneWEllCesJwYspSP7+iMdCZ
	 ZhI9fuPC0izgY4Y0Zqnd6mnSrEmGZmLJpVcFvxFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbfIPM6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:58:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39012 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfIPM6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:58:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so9723383wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FA5m4jqXaM4EIWzBjk0k8EZAokIEuUU76sx8jAplsh8=;
        b=MuTcBYbZSucUBj1eL3XGpYo5fMMwGcN2hhosiC/5sg6sR7PM4MvSGy3ghmEifMj2oM
         BJ+Ebjov+gRCJd64LQm4i/+Iye8zMsrYKkzdPQb4qejUNOov5m4UrF0ySrgtpSNv7aim
         QfLUpyFIi2xi1WaO7Uge56gGku6qoJqyQ408c2BB/EQfFcHHvVjxQoV7i8PpNG1KJdsw
         LcKhxQ1AgxdwWnpWGRmd/50xyrvGfoKebEmBjbify2EU2H8ElIvPMWb9+qGYY+DeRMCx
         OgesUkEEZ3kvsrmqTlUvzO+rdO4Lb7l3qy7tuB+tr1u+9Gv3uyrBWp0F/s17SkcE7+HR
         F0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=FA5m4jqXaM4EIWzBjk0k8EZAokIEuUU76sx8jAplsh8=;
        b=jprjoaNen5NxHSFYQtmwELpQoOm1gSPE3CsAbpwlohURn+QFeXSqsAA09hH8q4VcrK
         +tsST5FWkMlPeCLCVwk/uaC4vxX3XgYg7HXSkzU9fw9N0EPKGr/IK+RR/NqrR9W4U5Kb
         xXQIJQGaaj/QsMH4X0w+urCH8yRK2dk9737LDtcRdW8HK42qxxvzYnRHJ+r/WRbnJUoO
         +7kKA/IREc8SYysbyfc38fQcVpmCIiQRYrZByY46/fFjb4COXWXaMDTNurh+zyjhDv7I
         AmsCgGaLulEHskJvQXlb4qH6ej9qB8H9znoa0pD7iza4RIkxl6NzzU8OC02Eufwk5b8J
         ozRw==
X-Gm-Message-State: APjAAAUuJoOeEYET5coLIugCu7m/Y1C6mMfjGGqSfxUZ60inL9K1cwV4
        NwjxDESYm/qwy3awOjVzzGs=
X-Google-Smtp-Source: APXvYqy5LxFBd3/6tSSmmdQes2mJftNOYxnBm4tp3XEump4HXevxg6kw6sKibIVxPoWJeTj5A9tQCg==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr13793435wmk.84.1568638693735;
        Mon, 16 Sep 2019 05:58:13 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r2sm14695808wrm.3.2019.09.16.05.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:58:13 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:58:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/entry changes for v5.4
Message-ID: <20190916125811.GA73360@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-entry-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-for-linus

   # HEAD: 6365b842aae4490ebfafadfc6bb27a6d3cc54757 x86/syscalls: Split the x32 syscalls into their own table

This tree contains x32 and compat syscall improvements, the biggest one 
of which splits x32 syscalls into their own table, which allows new 
syscalls to share the x32 and x86-64 number - which turns the 512-547 
special syscall numbers range into a legacy wart that won't be extended 
going forward.

 Thanks,

	Ingo

------------------>
Andy Lutomirski (4):
      x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long
      x86/syscalls: Use the compat versions of rt_sigsuspend() and rt_sigprocmask()
      x86/syscalls: Disallow compat entries for all types of 64-bit syscalls
      x86/syscalls: Split the x32 syscalls into their own table


 arch/x86/entry/common.c                         | 13 ++--
 arch/x86/entry/syscall_64.c                     | 25 +++++++
 arch/x86/entry/syscalls/syscall_32.tbl          |  4 +-
 arch/x86/entry/syscalls/syscalltbl.sh           | 35 +++++-----
 arch/x86/include/asm/syscall.h                  |  4 ++
 arch/x86/include/asm/unistd.h                   |  6 --
 arch/x86/include/uapi/asm/unistd.h              |  2 +-
 arch/x86/kernel/asm-offsets_64.c                | 20 ++++++
 tools/testing/selftests/x86/Makefile            |  2 +-
 tools/testing/selftests/x86/syscall_numbering.c | 89 +++++++++++++++++++++++++
 10 files changed, 168 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/x86/syscall_numbering.c
