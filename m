Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D9FC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 10:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC992086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 10:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="R6k+IuHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfI2KYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 06:24:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38223 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfI2KYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 06:24:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so9647266wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 03:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3hP7uG+9EHpW+fJgEuzdYOoEFGxgLjWCOaNYKY6K2pk=;
        b=R6k+IuHh0gRSegIuiT0hMwL+K3vAe9e5Wwvl96aNU9EysAIdFVlr6wl9EbJBfqMmyH
         u8eAb8kmODEskCtvSxwdJmwJqYZEaa0TyZQ7NwZwAfNBcT2CkyZK/7qFGy1PY3ZKWmtv
         DrPikXDleJ3vvbApVCWZ7nLB6OAyGLUtad6gVGKk+EDOcl/Dhr46ScYDARCe7aSJNWlC
         DAzc15aI3RsmRsibnlUK6TrMzEOs56mQVXXv5dW0VYo8o+Ku/RVvD8iz3zpACkSLUIOB
         e7TxLKzKKuHsGbWMeNdjfi/77awvfDJG6uqp7JJbSVAbiAgCimPVOVd4vPCxeew7Ywhe
         IPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3hP7uG+9EHpW+fJgEuzdYOoEFGxgLjWCOaNYKY6K2pk=;
        b=DsKDkjkx3Rm9Gg7IvTc69KWMHkPvl5eNydjvIUvI+4y3dlp/owbLTzqdNseXD8bjfj
         s9pp/iSGnIVvQ941FDxA3Cp2H65a8U7KSDo9ffHPpumKju/2VtiBHZSHEi0aZ0zoQTe8
         jRHRJaNpce8GSD35a8JuvT+hdBZ4iCrxGawX/itARemHRxVBtshd8QF7nMDd4gQi2Rt2
         19/CXFoHGb6aVe4uZwPLtftyZLMmQPqWCcNYQg2UffYLeTVETV1VJxQ9KfUN0KRQpG6a
         nzyouRNtzN0/7jatsdiSl3XvsBEtrNcixCzZJOSBGfcpAo8VDsElgtJeVSWmzBRcK3O3
         E3wQ==
X-Gm-Message-State: APjAAAXbDEHJQfg1zk5N/cQ4itVMxZploXV+51EvJThwfyaYBUSOhx9z
        c7f6Zl5uFw38BPilsNAx0kFAUQ==
X-Google-Smtp-Source: APXvYqyDykjrrgNwcUTNoVacUKBlMgPiC7NhPSgDkEgKRQWJJky9JAB/CUbVgFUcmXiY0vR0bVcgNg==
X-Received: by 2002:a05:600c:24ce:: with SMTP id 14mr13013085wmu.71.1569752673470;
        Sun, 29 Sep 2019 03:24:33 -0700 (PDT)
Received: from linux-2.fritz.box (p200300D997073100A232ACDA09636D2D.dip0.t-ipconnect.de. [2003:d9:9707:3100:a232:acda:963:6d2d])
        by smtp.googlemail.com with ESMTPSA id z189sm32449238wmc.25.2019.09.29.03.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2019 03:24:32 -0700 (PDT)
Subject: Re: [PATCH] ipc/sem: Fix race between to-be-woken task and waker
To:     Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190920155402.28996-1-longman () redhat ! com>
From:   Manfred Spraul <manfred@colorfullife.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        1vier1@web.de
Message-ID: <d89b622a-2acf-b0a9-021d-c1c521a731f5@colorfullife.com>
Date:   Sun, 29 Sep 2019 12:24:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190920155402.28996-1-longman () redhat ! com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

I have now written the mail 3 times:
Twice I thought that I found a race, but during further analysis, it 
always turns out that the spin_lock() is sufficient.

First, to avoid any obvious things: Until the series with e.g. 
27d7be1801a4824e, there was a race inside sem_lock().

Thus it was possible that multiple threads were operating on the same 
semaphore array, with obviously arbitrary impact.

On 9/20/19 5:54 PM, Waiman Long wrote:

>   
> +		/*
> +		 * A spurious wakeup at the right moment can cause race
> +		 * between the to-be-woken task and the waker leading to
> +		 * missed wakeup. Setting state back to TASK_INTERRUPTIBLE
> +		 * before checking queue.status will ensure that the race
> +		 * won't happen.
> +		 *
> +		 *	CPU0				CPU1
> +		 *
> +		 *  <spurious wakeup>		wake_up_sem_queue_prepare():
> +		 *  state = TASK_INTERRUPTIBLE    status = error
> +		 *				try_to_wake_up():
> +		 *  smp_mb()			  smp_mb()
> +		 *  if (status == -EINTR)	  if (!(p->state & state))
> +		 *    schedule()		    goto out
> +		 */
> +		set_current_state(TASK_INTERRUPTIBLE);
> +

So the the hypothesis is that we have a race due to the optimization 
within try_to_wake_up():
If the status is already TASK_RUNNING, then the wakeup is a nop.

Correct?

The waker wants to use:

     lock();
     set_conditions();
     unlock();

as the wake_q is a shared list, completely asynchroneously this will happen:

     smp_mb(); //// ***1
     if (current->state = TASK_INTERRUPTIBLE) current->state=TASK_RUNNING;

The only guarantee is that this will happen after lock(), it may happen 
before set_conditions().

The task that goes to sleep uses:

     lock();
     check_conditions();
     __set_current_state();
     unlock(); //// ***2
     schedule();

You propose to change that to:

     lock();
     set_current_state();
     check_conditions();
     unlock();
     schedule();

I don't see a race anymore, and I don't see how the proposed change will 
help.
e.g.: __set_current_state() and smp_mb() have paired memory barriers 
***1 and ***2 above.

--

     Manfred

