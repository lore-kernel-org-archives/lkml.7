Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F89BC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6E4206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568706554;
	bh=SEloxIugQHWkGFM6ll63uqTpYpRZQ93fBvsS6evBN1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i3TDcF1erje806SeeQlFzwPfPb+UoHMCokT9cW1Q5+NK77WL11VsAYEsFsreCuPdl
	 4EBDHMMsksaG0v8/sy60NE71oGJeWsoQEneuT2eYOyrT3V1S/DFH6GpcN1YKJ1dyew
	 2+V1aQ4p4m5AAqwRsEi9prjaMQNiwslw+eVH456U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404502AbfIQHtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:49:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46129 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfIQHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:49:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so1935565wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xOuUurdemUjzb+YsUPJlT74lHu1IsrBcrqKYx9nwpQc=;
        b=j/+FlHTehVLaCnzNHkt1Sh7mNq5qFRfRyqiaDDfyhhB16N26ujbjUw3zB9kcKIRvz8
         y+aUIcCkZZP3qB995CFexF7hB4XOoQeQRcCYjjK18MYx9JdwKJ7wEM7IS6cS6LGb5PAm
         nM1Yuk9wMgv84dugAPvgW86pc4LvB4B8MzFjBEtBap7JIadvOlH07NNEXrXONvKdwy3G
         03NPR7nRYqKcAlfxIl2qmLKB01Pjm4glQM8D2OxGPmZor6MqAXblWIQ4VoOfczQQFIlj
         8UacPxDTWD6fetEBRL5SVuUhfWZHA/FsiKd2I9v1NilMXOV+kG2dV+HJ1Y/eQD+u4cPQ
         k20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xOuUurdemUjzb+YsUPJlT74lHu1IsrBcrqKYx9nwpQc=;
        b=mvP7s0G1j+6BTjXMsX/3jtdKTt+6z5ty0bwSVkvCKQ1sNitXv+WpjmqCKcQvijoZmO
         JH4zv4DnkTi7wRmleGCSZosjPh3dgc1EDzNSKg1DVeDphwqwfNJJ2dsUFxZWj4YmfyhQ
         S+2Qnz+Q746e0Ioq2khtXg4ukjH5+UbA/R7FQ4ozJtTLikKzx9vVev8ek4X8FEIhm9xS
         ToImwrAxtoTV68ADG0MtVprL7BmDCxpEoj1i8WVPwThKERFcnhAhzK+cmG4vR1dLXrv7
         vh/3AYfYNMqyowVo91yKkL+RCyVRvZLeH8CKrYEft2Dld8UY4slSrZPqNK22bKkIWJmO
         qTmg==
X-Gm-Message-State: APjAAAU6qIvPN0i/shQb5p5tcWEEPz26cqmX0Z82Th0PAfkn7QeOoity
        MiidUJgAt0VHpzqOdslRIFM=
X-Google-Smtp-Source: APXvYqy+NkWJ+aozCiihtV5a4IbQO0uzH/Q4bQg9Ij7TauuIWOm/5Oiab3RcehtvJqU9NQ9cwwVvwg==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr1715861wrv.350.1568706551517;
        Tue, 17 Sep 2019 00:49:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z189sm2291466wmc.25.2019.09.17.00.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 00:49:11 -0700 (PDT)
Date:   Tue, 17 Sep 2019 09:49:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Add __ASSEMBLY__ guards around struct clone_args
Message-ID: <20190917074909.GA49590@gmail.com>
References: <20190917071853.12385-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917071853.12385-1-seth.forshee@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Seth Forshee <seth.forshee@canonical.com> wrote:

> The addition of struct clone_args to uapi/linux/sched.h is not
> protected by __ASSEMBLY__ guards, causing a FTBFS for glibc on
> RISC-V. Add the guards to fix this.
> 
> Fixes: 7f192e3cd316 ("fork: add clone3")
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---
>  include/uapi/linux/sched.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index b3105ac1381a..851ff1feadd5 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -33,6 +33,7 @@
>  #define CLONE_NEWNET		0x40000000	/* New network namespace */
>  #define CLONE_IO		0x80000000	/* Clone io context */
>  
> +#ifndef __ASSEMBLY__
>  /*
>   * Arguments for the clone3 syscall
>   */
> @@ -46,6 +47,7 @@ struct clone_args {
>  	__aligned_u64 stack_size;
>  	__aligned_u64 tls;
>  };
> +#endif

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
