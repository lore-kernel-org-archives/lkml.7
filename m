Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B0EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F242071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="N8k7cFOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfKZD5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 22:57:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37603 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfKZD5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:57:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id g7so8146wrw.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 19:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e6wMTLKnA+rNgtD/pp0DryO/NWlpo8/d9a9UXsGOjg4=;
        b=N8k7cFOPVjqX2XGPDgw9O2rte/reF7R/56Ns6wnvp9fJxDVw6Rid+J5wO21USAz+sY
         0l9Ooms+vC9v+fUkgp1wqReUarFaRo3iZoUVbKbdCDB13AmDoSjv2GPie8BDbFmn1JeQ
         70Iwob9y2qCHHmsaVBbRuDvXcGrYr7Xu6UVbFiJApu7HaredvFmVZqNqwWwG2ondOUbE
         kI6M+vS4q6wTwemZSa5XlLZ6cP8zUJ6tc/NpB2q7T+c2csy6ZJgSsVA6tJgCJwcoOSvN
         sK3I3AM3FzWg1lucCP2+ST88HvJQ4C5TuKoC7xgY2pL0+GJdAn9fVRQ8M+T/+gmhuMHj
         Jshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e6wMTLKnA+rNgtD/pp0DryO/NWlpo8/d9a9UXsGOjg4=;
        b=A6WQAaT64oDYPW19Z+QKw63b5l/xcWcOS3LqCVkDim1DIAQcBQkfRWxmcj39Fnvqhz
         45GaZq6L0looPUeei3Yb4z+/3hASyH2l4TivgblzUOakq9jneH+ucjJdFGAcxLUl9Dr2
         lbTneZ1dK4eKVA3+brTtuJ6PQ4vAHtsQ1xaD1Cl0B9CBQkv2anrdGICmLuLwysO5s2GQ
         BBV++walZyQ7OIY1Qjf8PT+hBFXxX1VKQ4D7E/8UiZE79QsqJlb168XxlPXOl85OdPgI
         l8uB6/oHuipe5QQgKoJ+iTQsXofDeo1XyklRVpr0dMog94m1aZSb5FJDH9eaVZLdv1Y/
         Vpcw==
X-Gm-Message-State: APjAAAXtXaEl6kK/FNYpTV3MxQ/x/rL+2HQNWOZDthvrgcp66ZroiMnv
        4zsHvkwJdUwlhqM5tBluZcMzZQ==
X-Google-Smtp-Source: APXvYqx8y0/DoRJm7r1OiRmXfLs8gAGQIP6xyIigtQCt+q1MQA8F3r10IyeiIVwkBhNuVe6P6GeZjA==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr29786781wrp.82.1574740648040;
        Mon, 25 Nov 2019 19:57:28 -0800 (PST)
Received: from localhost (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id p25sm1470345wma.20.2019.11.25.19.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 19:57:27 -0800 (PST)
Date:   Tue, 26 Nov 2019 04:57:26 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH] f2fs: disble physical prealloc in LSF mount
Message-ID: <20191126035726.xj7pierxsck6adow@mpHalley>
References: <20191122085952.12754-1-javier@javigon.com>
 <BYAPR04MB58166AE029D919C6610D8404E74A0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20191125190320.g7beal27nc5ubju7@mpHalley>
 <BYAPR04MB58161C14246FA30366B69B9DE7450@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB58161C14246FA30366B69B9DE7450@BYAPR04MB5816.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.11.2019 02:06, Damien Le Moal wrote:
