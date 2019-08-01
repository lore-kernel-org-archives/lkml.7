Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7CBC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C872F20449
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfHAHLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:11:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47434 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbfHAHLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:11:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F3DE384F77E482D42356;
        Thu,  1 Aug 2019 15:11:19 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 1 Aug 2019
 15:11:18 +0800
Subject: Re: [BUG] lseek on /proc/meminfo is broken in 4.19.59
To:     Sergei Turchanov <turchanov@farpost.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <3bd775ab-9e31-c6b3-374e-7a9982a9a8cd@farpost.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <5c4c0648-2a96-4132-9d22-91c22e7c7d4d@huawei.com>
Date:   Thu, 1 Aug 2019 15:11:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <3bd775ab-9e31-c6b3-374e-7a9982a9a8cd@farpost.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just took a glance, maybe due to
commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")

I simply reverted it just now and it seems fine... but I haven't digged into this commit.

Maybe you could Cc NeilBrown <neilb@suse.com> for some more advice and
I have no idea whether it's an expected behavior or not...

Thanks,
Gao Xiang

On 2019/8/1 14:16, Sergei Turchanov wrote:
> Hello!
> 
> (I sent this e-mail two weeks ago with no feedback. Does anyone care? Wrong mailing list? Anything....?)
> 
> Seeking (to an offset within file size) in /proc/meminfo is broken in 4.19.59. It does seek to a desired position, but reading from that position returns the remainder of file and then a whole copy of file. This doesn't happen with /proc/vmstat or /proc/self/maps for example.
> 
> Seeking did work correctly in kernel 4.14.47. So it seems something broke in the way.
> 
> Background: this kind of access pattern (seeking to /proc/meminfo) is used by libvirt-lxc fuse driver for virtualized view of /proc/meminfo. So that /proc/meminfo is broken in guests when running kernel 4.19.x.
> 
> $ ./test /proc/meminfo 0        # Works as expected
> 
> MemTotal:       394907728 kB
> MemFree:        173738328 kB
> ...
> DirectMap2M:    13062144 kB
> DirectMap1G:    390070272 kB
> 
> -----------------------------------------------------------------------
> 
> $ ./test 1024                   # returns a copy of file after the remainder
> 
> Will seek to 1024
> 
> 
> Data read at offset 1024
> gePages:         0 kB
> ShmemHugePages:        0 kB
> ShmemPmdMapped:        0 kB
> HugePages_Total:       0
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> Hugetlb:               0 kB
> DirectMap4k:      245204 kB
> DirectMap2M:    13062144 kB
> DirectMap1G:    390070272 kB
> MemTotal:       394907728 kB
> MemFree:        173738328 kB
> MemAvailable:   379989680 kB
> Buffers:          355812 kB
> Cached:         207216224 kB
> ...
> DirectMap2M:    13062144 kB
> DirectMap1G:    390070272 kB
> 
> As you see, after "DirectMap1G:" line, a whole copy of /proc/meminfo returned by "read".
> 
> Test program:
> 
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
> 
> #define SIZE 1024
> char buf[SIZE + 1];
> 
> int main(int argc, char *argv[]) {
>     int     fd;
>     ssize_t rd;
>     off_t   ofs = 0;
> 
>     if (argc < 2) {
>         printf("Usage: test <file> [<offset>]\n");
>         exit(1);
>     }
> 
>     if (-1 == (fd = open(argv[1], O_RDONLY))) {
>         perror("open failed");
>         exit(1);
>     }
> 
>     if (argc > 2) {
>         ofs = atol(argv[2]);
>     }
>     printf("Will seek to %ld\n", ofs);
> 
>     if (-1 == (lseek(fd, ofs, SEEK_SET))) {
>         perror("lseek failed");
>         exit(1);
>     }
> 
>     for (;; ofs += rd) {
>         printf("\n\nData read at offset %ld\n", ofs);
>         if (-1 == (rd = read(fd, buf, SIZE))) {
>             perror("read failed");
>             exit(1);
>         }
>         buf[rd] = '\0';
>         printf(buf);
>         if (rd < SIZE) {
>             break;
>         }
>     }
> 
>     return 0;
> }
> 
> 
> 
