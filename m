Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E54C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F982070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLuMf3QH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfECMfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 08:35:20 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40904 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfECMfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:35:20 -0400
Received: by mail-yw1-f68.google.com with SMTP id t79so4137680ywc.7;
        Fri, 03 May 2019 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlIRPAVzjtKVstMciUPdYuhb+CAhhzJIEx3zMqLSb2w=;
        b=qLuMf3QHje1Tv8qze5K+fgkTfrbM8FyuB3H2lsFak2DNgaYDl8fsiA13L8gwVnvMqK
         uFQJMEl3UnCaziVprgLIFg8Wakj3cGMdqONEet4IwEB5wF8Ft+xsuvCkzgxjzQAld9Oj
         OPtYZ3/zsQeJurYP/5QRDBS4p/TZ26SFmUbwPqYrYoTFq0Cn9LXn4N8cet1qP+5dWUGk
         UXYTrgbgud7/m0BNxqSUN32dEKlFtRyTRfY3hUMxG2RHxjuSkPdYjg0V7/mCtGUh6pog
         9r9Cys2VJlGiRaRZEPJuU+EN+ztQQ4BdaRbfH3m4m+B/KDwkA1xwFijqHnXYhCbQDcui
         Q3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlIRPAVzjtKVstMciUPdYuhb+CAhhzJIEx3zMqLSb2w=;
        b=aFZcyoRbhkoOkmWTOfs0bk6FiiiacuiZrg4/vOz3d/TC5+wck1vyu5NXCY4dJd1N/i
         Q36EFFmYpSbnOaRm4Dy90Q25K9zn/pfu1tOTJ/2spLVQb5KGajvaDPRaRxeH+RShxbOx
         SxfY7uvuBXLBPK7XZlLdxBWxh2PHGOjUKsBrRRQ/xpnNmpY7fTZr2rqRD4ubrD71NSc4
         eFmOvD7229eUS/InkwF382P/DwOAFmzI+9tSrs01WSbmZL0m8JNGY44y/rGP6lMqACkD
         DQIwnHYmEMTFao1rtdFCoxJVpcWsVEzbq9eIjtQ2wizZ85o7Vs1eTHq4AyzL7y9oHNqO
         K3oQ==
X-Gm-Message-State: APjAAAU2/PQ8HbJEuOr4YsrO8zlkcSkmegWI/qjPyRG+p0GFY8eHEv1C
        knn22uYHZWCXVJc0m5/TfFjmDDGqS3Nou1JECaERk9fiuVc=
X-Google-Smtp-Source: APXvYqxVXVgQtxCvUVcXpIaCx96AHsKpVPAsDmqMtcqJv4c5K0fGnBjNL6/sbpCalpKQeVhC4cH1lsX4Kx/QJoEDz8Q=
X-Received: by 2002:a81:5294:: with SMTP id g142mr7217061ywb.211.1556886918610;
 Fri, 03 May 2019 05:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190503191033.6c56e4c0@canb.auug.org.au>
In-Reply-To: <20190503191033.6c56e4c0@canb.auug.org.au>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 3 May 2019 08:35:06 -0400
Message-ID: <CAOQ4uxikyWj5DMcCLt6kVzLeQt8dg=wMvaXE5vOfbDLaNiqJnw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 5:10 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>
>   fs/sync.c
>
> between commit:
>
>   22f96b3808c1 ("fs: add sync_file_range() helper")
>
> from the block tree and commit:
>
>   9a8d18789a18 ("fs/sync.c: sync_file_range(2) may use WB_SYNC_ALL writeback")
>
> from the akpm-current tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>

Fix looks technically correct, but it would have been better if the fat
comment moved to the fat helper and then replace
s/sys_sync_file_range/ksys_sync_file_range with
s/sys_sync_file_range/sync_file_range

It is probably best if either maintainer took both patches through his tree
and if move and update the comment from "sys_sync_file_range" be done
as part of the helper function patch.

Thanks,
Amir.