>On 2019/11/26 4:03, Javier González wrote:
>> On 25.11.2019 00:48, Damien Le Moal wrote:
>>> On 2019/11/22 18:00, Javier González wrote:
>>>> From: Javier González <javier.gonz@samsung.com>
>>>>
>>>> Fix file system corruption when using LFS mount (e.g., in zoned
>>>> devices). Seems like the fallback into buffered I/O creates an
>>>> inconsistency if the application is assuming both read and write DIO. I
>>>> can easily reproduce a corruption with a simple RocksDB test.
>>>>
>>>> Might be that the f2fs_forced_buffered_io path brings some problems too,
>>>> but I have not seen other failures besides this one.
>>>>
>>>> Problem reproducible without a zoned block device, simply by forcing
>>>> LFS mount:
>>>>
>>>>   $ sudo mkfs.f2fs -f -m /dev/nvme0n1
>>>>   $ sudo mount /dev/nvme0n1 /mnt/f2fs
>>>>   $ sudo  /opt/rocksdb/db_bench  --benchmarks=fillseq --use_existing_db=0
>>>>   --use_direct_reads=true --use_direct_io_for_flush_and_compaction=true
>>>>   --db=/mnt/f2fs --num=5000 --value_size=1048576 --verify_checksum=1
>>>>   --block_size=65536
>>>>
>>>> Note that the options that cause the problem are:
>>>>   --use_direct_reads=true --use_direct_io_for_flush_and_compaction=true
>>>>
>>>> Fixes: f9d6d0597698 ("f2fs: fix out-place-update DIO write")
>>>>
>>>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>>>> ---
>>>>  fs/f2fs/data.c | 3 ---
>>>>  1 file changed, 3 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index 5755e897a5f0..b045dd6ab632 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -1081,9 +1081,6 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>>>>  			return err;
>>>>  	}
>>>>
>>>> -	if (direct_io && allow_outplace_dio(inode, iocb, from))
>>>> -		return 0;
>>>
>>> Since for LFS mode, all DIOs can end up out of place, I think that it
>>> may be better to change allow_outplace_dio() to always return true in
>>> the case of LFS mode. So may be something like:
>>>
>>> static inline int allow_outplace_dio(struct inode *inode,
>>> 			struct kiocb *iocb, struct iov_iter *iter)
>>> {
>>> 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>> 	int rw = iov_iter_rw(iter);
>>>
>>> 	return test_opt(sbi, LFS) ||
>>> 	 	(rw == WRITE && !block_unaligned_IO(inode, iocb, iter));
>>> }
>>>
>>> instead of the original:
>>>
>>> static inline int allow_outplace_dio(struct inode *inode,
>>> 			struct kiocb *iocb, struct iov_iter *iter)
>>> {
>>> 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>> 	int rw = iov_iter_rw(iter);
>>>
>>> 	return (test_opt(sbi, LFS) && (rw == WRITE) &&
>>> 				!block_unaligned_IO(inode, iocb, iter));
>>> }
>>>
>>> Thoughts ?
>>>
>>
>> I see what you mean and it makes sense. However, the problem I am seeing
>> occurs when allow_outplace_dio() returns true, as this is what creates
>> the inconsistency between the write being buffered and the read being
>> DIO.
>
>But if the write is switched to buffered, the DIO read should use the
>buffered path too, no ? Since this is all happening under VFS, the
>generic DIO read path will not ensure that the buffered writes are
>flushed to disk before issuing the direct read, I think. So that would
>explain your data corruption, i.e. you are reading stale data on the
>device before the buffered writes make it to the media.
>

As far as I can see, the read is always sent DIO, so yes, I also believe
that we are reading stale data. This is why the corruption is not seen
if preventing allow_outplace_dio() from sending the write to the
buffered path.

What surprises me is that this is very easy to trigger (see commit), so
I assume you must have seen this with SMR in the past.

Does it make sense to leave the LFS check out of the
allow_outplace_dio()? Or in other words, is there a hard requirement for
writes to take this path on a zoned device that I am not seeing?
Something like:

   static inline int allow_outplace_dio(struct inode *inode,
   			struct kiocb *iocb, struct iov_iter *iter)
   {
   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
   	int rw = iov_iter_rw(iter);

   	return (rw == WRITE && !block_unaligned_IO(inode, iocb, iter));
   }

Thanks,
Javier
