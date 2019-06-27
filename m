Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8282C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E08D216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="i7r9iMo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfF0Cqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:46:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40649 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfF0Cqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:46:49 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so1366035ioc.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 19:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ovBaKS+quEQiCRn3kHJDpPT3ZUV34WzUrRfi6mmIZto=;
        b=i7r9iMo/69vzH40oE3GhJbESSPj/0PUMG//YslEizmRURkBQDgHl0+jCkDXAYyzN/j
         320oYPpocZjp+DIZNxXd4rEF+QkuRdJSU71ZjLAoN9joCWLaEjyLndMrtX4ZlnHNvQ8C
         2HSSSyPRglAZdV3p/CZyc1kYsEO7qpDjq0A9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ovBaKS+quEQiCRn3kHJDpPT3ZUV34WzUrRfi6mmIZto=;
        b=UHp9R7lwbSEY5vrf46PVqPtnMrK50NANvblBbX9Wx44lZK5eWyQhtRFfecKcvmTw/B
         BliR2Cd9E8hJZ+XQ1tuc0MCokMby2UHBKyYm7SS1gOXLBZ7lbgzO4sd5pSH4w5vecglf
         SgfpJJvP4fh8K5Zt3gJTNSMRMLL00vIjDWqUj6qypQYgpA5jPjPIjOoSWzKhgGNVUywK
         R7i1W9Q53mF42S8UwWt6SiIEU+ATqP8evplT90YfYLZlWj9R90+Z1x9u2Y2TQu2OSk5x
         br+qeIJrsjWqIT+yWp9hg0qCdOJWJTHnuZAmLMyZ+Ca6cupAuzqnBjWyOIJj40ARubbp
         +/wg==
X-Gm-Message-State: APjAAAUQhOuoxaf8XGCi8RYyTc3WeFkabdclSc6rt1QtvSSVH+HF5BaB
        LqElixRyZx3GaQPb3cDTBRB0KUEMKik=
X-Google-Smtp-Source: APXvYqw67C0XVSIwijfJChMa3ktR+PB5t3JyxMGrD5O9kXazcX+0ba3hj/XIbiMFvUfs5VXpsaArvA==
X-Received: by 2002:a6b:6b14:: with SMTP id g20mr1809225ioc.28.1561603608085;
        Wed, 26 Jun 2019 19:46:48 -0700 (PDT)
Received: from [10.10.2.64] (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id p9sm745485ioj.49.2019.06.26.19.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 19:46:47 -0700 (PDT)
Subject: Re: [PATCH 1/1] udf: Fix incorrect final NOT_ALLOCATED (hole) extent
 length
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
References: <20190604123158.12741-1-steve@digidescorp.com>
 <20190604123158.12741-2-steve@digidescorp.com>
 <20190625103019.GA1994@quack2.suse.cz>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Message-ID: <b5fcfef0-5fd4-f10a-4cce-78244aa1b227@digidescorp.com>
Date:   Wed, 26 Jun 2019 21:46:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190625103019.GA1994@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 6/25/19 5:30 AM, Jan Kara wrote:
> On Tue 04-06-19 07:31:58, Steve Magnani wrote:
>> In some cases, using the 'truncate' command to extend a UDF file results
>> in a mismatch between the length of the file's extents (specifically, due
>> to incorrect length of the final NOT_ALLOCATED extent) and the information
>> (file) length. The discrepancy can prevent other operating systems
>> (i.e., Windows 10) from opening the file.
>>
>> Two particular errors have been observed when extending a file:
>>
>> 1. The final extent is larger than it should be, having been rounded up
>>     to a multiple of the block size.
>>
>> B. The final extent is not shorter than it should be, due to not having
>>     been updated when the file's information length was increased.
>>
>> The first case could represent a design error, if coded intentionally
>> due to a misinterpretation of scantily-documented ECMA-167 "file tail"
>> rules. The standard specifies that the tail, if present, consists of
>> a sequence of "unrecorded and allocated" extents (only).
>>
>> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>
> Thanks for the testcase and the patch! I finally got to reading through
> this in detail. In udf driver in Linux we are generally fine with the last
> extent being rounded up to the block size. udf_truncate_tail_extent() is
> generally responsible for truncating the last extent to appropriate size
> once we are done with the inode. However there are two problems with this:
>
> 1) We used to do this inside udf_clear_inode() back in the old days but
> then switched to a different scheme in commit 2c948b3f86e5f "udf: Avoid IO
> in udf_clear_inode". So this actually breaks workloads where user calls
> truncate(2) directly and there's no place where udf_truncate_tail_extent()
> gets called.
>
> 2) udf_extend_file() sets i_lenExtents == i_size although the last extent
> isn't properly rounded so even if udf_truncate_tail_extent() gets called
> (which is actually the case for truncate(1) which does open, ftruncate,
> close), it will think it has nothing to do and exit.
>
> Now 2) is easily fixed by setting i_lenExtents to real length of extents we
> have created. However that still leaves problem 1) which isn't easy to deal
> with. After some though I think that your solution of making
> udf_do_extend_file() always create appropriately sized extents makes
> sense. However I dislike the calling convention you've chosen. When
> udf_do_extend_file() needs to now byte length, then why not pass it to it
> directly, instead of somewhat cumbersome "sector length + byte offset"
> pair?
>
> Will you update the patch please? Thanks!

That sounds reasonable, but at first glance I think it might be more 
confusing. The API as I reworked it now communicates two different 
(although related) things - the number of blocks that need to be added, 
and the number of bytes within the last block that are part of the file. 
This is able to cover both the corner case of extending within the last 
file block and extending beyond that:

    	partial_final_block = newsize & (sb->s_blocksize - 1);

    	/* File has extent covering the new size (could happen when extending
    	 * inside a block)? */
    	if (etype == -1) {
    		if (partial_final_block)
    			offset++;
    	} else {
    		/* Extending file within the last file block */
    		offset = 0;  /* Don't add any new blocks */
    	}

If it were as simple as passing to udf_do_extend_file() a loff_t 
specifying the number of bytes to add, including both full blocks and a 
final partial block, I would agree with you. But this isn't enough 
information for udf_do_extend_file() to know whether the final partial 
block requires a new block or not.

I will think about it some more. Maybe moving the 'extending within the 
last file block' case out to udf_extend_file() would help.

Steve