> --
> Cheers,
> Stephen Rothwell
>
> diff --cc fs/sync.c
> index 01e82170545a,9e8cd90e890f..000000000000
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@@ -292,10 -348,16 +292,16 @@@ int sync_file_range(struct file *file,
>         }
>
>         if (flags & SYNC_FILE_RANGE_WRITE) {
> +               int sync_mode = WB_SYNC_NONE;
> +
> +               if ((flags & SYNC_FILE_RANGE_WRITE_AND_WAIT) ==
> +                            SYNC_FILE_RANGE_WRITE_AND_WAIT)
> +                       sync_mode = WB_SYNC_ALL;
> +
>                 ret = __filemap_fdatawrite_range(mapping, offset, endbyte,
> -                                                WB_SYNC_NONE);
> +                                                sync_mode);
>                 if (ret < 0)
>  -                      goto out_put;
>  +                      goto out;
>         }
>
>         if (flags & SYNC_FILE_RANGE_WAIT_AFTER)
> @@@ -305,68 -369,6 +311,71 @@@ out
>         return ret;
>   }
>
>  +/*
> -  * sys_sync_file_range() permits finely controlled syncing over a segment of
> ++ * ksys_sync_file_range() permits finely controlled syncing over a segment of
>  + * a file in the range offset .. (offset+nbytes-1) inclusive.  If nbytes is
> -  * zero then sys_sync_file_range() will operate from offset out to EOF.
> ++ * zero then ksys_sync_file_range() will operate from offset out to EOF.
>  + *
>  + * The flag bits are:
>  + *
>  + * SYNC_FILE_RANGE_WAIT_BEFORE: wait upon writeout of all pages in the range
>  + * before performing the write.
>  + *
>  + * SYNC_FILE_RANGE_WRITE: initiate writeout of all those dirty pages in the
>  + * range which are not presently under writeback. Note that this may block for
>  + * significant periods due to exhaustion of disk request structures.
>  + *
>  + * SYNC_FILE_RANGE_WAIT_AFTER: wait upon writeout of all pages in the range
>  + * after performing the write.
>  + *
>  + * Useful combinations of the flag bits are:
>  + *
>  + * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE: ensures that all pages
> -  * in the range which were dirty on entry to sys_sync_file_range() are placed
> ++ * in the range which were dirty on entry to ksys_sync_file_range() are placed
>  + * under writeout.  This is a start-write-for-data-integrity operation.
>  + *
>  + * SYNC_FILE_RANGE_WRITE: start writeout of all dirty pages in the range which
>  + * are not presently under writeout.  This is an asynchronous flush-to-disk
>  + * operation.  Not suitable for data integrity operations.
>  + *
>  + * SYNC_FILE_RANGE_WAIT_BEFORE (or SYNC_FILE_RANGE_WAIT_AFTER): wait for
>  + * completion of writeout of all pages in the range.  This will be used after an
>  + * earlier SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE operation to wait
>  + * for that operation to complete and to return the result.
>  + *
> -  * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER:
> ++ * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER
> ++ * (a.k.a. SYNC_FILE_RANGE_WRITE_AND_WAIT):
>  + * a traditional sync() operation.  This is a write-for-data-integrity operation
>  + * which will ensure that all pages in the range which were dirty on entry to
> -  * sys_sync_file_range() are committed to disk.
> ++ * ksys_sync_file_range() are committed to disk.  It should be noted that disk
> ++ * caches are not flushed by this call, so there are no guarantees here that the
> ++ * data will be available on disk after a crash.
>  + *
>  + *
>  + * SYNC_FILE_RANGE_WAIT_BEFORE and SYNC_FILE_RANGE_WAIT_AFTER will detect any
>  + * I/O errors or ENOSPC conditions and will return those to the caller, after
>  + * clearing the EIO and ENOSPC flags in the address_space.
>  + *
>  + * It should be noted that none of these operations write out the file's
>  + * metadata.  So unless the application is strictly performing overwrites of
>  + * already-instantiated disk blocks, there are no guarantees here that the data
>  + * will be available after a crash.
>  + */
>  +int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
>  +                       unsigned int flags)
>  +{
>  +      int ret;
>  +      struct fd f;
>  +
>  +      ret = -EBADF;
>  +      f = fdget(fd);
>  +      if (f.file)
>  +              ret = sync_file_range(f.file, offset, nbytes, flags);
>  +
>  +      fdput(f);
>  +      return ret;
>  +}
>  +
>   SYSCALL_DEFINE4(sync_file_range, int, fd, loff_t, offset, loff_t, nbytes,
>                                 unsigned int, flags)
>   {
