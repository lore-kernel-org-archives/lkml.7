Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCCEC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8710920836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=leun.net header.i=@leun.net header.b="Qs3rIoPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfCIOMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:12:32 -0500
Received: from tux.leun.net ([46.251.251.20]:42874 "EHLO tux.leun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfCIOMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:12:32 -0500
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Mar 2019 09:12:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leun.net; s=default;
        t=1552140397; bh=21mZWCddwN+rlHHlsqojO6L+eLe7PiED7V7que7Dv1w=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Qs3rIoPmCNEArbc1qm29gvr8p+W9BHhoLU4rxjAu16BzvIxe+SqHUXto/aTs1rejc
         nOZlGuVbqyEKYjFtV4rnQKRN1ZDpYJ45GLf7Q8iIYiy3Gc0N8BaflWhumH8PPDAjhw
         M1pgv4nWPubFtUCnmEGEhHgK8/dXt/LgqhIlgwjIi8GXjuVfDlyVrKDI6NFeNSpi0t
         jSeWOnVwp8SAtGdrGB/+zLbskmzLpqN3NWQVi5ycNK7YlC4z6WmuCHvXqOHlnFvjXc
         P2hkHah/VUKzQ8O6GlZwEiwptCvHv/UeOLj4OevLQukfTOsPlnSw0dHZV5muzsbg0b
         qepdZ8dr0kiXw==
Received: from jill.leun.net ([IPv6:2a02:908:1980:fc00:918c:d6df:fe0a:6a1f])
        (authenticated bits=0)
        by tux.leun.net (8.14.7/8.14.7) with ESMTP id x29E6aMS030336
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 9 Mar 2019 15:06:37 +0100
Subject: Re: Raid 5 painfully slow with linux 5.0.0
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <35ddef28-a449-72a8-933f-341e3535546a@newton.leun.net>
From:   Michael Leun <linux-raid-20190308@newton.leun.net>
Openpgp: preference=signencrypt
Message-ID: <a970bfdc-97c1-53c6-0966-f83743a6190e@jill.leun.net>
Date:   Sat, 9 Mar 2019 15:06:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <35ddef28-a449-72a8-933f-341e3535546a@newton.leun.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am 08.03.19 um 20:53 schrieb linux-raid-20190308@newton.leun.net:

since Linux 5.0 my md raid5 is painfully slow, ~100 kb/s, bisected that,
bisect blames

5d2ee7122c73be6a3b6bfe90d237e8aed737cfaa is the first bad commit
commit 5d2ee7122c73be6a3b6bfe90d237e8aed737cfaa
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Nov 29 17:36:41 2018 -0700


when trying to revert that from v5.0 I get a conflict and do not know
how to resolve that. Please help/fix.

Best Regards,

Michael Leun


> Hello,
> 
> I have a raid5 array consisting of 4 8TB disks connected via USB3.
> 
> [ml@xenia ~]$ cat /proc/mdstat
> Personalities : [raid6] [raid5] [raid4]
> md127 : active raid5 sde1[4] sdc1[1] sdd1[2] sdb1[0]
>       23441682432 blocks super 1.2 level 5, 512k chunk, algorithm 2
> [4/4] [UUUU]
>       bitmap: 0/59 pages [0KB], 65536KB chunk
> 
> unused devices: <none>
> [ml@xenia ~]$
> 
> Up to and including kernel 4.20.13-arch1 everything is fine and I get
> reasonable performance:
> 
> [root@xenia ml]# dd if=/dev/md127 of=/dev/null bs=2M status=progress
> 3078619136 bytes (3,1 GB, 2,9 GiB) copied, 13 s, 237 MB/s^C
> 1516+0 Datensätze ein
> 1515+0 Datensätze aus
> 3177185280 bytes (3,2 GB, 3,0 GiB) copied, 13,4403 s, 236 MB/s
> 
> [root@xenia ml]# uname -a
> Linux xenia.leun.net 4.20.13-arch1-1-ARCH #1 SMP PREEMPT Wed Feb 27
> 19:10:28 UTC 2019 x86_64 GNU/Linux
> [root@xenia ml]#
> 
> 
> With kernel 5.0.0-arch1-1-ARCH (also verified that with kernel.org
> 5.0.0) I get PAINFULLY slow performance on the raid, but the performance
> of the disks the array consists of is ok:
> 
> [root@xenia ml]# dd if=/dev/md127 of=/dev/null bs=2M status=progress
> 6291456 bytes (6,3 MB, 6,0 MiB) copied, 41 s, 154 kB/s^C
> 4+0 Datensätze ein
> 3+0 Datensätze aus
> 6291456 bytes (6,3 MB, 6,0 MiB) copied, 59,0605 s, 107 kB/s
> 
> [root@xenia ml]# dd if=/dev/sdb1 of=/dev/null bs=2M status=progress
> 1642070016 bytes (1,6 GB, 1,5 GiB) copied, 8 s, 205 MB/s^C
> 806+0 Datensätze ein
> 805+0 Datensätze aus
> 1688207360 bytes (1,7 GB, 1,6 GiB) copied, 8,23402 s, 205 MB/s
> 
> [root@xenia ml]#
> 
> (The other 3 disks show the same speed)
> 
> Any idea why it is THAT slow?
> 
> Best Regards,
> 
> Michael Leun
> 

