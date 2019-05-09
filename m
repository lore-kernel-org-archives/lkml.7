Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D369C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB8E2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDfRT5wB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfEIJYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 05:24:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43470 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfEIJYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:24:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id c6so996305pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KNPNciYIU3+HXkk3DJ6VxArPy7nMFhtdtj0MwjhBgkw=;
        b=CDfRT5wBnjjC6wGBkOnSkopnu77rpnWGpqCPZrQqv62cZJXdLPCaWeVGfh3HE5EH8Q
         CwnnLXBpHdGr0/V+iLHmdfk5/vkTNu/gZRNFUHvja79j5MuNITfjzv6nnJxJtOOF7dhU
         Wi+c8MIZGoirpwg+Z0Z74yz4XTCbVFmeXrEgui8S4u8TQA6QPX25UtsmrD1pc6/3834o
         fGTLMMDBjNyIjh6IMge/VBRrv35YrOkQY9okwS8zPIjIx2qasuIQtHEzuhuD823k6L25
         lUcRW1j5EmjGpr0gmfvV7w+a0eN3DrSxfTzkfhsm51cC5b2/Ekrrtui6MO/Xenr+Rey9
         P4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KNPNciYIU3+HXkk3DJ6VxArPy7nMFhtdtj0MwjhBgkw=;
        b=oHNPNJaT8jah6x7IeA/5qf/AoZw79VQPTmEbWYdP5W63EzXAZk+H68Elusi6Lljf2g
         I8Gci8AX+AXDz2jz+n+8zqPJRk1WCs2/X+eNEfKeNfVKNW50j81vYS2hs8Z1pYhU1cjl
         HAuFb7O8As5Opkb4bgGev3KayWE16upPG/FrVDcA6Bm+uPfVp5N990SZtXwtaQ5PmqHN
         0sOjkIet2UgB5E14N3DN48cAF+vHotYq7h/5Vq6lRyx6PFp9fqZcjmQD7po7guDYj4Ts
         0GwCtFWnoT75VNMWVgXu+7+M9+orfiSnXPZ6Iz3PmdQqjjHCtKUeVla+9L+mU8k3fHvc
         vGHw==
X-Gm-Message-State: APjAAAUx9w1WWsaY6wRdEDuIh/n941ykAhw631RgaPnEf2Z5mfK6Y2KP
        ieTHT/Okq/U72y/M8PmBxfU=
X-Google-Smtp-Source: APXvYqw1L1IzIicEJkRu7GcUhIlR2YBfCiQbwJF7MEhqA9gMYXmTgijivbCF8bEVfWAKV5SQ9killw==
X-Received: by 2002:a65:5cca:: with SMTP id b10mr4031082pgt.444.1557393893986;
        Thu, 09 May 2019 02:24:53 -0700 (PDT)
Received: from localhost ([39.7.47.21])
        by smtp.gmail.com with ESMTPSA id n7sm2364546pff.45.2019.05.09.02.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 02:24:53 -0700 (PDT)
Date:   Thu, 9 May 2019 18:24:49 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Don Zickus <dzickus@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH 2/2] RFC: soft/hardlookup: taint kernel
Message-ID: <20190509092449.GA10828@jagdpanzerIV>
References: <20190502194208.3535-1-daniel.vetter@ffwll.ch>
 <20190502194208.3535-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502194208.3535-2-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/02/19 21:42), Daniel Vetter wrote:
[..]
> @@ -469,6 +469,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
>  		if (softlockup_panic)
>  			panic("softlockup: hung tasks");
> +		else
> +			add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
>  		__this_cpu_write(soft_watchdog_warn, true);

Soft lockup sets TAINT_SOFTLOCKUP bit. Would it be enough for your CI?

[..]
> @@ -154,6 +154,8 @@ static void watchdog_overflow_callback(struct perf_event *event,
>
>  		if (hardlockup_panic)
>  			nmi_panic(regs, "Hard LOCKUP");
> +		else
> +			add_taint(TAINT_WARN, LOCKDEP_STILL_OK);

Maybe you can mirror what soft lockup does. Add a HARDLOCKUP taint bit

+++ b/include/linux/kernel.h
@@ -571,7 +571,8 @@ extern enum system_states {
 #define TAINT_LIVEPATCH                        15
 #define TAINT_AUX                      16
 #define TAINT_RANDSTRUCT               17
-#define TAINT_FLAGS_COUNT              18
+#define TAINT_HARDLOCKUP               18
+#define TAINT_FLAGS_COUNT              19

and then set TAINT_HARDLOCKUP in watchdog_overflow_callback().

Just a small idea, I'll leave this to more experienced people.

	-ss
