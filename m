Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27199C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1ED217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfEISd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:33:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34447 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfEISd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:33:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id n19so1765800pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 11:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yqiI+x42OXIbUvTBPZc5iTEkpFbz64YiBLYaRAWuA0c=;
        b=Uze6NB/maBrywEP+0raPT+/Aql+qsMNEoxa4YcIX1Q0voy7yKJcitLShUXoR8zF1ym
         ITf4USy/k1QrKuxOfGf2omUgapWCiKRqFA9tj8a5aWDHy2VtFuJlgkM6FUCKYKr5EBIM
         1cxlu9sYwq8OoksYLtIX5L+3UN5brLU8//7UIJcBMKKgv0txTdmKpDSfRMTCQDS770YX
         2RGq58utbgNnO4aak1Q6702JnGXuXC/UDYZsC2jxVIwg8p+1GLOAbomVMGOsgHR4IIad
         dnbudrIo+rL/bIBm84gusWdgIvzntRxI2P4QAbQP6EnOJnz8yab+nzKPpP2zn7Zny9dz
         XSWQ==
X-Gm-Message-State: APjAAAVd9AR18yFoWNK/vKjIwambCxhuyOMdgNbTE991aORC5+PH26sh
        tEEF1+D7HqagkjZ6nBA/BfE=
X-Google-Smtp-Source: APXvYqyEc1uZevZKY+jNDHPdN0qC+8kcKlru+7ZgfAEEO+vBJPv7McdJDqNHLDhPTA7XqyJ/yigK1g==
X-Received: by 2002:aa7:980e:: with SMTP id e14mr7485557pfl.142.1557426837664;
        Thu, 09 May 2019 11:33:57 -0700 (PDT)
Received: from sultan-box.localdomain ([2601:200:c001:5f40:7687:d078:2931:7298])
        by smtp.gmail.com with ESMTPSA id o2sm7914179pgq.1.2019.05.09.11.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 11:33:56 -0700 (PDT)
Date:   Thu, 9 May 2019 11:33:53 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190509183353.GA13018@sultan-box.localdomain>
References: <20190318002949.mqknisgt7cmjmt7n@brauner.io>
 <20190318235052.GA65315@google.com>
 <20190319221415.baov7x6zoz7hvsno@brauner.io>
 <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
 <20190507153154.GA5750@redhat.com>
 <20190507163520.GA1131@sultan-box.localdomain>
 <20190509155646.GB24526@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509155646.GB24526@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 05:56:46PM +0200, Oleg Nesterov wrote:
> Impossible ;) I bet lockdep should report the deadlock as soon as find_victims()
> calls find_lock_task_mm() when you already have a locked victim.

I hope you're not a betting man ;)

With the following configured:
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
# CONFIG_DEBUG_SPINLOCK_BITE_ON_BUG is not set
CONFIG_DEBUG_SPINLOCK_PANIC_ON_BUG=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set

And a printk added in vtsk_is_duplicate() to print when a duplicate is detected,
and my phone's memory cut in half to make simple_lmk do something, this is what
I observed:
taimen:/ # dmesg | grep lockdep
[    0.000000] \x09RCU lockdep checking is enabled.
taimen:/ # dmesg | grep simple_lmk
[   23.211091] simple_lmk: Killing android.carrier with adj 906 to free 37420 kiB
[   23.211160] simple_lmk: Killing oadcastreceiver with adj 906 to free 36784 kiB
[   23.248457] simple_lmk: Killing .apps.translate with adj 904 to free 45884 kiB
[   23.248720] simple_lmk: Killing ndroid.settings with adj 904 to free 42868 kiB
[   23.313417] simple_lmk: DUPLICATE VTSK!
[   23.313440] simple_lmk: Killing ndroid.keychain with adj 906 to free 33680 kiB
[   23.313513] simple_lmk: Killing com.whatsapp with adj 904 to free 51436 kiB
[   34.646695] simple_lmk: DUPLICATE VTSK!
[   34.646717] simple_lmk: Killing ndroid.apps.gcs with adj 906 to free 37956 kiB
[   34.646792] simple_lmk: Killing droid.apps.maps with adj 904 to free 63600 kiB
taimen:/ # dmesg | grep lockdep
[    0.000000] \x09RCU lockdep checking is enabled.
taimen:/ # 

> As for https://github.com/kerneltoast/android_kernel_google_wahoo/commit/afc8c9bf2dbde95941253c168d1adb64cfa2e3ad
> Well,
> 
> 	mmdrop(mm);
> 	simple_lmk_mm_freed(mm);
> 
> looks racy because mmdrop(mm) can free this mm_struct. Yes, simple_lmk_mm_freed()
> does not dereference this pointer, but the same memory can be re-allocated as
> another ->mm for the new task which can be found by find_victims(), and _in theory_
> this all can happen in between, so the "victims[i].mm == mm" can be false positive.
> 
> And this also means that simple_lmk_mm_freed() should clear victims[i].mm when
> it detects "victims[i].mm == mm", otherwise we have the same theoretical race,
> victims_to_kill is only cleared when the last victim goes away.

Fair point. Putting simple_lmk_mm_freed(mm) right before mmdrop(mm), and
sprinkling in a cmpxchg in simple_lmk_mm_freed() should fix that up.

> Another nit... you can drop tasklist_lock right after the 1st "find_victims" loop.

True!

> And it seems that you do not really need to walk the "victims" array twice after that,
> you can do everything in a single loop, but this is cosmetic.

Won't this result in potentially holding the task lock way longer than necessary
for multiple tasks that aren't going to be killed?

Thanks,
Sultan
