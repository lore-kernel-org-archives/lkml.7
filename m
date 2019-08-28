Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA25C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8010B22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5vZiC16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfH1Wcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:32:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35546 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfH1Wcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:32:47 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so1040243oii.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0HaheuQHQRT9LEcUZx3XnMQChJG5XRPyuRaS389XelY=;
        b=V5vZiC16J5Bo/EFt40iuUWwnm4/xViVSyGBhX75zFVM/0kdyuv4XCBtyAd9+y0EBjk
         d5wLd/zPiUSIRR4KUVHRY2vJMnraOR+JkElYh03WeZhN2wtSyAAi7hO66MrzSCteG/1t
         oRqrQX9yAYfoUsCVBPa4jjk3F5LPzqib+FED2i8aDpUO2j5P4jQ8if+CV+dinRsrqK08
         YxxqiDBbjCsNsevgElegWEiAPAW5v69Gb4mOX1O8TdQPRHWUpfyCcUx5fdUquy1/+vXW
         GJuC3+wdydLKcUIhdLsSdxR5brS47cl73bDpTsh7TE5xBs52AdWWr+0fB9EYWGzuvFta
         Fb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=0HaheuQHQRT9LEcUZx3XnMQChJG5XRPyuRaS389XelY=;
        b=KJzPIChT+msXsf6s0FKuhHh73z+DM/VJ+H9H6duuHpyj9l0IC3NDIaEzzy7OBqP5wE
         G8UcWKw0hExfok2urEph0Ps1r5UQ5E756h7eZsp1tcEKplyhd0WiltwZltuG3BSJ5tDt
         xZGRI00xz5UkT0db2dqJvN14MiEnWN9fqvgMWO8ytrjlxSr8lJjbjzcdZrH4ScqoAzKS
         gTieqr5O26YCHijsEuTHGqNiAYLJnCY3mpyX1JEjWXjK5gws+QGYUipNVH6jOEcSLf9m
         O2liwkEm6PNbkckeZ+1IsJSbA5bpFgOXx9txqiBEoj7wszcH5HKVYlKWH43oiQsAM8wN
         6G2A==
X-Gm-Message-State: APjAAAVhG6mcbGjteRqmGazJsEtaoQxVEm/OuiQaSSEOpmMy+2DVYv9A
        qUP4d4N+aH0dDcw+m01Geg==
X-Google-Smtp-Source: APXvYqzteF9SCvtsRjWtIzJJEXjRttCnhDRsKCkjbJtd/gHZP3r2rNLG0DB1SCpG3D8s7IpUS6nzKQ==
X-Received: by 2002:aca:5ad4:: with SMTP id o203mr2830633oib.136.1567031566036;
        Wed, 28 Aug 2019 15:32:46 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id i17sm135007oik.32.2019.08.28.15.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 15:32:45 -0700 (PDT)
Received: from t560 (unknown [45.19.219.178])
        by serve.minyard.net (Postfix) with ESMTPSA id A5C7E180039;
        Wed, 28 Aug 2019 22:32:43 +0000 (UTC)
Date:   Wed, 28 Aug 2019 17:32:38 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net, kernel-team@fb.com
Subject: Re: [PATCH 0/1] Fix race in ipmi timer cleanup
Message-ID: <20190828223238.GB3294@t560>
Reply-To: minyard@acm.org
References: <20190828203625.32093-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828203625.32093-1-Jes.Sorensen@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 04:36:24PM -0400, Jes Sorensen wrote:
> From: Jes Sorensen <jsorensen@fb.com>
> 
> I came across this in 4.16, but I believe the bug is still present
> in current 5.x, even if it is less likely to trigger.
> 
> Basially stop_timer_and_thread() only calls del_timer_sync() if
> timer_running == true. However smi_mod_timer enables the timer before
> setting timer_running = true.

All the modifications/checks for timer_running should be done under
the si_lock.  It looks like a lock is missing in shutdown_smi(),
probably starting before setting interrupt_disabled to true and
after stop_timer_and_thread.  I think that is the right fix for
this problem.

-corey

> 
> I was able to reproduce this in 4.16 running the following on a host
> 
>    while :; do rmmod ipmi_si ; modprobe ipmi_si; done
> 
> while rebooting the BMC on it in parallel.
> 
> 5.2 moves the error handling around and does it more centralized, but
> relying on timer_running still seems dubious to me.
> 
> static void smi_mod_timer(struct smi_info *smi_info, unsigned long new_val)
> {
>         if (!smi_info->timer_can_start)
>                 return;
>         smi_info->last_timeout_jiffies = jiffies;
>         mod_timer(&smi_info->si_timer, new_val);
>         smi_info->timer_running = true;
> }
> 
> static inline void stop_timer_and_thread(struct smi_info *smi_info)
> {
>         if (smi_info->thread != NULL) {
>                 kthread_stop(smi_info->thread);
>                 smi_info->thread = NULL;
>         }
> 
>         smi_info->timer_can_start = false;
>         if (smi_info->timer_running)
>                 del_timer_sync(&smi_info->si_timer);
> }
> 
> Cheers,
> Jes
> 
> Jes Sorensen (1):
>   ipmi_si_intf: Fix race in timer shutdown handling
> 
>  drivers/char/ipmi/ipmi_si_intf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> -- 
> 2.21.0
> 
