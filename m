Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_RCVD_SPACE_BRACKET autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C2FC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 18:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861B92173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 18:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfEKSMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 14:12:12 -0400
Received: from mutluit.com ([82.211.8.197]:52858 "EHLO mutluit.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfEKSML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 14:12:11 -0400
Received: from [127.0.0.1] (s2.mutluit.com [82.211.8.197]:40136)
        by mutluit.com (s2.mutluit.com [82.211.8.197]:50025) with ESMTP ([XMail 1.27 ESMTP Server])
        id <S16FACAA> for <linux-kernel@vger.kernel.org> from <um@mutluit.com>;
        Sat, 11 May 2019 14:12:07 -0400
Subject: Re: [RFC PATCH] drivers: ata: ahci_sunxi: Increased SATA/AHCI DMA
 TX/RX FIFOs
To:     Stefan Monnier <monnier@iro.umontreal.ca>,
        linux-ide@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de
References: <20190510192550.17458-1-um@mutluit.com>
 <jwvk1ex6rvb.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
From:   "U.Mutlu" <um@mutluit.com>
Organization: mutluit.com
Message-ID: <5CD71077.1020100@mutluit.com>
Date:   Sat, 11 May 2019 20:12:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:40.0) Gecko/20100101
 Firefox/40.0 SeaMonkey/2.37a1
MIME-Version: 1.0
In-Reply-To: <jwvk1ex6rvb.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Monnier wrote on 05/11/2019 03:37 PM:
>> Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS) from
>> default 0x0 each to 0x3 each gives a write performance boost of 120MB/s
>> from lame 36MB/s to 45MB/s previously. Read performance is about 200MB/s
>> [tested on SSD using dd bs=4K count=512K].
>
> Such a simple patch to fix such a long-standing performance problem that
> everyone [ well, apparently not quite everyone ] assumed was a hardware
> limitation...
>
> And yet, April 1st is long gone.
>
> Is it really for real?

Yes, it's indeed real, Stefan; really no April 1st joke.  :-)

As you indicated, this problem of slow SATA write-speed
with these small devices lasts now for more than 5 years.
This patch finally solves the problem.

On my test device (BPI-R1) the optimum blocksize seems to be 12K
as it then gives even 129 MB/s write speed.

Here are some test results with different blocksizes, all giving
a write speed of 125 to 129 MB/s:

time sh -c "dd if=/dev/zero of=test.tmp bs=$bs count=$count conv=fdatasync"


------------ bs=8K / count=256K / 1 ------------------
262144+0 records in
262144+0 records out
2147483648 bytes (2.1 GB) copied, 16.9237 s, 127 MB/s

real	0m16.935s
user	0m0.388s
sys	0m15.777s

------------ bs=8K / count=256K / 2 ------------------
262144+0 records in
262144+0 records out
2147483648 bytes (2.1 GB) copied, 16.9916 s, 126 MB/s

real	0m17.973s
user	0m0.326s
sys	0m16.806s

------------ bs=8K / count=256K / 3 ------------------
262144+0 records in
262144+0 records out
2147483648 bytes (2.1 GB) copied, 17.0085 s, 126 MB/s

real	0m17.993s
user	0m0.442s
sys	0m16.588s

------------ bs=12K / count=171K / 1 ------------------
175104+0 records in
175104+0 records out
2151677952 bytes (2.2 GB) copied, 16.8474 s, 128 MB/s

real	0m16.860s
user	0m0.205s
sys	0m15.705s

------------ bs=12K / count=171K / 2 ------------------
175104+0 records in
175104+0 records out
2151677952 bytes (2.2 GB) copied, 16.6934 s, 129 MB/s

real	0m17.669s
user	0m0.227s
sys	0m16.355s

------------ bs=12K / count=171K / 3 ------------------
175104+0 records in
175104+0 records out
2151677952 bytes (2.2 GB) copied, 16.6684 s, 129 MB/s

real	0m17.654s
user	0m0.388s
sys	0m16.118s

------------ bs=16K / count=128K / 1 ------------------
131072+0 records in
131072+0 records out
2147483648 bytes (2.1 GB) copied, 17.1845 s, 125 MB/s

real	0m17.200s
user	0m0.251s
sys	0m16.060s

------------ bs=16K / count=128K / 2 ------------------
131072+0 records in
131072+0 records out
2147483648 bytes (2.1 GB) copied, 16.9221 s, 127 MB/s

real	0m17.902s
user	0m0.170s
sys	0m16.763s

------------ bs=16K / count=128K / 3 ------------------
131072+0 records in
131072+0 records out
2147483648 bytes (2.1 GB) copied, 16.8845 s, 127 MB/s

real	0m17.868s
user	0m0.167s
sys	0m16.736s


