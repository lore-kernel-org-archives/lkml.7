Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9E1C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9382067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="RDjOLla7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbfKFQcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:32:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46446 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfKFQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:32:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id l4so6433025plt.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 08:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YDXR99N/YzQ/pZqCEI29huJxwejGrYigJcQpVl3mLN0=;
        b=RDjOLla7UpdFA1uZVV/RjkQ6SwfLGswLg8cNYaDk16wAy2jKbHaMgvrGMS8PErrxrW
         GFDxosOG5HVnj4O+ADH20k7STXbGnrgA7hy1HmziitFTqXDWjWdcbKeriEp4JFFQeLZa
         kDyPWLHToo27tjU2eNGO/Vllhc2AHU6Bdq/yxqnkKCoOCkUQH6vfLsUVOoMGt/A/2npb
         gnyLGHxmd5oYviEmAREMcaw4zruZmAxc07zAPbTcHGNNXl8MvZLk3Fl2rWYvWkwoyDCE
         1xPysUBCTD+eYaEZERw3pv6bKvd/HaBKrT6uITNWO/cM57G9mxGX2doCTFJq47dDsnYs
         p8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YDXR99N/YzQ/pZqCEI29huJxwejGrYigJcQpVl3mLN0=;
        b=S7kk+yJMCCcy2LC4t02LtBOIxzBjYC4Q6UbWLipf4xBD19w1hBnNXIVrUKti5HUe78
         H/oZU4I/NjnLpI/s3bu0NlIUPreMXGiIo1Uap9nZISEml+i8WtfxT38xoVBqt/meD8Rv
         0ylQ4+kKcPSVtw7usS68ZJQNBqExtzFjMN3YKZ0Ja/7+hfdWGmllM7iVKhq4ma4/gW0F
         dZhwcZEf8E1E8oXdawbA6al5zlbtQsUWjRiTWm6z+GClhDiZjMw0CT+v5y9++IaJwb1T
         7gOl7StXiKeInBWVwj7RO1RgSS00yAY9wtxjlKbWN4WSJGBrT1JzsM8pr6eia5oCOf7o
         0DPw==
X-Gm-Message-State: APjAAAXI0v1LMFBiZxBTBcjRWDX2U3H8FZV2+x+9lIXHUY4ZG7ynvkfV
        IKiPtjtyQDNHcBge7ShVqqzC6Q==
X-Google-Smtp-Source: APXvYqzGnty5jGHPlGvF4cPMglmlPHfo5F67afnyOnzik5KBFCH43E7LJ5r8u2evmErEOI3pDLHStg==
X-Received: by 2002:a17:902:8486:: with SMTP id c6mr274839plo.137.1573057934474;
        Wed, 06 Nov 2019 08:32:14 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m12sm2974603pjk.13.2019.11.06.08.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 08:32:13 -0800 (PST)
Subject: Re: [PATCH 05/50] arm: Add loglvl to unwind_backtrace()
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com
References: <20191106030542.868541-1-dima@arista.com>
 <20191106030542.868541-6-dima@arista.com>
 <20191106091258.GS25745@shell.armlinux.org.uk>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <cd6c5df5-effd-a1f9-8a25-9f5aac3a92f9@arista.com>
Date:   Wed, 6 Nov 2019 16:32:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106091258.GS25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 9:12 AM, Russell King - ARM Linux admin wrote:
> On Wed, Nov 06, 2019 at 03:04:56AM +0000, Dmitry Safonov wrote:
>> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
>> index 7c3f32b26585..69e35462c9e9 100644
>> --- a/arch/arm/kernel/traps.c
>> +++ b/arch/arm/kernel/traps.c
>> @@ -202,7 +202,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>>  #ifdef CONFIG_ARM_UNWIND
>>  static inline void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>>  {
>> -	unwind_backtrace(regs, tsk);
>> +	unwind_backtrace(regs, tsk, KERN_DEBUG);
> 
> Why demote this to debug level?  This is used as part of the kernel
> panic message, surely we don't want this at debug level?  What about
> the non-unwind version?

Right, I wanted to keep the old loglevel in this patch - KERN_DEFAULT.
But got confused with log level in unwind_backtrace().
Will fix.

[..]
>> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
>> index 0a65005e10f0..caaae1b6f721 100644
>> --- a/arch/arm/kernel/unwind.c
>> +++ b/arch/arm/kernel/unwind.c
>> @@ -455,11 +455,12 @@ int unwind_frame(struct stackframe *frame)
>>  	return URC_OK;
>>  }
>>  
>> -void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>> +void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
>> +		      const char *loglvl)
>>  {
>>  	struct stackframe frame;
>>  
>> -	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
>> +	printk("%s%s(regs = %p tsk = %p)\n", loglvl, __func__, regs, tsk);
> 
> Clearly, this isn't supposed to be part of the normal backtrace output...

Yes, sorry it's debug for a backtrace - will return pr_debug() for the
message.

Thanks,
          Dmitry
