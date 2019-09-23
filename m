Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA77C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60ACC20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405742AbfIWILm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:11:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:37810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388953AbfIWILm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:11:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D323EAC3E;
        Mon, 23 Sep 2019 08:11:40 +0000 (UTC)
References: <20190923003846.GB15734@shao2-debian>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     ltp@lists.linux.it
Cc:     Andy Lutomirski <luto@kernel.org>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [LTP] 12abeb544d: ltp.read_all_dev.fail
Reply-To: rpalethorpe@suse.de
In-reply-to: <20190923003846.GB15734@shao2-debian>
Date:   Mon, 23 Sep 2019 10:11:40 +0200
Message-ID: <871rw7l9dv.fsf@rpws.prws.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

kernel test robot <rong.a.chen@intel.com> writes:

> FYI, we noticed the following commit (built with gcc-7):
>
> commit: 12abeb544d548f55f56323fc6e5e6c0fb74f58e1 ("horrible test hack")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/luto/linux.git random/kill-it
>
> in testcase: ltp
> with following parameters:
>
> 	disk: 1HDD
> 	fs: ext4
> 	test: fs-02
>
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
> <<<test_start>>>
> tag=read_all_dev stime=1569106866
> cmdline="read_all -d /dev -p -q -r 10"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1108: INFO: Timeout per run is 0h 05m 00s
> Test timeouted, sending SIGKILL!
> tst_test.c:1148: INFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1149: BROK: Test killed! (timeout?)

So perhaps this is caused by reads of /dev/random hanging? At any rate,
I suppose this is intended to deliberately break something, so we can
ignore it.

--
Thank you,
Richard.
