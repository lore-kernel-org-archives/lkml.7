Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9610C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC28520896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXR2Lyoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbfFLFJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 01:09:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41026 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFLFJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 01:09:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id 83so8232976pgg.8;
        Tue, 11 Jun 2019 22:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QSiy1WALeaxto2+oBA0YiByDyDuP8YMrBLAEms1CKDs=;
        b=SXR2Lyoq072s2FEh6iCN/Ver9AsBV8dO1TYMB5QgEnLmoZnfs5E30iFUaf6jA6NW2Z
         XsrO6iTMfOwSamZbc9OPbT7l2dPOv9mc03s/s6DUcBUF60OKOhHKwwnk0Fw8tUEJ0wY6
         if3bGcJny6G1qyG68YYRQa1efh7Czb7DyRqhRXUp2bW4Hnlgar0oywPmkCI6r7Sp7PMP
         ArAFoSbBfU1vl2G9+f5rAlgFwzpcbbHkFPeXj5qnA75/f3A25DDufw9tvtNcgy3QcdsC
         n8ATDZH9youAe73o+iO+/d5hyKU8QRxo2Wt0LjZbZ5dGqtEYJFbhuMTAN0sCK/BzuLTx
         h9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QSiy1WALeaxto2+oBA0YiByDyDuP8YMrBLAEms1CKDs=;
        b=ovGL32Kx1PkIYUpgNNUawm5vdZhHElfGBjRdHts9h+xbWKuNVE06J29Gjo0YRVbgS+
         Z2Zhek3n90Qk5rKu0CBXXWZbs1+LWnT9NqJkIj870R/vpNS4uT1ulR4W5SqUEILnML5e
         Dil6OeXopfxzWzY1IFhebiGewyJHoIjEtc7IgGKVw+tPCd54zuq0yeF5FM0UJTC6TIHX
         ZAGM9MGVAiWj4sywrI8UI0y9IrhGt/4KQOCW8Y7L3871jGXlxqWn9nneKw8JWiH99ABp
         up21DeLSdk5KAed5HXg3b6zbgbvOiJ92yUJ4F+bJkEyfuXc/5fqoegC6CkdFitsBhbpU
         I1Ag==
X-Gm-Message-State: APjAAAWs6V7N2HHu6bXNj2tUdZ3kzPCK3zB76vhpPQ3xMI3hTeBSjsL9
        OWgoI0J7G3NbwlepkNJzxn4=
X-Google-Smtp-Source: APXvYqzH5Urf5rNA/dTXGsOOhH5rN3ddBBmHGYo2FFbZZ1tVz2HqqOlPHzbh9URpZogmBOndR2mrEA==
X-Received: by 2002:a63:ec42:: with SMTP id r2mr24144062pgj.262.1560316190612;
        Tue, 11 Jun 2019 22:09:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v190sm13851931pfv.75.2019.06.11.22.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 22:09:49 -0700 (PDT)
Subject: Re: linux-next 20190611: objtool warning
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jean Delvare <jdelvare@suse.com>
References: <a9ceb8f8-f2fd-e57d-3428-aaf50e011a43@infradead.org>
 <20190612025227.lxumqqtqao6iqms3@treble>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <badd630c-4bf9-1694-11ec-cbfd13964516@roeck-us.net>
Date:   Tue, 11 Jun 2019 22:09:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612025227.lxumqqtqao6iqms3@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
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
>    drivers/hwmon/smsc47m1.o: warning: objtool: fan_div_store()+0xb6: can't find jump dest instruction at .text+0x93a
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
>    drivers/hwmon/smsc47m1.o: warning: objtool: fan_div_store()+0xb6: can't find jump dest instruction at .text+0x93a
> 
> It's apparently caused by
> 
>    2cf6745e69d1 ("hwmon: (smsc47m1) fix (suspicious) outside array bounds warnings")
> 
> which is somehow convincing GCC to add a jump past the end of the
> function:
> 
>    793:   45 85 ed                test   %r13d,%r13d
>    796:   0f 88 9e 01 00 00       js     93a <fan_div_store+0x25a>
>    ...
>    930:   e9 5e fe ff ff          jmpq   793 <fan_div_store+0xb3>
>    935:   e8 00 00 00 00          callq  93a <fan_div_store+0x25a>
> 			936: R_X86_64_PLT32     __stack_chk_fail-0x4
>    <function end>
> 
> I suppose this falls under the category of undefined behavior, so we
> probably can't call it a GCC bug.  But if the value of "nr" were out of
> range somehow then it would start executing random code.  Use a runtime
> BUG() assertion to avoid undefined behavior.
> 
> Fixes: 2cf6745e69d1 ("hwmon: (smsc47m1) fix (suspicious) outside array bounds warnings")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>   drivers/hwmon/smsc47m1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
> index 6d366c9cb906..b637836b58a1 100644
> --- a/drivers/hwmon/smsc47m1.c
> +++ b/drivers/hwmon/smsc47m1.c
> @@ -352,7 +352,7 @@ static ssize_t fan_div_store(struct device *dev,
>   		smsc47m1_write_value(data, SMSC47M2_REG_FANDIV3, tmp);
>   		break;
>   	default:
> -		unreachable();
> +		BUG();

Sigh. And I wanted to avoid BUG() because this is all just to make
the compiler happy to start with. Oh well. I updated the offending
patch to use BUG().

Guenter

>   	}
>   
>   	/* Preserve fan min */
> 

