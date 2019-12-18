Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B529C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B26D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="iA1ZrmcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLRTyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:54:49 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35464 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfLRTyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:54:47 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so2956711qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gUYCfJkvoOW9sK/HezS/S1t6qq/dHNlAaZb//bG4t8w=;
        b=iA1ZrmcTZLU3+eTlAlHFmX16tb5XtE/h5L1OA0P8/h2vDl3GZnq6sZhgv7p0eQSzOc
         4X/idVUpZ4QbbHRA1s6iYYABDUKwupiNvU15grLA1I/2NigJfIxbuwEbHW8UIZpNY0Su
         1vmv8KRDLnBEPQreUQp9U3uDexs7bsMQZaCtmZTuvMUdvdgZ/rUmkKf18SuZUtzJkbXy
         tuEksNSirqQ3o43+jjiPPeuxFY7I6Drb8UMPWT/l4Z9nF1OYe75RmXqf8GCt5BtwRyxI
         gt7aQzSCJrbtNMVYhdCc0fP7j/sCTbFoiP5PXy23TkPTBYMNgyev5wsnAMy/bd/emsNS
         tGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gUYCfJkvoOW9sK/HezS/S1t6qq/dHNlAaZb//bG4t8w=;
        b=dKegkNgNkFsOVdxkcpLDoyLfJA3rVfhnlNga/iAFgXY9XOnR3IbDRutCfmlgE8gtGM
         XFI+8Qxw1NCIYNinqzQmAUW4HviCLsrxvXhojOEnZ0YLzGMhtBWTbkPIoZ3gzVlgJvVc
         Eahky7aK/o04f6hf2bhnM89+47ZAZkbEhzNO2IIuKkj2QxwbLlmOrD5jVDfDtbFp7CwC
         N0QYH7+u8U5DIowifopLQGKbFo7bbGTWnZ48WJ94twVQQa2LPoDTEsYsDDz19kbpo/lJ
         M1UcQWROJ3Oedsszmd68G+5QwacDeip5Td1YFjR4G1KtFru2LbsslyuWzQt4X4XOzQsn
         uTPQ==
X-Gm-Message-State: APjAAAWj/+Dcd4fEVejt1PT/XvNzyWpApO6Yvbqxy8oxF5PF4z/siBnY
        aY8eck/FeAEXScrU3yXqXy+7sPYzUhPtjg==
X-Google-Smtp-Source: APXvYqzbtm3z5WynvFhk7k05Tloq0ed/h9hIClr8b60GvBYq+F+ai9cRDgvk8l88e3HEz9eFD3OrmQ==
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr3888982qtp.50.1576698886089;
        Wed, 18 Dec 2019 11:54:46 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::65a1])
        by smtp.gmail.com with ESMTPSA id d8sm1024807qtr.53.2019.12.18.11.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:54:45 -0800 (PST)
Subject: Re: [PATCH] btrfs: remove BUG_ON used as assertions
To:     dsterba@suse.cz, Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191215171237.27482-1-pakki001@umn.edu>
 <2f9d6549-47cf-fb71-3bff-50b51093e757@toxicpanda.com>
 <20191218164706.GP3929@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <57ffdc3b-59c7-66d4-8e55-909ad4710f5f@toxicpanda.com>
Date:   Wed, 18 Dec 2019 14:54:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191218164706.GP3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/19 11:47 AM, David Sterba wrote:
> On Wed, Dec 18, 2019 at 11:38:18AM -0500, Josef Bacik wrote:
>> On 12/15/19 12:12 PM, Aditya Pakki wrote:
>>> alloc_extent_state_atomic() allocates extents via GFP_ATOMIC flag
>>> and cannot fail. There are multiple invocations of BUG_ON on the
>>> return value to check for failure. The patch replaces certain
>>> invocations of BUG_ON by returning the error upstream.
>>>
>>> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>>
>> I already tried this a few months ago and gave up.  There are a few things if
>> you want to tackle something like this
>>
>> 1) use bpf's error injection thing to make sure you handle every path that can
>> error out.  This is the script I wrote to do just that
>>
>> https://github.com/josefbacik/debug-scripts/blob/master/error-injection-stress.py
>>
>> 2) We actually can't fail here.  We would need to go back and make _all_ callers
>> of lock_extent_bits() handle the allocation error.  This is theoretically
>> possible, but a giant pain in the ass.  In general we can make allocations here
>> and we need to be able to make them.
>>
>> 3) We should probably mark this path with __GFP_NOFAIL because again, this is
>> locking and we need locking to succeed.
> 
> NOFAIL can introduce loops that could lead to deadlocks, if not used
> carefully. __set_extent_bit is not just locking, so if one thread wants
> to set bits, allocate, wait, allocator goes to write some memory
> 
> eg.
> 
> set_extent_bit on some range
>    alloc state (NOFAIL)
>      allocator wants to flush dome dirty data
>                     ------------------------------>
> 		                               set_extent_bit
> 					         alloc state (NOFAIL)
> 						 (wait)
> 

Yes obviously I just want it for EXTENT_LOCKED.  But we could even just use a 
mempool to be really safe, since most places are going to use GFP_KERNEL or 
something else related, we only really need the safety in a few critical areas. 
Thanks,

Josef

