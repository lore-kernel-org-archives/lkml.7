Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C397CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D2D21D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408828AbfJXH7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:59:37 -0400
Received: from wp051.webpack.hosteurope.de ([80.237.132.58]:35610 "EHLO
        wp051.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405209AbfJXH7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:59:36 -0400
X-Greylist: delayed 1378 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Oct 2019 03:59:36 EDT
Received: from p200300cd5f0509008cc3eaf0bbac9dd5.dip0.t-ipconnect.de ([2003:cd:5f05:900:8cc3:eaf0:bbac:9dd5]); authenticated
        by wp051.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1iNXfh-0002uw-UO; Thu, 24 Oct 2019 09:36:37 +0200
To:     linux-kernel@vger.kernel.org
From:   Robert Stupp <snazy@snazy.de>
Subject: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
Date:   Thu, 24 Oct 2019 09:36:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-bounce-key: webpack.hosteurope.de;snazy@snazy.de;1571903976;f6e34a93;
X-HE-SMSGID: 1iNXfh-0002uw-UO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I've got an issue with `mlockall(MCL_CURRENT)` after upgrading Ubuntu 
19.04 to 19.10 - i.e. kernel version change from 5.0.x to 5.3.x.

The following simple program hangs forever with one CPU running at 100% 
(kernel):

#include <stdio.h>
#include <sys/mman.h>
int main(char** argv) {
   printf("Before mlockall(MCL_CURRENT)\n");
   // works in 5.0
   // hangs forever w/ 5.1 and newer
   mlockall(MCL_CURRENT);
   printf("After mlockall(MCL_CURRENT)\n");
}

All kernel versions since 5.1 (tried 5.1.0, 5.1.21, 5.2.21, 5.3.0-19, 
5.3.7, 5.4-rc4) show the same symptom (hanging in mlockall(MCL_CURRENT) 
with 100% kernel-CPU). 5.0 kernel versions (5.0.21) are fine.

First, I thought, that it's something generic, so I tried the above 
program in a fresh install of Ubuntu eoan (5.3.x) in a VM in virtualbox, 
but it works fine there. So I suspect, that it has to do with something 
that's specific to my machine.

My first suspicion was that some library "hijacks" mlockall(), but 
calling the test program with `LD_DEBUG=all` shows that glibc gets 
called directly:
      12248:    symbol=mlockall;  lookup in file=./test [0]
      12248:    symbol=mlockall;  lookup in 
file=/lib/x86_64-linux-gnu/libc.so.6 [0]
      12248:    binding file ./test [0] to 
/lib/x86_64-linux-gnu/libc.so.6 [0]: normal symbol `mlockall' [GLIBC_2.2.5]
An `strace` doesn't show anything meaningful (beside that mlockall's 
been called but never returns). dmesg and syslog don't show anything 
obvious (to me) as well.

Some information about the machine:
- Intel(R) Core(TM) i7-6900K, Intel X99 chipset
- NVMe 1.1b
- 64GB RAM (4x 16GB)

I've also reverted all changes for sysctl and ld.conf and checked for 
other suspicious software without any luck.

I also tried a bunch of variations of the above program, but only 
`mlockall(MCL_CURRENT)` or `mlockall(MCL_FUTURE | MCL_CURRENT)` hang.

A `git diff v5.0..v5.1 mm/` doesn't show anything obvious (to me).

It seems, there's no debug/trace information that would help to find out 
what exactly it's doing.

I'm kinda lost at the moment.


PS: Variations of the above test program:

#include <stdio.h>
#include <sys/mman.h>
char foo[65536];
int main(char** argv) {
   printf("Before mlock()\n");
   int e = mlock(foo, 8192); // works in 5.0, 5.1, 5.2, 5.3, 5.4
   printf("After mlock()=%d\n", e);
}


#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
int main(char** argv) {
   printf("Before mlockall(MCL_FUTURE)\n");
   int e = mlockall(MCL_FUTURE); // works in 5.0, 5.1, 5.2, 5.3, 5.4
   printf("After mlockall(MCL_FUTURE) = %d\n", e);
   void* mem = malloc(1024 * 1024 * 1024);
   printf("After malloc()\n");
   mem = malloc(1024 * 1024 * 1024);
   printf("After malloc()\n");
   mem = malloc(1024 * 1024 * 1024);
   printf("After malloc()\n");
   // works in 5.0, 5.1, 5.2, 5.3, 5.4
}


#include <stdio.h>
#include <sys/mman.h>
int main(char** argv) {
   printf("Before munlockall()\n");
   int e = munlockall(); // works in 5.0, 5.1, 5.2, 5.3, 5.4
   printf("After munlockall() = %d\n", e);
}


#include <stdio.h>
#include <sys/mman.h>
int main(char** argv) {
   printf("Before mlockall(MCL_CURRENT|MCL_FUTURE)\n");
   // works in 5.0
   // hangs forever w/ 5.1 and newer
   int e = mlockall(MCL_CURRENT|MCL_FUTURE);
   printf("After mlockall(MCL_CURRENT|MCL_FUTURE) = %d\n", e);
}

PPS: Kernel version images installed from 
https://kernel.ubuntu.com/~kernel-ppa/mainline/?C=N;O=D

-- 
Robert Stupp
@snazy

