Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02198C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C3C2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FskF3yeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391899AbfFLDRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 23:17:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34216 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388207AbfFLDRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 23:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IpLE7ds2K7OtQWpRAGotTZF/PZyEILhWbTrpge7p0cg=; b=FskF3yeL0/79r17kY13jKRiXqy
        p61RiQCqPCuaV6wK9aOriMS+o6syY3+q3GH7ogGSRoDe/+XfIq7c3mE89pCRdTuPboH6VRQt+SStN
        lqosfsN/knVsUPDu+htIe6f1BQyQUMMbTAHsbnhRwyfN1JGJR+U+4iTddXmRHS9eg0efGrhB8dqAc
        zpbSCTiIS9/Zr9qngbf4DcdJs29NelKYWZh9P4OkM8JNtcY1hWacSQELN+riB9wmgX7oHFiAPeVK6
        sxzet/L+MDj7qbMmQEjKczKQzlF02y9qoc9JSnRxJZliY/e3sLAx/rSp7MFgPmpuGpsNSOrSHcseo
        CL/3eMUw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hatlL-0002pl-M5; Wed, 12 Jun 2019 03:17:24 +0000
Subject: Re: linux-next 20190611: objtool warning
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
References: <a9ceb8f8-f2fd-e57d-3428-aaf50e011a43@infradead.org>
 <20190612025227.lxumqqtqao6iqms3@treble>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <18e6ef70-2fa3-3f70-0fcd-3eadef2cfceb@infradead.org>
Date:   Tue, 11 Jun 2019 20:17:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612025227.lxumqqtqao6iqms3@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/19 7:52 PM, Josh Poimboeuf wrote:
> On Tue, Jun 11, 2019 at 06:59:22PM -0700, Randy Dunlap wrote:
>> Hi,
>>
>> New warning AFAIK:
>>
>> drivers/hwmon/smsc47m1.o: warning: objtool: fan_div_store()+0x11f: sibling call from callable instruction with modified stack frame
> 
> I'm getting a different warning:
> 
>   drivers/hwmon/smsc47m1.o: warning: objtool: fan_div_store()+0xb6: can't find jump dest instruction at .text+0x93a
> 
> But I bet the root cause is the same.
> 
> This fixes it for me:
> 
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] hwmon/smsc47m1: Fix objtool warning caused by undefined behavior
> 
> Objtool is reporting the following warning:
> 
>   drivers/hwmon/smsc47m1.o: warning: objtool: fan_div_store()+0xb6: can't find jump dest instruction at .text+0x93a
> 
> It's apparently caused by
> 
>   2cf6745e69d1 ("hwmon: (smsc47m1) fix (suspicious) outside array bounds warnings")
> 
> which is somehow convincing GCC to add a jump past the end of the
> function:
> 
>   793:   45 85 ed                test   %r13d,%r13d
>   796:   0f 88 9e 01 00 00       js     93a <fan_div_store+0x25a>
>   ...
>   930:   e9 5e fe ff ff          jmpq   793 <fan_div_store+0xb3>
>   935:   e8 00 00 00 00          callq  93a <fan_div_store+0x25a>
> 			936: R_X86_64_PLT32     __stack_chk_fail-0x4
>   <function end>
> 
> I suppose this falls under the category of undefined behavior, so we
> probably can't call it a GCC bug.  But if the value of "nr" were out of
> range somehow then it would start executing random code.  Use a runtime
> BUG() assertion to avoid undefined behavior.
> 
> Fixes: 2cf6745e69d1 ("hwmon: (smsc47m1) fix (suspicious) outside array bounds warnings")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Yes, that works for me.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/hwmon/smsc47m1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
> index 6d366c9cb906..b637836b58a1 100644
> --- a/drivers/hwmon/smsc47m1.c
> +++ b/drivers/hwmon/smsc47m1.c
> @@ -352,7 +352,7 @@ static ssize_t fan_div_store(struct device *dev,
>  		smsc47m1_write_value(data, SMSC47M2_REG_FANDIV3, tmp);
>  		break;
>  	default:
> -		unreachable();
> +		BUG();
>  	}
>  
>  	/* Preserve fan min */
> 


-- 
~Randy
