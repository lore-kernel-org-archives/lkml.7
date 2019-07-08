Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09B7C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0A221707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbfGHS57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:57:59 -0400
Received: from ivanoab6.miniserver.com ([5.153.251.140]:35716 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbfGHS57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:57:59 -0400
X-Greylist: delayed 2280 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jul 2019 14:57:59 EDT
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1hkYF3-0000i0-Lu
        for linux-kernel@vger.kernel.org; Mon, 08 Jul 2019 18:19:57 +0000
Received: from sleer.kot-begemot.co.uk ([192.168.3.72])
        by jain.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1hkYF1-00053d-7c
        for linux-kernel@vger.kernel.org; Mon, 08 Jul 2019 19:19:57 +0100
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: NFS Caching broken in 4.19.37
Organization: Cambridge Greys
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <5022bdc4-9f3e-9756-cbca-ada37f88ecc7@cambridgegreys.com>
Date:   Mon, 8 Jul 2019 19:19:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

NFS caching appears broken in 4.19.37.

The more cores/threads the easier to reproduce. Tested with identical 
results on Ryzen 1600 and 1600X.

1. Mount an openwrt build tree over NFS v4
2. Run make -j `cat /proc/cpuinfo | grep vendor | wc -l` ; make clean in 
a loop
3. Result after 3-4 iterations:

State on the client

ls -laF 
/var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm

total 8
drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../

State as seen on the server (mounted via nfs from localhost):

ls -laF 
/var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
total 12
drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
-rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h

Actual state on the filesystem:

ls -laF 
/exports/work/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
total 12
drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
-rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h

So the client has quite clearly lost the plot. Telling it to drop caches 
and re-reading the directory shows the file present.

It is possible to reproduce this using a linux kernel tree too, just 
takes much more iterations - 10+ at least.

Both client and server run 4.19.37 from Debian buster. This is filed as 
debian bug 931500. I originally thought it to be autofs related, but 
IMHO it is actually something fundamentally broken in nfs caching 
resulting in cache corruption.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
