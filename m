Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C374C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD1321902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e4J+mssY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e4J+mssY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfDXOJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:09:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56186 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfDXOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:09:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6BA6F6053D; Wed, 24 Apr 2019 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556114949;
        bh=MHVdlAoAhKQSKrc5bbXQ5+gLT+VeIgHuzo/MaJlw7Og=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e4J+mssYhr7N0eH/yf7PC9gDFqta2jYIzUK9qxr6cObNm4QSoPFnvfbrlWKvHXGUd
         Ll6bdCx5jTtAFAp9Mpi0N/lgQL7X0DwPZ2qQ6PA3S2ckhwX/uPpzXBGuRyMCsrLWMj
         LN48X5YeGDOGNWto3QtNceNo9jE1623bsJ5u6bmk=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1F20601C4;
        Wed, 24 Apr 2019 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556114949;
        bh=MHVdlAoAhKQSKrc5bbXQ5+gLT+VeIgHuzo/MaJlw7Og=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e4J+mssYhr7N0eH/yf7PC9gDFqta2jYIzUK9qxr6cObNm4QSoPFnvfbrlWKvHXGUd
         Ll6bdCx5jTtAFAp9Mpi0N/lgQL7X0DwPZ2qQ6PA3S2ckhwX/uPpzXBGuRyMCsrLWMj
         LN48X5YeGDOGNWto3QtNceNo9jE1623bsJ5u6bmk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1F20601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a global
 lock
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gaurav Kohli <gkohli@codeaurora.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Martin Kepplinger <martink@posteo.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <20190418014321.dptin7tpxpldhsns@penguin>
 <bb92c3f2-faf1-04ec-4c67-3aba56c507a9@codeaurora.org>
 <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
 <20190419071152.x5ghvbybjhv76uxt@penguin>
 <f3cd46fb-2bb1-0422-b2be-3f7625ec9c4e@codeaurora.org>
 <20190423032839.xvbldglrmjxkdntj@penguin>
 <17f4a0be-ab04-8537-9197-32fbca807f3f@codeaurora.org>
 <20190423084944.gj2boxfcg7lp4zad@penguin>
 <20190423110611.GL2217@ZenIV.linux.org.uk>
 <5614f04f-827d-1668-9ed0-60d93e110b8e@codeaurora.org>
 <20190424130711.GP2217@ZenIV.linux.org.uk>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <5b02ac1e-df3e-d9cd-ecf3-fe60cda2cece@codeaurora.org>
Date:   Wed, 24 Apr 2019 19:39:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424130711.GP2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/24/2019 6:37 PM, Al Viro wrote:
> On Wed, Apr 24, 2019 at 05:40:40PM +0530, Mukesh Ojha wrote:
>> Al,
>>
>> i tried to put traceprintk inside ioctl after fdget and fdput on a simple
>> call of open  => ioctl => close
> in a loop, and multithreaded, presumably?
>
>> on /dev/uinput.
>>
>>            uinput-532   [002] ....    45.312044: SYSC_ioctl: 2     <= f_count
>>>      <After fdget()
>>            uinput-532   [002] ....    45.312055: SYSC_ioctl: 2
>> <After fdput()
>>            uinput-532   [004] ....    45.313766: uinput_open: uinput: 1
>>            uinput-532   [004] ....    45.313783: SYSC_ioctl: 1
>>            uinput-532   [004] ....    45.313788: uinput_ioctl_handler:
>> uinput: uinput_ioctl_handler, 1
>>            uinput-532   [004] ....    45.313835: SYSC_ioctl: 1
>>            uinput-532   [004] ....    45.313843: uinput_release: uinput:  0
>>
>>
>> So while a ioctl is running the f_count is 1, so a fput could be run and do
>> atomic_long_dec_and_test
>> this could call release right ?
> Look at ksys_ioctl():
> int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
> {
>          int error;
>          struct fd f = fdget(fd);
> an error or refcount bumped
>          if (!f.file)
>                  return -EBADF;
> not an error, then.  We know that ->release() won't be called
> until we drop the reference we've just acquired.
>          error = security_file_ioctl(f.file, cmd, arg);
>          if (!error)
>                  error = do_vfs_ioctl(f.file, fd, cmd, arg);
> ... and we are done with calling ->ioctl(), so
>          fdput(f);
> ... we drop the reference we'd acquired.
>
> Seeing refcount 1 inside ->ioctl() is possible, all right:
>
> CPU1: ioctl(2) resolves fd to struct file *, refcount 2
> CPU2: close(2) rips struct file * from descriptor table and does fput() to drop it;
> 	refcount reaches 1 and fput() is done; no call of ->release() yet.
> CPU1: we get arouund to ->ioctl(), where your trace sees refcount 1
> CPU1: done with ->ioctl(), drop our reference.  *NOW* refcount gets to 0, and
> 	->release() is called.

Thanks for the detail reply, Al

This was my simple program no multithreading just to understand f_counting

int main()
{
         int fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
         ioctl(fd, UI_SET_EVBIT, EV_KEY);
         close(fd);
         return 0;
}

            uinput-532   [002] ....    45.312044: SYSC_ioctl: 2   <= 
f_count >    <After fdget()
           uinput-532   [002] ....    45.312055: SYSC_ioctl: 
2            <After fdput()
           uinput-532   [004] ....    45.313766: uinput_open: uinput: 
1   /* This is from the uinput driver uinput_open()*/

   =>>>>                         /* All the above calls happened for the 
open() in userspace*/

           uinput-532   [004] ....    45.313783: SYSC_ioctl: 1 /* This 
print is for the trace, i put after fdget */
           uinput-532   [004] ....    45.313788: uinput_ioctl_handler: 
uinput: uinput_ioctl_handler, 1 /* This print is from the uinput_ioctl 
driver */

           uinput-532   [004] ....    45.313835: SYSC_ioctl: 1 /* This 
print is for the trace, i put after fdput*/
           uinput-532   [004] ....    45.313843: uinput_release: 
uinput:  0 /* And this is from the close()  */


Should fdget not suppose to increment the f_count here, as it is coming 1 ?
This f_count to one is done at the open, but i have no idea how this  
below f_count 2 came before open() for
this simple program.

          uinput-532   [002] ....    45.312044: SYSC_ioctl: 2 <= f_count 
 >    <After fdget()
           uinput-532   [002] ....    45.312055: SYSC_ioctl: 
2            <After fdput()

-Mukesh

> IOW, in your trace fput() has already been run by close(2); having somebody else
> do that again while we are in ->ioctl() would be a bug (to start with, where
> did they get that struct file * and why wasn't that reference contributing to
> struct file refcount?)
>
> In all cases we only call ->release() once all references gone - both
> the one(s) in descriptor tables and any transient ones acquired by
> fdget(), etc.
>
> I would really like to see a reproducer for the original use-after-free report...
