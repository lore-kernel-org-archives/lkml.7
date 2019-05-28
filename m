Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66714C04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E4F20717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfE1ASu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 20:18:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:52232 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfE1ASu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 20:18:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 17:18:49 -0700
X-ExtLoop1: 1
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2019 17:18:48 -0700
Subject: Re: eb9d1bf079 [ 88.881528] EIP: _random_read
To:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
References: <20190516071405.GO31424@shao2-debian>
 <20190522162444.GB2744@mit.edu>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <5408d2e0-53ec-55ee-3ad5-b6c797a9cf5a@intel.com>
Date:   Tue, 28 May 2019 08:19:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522162444.GB2744@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/19 12:24 AM, Theodore Ts'o wrote:
> Can you check and see if this addresses the issue?  I'm not able to
> easily repro the softlockup.

Hi,

The patch could fix the issue in our testing environment.

Best Regards,
Rong Chen


>
> Thanks!
>
> 						- Ted
>
> commit f93d3e94983bf8b4697ceb121c79afd941862860
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Wed May 22 12:02:16 2019 -0400
>
>      random: fix soft lockup when trying to read from an uninitialized blocking pool
>      
>      Fixes: eb9d1bf079bb: "random: only read from /dev/random after its pool has received 128 bits"
>      Reported-by: kernel test robot <lkp@intel.com>
>      Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index a42b3d764da8..9cea93d0bfb3 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1936,8 +1936,8 @@ _random_read(int nonblock, char __user *buf, size_t nbytes)
>   			return -EAGAIN;
>   
>   		wait_event_interruptible(random_read_wait,
> -			ENTROPY_BITS(&input_pool) >=
> -			random_read_wakeup_bits);
> +		    blocking_pool.initialized &&
> +		    (ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits));
>   		if (signal_pending(current))
>   			return -ERESTARTSYS;
>   	}
