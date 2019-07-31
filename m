Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B60C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C499206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYqDm0aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfGaQuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:50:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34966 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfGaQuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:50:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so60437226wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qrmVYgiFrygAbwYOEEMHH0NYuDdaUguNNXX83FQoVys=;
        b=WYqDm0aj2GA8Xeog244Z1cJSk2l3lK+xS2hBabX+bWJE1ZeUqVA0fdZm4T6gkbi1Zj
         CsIUDE68jDvaiRfBXFjz+iIFNoJVjrIAYCaXOSvk9tKYhShUsKeHU/+pnV1G3OXpHhJB
         2mAnSJAsyAKPUmN6CdHJ9IO8qkrYLjaFkyGJSqPaxNRiMLxcI1WtGzKqI/0tmOhEFSok
         QVjOLAbuhLnJAHz/7Wb+9wOVb8srhRnUPwdY8YhYugqfvGTeJ415KTcZ4Ba4TNCXKlnP
         OGkpmlzsb7FHhANKAGtsqDxAcbOl9MjAOTgPCt1NpSMM/wiQouobjXgxCbcB2ne25Ozu
         YKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qrmVYgiFrygAbwYOEEMHH0NYuDdaUguNNXX83FQoVys=;
        b=tdCIOIMkrPzZpLWrHvCVNGTE4q8td7+dGbMEHrQxl8thsYRCfIgTv8txGq3qAW/QOn
         OEfRLOi5UBWV8Z/NdYFuUR1a3jz0B2gcWWylZlkiRD+Kxo33K76Jk1ukTMifwaxNhApt
         +xbCpDE/Zi2y3WBhcXPczkN0qU4t6EHhRq4xLzfmg7TqrNykz0ikyHVa7Z8ZYUj8lt76
         VYJetf+zusyI6VoiFWdEvXvupH2XwKBcVlsq1wsmqheTuJwpjzdozioGQ+BIXwCis2ts
         9fQacx86uwPmPssno+oOO50VHDtQ4oj4c4DqsjPi2x1q6oqqo6v46SjoK6Og7j1Y3a3C
         JtZg==
X-Gm-Message-State: APjAAAWFVuBOEq03S535T/tvDVfIQlBhuMFIGZSkXe0lEs6z2SdA4/jh
        5c3MNI9+QQCyYIWyVdSm42g=
X-Google-Smtp-Source: APXvYqxXOY2kQLEEBz9nadMPska92wDSOdumqLNuk06JoZgp8slSW6e0aPINzdcqOepkHpK1FkEubQ==
X-Received: by 2002:a1c:4803:: with SMTP id v3mr113366670wma.49.1564591800571;
        Wed, 31 Jul 2019 09:50:00 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x185sm63607355wmg.46.2019.07.31.09.49.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 09:49:59 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] fork: extend clone3() to support CLONE_SET_TID
To:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
References: <20190731161223.2928-1-areber@redhat.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <417a9682-c7fc-fec4-3510-81a8aa7cd0af@gmail.com>
Date:   Wed, 31 Jul 2019 17:49:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190731161223.2928-1-areber@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 7/31/19 5:12 PM, Adrian Reber wrote:
[..]
> @@ -2530,14 +2530,12 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  					      struct clone_args __user *uargs,
>  					      size_t size)
>  {
> +	struct pid_namespace *pid_ns = task_active_pid_ns(current);
>  	struct clone_args args;
>  
>  	if (unlikely(size > PAGE_SIZE))
>  		return -E2BIG;
>  
> -	if (unlikely(size < sizeof(struct clone_args)))
> -		return -EINVAL;
> -

It might be better to validate it still somehow, but I don't insist.

[..]
> @@ -2578,11 +2580,16 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  
>  static bool clone3_args_valid(const struct kernel_clone_args *kargs)
>  {
> -	/*
> -	 * All lower bits of the flag word are taken.
> -	 * Verify that no other unknown flags are passed along.
> -	 */
> -	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
> +	/* Verify that no other unknown flags are passed along. */
> +	if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE_SET_TID))
> +		return false;
> +
> +	/* Fail if set_tid is set without CLONE_SET_TID */
> +	if (kargs->set_tid && !(kargs->flags & CLONE_SET_TID))
> +		return false;
> +
> +	/* Also fail if set_tid is invalid */
> +	if ((kargs->set_tid <= 0) && (kargs->flags & CLONE_SET_TID))
>  		return false;

Sorry for not mentioning it on v1, but I've noticed it only now:
you check kargs->set_tid even with the legacy-sized kernel_clone_args,
which is probably some random value on a task's stack?

[..]

Thanks much,
          Dmitry
