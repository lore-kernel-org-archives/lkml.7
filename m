Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEADC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969FF20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfDBNHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:07:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730245AbfDBNHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:07:05 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [10.3.19.211])
        by Forcepoint Email with ESMTP id 55EA854F1E463E7B5B47;
        Tue,  2 Apr 2019 21:06:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.244.145) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Tue, 2 Apr 2019
 21:06:39 +0800
Subject: Re: ext3 file system livelock and file system corruption, 4.9.166
 stable kernel
To:     Jari Ruusu <jari.ruusu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CACMCwJ+qLHV+cjQC2kAnLQP6qVz1bJ75V8BqQBV5HE1edRC-AQ@mail.gmail.com>
CC:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        <linux-kernel@vger.kernel.org>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <cc23b5a8-64b9-63d4-c805-ae25c5b1bcad@huawei.com>
Date:   Tue, 2 Apr 2019 21:06:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CACMCwJ+qLHV+cjQC2kAnLQP6qVz1bJ75V8BqQBV5HE1edRC-AQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.244.145]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jari,

Sorry about introduce this livelocks bug. The patch 674a2b272 ("ext4:
brelse all indirect buffer in ext4_ind_remove_space()") want to fix a
buffer leak problem. The follow-up patch 5e86bdda415 ("ext4: cleanup
bh release code in ext4_ind_remove_space()") was just want to do some
cleanup stuff originally, it was seperate from the first patch [*] in
the v2 iteration. But I forget to do decrease the partial and partial2
pointers in the first patch when doing seperate job, sorry again.
Fortunately, the second patch can fix the livelocks bug, so the upstream
is fine.

Hi Greg, backport the second cleanup patch can fix the bug, or I can
post a individual fix patch if you want.

Thanks,
Yi.

[*] https://www.spinics.net/lists/linux-ext4/msg64668.html

On 2019/4/2 18:08, Jari Ruusu Wrote:
> To trigger this ext4 file system bug, you need a sparse file with
> correct sparse pattern on old-school ext3 file system. I tried
> more simpler ways to trigger this but those attempts did not
> trigger the bug. I have provided compressed sparse file that
> reliably triggers the bug. Size of compressed sparse file 1667256
> bytes. Size of uncompressed sparse file 7369850880 bytes.
> Following commands will demo the problem.
> 
>   wget http://www.elisanet.fi/jariruusu/123/sparse-demo.data.xz
>   xz -d sparse-demo.data.xz
>   mkfs -t ext3 -b 4096 -e remount-ro -O "^dir_index" /dev/sdc1
>   mount -t ext3 /dev/sdc1 /mnt
>   cp -v --sparse=always sparse-demo.data /mnt/aa
>   cp -v --sparse=always sparse-demo.data /mnt/bb
>   umount /mnt
>   mount -t ext3 /dev/sdc1 /mnt
>   cp -v --sparse=always /mnt/bb /mnt/aa
> 
> That last cp command reliably triggers the bug that livelocks and
> after reset you have file system corruption to deal with. Deeply
> unfunny.
> 
> The bug is caused by
> "ext4: brelse all indirect buffer in ext4_ind_remove_space()"
> upstream commit 674a2b27234d1b7afcb0a9162e81b2e53aeef217, from
> <yi.zhang@huawei.com>, who provided a follow-up patch
> "ext4: cleanup bh release code in ext4_ind_remove_space()"
> upstream commit 5e86bdda41534e17621d5a071b294943cae4376e. The
> problem with that follow-up patch is that it is almost criminally
> mislabeled. It should have said "fixes ext3 livelock and file
> system corrupting bug" or something like that, so that Greg KH &
> Co would have understood that it must be backported to stable
> kernels too. Now the bug appears to be in all/most stable kernels
> already.
> 
> Below is the buggy patch that causes the problem. Look at those
> new while loops. Once the while condition is true once, it is
> ALWAYS true, so it livelocks.
> 
>> --- a/fs/ext4/indirect.c
>> +++ b/fs/ext4/indirect.c
>> @@ -1385,10 +1385,14 @@ end_range:
>>  					   partial->p + 1,
>>  					   partial2->p,
>>  					   (chain+n-1) - partial);
>> -			BUFFER_TRACE(partial->bh, "call brelse");
>> -			brelse(partial->bh);
>> -			BUFFER_TRACE(partial2->bh, "call brelse");
>> -			brelse(partial2->bh);
>> +			while (partial > chain) {
>> +				BUFFER_TRACE(partial->bh, "call brelse");
>> +				brelse(partial->bh);
>> +			}
>> +			while (partial2 > chain2) {
>> +				BUFFER_TRACE(partial2->bh, "call brelse");
>> +				brelse(partial2->bh);
>> +			}
>>  			return 0;
>>  		}
>>
> 
> Greg & Co,
> Please revert that above patch from stable kernels or backport the
> follow-up patch that fixes the problem.
> 

