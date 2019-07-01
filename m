Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61127C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3302089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfGALng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:43:36 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36103 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfGALnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:43:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so10686130qkl.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 04:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LsbOcoFcfbHWJ2BbGzwqaI1iT+APhtMaltQvkyyA6ls=;
        b=BnFroOMvcOqC68irXyBkMsbZ4cqmwWWoNjs3EzZYYJxmXaSbyAqSFfPtHQ7ZPWFzRg
         sYk6yMNeKgAZmBEnjbnsqGQkNrDcmbvey+SKTBuNskkTY0jV4R4yfDYI8tZLBdkP3Zr8
         PvCMNJ1ndxxsvtKv9Jlk++QzWfcZMaex4UhIs5oQ3Mqa0Wxxvuenoy/KV3FkaL3QD2w5
         +Tzo1vgPu7skjoof0XjuyB36srmOJfKCQv5jI28kLka9cEHu+pM4PPB0tg1yg+DQJOF2
         iRmXtGPBe0ybZTY8bScwZVmRIFNMU6ExUH4fXMQPvMDF4M+TveRLxDziSpNWjRffTXqK
         oorg==
X-Gm-Message-State: APjAAAVZR60sNple8MA904VlprpWgFHEdvDdOIg+bQX1pm7/eDwHIFeE
        mFM+2Ca7Snev3f9HDYiRq7B43JBglt0=
X-Google-Smtp-Source: APXvYqxhjxvfFMx5H8R1QudznXOIqDnGjcbkjCcXmSU+amSFprfZ8GJ4vg/6CaJfYx/lPRHuS4NhiQ==
X-Received: by 2002:a37:634f:: with SMTP id x76mr20791937qkb.205.1561981414830;
        Mon, 01 Jul 2019 04:43:34 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id 2sm5197840qtz.73.2019.07.01.04.43.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:43:34 -0700 (PDT)
Subject: Re: [PATCH] ARM: mm: only adjust sections of valid mm structures
To:     Doug Berger <opendmb@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Peng Fan <peng.fan@nxp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <1561671168-29896-1-git-send-email-opendmb@gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <c11ebd80-0692-b001-42e4-59a8130af056@redhat.com>
Date:   Mon, 1 Jul 2019 07:43:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561671168-29896-1-git-send-email-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/19 5:32 PM, Doug Berger wrote:
> A timing hazard exists when an early fork/exec thread begins
> exiting and sets its mm pointer to NULL while a separate core
> tries to update the section information.
> 
> This commit ensures that the mm pointer is not NULL before
> setting its section parameters. The arguments provided by
> commit 11ce4b33aedc ("ARM: 8672/1: mm: remove tasklist locking
> from update_sections_early()") are equally valid for not
> requiring grabbing the task_lock around this check.
> 
> Fixes: 08925c2f124f ("ARM: 8464/1: Update all mm structures with section adjustments")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>   arch/arm/mm/init.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index be0b42937888..bdc70dff477b 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -616,7 +616,8 @@ static void update_sections_early(struct section_perm perms[], int n)
>   		if (t->flags & PF_KTHREAD)
>   			continue;
>   		for_each_thread(t, s)
> -			set_section_perms(perms, n, true, s->mm);
> +			if (s->mm)
> +				set_section_perms(perms, n, true, s->mm);
>   	}
>   	set_section_perms(perms, n, true, current->active_mm);
>   	set_section_perms(perms, n, true, &init_mm);
> 

Acked-by: Laura Abbott <labbott@redhat.com>
