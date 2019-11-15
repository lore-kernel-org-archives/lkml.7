Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D63C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF01A20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgSo0NTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfKONqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:46:04 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33783 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfKONqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:46:04 -0500
Received: by mail-qk1-f196.google.com with SMTP id 71so8123226qkl.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 05:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wFCQuQA85xWwryGtN7bWLtCWqMvfBLzKa2tYtAL7AJ4=;
        b=CgSo0NTNilCZ9UpBcaBT8myQuQoFYxo5h+V58XxndAABs9C55u4LuPzUItpGOlj6ep
         ao18BAsa/6UcWwseyHf0NRzSYIwH5jzJWStrm7YkezIogJr74NAx9B4el0fiAzH6ajrd
         1aZ+Ae0Oh3qJBmT6lxUO88A/4n1+oeP5ioXxeii73CYKc9MeTf5BTRySfRUOwadDg5zj
         kzfLpVBn7Yabje9zloMv+YZR4nzEd0tFcJxF23oFphJBS2ZdXKrduZrfpaBxJeEOntQy
         WmHEUPmRZHuSuKEU3NOqVsD90+mgiBuHbUPxK0y+k7cC47i5sj0ZlaAOauAXPX+XvJoo
         Ifog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wFCQuQA85xWwryGtN7bWLtCWqMvfBLzKa2tYtAL7AJ4=;
        b=E7owfNe1hJxU8FX5cI2dMIMIsw6JvGgXVDb4Loykq930IYWyjMJoX1A1KSsKs/Rtxl
         Ke9UJ7jFbH063GrGF5lLE4Kxc3rM5+1AZxwh48LpzP9I1XzmRpL9sua68gvKnnxOYOQA
         QWkjt6ubhb5vFT9hXRfXJHr3QetyhUsU7fYBj4IXQuGXNBzy92Kzn4CnJWUDmuJRZcpQ
         tcR4OuAzNbbWSyKBx02//oQzZdpvQ7U5X0nbqcBlZLE/SQMQJb0xhHDSpwsPpNW68g3i
         DbLX9Vt7YeQ06riEF/rfhAOFxq8o6pVI1NLwgjgU4wdKTo0JV4TFCRqPPYt0F14lp3oB
         xrww==
X-Gm-Message-State: APjAAAWzcIeJw/BaCiK9USBT+rEf7p2u52A0jB1tZaJ5PO6tvHkIyCc9
        e8T7FqWP9Xmx7ucQP5HS2xWfCOk=
X-Google-Smtp-Source: APXvYqzcNMp11EFP0G06Wzv2aV49+XyU+j0nMoejGhjmqkUd4ovHzz42Zc2Ca34pxAZqkmfQbA81aw==
X-Received: by 2002:a37:4c4a:: with SMTP id z71mr12563017qka.451.1573825563381;
        Fri, 15 Nov 2019 05:46:03 -0800 (PST)
Received: from [192.168.1.99] ([92.117.186.89])
        by smtp.googlemail.com with ESMTPSA id v20sm4034817qkg.92.2019.11.15.05.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 05:46:02 -0800 (PST)
Subject: Re: [for-next][PATCH] tracing: Add missing "inline" in stub function
 of latency_fsnotify()
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
References: <20191115082719.4f2d11a0@gandalf.local.home>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Message-ID: <45d969e0-cb51-507c-4a43-4ad2227d31d2@gmail.com>
Date:   Fri, 15 Nov 2019 14:46:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115082719.4f2d11a0@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 2:27 PM, Steven Rostedt wrote:

> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 90cba68c8b50..2df8aed6a8f0 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -801,7 +801,7 @@ void latency_fsnotify(struct trace_array *tr);
>   
>   #else
>   
> -static void latency_fsnotify(struct trace_array *tr) { }
> +static inline void latency_fsnotify(struct trace_array *tr) { }
>   
>   #endif
>   
> 

Looks good to me.

Thanks for fixing this.

best regards,

Viktor
