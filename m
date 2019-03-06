Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA77C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D4820661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfCFOo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:44:56 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39132 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbfCFOo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:44:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id x6so6918134qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 06:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Moh17FotqbS8PGr7+VzFFFbAzRgRuL6S/4wWaPexRa0=;
        b=FbxGA/hZTO3Fm73WRzvo2H1H3STUHLOAB13G4eDsG5aHBMQgdnisU3bgQ94FzD33Ql
         ew17KvIbEEdgdzJ9fnzloDQ73+v+SPYENGvEe3UMQXybhZjPMzUrH7swjEHO0uxss3nA
         hVBxDIEXMj79AJnC/vfDzkIc8/8U14ljmnK25lIwCW/FZlIG9mW4nt+/6E5VEBnF8+Lu
         AwMrfaf+tTC8LK2IQiliSEAXaJUgttAv6Q8021Wxxt5IRLEBVNapvQvsAWEBbi331xUu
         Ld8/1WLU/MO03IDh139pCm+csZ8lsq6OJ+4OmghI+vkbFI1mS+f62mCGPiEBb9P1/S5L
         0xYA==
X-Gm-Message-State: APjAAAW+WXYCgQepNHRx8m7Ug7gHsfXHYcQlI1eyfsevJlRP6EexueF9
        R+QUAawBhsbbNqBV/w2xj2nn1zk/HiA=
X-Google-Smtp-Source: APXvYqyA5nfLEVXzu2B7LvulYlIzOV58bWM9vCBNgM8cY4NS4dOFUvhOY5fAPTWmpxbSshvy5zZ2GQ==
X-Received: by 2002:a05:620a:1389:: with SMTP id k9mr5753258qki.93.1551883494557;
        Wed, 06 Mar 2019 06:44:54 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6:8083:e891:a0d6:f666? ([2601:602:9800:dae6:8083:e891:a0d6:f666])
        by smtp.gmail.com with ESMTPSA id s5sm934489qkf.87.2019.03.06.06.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 06:44:53 -0800 (PST)
Subject: Re: [PATCH] ipc: Fix building compat mode without sysvipc
To:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190306142944.834167-1-arnd@arndb.de>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <3614a6b8-0c2f-747c-ce60-b58e79c5cec5@redhat.com>
Date:   Wed, 6 Mar 2019 06:44:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190306142944.834167-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 6:29 AM, Arnd Bergmann wrote:
> As John Stultz noticed, my y2038 syscall series caused a link
> failure when CONFIG_SYSVIPC is enabled but CONFIG_COMPAT is
> enabled:
> 

is this supposed to be "CONFIG_SYSVIPC is disabled" to match the
subject?

> arch/arm64/kernel/sys32.o:(.rodata+0x960): undefined reference to `__arm64_compat_sys_old_semctl'
> arch/arm64/kernel/sys32.o:(.rodata+0x980): undefined reference to `__arm64_compat_sys_old_msgctl'
> arch/arm64/kernel/sys32.o:(.rodata+0x9a0): undefined reference to `__arm64_compat_sys_old_shmctl'
> 
> Add the missing entries in kernel/sys_ni.c for the new system
> calls.
> 
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm about to send off my pull requests for arm-soc, so I'd just
> send another one with just this common from my y2038 tree.
> ---
>   kernel/sys_ni.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 85e5ccec0955..62a6c8707799 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -202,6 +202,7 @@ COND_SYSCALL(msgget);
>   COND_SYSCALL(old_msgctl);
>   COND_SYSCALL(msgctl);
>   COND_SYSCALL_COMPAT(msgctl);
> +COND_SYSCALL_COMPAT(old_msgctl);
>   COND_SYSCALL(msgrcv);
>   COND_SYSCALL_COMPAT(msgrcv);
>   COND_SYSCALL(msgsnd);
> @@ -212,6 +213,7 @@ COND_SYSCALL(semget);
>   COND_SYSCALL(old_semctl);
>   COND_SYSCALL(semctl);
>   COND_SYSCALL_COMPAT(semctl);
> +COND_SYSCALL_COMPAT(old_semctl);
>   COND_SYSCALL(semtimedop);
>   COND_SYSCALL(semtimedop_time32);
>   COND_SYSCALL(semop);
> @@ -221,6 +223,7 @@ COND_SYSCALL(shmget);
>   COND_SYSCALL(old_shmctl);
>   COND_SYSCALL(shmctl);
>   COND_SYSCALL_COMPAT(shmctl);
> +COND_SYSCALL_COMPAT(old_shmctl);
>   COND_SYSCALL(shmat);
>   COND_SYSCALL_COMPAT(shmat);
>   COND_SYSCALL(shmdt);
> 

