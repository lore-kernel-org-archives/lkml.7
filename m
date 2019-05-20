Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D71C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947142081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbfETKFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:05:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729834AbfETKFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:05:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C217B3082133;
        Mon, 20 May 2019 10:04:58 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 648EA704DB;
        Mon, 20 May 2019 10:04:56 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 432F61806B13;
        Mon, 20 May 2019 10:04:50 +0000 (UTC)
Date:   Mon, 20 May 2019 06:04:46 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, lkp@01.org,
        Roman Gushchin <guro@fb.com>, ltp@lists.linux.it,
        naresh.kamboju@linaro.org
Message-ID: <875220079.23570847.1558346686738.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190520032018.GW31424@shao2-debian>
References: <20190520032018.GW31424@shao2-debian>
Subject: Re: [LTP] [mm]  8c7829b04c: ltp.overcommit_memory01.fail
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.17.163, 10.4.195.9]
Thread-Topic: 8c7829b04c: ltp.overcommit_memory01.fail
Thread-Index: dCTlD5jI9boDoW478vfOqrfGG+birA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 20 May 2019 10:05:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 8c7829b04c523cdc732cb77f59f03320e09f3386 ("mm: fix false-positive
> OVERCOMMIT_GUESS failures")

This matches report from Naresh:
  http://lists.linux.it/pipermail/ltp/2019-May/011962.html

> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: ltp
> with following parameters:
> 
> 	disk: 1HDD
> 	test: mm-01
> 
> test-description: The LTP testsuite contains a collection of tools for
> testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [  554.112267 ] <<<test_start>>>
> [  554.112269 ]
> [  554.115806 ] tag=overcommit_memory01 stime=1558074982
> [  554.115809 ]
> [  554.119303 ] cmdline="overcommit_memory"
> [  554.119306 ]
> [  554.121962 ] contacts=""
> [  554.121965 ]
> [  554.124459 ] analysis=exit
> [  554.124463 ]
> [  554.127140 ] <<<test_output>>>
> [  554.127144 ]
> [  554.131401 ] tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
> [  554.131404 ]
> [  554.136248 ] overcommit_memory.c:117: INFO: MemTotal is 4033124 kB
> [  554.136251 ]
> [  554.141365 ] overcommit_memory.c:119: INFO: SwapTotal is 268435452 kB
> [  554.141368 ]
> [  554.146664 ] overcommit_memory.c:123: INFO: CommitLimit is 270452012 kB
> [  554.146666 ]
> [  554.151375 ] mem.c:814: INFO: set overcommit_ratio to 50
> [  554.151378 ]
> [  554.155796 ] mem.c:814: INFO: set overcommit_memory to 2
> [  554.155799 ]
> [  554.159951 ] overcommit_memory.c:190: INFO: malloc 538608648 kB failed
> [  554.159953 ]
> [  554.164801 ] overcommit_memory.c:211: PASS: alloc failed as expected
> [  554.164804 ]
> [  554.170196 ] overcommit_memory.c:190: INFO: malloc 270452012 kB failed
> [  554.170199 ]
> [  554.175344 ] overcommit_memory.c:211: PASS: alloc failed as expected
> [  554.175347 ]
> [  554.180932 ] overcommit_memory.c:186: INFO: malloc 134651878 kB
> successfully
> [  554.180935 ]
> [  554.186522 ] overcommit_memory.c:205: PASS: alloc passed as expected
> [  554.186524 ]
> [  554.191234 ] mem.c:814: INFO: set overcommit_memory to 0
> [  554.191237 ]
> [  554.196930 ] overcommit_memory.c:186: INFO: malloc 134734122 kB
> successfully
> [  554.196933 ]
> [  554.202738 ] overcommit_memory.c:205: PASS: alloc passed as expected
> [  554.202742 ]
> [  554.208563 ] overcommit_memory.c:190: INFO: malloc 538936488 kB failed
> [  554.208566 ]
> [  554.214355 ] overcommit_memory.c:211: PASS: alloc failed as expected
> [  554.214357 ]
> [  554.220506 ] overcommit_memory.c:186: INFO: malloc 272468576 kB
> successfully
> [  554.220509 ]
> [  554.226564 ] overcommit_memory.c:213: FAIL: alloc passed, expected to fail
> [  554.226568 ]
> [  554.231870 ] mem.c:814: INFO: set overcommit_memory to 1
> [  554.231873 ]
> [  554.237819 ] overcommit_memory.c:186: INFO: malloc 136234288 kB
> successfully
> [  554.237821 ]
> [  554.243711 ] overcommit_memory.c:205: PASS: alloc passed as expected
> [  554.243713 ]
> [  554.249791 ] overcommit_memory.c:186: INFO: malloc 272468576 kB
> successfully
> [  554.249794 ]
> [  554.255069 ] overcommit_memory.c:205: PASS: alloc passed as expected
> [  554.255073 ]
> [  554.261594 ] overcommit_memory.c:186: INFO: malloc 544937152 kB
> successfully
> [  554.261597 ]
> [  554.267855 ] overcommit_memory.c:205: PASS: alloc passed as expected
> [  554.267858 ]
> [  554.273445 ] mem.c:814: INFO: set overcommit_memory to 0
> [  554.273448 ]
> [  554.278882 ] mem.c:814: INFO: set overcommit_ratio to 50
> [  554.278885 ]
> [  554.282419 ]
> [  554.284170 ] Summary:
> [  554.284173 ]
> [  554.287476 ] passed   8
> [  554.287480 ]
> [  554.290740 ] failed   1
> [  554.290743 ]
> [  554.293971 ] skipped  0
> [  554.293974 ]
> [  554.297123 ] warnings 0
> [  554.297126 ]
> [  554.300746 ] <<<execution_status>>>
> [  554.300749 ]
> [  554.304489 ] initiation_status="ok"
> [  554.304492 ]
> [  554.309762 ] duration=0 termination_type=exited termination_id=1
> corefile=no
> [  554.309765 ]
> [  554.313681 ] cutime=0 cstime=0
> [  554.313685 ]
> [  554.316880 ] <<<test_end>>>
> 
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.1.0-10246-g8c7829b .config
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 	bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached
> 	in this email
> 
> 
> 
> 
> Thanks,
> Rong Chen
> 
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
