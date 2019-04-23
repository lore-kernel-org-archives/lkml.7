Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7D3C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395B420685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="PSJfHQlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfDWPOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:14:47 -0400
Received: from smtp105.ord1c.emailsrvr.com ([108.166.43.105]:33573 "EHLO
        smtp105.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727656AbfDWPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:14:47 -0400
Received: from smtp22.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp22.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 97381E03B5;
        Tue, 23 Apr 2019 11:14:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1556032485;
        bh=PnYKsXXdL+qiZeSN8eOsMOuCdFeAcZDQmq+Lhgyc8yE=;
        h=Subject:To:From:Date:From;
        b=PSJfHQlYbQ62SkxWMUTleAuQfw2dxGWdbkpfpuEa4mnW+IfVJrFEF5saz01LDxaG6
         ayqf0OXl3B7GtpDP4w0Bs/8n0LClS8d6wZMW32Slxq3V8bAjSIP/UlAyHCx6qGKihd
         oGQjEA94kiD0sjXr97mLcfr0oUl9iOO1WkGzEhPc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp22.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id DE1C8E0366;
        Tue, 23 Apr 2019 11:14:44 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.62] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 23 Apr 2019 11:14:45 -0400
Subject: Re: [PATCH] fuse: Add ioctl flag for compat ioctl with 64-bit time_t
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190301170831.23612-1-abbotti@mev.co.uk>
 <CAJfpegsQvUGz-YRQVrfkTWuSFe==Hg_Y=VpV0ZagKe0qGfxQ7g@mail.gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <d2bab6ae-0c52-5a6a-78e4-72a5f298a85f@mev.co.uk>
Date:   Tue, 23 Apr 2019 16:14:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJfpegsQvUGz-YRQVrfkTWuSFe==Hg_Y=VpV0ZagKe0qGfxQ7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2019 13:55, Miklos Szeredi wrote:
> On Fri, Mar 1, 2019 at 6:08 PM Ian Abbott <abbotti@mev.co.uk> wrote:
>>
>> Currently, a CUSE server running on a 64-bit kernel can tell when an
>> ioctl request comes from a process running a 32-bit ABI, but cannot tell
>> whether the requesting process is using legacy IA32 emulation or x32
>> ABI, for example.  In particular, the server does not know the size of
>> the client process's `time_t` type.
>>
>> For 64-bit kernels, the `FUSE_IOCTL_COMPAT` and `FUSE_IOCTL_32BIT` flags
>> are currently set in the ioctl input request (`struct fuse_ioctl_in`
>> member `flags`) for a 32-bit requesting process.  This patch defines a
>> new flag `FUSE_IOCTL_COMPAT_64TIME` and sets it if the 32-bit requesting
>> process (running on a 64-bit kernel) uses a 64-bit `time_t` type.
> 
> Hi,
> 
> Thanks for the patch.
> 
> I think it should rather use in_x32_syscall() helper and follow that
> naming because there's apparently at least one example in xfs of a
> non-time_t related ioctl that varies between the x32 vs ia32.

Hi Miklos,

It is conceivable that COMPAT_USE_64BIT_TIME could be true for some 
other arch/ABI (although currently it is only ever set for x86/x32). 
Should it have separate flags for "compat 64-bit time" and "compat x32" 
(even though that is currently redundant)?

Kind regards,
Ian.

> 
> Thanks,
> Miklos
> 
>>
>> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
>> ---
>>   fs/fuse/file.c            | 5 ++++-
>>   include/uapi/linux/fuse.h | 2 ++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 06096b60f1df..9777e7a19889 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -2576,8 +2576,11 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
>>   #if BITS_PER_LONG == 32
>>          inarg.flags |= FUSE_IOCTL_32BIT;
>>   #else
>> -       if (flags & FUSE_IOCTL_COMPAT)
>> +       if (flags & FUSE_IOCTL_COMPAT) {
>>                  inarg.flags |= FUSE_IOCTL_32BIT;
>> +               if (COMPAT_USE_64BIT_TIME)
>> +                       inarg.flags |= FUSE_IOCTL_COMPAT_64TIME;
>> +       }
>>   #endif
>>
>>          /* assume all the iovs returned by client always fits in a page */
>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> index 2ac598614a8f..1f4a71486601 100644
>> --- a/include/uapi/linux/fuse.h
>> +++ b/include/uapi/linux/fuse.h
>> @@ -335,6 +335,7 @@ struct fuse_file_lock {
>>    * FUSE_IOCTL_RETRY: retry with new iovecs
>>    * FUSE_IOCTL_32BIT: 32bit ioctl
>>    * FUSE_IOCTL_DIR: is a directory
>> + * FUSE_IOCTL_COMPAT_64TIME: 32bit compat ioctl with 64bit time_t
>>    *
>>    * FUSE_IOCTL_MAX_IOV: maximum of in_iovecs + out_iovecs
>>    */
>> @@ -343,6 +344,7 @@ struct fuse_file_lock {
>>   #define FUSE_IOCTL_RETRY       (1 << 2)
>>   #define FUSE_IOCTL_32BIT       (1 << 3)
>>   #define FUSE_IOCTL_DIR         (1 << 4)
>> +#define FUSE_IOCTL_COMPAT_64TIME (1 << 5)
>>
>>   #define FUSE_IOCTL_MAX_IOV     256
>>
>> --
>> 2.20.1
>>


-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
