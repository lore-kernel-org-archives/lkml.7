Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108A6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE029208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAruqRTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfE1PzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:55:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36278 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1PzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:55:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id w16so593019ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4sx6zuiPNmk1/+rypL+mdhl/tHJkw6ok3vlutZvaqlg=;
        b=BAruqRTNAuHmdADbYtzdc1NnjwOLpFamR1xmF5wKpLBENZTkD/0oxBAS7jyujLZbm7
         +QcU9GgX9XR9EbGCvyHpNv6cWM+in+2ruw6J3gkyKDwbsArABfIG/y4VmVnO+C16fFIh
         ugptwjzGuo9+eCuEI0KXyQwmcSWkLIYcjK9aON+GXxIe8E17LWOquf5IiHAaWfNitGHF
         Aqdv7ZjeJuz+l+lxYCpS/S+/D7uIxoqKhh52aJfwVdwrxjP/V4gMj1GVvFYiyw3LZl4S
         cdiDLu/e/LN0SEb5PH+B+Em6gnwYs13wEzxkqu446ssr8MOqCFGjGeQ/5qxCeVl2LiEm
         hyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4sx6zuiPNmk1/+rypL+mdhl/tHJkw6ok3vlutZvaqlg=;
        b=PbPf61rFIjAL0JDJ4mdEOpgj6C4yJV9KorH5dyYTd4cavTeMCwIIRAJT390KCswm6n
         NU+sztkkPxrC3R0FkLIozy1wOQNwlhg0ZxGxCAYEA6hxuecYrMtlQrhhYu0W9hs9RcYt
         2iQeUfaQCrHH4nbU1kLl6E3vLGdTbNBSWxzI/Caw6EOIYpg6mzYRd3fMi61f8wL4O/nT
         0xcA2OxJOxIosv4Lj2ELIXvFdn1gDbzeKO885iDGTnvY1vfeuqbqnvQDmJij29mna8Vu
         LeodbtKiDrq4Q0zI/rhiXunFxk8DSg9kCLgUbweP/DZIlFW6n5YZBJgK47595MkTXBHr
         gabg==
X-Gm-Message-State: APjAAAVeykGlVTXmfbg3TnEQ1O9qnAKCXLYFCGXYfVaPBw9DhHR76KNk
        qh1lky35+u28Z6GA1W4ppo0=
X-Google-Smtp-Source: APXvYqxHwcqXc06f5pQ+XqZafA39rbMtg+msYgE/4STzxNSivOcNBRfDWH4daxE6Qrd9tQGVAPUhfA==
X-Received: by 2002:a2e:7d02:: with SMTP id y2mr38817535ljc.62.1559058919834;
        Tue, 28 May 2019 08:55:19 -0700 (PDT)
Received: from [192.168.1.15] (2-111-15-75-dynamic.dk.customer.tdc.net. [2.111.15.75])
        by smtp.gmail.com with ESMTPSA id m21sm405603lfh.20.2019.05.28.08.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:55:19 -0700 (PDT)
Subject: Re: [PATCH] trace: Avoid memory leak in predicate_parse()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com
References: <20190528104400.388e4c3f@gandalf.local.home>
 <20190528154338.29976-1-tomasbortoli@gmail.com>
 <20190528114821.2302dabd@gandalf.local.home>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2100b570-889d-a3d3-9e7e-19b74da9243c@gmail.com>
Date:   Tue, 28 May 2019 17:55:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528114821.2302dabd@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/19 5:48 PM, Steven Rostedt wrote:
> On Tue, 28 May 2019 17:43:38 +0200
> Tomas Bortoli <tomasbortoli@gmail.com> wrote:
> 
>> In case of errors, predicate_parse() goes to the out_free label
>> to free memory and to return an error code.
>>
>> However, predicate_parse() does not free the predicates of the
>> temporary prog_stack array, thence leaking them.
> 
> Thanks, I applied this and I'm running it through my tests. But just an
> FYI, when sending updated patches please add a "v2" to the subject:
> 
>  [PATCH v2] tracing: Avoid memory leak in predicate_parse()
> 
> That way struggling maintainers like myself don't get confused about
> which patch to apply ;-)
> 
> Thanks!
> 

Yeah, sorry about that, will make sure it doesn't happen again!

Thank you,
Tomas


> 
>>
>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
>> Reported-by: syzbot+6b8e0fb820e570c59e19@syzkaller.appspotmail.com
>> ---
>>  kernel/trace/trace_events_filter.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
>> index 05a66493a164..ecfa6f0f1c7e 100644
>> --- a/kernel/trace/trace_events_filter.c
>> +++ b/kernel/trace/trace_events_filter.c
>> @@ -427,7 +427,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
>>  	op_stack = kmalloc_array(nr_parens, sizeof(*op_stack), GFP_KERNEL);
>>  	if (!op_stack)
>>  		return ERR_PTR(-ENOMEM);
>> -	prog_stack = kmalloc_array(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
>> +	prog_stack = kcalloc(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
>>  	if (!prog_stack) {
>>  		parse_error(pe, -ENOMEM, 0);
>>  		goto out_free;
>> @@ -578,6 +578,8 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
>>  out_free:
>>  	kfree(op_stack);
>>  	kfree(inverts);
>> +	for (i = 0; prog_stack[i].pred; i++)
>> +		kfree(prog_stack[i].pred);
>>  	kfree(prog_stack);
>>  	return ERR_PTR(ret);
>>  }
> 

