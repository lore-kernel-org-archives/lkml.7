Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BC1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5520C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOoxV12s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfGaQ4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:56:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41196 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGaQ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:56:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so67259581wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DqTY6aG8nZY+73IAGA5g/qZiERQkK4hZGuiPzmKKWh8=;
        b=FOoxV12saNl7w3akWNrNCgTnPrD+3S544LRe0DFS56PBepCvDb+o+ypQ3kWM+CcjZh
         A60KOtsbTCJSXGUZKAfj13fHFuxNpVqtz0Pk4SgCR+3P1m2UeRtJ2lGobZyvKUz2OXRP
         3Y6pyFUe3ZMvjhYrabMaLY3VaQmTKvaLDMuGH+VDdVFcz83ty4pg9448jpvyz+GmoKZF
         RDl+6A3WygeFh88OBt1z+RM4uPZZZtsgNPTwtoUV90DTQP7P/OPtE7f6yu9CFgmdi+RX
         a+3W1n2/MyoIRxKRJ/VdwFxAz08GPRoe9ie7NX2ycW1cpBYQeiXQ1t4zZeY8LE5WTgol
         1+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DqTY6aG8nZY+73IAGA5g/qZiERQkK4hZGuiPzmKKWh8=;
        b=FWOgZUptgOmwNv5CJFUhJuy02I5/x0wQhGuOvwZusbS9ZwHyThjW2YyXIQoTqV/RwX
         /rQtC1QjTE8SR5puLI8UOsxeeXYszsuFvLEXDCeZk6c0k9JAp14epVPG4XuH636lCVEA
         5suwFb3JsWMBWTpzk2wv9Wo9X0Nulbd4GAeWQxr4CzsSVc2ko8MbToMWAMCoYBjt2oAT
         6cIV3eb+lhFY3N7+sP1W+MrR8nWat2xMCV1hz+4u3+tanOqwFXP6QY49r0RtmzRmYPdq
         2KrItGOLh/naQIzrrNGtJ+Dh+eYVoOBoDNgiYOni383JPR5wp5xOm102I0/LvB4BLF29
         4PiQ==
X-Gm-Message-State: APjAAAWRNOC/bK7WJIoqbm+WNCxreQq4m82pOkG+JhXrNjI7glfwkcZv
        gjG3+ma2fPRWT34645gE/RTkS5Pp
X-Google-Smtp-Source: APXvYqyEr5vH+yM6CVIKtJRwhUsYkjz2ReBhxlt3hz+0NTQ0s/DV5AxWE2VrUwtuelDy4jhVJndneg==
X-Received: by 2002:a05:6000:11c6:: with SMTP id i6mr34529911wrx.193.1564592204430;
        Wed, 31 Jul 2019 09:56:44 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id v5sm83709220wre.50.2019.07.31.09.56.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 09:56:43 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] fork: extend clone3() to support CLONE_SET_TID
From:   Dmitry Safonov <0x7f454c46@gmail.com>
To:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
References: <20190731161223.2928-1-areber@redhat.com>
 <417a9682-c7fc-fec4-3510-81a8aa7cd0af@gmail.com>
Message-ID: <6ccdda8e-73a3-c8e9-1f37-f89bf688c0fa@gmail.com>
Date:   Wed, 31 Jul 2019 17:56:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <417a9682-c7fc-fec4-3510-81a8aa7cd0af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 5:49 PM, Dmitry Safonov wrote:
> Hi Adrian,
> 
> On 7/31/19 5:12 PM, Adrian Reber wrote:
> [..]
>> @@ -2530,14 +2530,12 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>>  					      struct clone_args __user *uargs,
>>  					      size_t size)
>>  {
>> +	struct pid_namespace *pid_ns = task_active_pid_ns(current);
>>  	struct clone_args args;
>>  
>>  	if (unlikely(size > PAGE_SIZE))
>>  		return -E2BIG;
>>  
>> -	if (unlikely(size < sizeof(struct clone_args)))
>> -		return -EINVAL;
>> -
> 
> It might be better to validate it still somehow, but I don't insist.
> 
> [..]
>> @@ -2578,11 +2580,16 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>>  
>>  static bool clone3_args_valid(const struct kernel_clone_args *kargs)
>>  {
>> -	/*
>> -	 * All lower bits of the flag word are taken.
>> -	 * Verify that no other unknown flags are passed along.
>> -	 */
>> -	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
>> +	/* Verify that no other unknown flags are passed along. */
>> +	if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE_SET_TID))
>> +		return false;
>> +
>> +	/* Fail if set_tid is set without CLONE_SET_TID */
>> +	if (kargs->set_tid && !(kargs->flags & CLONE_SET_TID))
>> +		return false;
>> +
>> +	/* Also fail if set_tid is invalid */
>> +	if ((kargs->set_tid <= 0) && (kargs->flags & CLONE_SET_TID))
>>  		return false;
> 
> Sorry for not mentioning it on v1, but I've noticed it only now:
> you check kargs->set_tid even with the legacy-sized kernel_clone_args,
> which is probably some random value on a task's stack?

Self-correction: On kernel stack in copy_clone_args_from_user().
Which may probably be considered as a security leak..
Sorry again for not spotting it in v1.

Thanks,
          Dmitry
