Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34C6C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901F220659
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU8WRk5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfJBWFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:05:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44223 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJBWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:05:01 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so746650qth.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VUCrdG5Ip3vuddK4QdH3k6TYwm2kGknJubRiy7zVTCU=;
        b=CU8WRk5Yufy1cRgHxXBFKYCXF9kzkm0Bkbw0x/T7oKYpOUJ9luYkFV6x3upMhgGY6k
         RG4mIuoOCxZNeezAJIcLKNWbC5i+nTlFG4hfGyE4BNjqNNJ6MB/+9DTa/+5cSzeG55bB
         l49szpLC/RAR9jCswbsT3clcCw0Fhcs+S4L1XYdLUwAK56ENrdu8Id56UtI2zMoyc4iw
         G8tYMjCwNl8PSj4J7lhUkdHsSLurVHqElRzBZ2jDGksLlobtIJWW1HBXSybCk4GlOXOp
         tuEgy0jBfcOHpoD/Z2phbVPqVpCLshNhsbD8IVsIuOgluHxwd61iQoFBPze2GpOuSU01
         /l0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VUCrdG5Ip3vuddK4QdH3k6TYwm2kGknJubRiy7zVTCU=;
        b=oibWIDr0oJhF+htNjKuyB9XzKwxb9nbNs3EwM5HQT1rtBF8Fh4REBMiTZYSIErwxIL
         P+F32ILL5zKzEva5Cen5LYFiBdR58Zk9E2qBxK4wBkTLONE+kszqdq/dhc6GvUICdg0g
         Qq6j6MwZWVR3JneXKMwsEpudptkr7PUtNEEabF+YxrfZiwkixOp+S3uqAWTgE9hmAftv
         FaGFUKnngAXb5hOEgRVB5fybPC0UOxrpSc3aGqUbkpB8XwGQmYlwHnXQjCT+phvoMag/
         RvBeOUSwu5TF0bTJJBhPQOsbP4J32Qju76oxedDrVkmkUobwzgyoPvml3hcb8K5pQfMA
         c7RQ==
X-Gm-Message-State: APjAAAWXfRYHyas9VshR1LuRSyHrgT/zv866+WJBVmuAwjMBQXeTMjat
        iZRqwCRpPdIK6CWAn56vOQ==
X-Google-Smtp-Source: APXvYqzqfrCfFWQrATtQwJxSSHemsR9/zs41r5jssmQJJrFqR71GEISgh2rAvuSsnH9he3sW04m4Lg==
X-Received: by 2002:ac8:4597:: with SMTP id l23mr6897186qtn.284.1570053899632;
        Wed, 02 Oct 2019 15:04:59 -0700 (PDT)
Received: from [192.168.1.99] ([92.117.179.41])
        by smtp.googlemail.com with ESMTPSA id d23sm315040qkc.127.2019.10.02.15.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 15:04:58 -0700 (PDT)
Subject: Re: [PATCH v7 1/4] ftrace: Implement fs notification for
 tracing_max_latency
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
References: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
 <20190920152219.12920-2-viktor.rosendahl@gmail.com>
 <20191002111324.7590bf6d@gandalf.local.home>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Message-ID: <fc1de769-a00e-b7cc-50cb-796560d79d89@gmail.com>
Date:   Thu, 3 Oct 2019 00:04:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002111324.7590bf6d@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/19 5:13 PM, Steven Rostedt wrote:
> On Fri, 20 Sep 2019 17:22:16 +0200
> "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com> wrote:
> 
>> This patch implements the feature that the tracing_max_latency file,
>> e.g. /sys/kernel/debug/tracing/tracing_max_latency will receive
>> notifications through the fsnotify framework when a new latency is
>> available.
>>
>> One particularly interesting use of this facility is when enabling
>> threshold tracing, through /sys/kernel/debug/tracing/tracing_thresh,
>> together with the preempt/irqsoff tracers. This makes it possible to
>> implement a user space program that can, with equal probability,
>> obtain traces of latencies that occur immediately after each other in
>> spite of the fact that the preempt/irqsoff tracers operate in overwrite
>> mode.
>>
>> This facility works with the hwlat, preempt/irqsoff, and wakeup
>> tracers.
>>
>> The tracers may call the latency_fsnotify() from places such as
>> __schedule() or do_idle(); this makes it impossible to call
>> queue_work() directly without risking a deadlock. The same would
>> happen with a softirq,  kernel thread or tasklet. For this reason we
>> use the irq_work mechanism to call queue_work().
> 
> Can fsnotify() be called from irq context? If so, why have the work
> queue at all? Just do the work from the irq_work handler.
> 

fsnotify() might sleep. It calls send_to_group(), which calls 
inotify_handle_event() through a function pointer.

inotify_handle_event() calls kmalloc() without the GFP_ATOMIC flag.

There might be other reasons as well but the above is one that I have 
seen a warning for, when enabling CONFIG_DEBUG_ATOMIC_SLEEP and trying 
to call fsnotify() from an atomic context.

best regards,

Viktor
