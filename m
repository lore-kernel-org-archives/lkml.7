Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC61C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 07:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6252082E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 07:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575011640;
	bh=aVoLB0jj9IWQogUH848B/rnub9gft6NXe1dXWqgepiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dW+CCpMboy5BxoHD0zi39rEn4eF4tCKGEyQn1N1lF43Pn1REYNJuv3uzoskYr3qxO
	 p3O/NZ3hYlDvWCbn04APwhv1Kva1EABtf9833Hw+MM8FZX6SorXRL5YLB5MCNgYqsu
	 W7MnAOHRzZK285I1N3Q9YXpw+JbHWCy3Kjmi/Q7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfK2HN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 02:13:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45170 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfK2HN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 02:13:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so7885360wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 23:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hEdB8A1QZNWZj9z83ENJsdnWjos+n/eZeUXuwfkddEM=;
        b=ZFV8N2ipgVxTAJLhZP8jt4y5uTxL77EoccTNtegkYSdCPrvAwCLELu6rIN3DMbzGva
         aZNb7kiStUo9cK6H5AOZ66QWBQD9FgvGUPlWNHnJnxTFCaaS119YPKDI2gFY0nuZieKS
         pUMRRgI8PED1ZF0YIMDJbIZkx++1u/WGkmk2Gy40C71zcDDMW1Igwlf9ldzjVVu1zHRY
         04sAkHzyvaAJybZDyu0BzktnxyWZIpxy/sxUTYtLJg+ndkSo5G+UR4/fablOMEqJOFmC
         7j167r7qQ+U/94/VJK5b1L/xtYPiZMhZx0XfwieDDIh8mwFL0ABycQargxpvcHWabA8H
         z6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hEdB8A1QZNWZj9z83ENJsdnWjos+n/eZeUXuwfkddEM=;
        b=NsqSgYva7P1GtXikug4YMzsFIKGcJHAcoGNg1gWxSqD8HcBaSaVKZLSlKDrVH/x5MH
         uKt0A4YjZdZySrs2+rM3Wdi8FDFkSj/k4Uei9F6KMuhjc+CJZvGFDSBPuWfdgxYJuvbI
         dPivyl3mBjCkVRxhMVSpfsIv68enrKfjwzJcbCACnAI1QV5/OlvlHq9VcsU3X4MeNDVR
         fIuNecizr6nnnnze5+spW2HVrlPACicRMQMofyhHdojIuUuf98ZDFT1YK+F0f9VkJZSD
         S8jJQf52Wi5P59vBTNe94gWM6IM4MZfGOXkI4kgyCW607HUzg9i71HvefF1lHHLUyuj7
         rZ3g==
X-Gm-Message-State: APjAAAWLEQorm6JeUK1BNifH1UC3oaW2gqPbOK782mTDKfTRsIKyGAic
        +Z01JVuH5zQUTv8guQ7+1R4=
X-Google-Smtp-Source: APXvYqwbgOhfZ+qlZ18owYZ7Lkrn2IOX9+2kl3GL7J2MpfKiQGQi9pse6tMZk33CoOUnqrm9jHXEIA==
X-Received: by 2002:adf:df03:: with SMTP id y3mr32730138wrl.260.1575011635286;
        Thu, 28 Nov 2019 23:13:55 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q15sm13408933wmq.0.2019.11.28.23.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 23:13:54 -0800 (PST)
Date:   Fri, 29 Nov 2019 08:13:52 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: remove noop function task_fork_dl
Message-ID: <20191129071352.GA29046@gmail.com>
References: <56b066c2-90fd-4263-cf31-0a08ea44fd53@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56b066c2-90fd-4263-cf31-0a08ea44fd53@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tom Rix <trix@redhat.com> wrote:

> 
> task_fork_dl is an empty function used only for dl's
> sched_class.task_fork.  Removing it cleans up the code a bit
> and saves a function call in sched_fork.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  kernel/sched/deadline.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index a8a08030a8f7..fbafd97d883a 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1821,14 +1821,6 @@ static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
>          start_hrtick_dl(rq, p);
>  }
>  
> -static void task_fork_dl(struct task_struct *p)
> -{
> -    /*
> -     * SCHED_DEADLINE tasks cannot fork and this is achieved through
> -     * sched_fork()
> -     */
> -}
> -
>  #ifdef CONFIG_SMP
>  
>  /* Only try algorithms three times */
> @@ -2451,8 +2443,6 @@ const struct sched_class dl_sched_class = {
>  #endif
>  
>      .task_tick        = task_tick_dl,
> -    .task_fork              = task_fork_dl,
> -
>      .prio_changed           = prio_changed_dl,
>      .switched_from        = switched_from_dl,
>      .switched_to        = switched_to_dl,

Patch got whitespace-damaged - please see Documentation/process/email-clients.rst
of how to send patches with your mail client.

Your patch looks good otherwise.

Thanks,

	Ingo
