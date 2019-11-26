Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4886EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95592071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="dX4Rvw0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfKZGnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 01:43:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38743 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfKZGnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 01:43:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so1928253wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 22:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ETIUHJ3AzvG4MKmyof7txYs57MBd5qafDNDNbagrVYo=;
        b=dX4Rvw0zMtqYThfHdUPz31/4100BIND9a4FPEmcE1DdsM/Bw9snYmkdu6kGFMeaooB
         4LUn+RA5g0N/Ja4DRzXrpQawFoSGE5/tU6WH5A5aSWrgNAkx++6pQNDS21JUUFLH9twS
         WntUKQKv/HabwTmvMpjIDJ6eNDpgbILdz9TmTLKB9i15G3PgwVOUc8gPVLr1iVRcL0MP
         vXnUtUxyufSJuaW9dVSPtZuiDelOZTBLtjPGKQKHTvUFndoRY5LxhmnAXUZr3/OBL1Jx
         tJAzoPg3QVVTR8FDMhXk+0rRwi2TYxFC3g6gXCD3Gtvqp/QHDND9cW/DhAwEwfDBhaYK
         ukUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ETIUHJ3AzvG4MKmyof7txYs57MBd5qafDNDNbagrVYo=;
        b=LLq6bP0wPAleA8pgsiyBS/Ma5IodqX0w4KerMb01qTxMJeVVKCnJZJ6FXB8nS6dCW6
         Z9pbN/JHdjUtMs7kqTQ/qcOjqvh33EOl0WdIkC2BXVcq/e0Rh5awJ9vbYBpIeNRI846b
         0stA4hwjYpAmwDJhWqYTue9rgW3GIcfxI8abQ14j6wX9p9pp81qjR4FEugAjhw5iubON
         zbMcUpPHJPSUVGG046c39XH/CIeD8qHTUtyK4GcyUvxKjmb8clv26CDunmnm9dzp4tn7
         Rtu6aQyL1yIrb4nKYI8RHVh1HAyn+CfP3HVIvgoDCIJfXVT7BSc+sscYPyRA4cZl0psV
         gttA==
X-Gm-Message-State: APjAAAX5s0zlV2WgFW5enR/NcLURXwicUYQmT29H8DV00y+OtZuj4rO+
        TUrphhIdCGF1bPDY59XckOWctQ==
X-Google-Smtp-Source: APXvYqzfVhP4yywet9AudY12rs64ANWPmJoVuQ67NV89zaHmlmFhFFpY/La8bZ5ByNzdPWUk92hg3Q==
X-Received: by 2002:a7b:ce92:: with SMTP id q18mr2612740wmj.164.1574750597913;
        Mon, 25 Nov 2019 22:43:17 -0800 (PST)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id s9sm1870420wmj.22.2019.11.25.22.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 22:43:17 -0800 (PST)
Date:   Tue, 26 Nov 2019 07:43:16 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] f2fs: disble physical prealloc in LSF mount
Message-ID: <20191126064316.ly4sfdcmyxtccnss@mpHalley.local>
References: <20191122085952.12754-1-javier@javigon.com>
 <BYAPR04MB58166AE029D919C6610D8404E74A0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20191125190320.g7beal27nc5ubju7@mpHalley>
 <BYAPR04MB58161C14246FA30366B69B9DE7450@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20191126035726.xj7pierxsck6adow@mpHalley>
 <BYAPR04MB581676157DCF909EDF1AAAFCE7450@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB5816F0BB42891E49C5AB42DDE7450@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB5816F0BB42891E49C5AB42DDE7450@BYAPR04MB5816.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.11.2019 06:20, Damien Le Moal wrote:
