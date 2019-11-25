Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FE3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD6C2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Kw1EBbZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfKYTDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 14:03:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36220 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfKYTDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 14:03:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id n188so505846wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 11:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UlOSumQoWcAQJdorsUTG6xjcAVup8thJTbtcARuUmQ0=;
        b=Kw1EBbZmGCF99Iu6qPidBTYZP+Ln6f2Ho//8LK77WLDZ85N/c5klSWbVf8ttN3TWMn
         7y/TCA4Y6SjE4J4/s65Lr7hi5fznaPguKzjX09nqADZgd5APuHBQCPPMH5Khx+cZnJ1z
         PAh17CgDZtAUMEI3dMMHpdl7hm/9+xXzw3/UNZHW90Qp6L8+EgI3IkneU7bU5CXbHZQA
         xzesmvPVgYDlMTuKzb7oNbFMzgTOysaJh1mCSG1O8wDyPtBYVmO4qA4/Ooa2+U5UYaZu
         KeYoDpYOW7lROFEGZHeNdzYlxIoRLe4b71jbyEdVQZoyj1LstcqR22PEoi5Q3NBe4uCn
         5s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UlOSumQoWcAQJdorsUTG6xjcAVup8thJTbtcARuUmQ0=;
        b=RRkDz1cKKkFW5TjuEzjSTMU9rEwfyntACTvs24T8RZMcbKhsQC+BLrtr5N5EXR+8pL
         X06EfCLZTMNBiDYLxsti7vBuSDaT7yLuq5wQ9eT+wiIkx8/kDXEHmQYu/bifWK8Xt6nS
         1R3Ea5pPN/HYO6LBMdxEV6RZ/cmRTwMjmY2rf7t0/e6JRi27/R6O/sH9CYtJeG7lq0KX
         8r7iUu10vhtbApgKeHGcd5/IMV77skmZr0uNCavST2YPM275W/eAz3UAKE2W1aiEqph3
         1QGSzF8zX5IBEi7tzIXdBXeygPvui+OyY2MYot9QsM9ZLu762bAPgqT42SigMD8OP6mA
         juvA==
X-Gm-Message-State: APjAAAXBceNpcdMiCvfykrKvNCwNENG0DopiTKvzYfmJuKcnqEotz0wT
        8K29dpqZiQMVSXNZhkLlEh4wcQ==
X-Google-Smtp-Source: APXvYqx+dqlHxFDmhdz8og05bzChcXZSp0TX/OuqzavhcN+IGKg3ikpoKuUi8YKS6OABtPRILb6StQ==
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr296821wma.119.1574708602018;
        Mon, 25 Nov 2019 11:03:22 -0800 (PST)
Received: from localhost (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id 4sm242188wmd.33.2019.11.25.11.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 11:03:21 -0800 (PST)
Date:   Mon, 25 Nov 2019 20:03:20 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH] f2fs: disble physical prealloc in LSF mount
Message-ID: <20191125190320.g7beal27nc5ubju7@mpHalley>
References: <20191122085952.12754-1-javier@javigon.com>
 <BYAPR04MB58166AE029D919C6610D8404E74A0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB58166AE029D919C6610D8404E74A0@BYAPR04MB5816.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.2019 00:48, Damien Le Moal wrote:
>On 2019/11/22 18:00, Javier González wrote:
>> From: Javier González <javier.gonz@samsung.com>
>>
>> Fix file system corruption when using LFS mount (e.g., in zoned
>> devices). Seems like the fallback into buffered I/O creates an
>> inconsistency if the application is assuming both read and write DIO. I
>> can easily reproduce a corruption with a simple RocksDB test.
>>
>> Might be that the f2fs_forced_buffered_io path brings some problems too,
>> but I have not seen other failures besides this one.
>>
>> Problem reproducible without a zoned block device, simply by forcing
>> LFS mount:
>>
>>   $ sudo mkfs.f2fs -f -m /dev/nvme0n1
>>   $ sudo mount /dev/nvme0n1 /mnt/f2fs
>>   $ sudo  /opt/rocksdb/db_bench  --benchmarks=fillseq --use_existing_db=0
>>   --use_direct_reads=true --use_direct_io_for_flush_and_compaction=true
>>   --db=/mnt/f2fs --num=5000 --value_size=1048576 --verify_checksum=1
>>   --block_size=65536
>>
>> Note that the options that cause the problem are:
>>   --use_direct_reads=true --use_direct_io_for_flush_and_compaction=true
>>
>> Fixes: f9d6d0597698 ("f2fs: fix out-place-update DIO write")
>>
>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>> ---
>>  fs/f2fs/data.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 5755e897a5f0..b045dd6ab632 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1081,9 +1081,6 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>>  			return err;
>>  	}
>>
>> -	if (direct_io && allow_outplace_dio(inode, iocb, from))
>> -		return 0;
>
>Since for LFS mode, all DIOs can end up out of place, I think that it
>may be better to change allow_outplace_dio() to always return true in
>the case of LFS mode. So may be something like:
>
>static inline int allow_outplace_dio(struct inode *inode,
>			struct kiocb *iocb, struct iov_iter *iter)
>{
>	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>	int rw = iov_iter_rw(iter);
>
>	return test_opt(sbi, LFS) ||
>	 	(rw == WRITE && !block_unaligned_IO(inode, iocb, iter));
>}
>
>instead of the original:
>
>static inline int allow_outplace_dio(struct inode *inode,
>			struct kiocb *iocb, struct iov_iter *iter)
>{
>	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>	int rw = iov_iter_rw(iter);
>
>	return (test_opt(sbi, LFS) && (rw == WRITE) &&
>				!block_unaligned_IO(inode, iocb, iter));
>}
>
>Thoughts ?
>

I see what you mean and it makes sense. However, the problem I am seeing
occurs when allow_outplace_dio() returns true, as this is what creates
the inconsistency between the write being buffered and the read being
DIO.

I did test the code you propose and, as expected, it still triggered the
corruption.

>> -
>>  	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
>>  		return 0;
>>
>>
>
>
>-- 
>Damien Le Moal
>Western Digital Research

Thanks,
Javier
