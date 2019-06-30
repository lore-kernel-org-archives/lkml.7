Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF9EC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 09:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7632220449
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 09:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="yAo4Uvsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfF3JEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 05:04:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36099 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF3JEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 05:04:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so4554025pgg.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rW6hBoo1Zrh9QrQY/e74REo8uL+nhi2gj6+w+fB33Bg=;
        b=yAo4Uvsxq4AeieBQzZsAcQDV++mSH8dBBYo1ydhltlW9Zf4CnM+JPs7VQeEGafVXJT
         TFlKZS0WO278SbIYkv/JXgtoe2rH8Ou2Tp4B7YkqtYLJa8vgPbrwL3nToh4GlS6SuesO
         L7E2x7LXDYcjMIsx+3aupOst+nYVwwSrTw91yA4O49MTVcncMB42W5ZvIVn9ZKzuacwQ
         xoBmB03xsSFswfzbGHuHXGPLgOKjd3KgaShKsTTnZu7EccA1mqi7D8GlnnzzS5BgoWyB
         PqtChj2ubfgdANjUZEsKwhMXnDLHwgo2zTdJ1HPu6uD5htbkVLU5h6DZobfzaWsIjKb1
         6Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rW6hBoo1Zrh9QrQY/e74REo8uL+nhi2gj6+w+fB33Bg=;
        b=p3FQxLDi7vWPjRRegvRj+aD+CaGCxpJL+OAJbL5gv8kIXpOzML+IKvV2mwvRw8ZtN2
         X/gXKeCzmcgHP9/ngOKkY/wl0HOHTYvQkolmOf0OtrHRY9ebIRccbuB1NB5rw2YQmEIY
         dsUrKCzI8n4EVVAmPtRv9DIFXo1AssNz4I2yxmauNK/k5L38WfSsmJGHhDZZuHG/yl1w
         FG8ZZx4THFhZm02vVBNzaQQ+hEOxDDwts8LOGVQcv9BBj+QdgF0XbQhaGSDg76KG970V
         WK4kXGLA/iYBlfH3AzyM95YzOSSH3ryBBmZXX64aiE1teFdgUFQ2SUiqCnciKItrZ/Ao
         lBhA==
X-Gm-Message-State: APjAAAWDxbTOciPkMgci9Y5YFNvfWft7f2SK0ckEU5q1f+hb9Jeyjq0w
        W/d3NRSVDxNl5NDKHOY/1YPkMUeBNvE=
X-Google-Smtp-Source: APXvYqyITUbfKlm3vOfGbqUkKvBcLOc+cioBxW6qMQqmlk0ASkp1NuGGe9PzUl7KJ8SYrgInQc2pUQ==
X-Received: by 2002:a17:90a:be0a:: with SMTP id a10mr22700668pjs.112.1561885443036;
        Sun, 30 Jun 2019 02:04:03 -0700 (PDT)
Received: from Etsukata.local (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id bg3sm214692pjb.9.2019.06.30.02.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 02:04:02 -0700 (PDT)
Subject: Re: [PATCH] tracing: Fix out-of-range read in trace_stack_print()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190610040016.5598-1-devel@etsukata.com>
 <20190614163136.25115131@gandalf.local.home>
From:   Eiichi Tsukata <devel@etsukata.com>
Openpgp: preference=signencrypt
Autocrypt: addr=devel@etsukata.com; keydata=
 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
Message-ID: <398c816d-e80e-9277-569a-2a6b5632e812@etsukata.com>
Date:   Sun, 30 Jun 2019 18:03:59 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190614163136.25115131@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/06/15 5:31, Steven Rostedt wrote:
...

> 
>>
>> Fixes: 4a9bd3f134dec ("tracing: Have dynamic size event stack traces")
> 
> Actually it fixes:
> 
>  4285f2fcef80 ("tracing: Remove the ULONG_MAX stack trace hackery")
> 
> Because before that, a ULONG_MAX was inserted into the buffer.
> 
> -- Steve

Thank you for the advice.
Now there is no ULONG_MAX marker, so I should have fixed it by just
removing `*p != ULONG_MAX` check, right?


Thanks

Eiichi

> 
>> Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
>> ---
>>  kernel/trace/trace_output.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
>> index 54373d93e251..ba751f993c3b 100644
>> --- a/kernel/trace/trace_output.c
>> +++ b/kernel/trace/trace_output.c
>> @@ -1057,7 +1057,7 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
>>  
>>  	trace_seq_puts(s, "<stack trace>\n");
>>  
>> -	for (p = field->caller; p && *p != ULONG_MAX && p < end; p++) {
>> +	for (p = field->caller; p && p < end && *p != ULONG_MAX; p++) {
>>  
>>  		if (trace_seq_has_overflowed(s))
>>  			break;
> 