>+ Shin'Ichiro
>
>On 2019/11/26 15:19, Damien Le Moal wrote:
>> On 2019/11/26 12:58, Javier González wrote:
>>> On 26.11.2019 02:06, Damien Le Moal wrote:
>>>> On 2019/11/26 4:03, Javier González wrote:
>>>>> On 25.11.2019 00:48, Damien Le Moal wrote:
>>>>>> On 2019/11/22 18:00, Javier González wrote:
>>>>>>> From: Javier González <javier.gonz@samsung.com>
>>>>>>>
>>>>>>> Fix file system corruption when using LFS mount (e.g., in zoned
>>>>>>> devices). Seems like the fallback into buffered I/O creates an
>>>>>>> inconsistency if the application is assuming both read and write DIO. I
>>>>>>> can easily reproduce a corruption with a simple RocksDB test.
>>>>>>>
>>>>>>> Might be that the f2fs_forced_buffered_io path brings some problems too,
>>>>>>> but I have not seen other failures besides this one.
>>>>>>>
>>>>>>> Problem reproducible without a zoned block device, simply by forcing
>>>>>>> LFS mount:
>>>>>>>
>>>>>>>   $ sudo mkfs.f2fs -f -m /dev/nvme0n1
>>>>>>>   $ sudo mount /dev/nvme0n1 /mnt/f2fs
>>>>>>>   $ sudo  /opt/rocksdb/db_bench  --benchmarks=fillseq --use_existing_db=0
>>>>>>>   --use_direct_reads=true --use_direct_io_for_flush_and_compaction=true
>>>>>>>   --db=/mnt/f2fs --num=5000 --value_size=1048576 --verify_checksum=1
>>>>>>>   --block_size=65536
>>>>>>>
>>>>>>> Note that the options that cause the problem are:
>>>>>>>   --use_direct_reads=true --use_direct_io_for_flush_and_compaction=true
>>>>>>>
>>>>>>> Fixes: f9d6d0597698 ("f2fs: fix out-place-update DIO write")
>>>>>>>
>>>>>>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>>>>>>> ---
>>>>>>>  fs/f2fs/data.c | 3 ---
>>>>>>>  1 file changed, 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>>>> index 5755e897a5f0..b045dd6ab632 100644
>>>>>>> --- a/fs/f2fs/data.c
>>>>>>> +++ b/fs/f2fs/data.c
>>>>>>> @@ -1081,9 +1081,6 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>>>>>>>  			return err;
>>>>>>>  	}
>>>>>>>
>>>>>>> -	if (direct_io && allow_outplace_dio(inode, iocb, from))
>>>>>>> -		return 0;
>>>>>>
>>>>>> Since for LFS mode, all DIOs can end up out of place, I think that it
>>>>>> may be better to change allow_outplace_dio() to always return true in
>>>>>> the case of LFS mode. So may be something like:
>>>>>>
>>>>>> static inline int allow_outplace_dio(struct inode *inode,
>>>>>> 			struct kiocb *iocb, struct iov_iter *iter)
>>>>>> {
>>>>>> 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>>>> 	int rw = iov_iter_rw(iter);
>>>>>>
>>>>>> 	return test_opt(sbi, LFS) ||
>>>>>> 	 	(rw == WRITE && !block_unaligned_IO(inode, iocb, iter));
>>>>>> }
>>>>>>
>>>>>> instead of the original:
>>>>>>
>>>>>> static inline int allow_outplace_dio(struct inode *inode,
>>>>>> 			struct kiocb *iocb, struct iov_iter *iter)
>>>>>> {
>>>>>> 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>>>> 	int rw = iov_iter_rw(iter);
>>>>>>
>>>>>> 	return (test_opt(sbi, LFS) && (rw == WRITE) &&
>>>>>> 				!block_unaligned_IO(inode, iocb, iter));
>>>>>> }
>>>>>>
>>>>>> Thoughts ?
>>>>>>
>>>>>
>>>>> I see what you mean and it makes sense. However, the problem I am seeing
>>>>> occurs when allow_outplace_dio() returns true, as this is what creates
>>>>> the inconsistency between the write being buffered and the read being
>>>>> DIO.
>>>>
>>>> But if the write is switched to buffered, the DIO read should use the
>>>> buffered path too, no ? Since this is all happening under VFS, the
>>>> generic DIO read path will not ensure that the buffered writes are
>>>> flushed to disk before issuing the direct read, I think. So that would
>>>> explain your data corruption, i.e. you are reading stale data on the
>>>> device before the buffered writes make it to the media.
>>>>
>>>
>>> As far as I can see, the read is always sent DIO, so yes, I also believe
>>> that we are reading stale data. This is why the corruption is not seen
>>> if preventing allow_outplace_dio() from sending the write to the
>>> buffered path.
>>>
>>> What surprises me is that this is very easy to trigger (see commit), so
>>> I assume you must have seen this with SMR in the past.
>>
>> We just did. Shin'Ichiro in my team finally succeeded in recreating the
>> problem. The cause seems to be:
>>
>> bool direct_io = iocb->ki_flags & IOCB_DIRECT;
>>
>> being true on entry of f2fs_preallocate_blocks() whereas
>> f2fs_direct_IO() forces buffered IO path for DIO on zoned devices with:
>>
>> if (f2fs_force_buffered_io(inode, iocb, iter))
>> 		return 0;
>>
>> which has:
>>
>> 	if (f2fs_sb_has_blkzoned(sbi))
>> 		return true;
>>
>> So the top DIO code says "do buffered IOs", but lower in the write path,
>> the IO is still assumed to be a DIO because of the iocb flag... That's
>> inconsistent.
>>
>> Note that for the non-zoned device LFS case, f2fs_force_buffered_io()
>> returns true only for unaligned write DIOs... But that will still trip
>> on the iocb flag test. So the proper fix is likely something like:
>>
>> int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>> {
>> 	struct inode *inode = file_inode(iocb->ki_filp);
>> 	struct f2fs_map_blocks map;
>> 	int flag;
>> 	int err = 0;
>> -	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
>> +	bool direct_io = (iocb->ki_flags & IOCB_DIRECT) &&
>> +		!2fs_force_buffered_io(inode, iocb, iter);
>>
>> 	/* convert inline data for Direct I/O*/
>> 	if (direct_io) {
>> 		err = f2fs_convert_inline_inode(inode);
>> 		if (err)
>> 			return err;
>> 	}
>>
>> Shin'Ichiro tried this on SMR disks and the failure is gone...
>>
>> Cheers.
>>

Yes! This is it. I originally though that the problem was on
f2fs_force_buffered_io(), but could not hit the problem there. Thanks
for the analysis; it makes sense now.

Just tested your patch on our drives and the problem is gone too. Guess
you can send a new patch an ignore this one. You can set my reviewed-by
on it.

Thanks Damien!
Javier
