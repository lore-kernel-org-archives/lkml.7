Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C94C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBE321670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="PcioB/LS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfIDJNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:13:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45506 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbfIDJNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:13:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id l1so18842344lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5phCvVl3uOdZP3GpSf7W5TJQ15xML2KLNcC8rhDQhaw=;
        b=PcioB/LS6ytYKEcC7HRkZWt0pLUNGARVuTa/QiLkGLV19eYlRQ+qKAU19iczNFRiHK
         ursj9lw/vurWdwefeXvFiQ347qMhAIjbwuLQ2x1UbLzX40ixgy5/202Y7lCuZGRfuJ5o
         o63edpxFgKB31ee8K9bdZPSzj8sZvj/Vi+BpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5phCvVl3uOdZP3GpSf7W5TJQ15xML2KLNcC8rhDQhaw=;
        b=E3D7MpGImLF3GzW78vSCJlTkR67eTZ3EhfokM2xOa1+sf52GTAXLTi1J4h1QltLAd6
         Jyy/KVvHNEc8WxeD5uE5J+VnW2iu9f7A3BwXkNtptbUc0/RH+fnhIfy3aV3JwHGGDVxu
         0Kyr4nZauYRehYH861/CH8Ciq5eCbkuqSXLdK1R6lK52kravWrxAeRxa+zVOmATH6amf
         1m0j7H18Gcho+2AMzdO2QaKNlVTFEPDuhdpffKCVpiy6d1Lpsi6dBuAAQULGyTZMXrb5
         N+uXevithXL6yPKzSAI+cwn9il+QuvFGNxjtAAf81MFxN8FJkCUdeXlC7ZPYE20b08mf
         89UA==
X-Gm-Message-State: APjAAAXxDxUp5rfytfxnA5cAm+/4LJcF82K+EOJEvi3p5XYH/Da9mO41
        UAZyCuWNwRnzuH/PC/jqNd2TOuMRit8s5CPm
X-Google-Smtp-Source: APXvYqxDXRcfp2OuQovD+1YP/V7dcr2chziFU9Cexh9T4IkY02DHoeKTC2yF8/F29CVmGFawkcHUug==
X-Received: by 2002:a05:651c:1104:: with SMTP id d4mr14676387ljo.90.1567588420011;
        Wed, 04 Sep 2019 02:13:40 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t21sm3405403lft.5.2019.09.04.02.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 02:13:39 -0700 (PDT)
Subject: Re: [PATCH] printf: add support for printing symbolic error codes
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
 <7f744f43-3928-65a8-290b-ad1a45320210@kleine-koenig.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4d085535-3ff1-c53c-b032-42bdfcf1bddd@rasmusvillemoes.dk>
Date:   Wed, 4 Sep 2019 11:13:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7f744f43-3928-65a8-290b-ad1a45320210@kleine-koenig.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2019 17.29, Uwe Kleine-König wrote:
> Hello Rasmus,
> 
> On 8/30/19 11:46 PM, Rasmus Villemoes wrote:
>> It has been suggested several times to extend vsnprintf() to be able
>> to convert the numeric value of ENOSPC to print "ENOSPC". This is yet
>> another attempt. Rather than adding another %p extension, simply teach
>> plain %p to convert ERR_PTRs. While the primary use case is
>>
>>   if (IS_ERR(foo)) {
>>     pr_err("Sorry, can't do that: %p\n", foo);
>>     return PTR_ERR(foo);
>>   }
>>
>> it is also more helpful to get a symbolic error code (or, worst case,
>> a decimal number) in case an ERR_PTR is accidentally passed to some
>> %p<something>, rather than the (efault) that check_pointer() would
>> result in.
> 
> Your text suggests that only cases that formerly emitted "(efault)" are
> affected. I didn't check this but if this is the case, I like your patch.

Well, sort of. Depends on whether this is plain %p or %p<something>.

In the former case, the pointer would have been treated as any other
"valid" kernel pointer, hence passed through the ptr_to_id() and printed
as the result of, roughly, siphash((long)ptr) - i.e. some hex number
that has nothing directly to do with the -EIO that was passed in.
Moreover, while the printed value would be the same for a given error
code during a given boot, on the next boot, the hashing would use a
different seed, so would result in another "random" hex value being
printed - which one can easily imagine makes debugging harder. With my
patch, these would always result in "EIO" (or its decimal
representation) being printed.

In the latter case, yes, all the %p extensions that would somehow
dereference ptr would then be caught in the check_pointer() and instead
of printing (efault), we'd (again) get the symbolic error code.

In both cases, I see printing the symbolic errno as a clear improvement
- completely independent of whether we somehow want to make it
"officially allowed" to deliberately pass ERR_PTRs (and I see that I
forgot to update Documentation). So while that is really the main point
of the patch, IMO the patch can already be justified by the above.

[A few of the %p extensions do not dereference ptr (e.g. the %pS aka
print the symbol name) - I think they just print ptr as a hex value if
no symbol is found (or !CONFIG_KALLSYMS). I can't imagine how an ERR_PTR
would be passed to %pS, though, and again, getting the symbolic error
(or the decimal -22) should be better than getting -22 printed as a hex
string.]

>> With my embedded hat on, I've made it possible to remove this.
> 
> I wonder if the config item should only be configurable if EXPERT is
> enabled.

Maybe. Or one could make it default y and then only make it possible to
deselect if CONFIG_EXPERT - only really space-constrained embedded
devices would want this disabled, I think. But I prefer keeping it
simple, i.e. keeping it as-is for now.

> Apart from the above minor issues:
> 
> Acked-by: Uwe Kleine-König <uwe@kleine-koenig.org>

Thanks. The buildbot apparently tried to compile the errcode.h header by
itself and complained that NULL was not defined, so I'll respin to make
it happy, and add a note to Documentation/. Can I include that ack even
if I don't change the Kconfig logic?

Thanks,
Rasmus
