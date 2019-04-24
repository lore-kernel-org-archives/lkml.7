Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38684C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F3420811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="oO0jKCqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbfDXMls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:41:48 -0400
Received: from smtp121.ord1d.emailsrvr.com ([184.106.54.121]:54247 "EHLO
        smtp121.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726322AbfDXMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:41:48 -0400
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 08:41:47 EDT
Received: from smtp24.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp24.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id C7D38A00E9;
        Wed, 24 Apr 2019 08:33:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1556109238;
        bh=vNn977CTQA2JGqXRjsZvDkpbkUdjgvPJF7Vp8G9ny+o=;
        h=Subject:To:From:Date:From;
        b=oO0jKCqAPY4mwZiTMEkl24CdaZcfPr69ywgAP4C61XeWAnRb3mDnQ/Ep53g2uodSo
         5Pv3ZU4udPpElOXWl4KibyzP6QTtM2SOAymtkxhJ/YP6Nowwpcwa9884EusC4KKnls
         1dTMYQCbV3u/GYCQmJ2FaSByG3EWXsslb6rU2Dfk=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp24.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 3713CA011C;
        Wed, 24 Apr 2019 08:33:58 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.62] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 24 Apr 2019 08:33:58 -0400
Subject: Re: [PATCH] fuse: Add ioctl flag for compat ioctl with 64-bit time_t
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190301170831.23612-1-abbotti@mev.co.uk>
 <CAJfpegsQvUGz-YRQVrfkTWuSFe==Hg_Y=VpV0ZagKe0qGfxQ7g@mail.gmail.com>
 <d2bab6ae-0c52-5a6a-78e4-72a5f298a85f@mev.co.uk>
 <CAJfpegvhvS2KEP3kFsSGXONVuBdSdpgy8OGqd79ehN0uGAy5VA@mail.gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <4dba1140-be46-6c1b-d88a-4cdf4d69cdda@mev.co.uk>
Date:   Wed, 24 Apr 2019 13:33:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJfpegvhvS2KEP3kFsSGXONVuBdSdpgy8OGqd79ehN0uGAy5VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2019 11:52, Miklos Szeredi wrote:
> On Tue, Apr 23, 2019 at 5:14 PM Ian Abbott <abbotti@mev.co.uk> wrote:
>>
>> On 23/04/2019 13:55, Miklos Szeredi wrote:
>>> On Fri, Mar 1, 2019 at 6:08 PM Ian Abbott <abbotti@mev.co.uk> wrote:
>>>>
>>>> Currently, a CUSE server running on a 64-bit kernel can tell when an
>>>> ioctl request comes from a process running a 32-bit ABI, but cannot tell
>>>> whether the requesting process is using legacy IA32 emulation or x32
>>>> ABI, for example.  In particular, the server does not know the size of
>>>> the client process's `time_t` type.
>>>>
>>>> For 64-bit kernels, the `FUSE_IOCTL_COMPAT` and `FUSE_IOCTL_32BIT` flags
>>>> are currently set in the ioctl input request (`struct fuse_ioctl_in`
>>>> member `flags`) for a 32-bit requesting process.  This patch defines a
>>>> new flag `FUSE_IOCTL_COMPAT_64TIME` and sets it if the 32-bit requesting
>>>> process (running on a 64-bit kernel) uses a 64-bit `time_t` type.
>>>
>>> Hi,
>>>
>>> Thanks for the patch.
>>>
>>> I think it should rather use in_x32_syscall() helper and follow that
>>> naming because there's apparently at least one example in xfs of a
>>> non-time_t related ioctl that varies between the x32 vs ia32.
>>
>> Hi Miklos,
>>
>> It is conceivable that COMPAT_USE_64BIT_TIME could be true for some
>> other arch/ABI (although currently it is only ever set for x86/x32).
>> Should it have separate flags for "compat 64-bit time" and "compat x32"
>> (even though that is currently redundant)?
> 
> No, it should just be a single flag, something like
> FUSE_IOCTL_COMPAT_X32 and the documentation should say that it implies
> 64bit time values.

Okay, since the subject line, description and code will change, I'll 
submit the new patch as a new patch, rather than a "v2".  (I'll mention 
its history below the scissors line.)  Please drop this patch.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
